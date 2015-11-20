From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:28:42 +0200
Subject: [PATCH 07/10] arm: dts: lpc32xx: reparent SIC1 and SIC2 interrupts
 from MIC
In-Reply-To: <1447982925-30138-1-git-send-email-vz@mleia.com>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
Message-ID: <1447982925-30138-8-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds separate device nodes for SIC1 and SIC2 interrupt
controllers and reparents all defined SIC1 and SIC2 interrupt
producers to the correspondent interrupt controller, this is needed to
perform switching to a new LPC32xx MIC/SIC interrupt controller driver.

At the moment SIC1 and SIC2 are disabled by default, this has some
excuses:
* legacy LPC32xx interrupt controller driver is broken since commit
  76ba59f8366f ("genirq: Add irq_domain-aware core IRQ handler"),
  which requires a private interrupt handler, otherwise any SIC1
  generated interrupt (mapped to MIC hwirq 0) breaks the kernel with
  the message "unexpected IRQ trap at vector 00",
* due to the problem described above restriction of access to
  SIC1 interrupts may be even considered as helpful, now at least the
  kernel can be successfully booted, but with some not hooked
  peripherals (ADC/touchscreen, I2C, RTC and USB),
* the change is transitional before switching to a new LPC32xx IC
  driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 86 +++++++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index b2735dd..8dda6e7 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -92,7 +92,8 @@
 			ohci: ohci at 0 {
 				compatible = "nxp,ohci-nxp", "usb-ohci";
 				reg = <0x0 0x300>;
-				interrupts = <59 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&sic1>;
+				interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&usbclk LPC32XX_USB_CLK_HOST>;
 				status = "disabled";
 			};
@@ -100,10 +101,11 @@
 			usbd: usbd at 0 {
 				compatible = "nxp,lpc3220-udc";
 				reg = <0x0 0x300>;
-				interrupts = <61 IRQ_TYPE_LEVEL_HIGH>,
-					     <62 IRQ_TYPE_LEVEL_HIGH>,
-					     <60 IRQ_TYPE_LEVEL_HIGH>,
-					     <58 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-parent = <&sic1>;
+				interrupts = <29 IRQ_TYPE_LEVEL_HIGH>,
+					     <30 IRQ_TYPE_LEVEL_HIGH>,
+					     <28 IRQ_TYPE_LEVEL_HIGH>,
+					     <26 IRQ_TYPE_LEVEL_LOW>;
 				clocks = <&usbclk LPC32XX_USB_CLK_DEVICE>;
 				status = "disabled";
 			};
@@ -111,7 +113,8 @@
 			i2cusb: i2c at 300 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x300 0x100>;
-				interrupts = <63 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&sic1>;
+				interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&usbclk LPC32XX_USB_CLK_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -249,7 +252,8 @@
 			i2c1: i2c at 400A0000 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x400A0000 0x100>;
-				interrupts = <51 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-parent = <&sic1>;
+				interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pnx,timeout = <0x64>;
@@ -259,7 +263,8 @@
 			i2c2: i2c at 400A8000 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x400A8000 0x100>;
-				interrupts = <50 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-parent = <&sic1>;
+				interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pnx,timeout = <0x64>;
@@ -309,15 +314,9 @@
 				};
 			};
 
-			/*
-			 * MIC Interrupt controller includes:
-			 *   MIC @40008000
-			 *   SIC1 @4000C000
-			 *   SIC2 @40010000
-			 */
 			mic: interrupt-controller at 40008000 {
 				compatible = "nxp,lpc3220-mic";
-				reg = <0x40008000 0xC000>;
+				reg = <0x40008000 0x4000>;
 				interrupt-controller;
 				interrupt-controller-name = "mic";
 				#interrupt-cells = <2>;
@@ -326,6 +325,54 @@
 						 <&wakeup_int 25 27>;
 			};
 
+			sic1: interrupt-controller at 4000C000 {
+				compatible = "nxp,lpc3220-sic";
+				reg = <0x4000C000 0x4000>;
+				interrupt-controller;
+				interrupt-controller-name = "sic1";
+				#interrupt-cells = <2>;
+
+				interrupt-parent = <&mic>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
+					     <30 IRQ_TYPE_LEVEL_LOW>;
+
+				wakeup-sources = <&wakeup_int 16 22>, <&wakeup_int 19 26>,
+						 <&wakeup_int 20 25>, <&wakeup_int 21 31>,
+						 <&wakeup_int 24 20>, <&wakeup_int 29 8>,
+						 <&wakeup_int 30 6>, <&wakeup_int 31 7>,
+						 <&wakeup_pin 25 4>;
+
+				status = "disabled";
+			};
+
+			sic2: interrupt-controller at 40010000 {
+				compatible = "nxp,lpc3220-sic";
+				reg = <0x40010000 0x4000>;
+				interrupt-controller;
+				interrupt-controller-name = "sic2";
+				#interrupt-cells = <2>;
+
+				interrupt-parent = <&mic>;
+				interrupts = <1 IRQ_TYPE_LEVEL_LOW>,
+					     <31 IRQ_TYPE_LEVEL_LOW>;
+
+				wakeup-sources = <&wakeup_int 0 0>, <&wakeup_int 1 1>,
+						 <&wakeup_int 2 2>, <&wakeup_int 3 3>,
+						 <&wakeup_int 4 4>, <&wakeup_int 5 5>,
+						 <&wakeup_int 6 8>, <&wakeup_pin 3 9>,
+						 <&wakeup_pin 4 10>, <&wakeup_pin 5 11>,
+						 <&wakeup_pin 6 6>, <&wakeup_pin 7 15>,
+						 <&wakeup_pin 8 20>, <&wakeup_pin 9 31>,
+						 <&wakeup_pin 10 22>, <&wakeup_pin 11 23>,
+						 <&wakeup_pin 12 24>, <&wakeup_pin 13 25>,
+						 <&wakeup_pin 14 26>, <&wakeup_pin 15 27>,
+						 <&wakeup_pin 16 28>, <&wakeup_pin 18 18>,
+						 <&wakeup_pin 23 7>, <&wakeup_pin 26 19>,
+						 <&wakeup_pin 30 12>;
+
+				status = "disabled";
+			};
+
 			uart1: serial at 40014000 {
 				compatible = "nxp,lpc3220-hsuart";
 				reg = <0x40014000 0x1000>;
@@ -350,7 +397,8 @@
 			rtc: rtc at 40024000 {
 				compatible = "nxp,lpc3220-rtc";
 				reg = <0x40024000 0x1000>;
-				interrupts = <52 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&sic1>;
+				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_RTC>;
 			};
 
@@ -403,7 +451,8 @@
 			adc: adc at 40048000 {
 				compatible = "nxp,lpc3220-adc";
 				reg = <0x40048000 0x1000>;
-				interrupts = <39 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&sic1>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_ADC>;
 				status = "disabled";
 			};
@@ -411,7 +460,8 @@
 			tsc: tsc at 40048000 {
 				compatible = "nxp,lpc3220-tsc";
 				reg = <0x40048000 0x1000>;
-				interrupts = <39 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&sic1>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_ADC>;
 				status = "disabled";
 			};
-- 
2.1.4
