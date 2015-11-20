From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:28:40 +0200
Subject: [PATCH 05/10] arm: dts: lpc32xx: assign interrupt types
In-Reply-To: <1447982925-30138-1-git-send-email-vz@mleia.com>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
Message-ID: <1447982925-30138-6-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LPC32xx interrupt controller has two cells, instead of zero
specify proper irq types for all consumers.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 63 +++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index f396343..fbf1984b 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -14,6 +14,7 @@
 #include "skeleton.dtsi"
 
 #include <dt-bindings/clock/lpc32xx-clock.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	compatible = "nxp,lpc3220";
@@ -66,7 +67,7 @@
 		mlc: flash at 200a8000 {
 			compatible = "nxp,lpc3220-mlc";
 			reg = <0x200a8000 0x11000>;
-			interrupts = <11 0>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk LPC32XX_CLK_MLC>;
 			status = "disabled";
 		};
@@ -74,7 +75,7 @@
 		dma: dma at 31000000 {
 			compatible = "arm,pl080", "arm,primecell";
 			reg = <0x31000000 0x1000>;
-			interrupts = <0x1c 0>;
+			interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk LPC32XX_CLK_DMA>;
 			clock-names = "apb_pclk";
 		};
@@ -91,7 +92,7 @@
 			ohci: ohci at 0 {
 				compatible = "nxp,ohci-nxp", "usb-ohci";
 				reg = <0x0 0x300>;
-				interrupts = <0x3b 0>;
+				interrupts = <59 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&usbclk LPC32XX_USB_CLK_HOST>;
 				status = "disabled";
 			};
@@ -99,7 +100,10 @@
 			usbd: usbd at 0 {
 				compatible = "nxp,lpc3220-udc";
 				reg = <0x0 0x300>;
-				interrupts = <0x3d 0>, <0x3e 0>, <0x3c 0>, <0x3a 0>;
+				interrupts = <61 IRQ_TYPE_LEVEL_HIGH>,
+					     <62 IRQ_TYPE_LEVEL_HIGH>,
+					     <60 IRQ_TYPE_LEVEL_HIGH>,
+					     <58 IRQ_TYPE_LEVEL_LOW>;
 				clocks = <&usbclk LPC32XX_USB_CLK_DEVICE>;
 				status = "disabled";
 			};
@@ -107,7 +111,7 @@
 			i2cusb: i2c at 300 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x300 0x100>;
-				interrupts = <0x3f 0>;
+				interrupts = <63 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&usbclk LPC32XX_USB_CLK_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -124,7 +128,7 @@
 		clcd: clcd at 31040000 {
 			compatible = "arm,pl110", "arm,primecell";
 			reg = <0x31040000 0x1000>;
-			interrupts = <0x0e 0>;
+			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk LPC32XX_CLK_LCD>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -133,7 +137,7 @@
 		mac: ethernet at 31060000 {
 			compatible = "nxp,lpc-eth";
 			reg = <0x31060000 0x1000>;
-			interrupts = <0x1d 0>;
+			interrupts = <29 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk LPC32XX_CLK_MAC>;
 		};
 
@@ -161,7 +165,7 @@
 			ssp0: ssp at 20084000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x20084000 0x1000>;
-				interrupts = <0x14 0>;
+				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_SSP0>;
 				clock-names = "apb_pclk";
 			};
@@ -174,7 +178,7 @@
 			ssp1: ssp at 2008c000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x2008c000 0x1000>;
-				interrupts = <0x15 0>;
+				interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_SSP1>;
 				clock-names = "apb_pclk";
 			};
