import 'package:flutter/material.dart';
import 'dart:math';

main() => runApp(Imc());

class Imc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.green),
        buttonColor: Colors.green,
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _widthController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String _infoText = 'Informe seus dados!';
  double _value;

  _resetFields() {
    _widthController.text = '';
    _heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
    });
  }

  _onSubmitedIMC() {
    setState(() {
      _value = double.parse(_widthController.text) /
          (pow(double.parse(_heightController.text), 2));

      if (_value < 18.5)
        _infoText = 'Abaixo do peso';
      else if (_value >= 18.5 && 24.9 >= _value)
        _infoText = 'Peso normal ${_value.toStringAsFixed(2)}';
      else if (_value >= 25.0 && 29.9 >= _value)
        _infoText = 'Sobrepeso ${_value.toStringAsFixed(2)}';
      else if (_value >= 30.0 && 34.9 >= _value)
        _infoText = 'Obesidade grau 1 ${_value.toStringAsFixed(2)}';
      else if (_value >= 35.0 && 39.9 >= _value)
        _infoText = 'Obesidade grau 2 ${_value.toStringAsFixed(2)}';
      else
        _infoText = 'Obesidade grau 3 ${_value.toStringAsFixed(2)}';
    });
  }

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora do IMC'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 10,
        ),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
              ),
              TextFormField(
                  controller: _widthController,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) => _onSubmitedIMC(),
                  decoration: InputDecoration(
                    labelText: 'Peso (Kg)',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                  validator: (value) {
                    if(value.isEmpty)return 'Insira seu peso';
                  }),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _heightController,
                  onFieldSubmitted: (_) => _onSubmitedIMC(),
                  decoration: InputDecoration(
                    labelText: 'Altura (Cm)',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Insira sua altura!';
                  }),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                height: 50,
                child: RaisedButton(
                  child: Text(
                    'Calcular',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  color: Theme.of(context).buttonColor,
                  onPressed: () {
                    if (_formkey.currentState.validate()) _onSubmitedIMC();
                  },
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
