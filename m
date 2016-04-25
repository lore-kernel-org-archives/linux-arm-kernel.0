From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 25 Apr 2016 04:00:41 +0300
Subject: [PATCH v2 3/4] arm: dts: lpc32xx: reparent SIC1 and SIC2 interrupts
 from MIC
In-Reply-To: <1461545990-25560-1-git-send-email-vz@mleia.com>
References: <1461545990-25560-1-git-send-email-vz@mleia.com>
Message-ID: <1461546041-25713-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds separate device nodes for SIC1 and SIC2 interrupt
controllers and reparents all defined SIC1 and SIC2 interrupt
producers to the correspondent interrupt controller, this is needed to
perform switching to a new LPC32xx MIC/SIC interrupt controller driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
* squashed two step change in lpc32xx.dtsi - new irqchip driver can be
  used (i.e. board boots with access to userspace) with old DTS file,
  so there is no need to fix DTS firstly and then switch to a new driver,
* removed "interrupt-controller-name" and "wakeup-sources" properties
  from all interrupt controllers,
* removed outdated comment.

 arch/arm/boot/dts/lpc32xx.dtsi | 58 +++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 73c4746..4570ddc 100644
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
@@ -263,7 +266,8 @@
 			i2c1: i2c at 400A0000 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x400A0000 0x100>;
-				interrupts = <51 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-parent = <&sic1>;
+				interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pnx,timeout = <0x64>;
@@ -273,7 +277,8 @@
 			i2c2: i2c at 400A8000 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x400A8000 0x100>;
-				interrupts = <50 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-parent = <&sic1>;
+				interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pnx,timeout = <0x64>;
@@ -314,12 +319,6 @@
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
 				interrupt-controller;
@@ -327,6 +326,28 @@
 				#interrupt-cells = <2>;
 			};
 
+			sic1: interrupt-controller at 4000c000 {
+				compatible = "nxp,lpc3220-sic";
+				reg = <0x4000c000 0x4000>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				interrupt-parent = <&mic>;
+				interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
+					     <30 IRQ_TYPE_LEVEL_LOW>;
+				};
+
+			sic2: interrupt-controller at 40010000 {
+				compatible = "nxp,lpc3220-sic";
+				reg = <0x40010000 0x4000>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				interrupt-parent = <&mic>;
+				interrupts = <1 IRQ_TYPE_LEVEL_LOW>,
+					     <31 IRQ_TYPE_LEVEL_LOW>;
+			};
+
 			uart1: serial at 40014000 {
 				compatible = "nxp,lpc3220-hsuart";
 				reg = <0x40014000 0x1000>;
@@ -351,7 +372,8 @@
 			rtc: rtc at 40024000 {
 				compatible = "nxp,lpc3220-rtc";
 				reg = <0x40024000 0x1000>;
-				interrupts = <52 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&sic1>;
+				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_RTC>;
 			};
 
@@ -404,7 +426,8 @@
 			adc: adc at 40048000 {
 				compatible = "nxp,lpc3220-adc";
 				reg = <0x40048000 0x1000>;
-				interrupts = <39 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&sic1>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk LPC32XX_CLK_ADC>;
 				status = "disabled";
 			};
@@ -412,7 +435,8 @@
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
