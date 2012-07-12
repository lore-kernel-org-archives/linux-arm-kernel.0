From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 10:25:27 +0800
Subject: [PATCH v7 6/6] ARM: dts: imx28-evk: add usb devices
In-Reply-To: <1342059927-25661-1-git-send-email-richard.zhao@freescale.com>
References: <1342059927-25661-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342059927-25661-7-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add usb phy devices
- add usb controller devices
- add usb vbus regulators

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Tested-by: Subodh Nijsure <snijsure@grid-net.com>
---
 arch/arm/boot/dts/imx28-evk.dts |   38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28.dtsi    |   12 ++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 0d8739d..bee5676 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -59,6 +59,8 @@
 						0x31c3 /* MX28_PAD_PWM3__GPIO_3_28 */
 						0x31e3 /* MX28_PAD_LCD_RESET__GPIO_3_30 */
 						0x3053 /* MX28_PAD_AUART1_TX__GPIO_3_5 */
+						0x3083 /* MX28_PAD_AUART2_RX__GPIO_3_8 */
+						0x3093 /* MX28_PAD_AUART2_TX__GPIO_3_9 */
 					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
@@ -137,10 +139,28 @@
 				pinctrl-0 = <&auart3_pins_a>;
 				status = "okay";
 			};
+
+			usbphy0: usbphy at 8007c000 {
+				status = "okay";
+			};
+
+			usbphy1: usbphy at 8007e000 {
+				status = "okay";
+			};
 		};
 	};
 
 	ahb at 80080000 {
+		usb0: usb at 80080000 {
+			vbus-supply = <&reg_usb0_vbus>;
+			status = "okay";
+		};
+
+		usb1: usb at 80090000 {
+			vbus-supply = <&reg_usb1_vbus>;
+			status = "okay";
+		};
+
 		mac0: ethernet at 800f0000 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
@@ -185,6 +205,24 @@
 			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio2 15 0>;
 		};
+
+		reg_usb0_vbus: usb0_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb0_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 9 0>;
+			enable-active-high;
+		};
+
+		reg_usb1_vbus: usb1_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 8 0>;
+			enable-active-high;
+		};
 	};
 
 	sound {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index adb5ffc..cc25a0f 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -654,11 +654,13 @@
 			};
 
 			usbphy0: usbphy at 8007c000 {
+				compatible = "fsl,imx28-usbphy", "fsl,imx23-usbphy";
 				reg = <0x8007c000 0x2000>;
 				status = "disabled";
 			};
 
 			usbphy1: usbphy at 8007e000 {
+				compatible = "fsl,imx28-usbphy", "fsl,imx23-usbphy";
 				reg = <0x8007e000 0x2000>;
 				status = "disabled";
 			};
@@ -672,13 +674,19 @@
 		reg = <0x80080000 0x80000>;
 		ranges;
 
-		usbctrl0: usbctrl at 80080000 {
+		usb0: usb at 80080000 {
+			compatible = "fsl,imx28-usb", "fsl,imx27-usb";
 			reg = <0x80080000 0x10000>;
+			interrupts = <93>;
+			fsl,usbphy = <&usbphy0>;
 			status = "disabled";
 		};
 
-		usbctrl1: usbctrl at 80090000 {
+		usb1: usb at 80090000 {
+			compatible = "fsl,imx28-usb", "fsl,imx27-usb";
 			reg = <0x80090000 0x10000>;
+			interrupts = <92>;
+			fsl,usbphy = <&usbphy1>;
 			status = "disabled";
 		};
 
-- 
1.7.9.5
