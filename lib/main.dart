import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Cor roxa para o tema
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.purple[300], // Cor dos botões
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Botões com cantos arredondados
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.purple[900], fontSize: 18),
          headlineMedium: TextStyle(color: Colors.purple[700], fontSize: 36), // Estilo do resultado
        ),
      ),
      home: const CalculadoraScreen(),
    );
  }
}

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  String input = ''; // Entrada do usuário
  String result = ''; // Resultado do cálculo

  // Função para adicionar valores à entrada
  void _appendToInput(String value) {
    setState(() {
      input += value;
    });
  }

  // Função para calcular a expressão
  void _calculate() {
    try {
      final expression = input;
      final resultValue = _evaluateExpression(expression); // Avaliação simples da expressão
      setState(() {
        result = resultValue;
      });
    } catch (e) {
      setState(() {
        result = 'Erro';
      });
    }
  }

  // Função simples para avaliação de expressões
  String _evaluateExpression(String expression) {
    try {
      // Aqui, convertemos a expressão para double e calculamos o valor
      return (double.parse(expression)).toString();
    } catch (_) {
      return 'Erro'; // Retorna erro se não for uma expressão válida
    }
  }

  // Função para limpar a entrada e o resultado
  void _clear() {
    setState(() {
      input = '';
      result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.purple[600], // Cor do AppBar roxa
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tela de entrada (Input)
            TextField(
              controller: TextEditingController(text: input),
              enabled: false, // Não permite digitação manual, apenas os botões
              decoration: InputDecoration(
                labelText: 'Entrada',
                labelStyle: TextStyle(color: Colors.purple[700]),
                filled: true,
                fillColor: Colors.purple[50], // Fundo do campo de entrada
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // Cantos arredondados
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Tela de resultado
            Text(
              result,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            // Teclado da calculadora
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true, // Permite que o GridView ocupe apenas o espaço necessário
              children: [
                for (var value in ['7', '8', '9', '/', '4', '5', '6', '*', '1', '2', '3', '-', '0', '.', '=', '+', 'C'])
                  ElevatedButton(
                    onPressed: () {
                      if (value == 'C') {
                        _clear(); // Limpa a entrada e o resultado
                      } else if (value == '=') {
                        _calculate(); // Calcula a expressão
                      } else {
                        _appendToInput(value); // Adiciona valor à entrada
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[300], // Cor dos botões
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Botões com cantos arredondados
                      ),
                    ),
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
