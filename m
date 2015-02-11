From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 Feb 2015 16:19:22 +0100
Subject: [PATCH 2/2] ARM: at91/dt: add i2c1 declaration to sama5d4
Message-ID: <1423667962-29498-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philip Attfield <phil.attfield@seqlabs.com>

Add alias, node declaration and pinctrl for i2c1 (aka: twi1).

Signed-off-by: Philip Attfield <phil.attfield@seqlabs.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 97d5b9759c07..2f4cf5af2405 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -67,6 +67,7 @@
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
 		i2c0 = &i2c0;
+		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 	};
 	cpus {
@@ -839,6 +840,25 @@
 				status = "disabled";
 			};
 
+			i2c1: i2c at f8018000 {
+				compatible = "atmel,at91sam9x5-i2c";
+				reg = <0xf8018000 0x4000>;
+				interrupts = <33 IRQ_TYPE_LEVEL_HIGH 6>;
+				dmas = <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
+					AT91_XDMAC_DT_PERID(4)>,
+				       <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
+					AT91_XDMAC_DT_PERID(5)>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&twi1_clk>;
+				status = "disabled";
+			};
+
 			tcb0: timer at f801c000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf801c000 0x100>;
@@ -1190,6 +1210,14 @@
 					};
 				};
 
+				i2c1 {
+					pinctrl_i2c1: i2c1-0 {
+						atmel,pins =
+							<AT91_PIOE 29 AT91_PERIPH_C AT91_PINCTRL_NONE	/* TWD1, conflicts with UART0 RX and DIBP */
+							 AT91_PIOE 30 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* TWCK1, conflicts with UART0 TX and DIBN */
+					};
+				};
+
 				i2c2 {
 					pinctrl_i2c2: i2c2-0 {
 						atmel,pins =
-- 
2.1.3
