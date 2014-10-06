From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Mon,  6 Oct 2014 16:27:20 +0200
Subject: [PATCH v3 1/1] ARM: at91/dt: sam9x5: Add CAN device nodes
Message-ID: <1412605640-29472-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing CAN devices node including their pin muxing and clocks.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Changes in v3:
* Match the pin name to the ones in the datasheet.

 arch/arm/boot/dts/at91sam9x5.dtsi | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index e1a5c70..a58c1de 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -363,6 +363,16 @@
 						#clock-cells = <0>;
 						reg = <28>;
 					};
+
+					can0_clk: can0_clk {
+						#clock-cells = <0>;
+						reg = <29>;
+					};
+
+					can1_clk: can1_clk {
+						#clock-cells = <0>;
+						reg = <30>;
+					};
 				};
 			};
 
@@ -407,6 +417,28 @@
 				};
 			};
 
+			can0: can at f8000000 {
+				compatible = "atmel,at91sam9x5-can";
+				reg = <0xf8000000 0x300>;
+				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 3>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_can0_rx_tx>;
+				clocks = <&can0_clk>;
+				clock-names = "can_clk";
+				status = "disabled";
+			};
+
+			can1: can at f8004000 {
+				compatible = "atmel,at91sam9x5-can";
+				reg = <0xf8004000 0x300>;
+				interrupts = <30 IRQ_TYPE_LEVEL_HIGH 3>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_can1_rx_tx>;
+				clocks = <&can1_clk>;
+				clock-names = "can_clk";
+				status = "disabled";
+			};
+
 			tcb0: timer at f8008000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8008000 0x100>;
@@ -763,6 +795,22 @@
 					};
 				};
 
+				can0 {
+					pinctrl_can0_rx_tx: can0_rx_tx {
+						atmel,pins =
+							<AT91_PIOA 9 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANRX0, conflicts with DRXD */
+							 AT91_PIOA 10 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* CANTX0, conflicts with DTXD */
+					};
+				};
+
+				can1 {
+					pinctrl_can1_rx_tx: can1_rx_tx {
+						atmel,pins =
+							<AT91_PIOA 6 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANRX1, conflicts with RXD1 */
+							 AT91_PIOA 5 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* CANTX1, conflicts with TXD1 */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-- 
2.0.4