@@ -192,7 +196,8 @@
 			sd: sd at 20098000 {
 				compatible = "arm,pl18x", "arm,primecell";
 				reg = <0x20098000 0x1000>;
-				interrupts = <0x0f 0>, <0x0d 0>;
+				interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
+					     <13 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_SD>;
 				clock-names = "apb_pclk";
 				status = "disabled";
@@ -208,7 +213,7 @@
 				/* actually, ns16550a w/ 64 byte fifos! */
 				compatible = "nxp,lpc3220-uart";
 				reg = <0x40090000 0x1000>;
-				interrupts = <9 0>;
+				interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				clocks = <&clk LPC32XX_CLK_UART5>;
 				status = "disabled";
@@ -217,7 +222,7 @@
 			uart3: serial at 40080000 {
 				compatible = "nxp,lpc3220-uart";
 				reg = <0x40080000 0x1000>;
-				interrupts = <7 0>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				clocks = <&clk LPC32XX_CLK_UART3>;
 				status = "disabled";
@@ -226,7 +231,7 @@
 			uart4: serial at 40088000 {
 				compatible = "nxp,lpc3220-uart";
 				reg = <0x40088000 0x1000>;
-				interrupts = <8 0>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				clocks = <&clk LPC32XX_CLK_UART4>;
 				status = "disabled";
@@ -235,7 +240,7 @@
 			uart6: serial at 40098000 {
 				compatible = "nxp,lpc3220-uart";
 				reg = <0x40098000 0x1000>;
-				interrupts = <10 0>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				clocks = <&clk LPC32XX_CLK_UART6>;
 				status = "disabled";
@@ -244,7 +249,7 @@
 			i2c1: i2c at 400A0000 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x400A0000 0x100>;
-				interrupts = <0x33 0>;
+				interrupts = <51 IRQ_TYPE_LEVEL_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pnx,timeout = <0x64>;
@@ -254,7 +259,7 @@
 			i2c2: i2c at 400A8000 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x400A8000 0x100>;
-				interrupts = <0x32 0>;
+				interrupts = <50 IRQ_TYPE_LEVEL_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pnx,timeout = <0x64>;
@@ -308,28 +313,28 @@
 			uart1: serial at 40014000 {
 				compatible = "nxp,lpc3220-hsuart";
 				reg = <0x40014000 0x1000>;
-				interrupts = <26 0>;
+				interrupts = <26 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			uart2: serial at 40018000 {
 				compatible = "nxp,lpc3220-hsuart";
 				reg = <0x40018000 0x1000>;
-				interrupts = <25 0>;
+				interrupts = <25 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			uart7: serial at 4001c000 {
 				compatible = "nxp,lpc3220-hsuart";
 				reg = <0x4001c000 0x1000>;
-				interrupts = <24 0>;
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			rtc: rtc at 40024000 {
 				compatible = "nxp,lpc3220-rtc";
 				reg = <0x40024000 0x1000>;
-				interrupts = <0x34 0>;
+				interrupts = <52 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_RTC>;
 			};
 
@@ -343,7 +348,7 @@
 			timer4: timer at 4002C000 {
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x4002C000 0x1000>;
-				interrupts = <0x3 0>;
+				interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 				clocks = <&clk LPC32XX_CLK_TIMER4>;
 				clock-names = "timerclk";
 				status = "disabled";
@@ -352,7 +357,7 @@
 			timer5: timer at 40030000 {
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x40030000 0x1000>;
-				interrupts = <0x4 0>;
+				interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 				clocks = <&clk LPC32XX_CLK_TIMER5>;
 				clock-names = "timerclk";
 				status = "disabled";
@@ -369,7 +374,7 @@
 				reg = <0x40044000 0x1000>;
 				clocks = <&clk LPC32XX_CLK_TIMER0>;
 				clock-names = "timerclk";
-				interrupts = <0x10 0>;
+				interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
 			};
 
 			/*
@@ -382,7 +387,7 @@
 			adc: adc at 40048000 {
 				compatible = "nxp,lpc3220-adc";
 				reg = <0x40048000 0x1000>;
-				interrupts = <0x27 0>;
+				interrupts = <39 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_ADC>;
 				status = "disabled";
 			};
@@ -390,7 +395,7 @@
 			tsc: tsc at 40048000 {
 				compatible = "nxp,lpc3220-tsc";
 				reg = <0x40048000 0x1000>;
-				interrupts = <0x27 0>;
+				interrupts = <39 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_ADC>;
 				status = "disabled";
 			};
@@ -398,7 +403,7 @@
 			timer1: timer at 4004C000 {
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x4004C000 0x1000>;
-				interrupts = <0x11 0>;
+				interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
 				clocks = <&clk LPC32XX_CLK_TIMER1>;
 				clock-names = "timerclk";
 			};
@@ -406,14 +411,14 @@
 			key: key at 40050000 {
 				compatible = "nxp,lpc3220-key";
 				reg = <0x40050000 0x1000>;
-				interrupts = <54 0>;
+				interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			timer2: timer at 40058000 {
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x40058000 0x1000>;
-				interrupts = <0x12 0>;
+				interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
 				clocks = <&clk LPC32XX_CLK_TIMER2>;
 				clock-names = "timerclk";
 				status = "disabled";
@@ -436,7 +441,7 @@
 			timer3: timer at 40060000 {
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x40060000 0x1000>;
-				interrupts = <0x13 0>;
+				interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
 				clocks = <&clk LPC32XX_CLK_TIMER3>;
 				clock-names = "timerclk";
 				status = "disabled";
-- 
2.1.4
