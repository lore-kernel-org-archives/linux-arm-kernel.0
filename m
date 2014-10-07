From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue,  7 Oct 2014 13:51:50 +0200
Subject: [PATCH v4 1/1] ARM: at91/dt: sam9x5: Add CAN device nodes
Message-ID: <1412682710-14219-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing CAN devices node including their pin muxing to the shared
.dtsi for at91sam9x5. Actually include this file.
While at it, fix white spaces of can1_clk.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Changes in v4:
* Move can related descriptions to at91sam9x5_can.dtsi
* Actually include this file in at91sam9x[23]5.dtsi

 arch/arm/boot/dts/at91sam9x25.dtsi    |  1 +
 arch/arm/boot/dts/at91sam9x35.dtsi    |  1 +
 arch/arm/boot/dts/at91sam9x5_can.dtsi | 48 ++++++++++++++++++++++++++++++++---
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/at91sam9x25.dtsi
index c255421..3c5fa33 100644
--- a/arch/arm/boot/dts/at91sam9x25.dtsi
+++ b/arch/arm/boot/dts/at91sam9x25.dtsi
@@ -10,6 +10,7 @@
 #include "at91sam9x5_usart3.dtsi"
 #include "at91sam9x5_macb0.dtsi"
 #include "at91sam9x5_macb1.dtsi"
+#include "at91sam9x5_can.dtsi"
 
 / {
 	model = "Atmel AT91SAM9X25 SoC";
diff --git a/arch/arm/boot/dts/at91sam9x35.dtsi b/arch/arm/boot/dts/at91sam9x35.dtsi
index 8eac66c..499cdc8 100644
--- a/arch/arm/boot/dts/at91sam9x35.dtsi
+++ b/arch/arm/boot/dts/at91sam9x35.dtsi
@@ -8,6 +8,7 @@
 
 #include "at91sam9x5.dtsi"
 #include "at91sam9x5_macb0.dtsi"
+#include "at91sam9x5_can.dtsi"
 
 / {
 	model = "Atmel AT91SAM9X35 SoC";
diff --git a/arch/arm/boot/dts/at91sam9x5_can.dtsi b/arch/arm/boot/dts/at91sam9x5_can.dtsi
index f44ab77..3579232 100644
--- a/arch/arm/boot/dts/at91sam9x5_can.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_can.dtsi
@@ -20,10 +20,50 @@
 						reg = <29>;
 					};
 
-                                        can1_clk: can1_clk {
-                                                #clock-cells = <0>;
-                                                reg = <30>;
-                                        };
+					can1_clk: can1_clk {
+						#clock-cells = <0>;
+						reg = <30>;
+					};
+				};
+			};
+
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
+			pinctrl at fffff400 {
+				can0 {
+					pinctrl_can0_rx_tx: can0_rx_tx {
+						atmel,pins =
+							<AT91_PIOA 9 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANRX0, conflicts with DRXD */
+							AT91_PIOA 10 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* CANTX0, conflicts with DTXD */
+					};
+				};
+
+				can1 {
+					pinctrl_can1_rx_tx: can1_rx_tx {
+						atmel,pins =
+							<AT91_PIOA 6 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANRX1, conflicts with RXD1 */
+							AT91_PIOA 5 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* CANTX1, conflicts with TXD1 */
+					};
 				};
 			};
 		};
-- 
2.0.4
