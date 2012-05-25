From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 25 May 2012 10:24:25 +0800
Subject: [PATCH v3 12/12] ARM: dts: imx28-evk: add usb devices
In-Reply-To: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
References: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337912665-16615-13-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add usb phy devices
- add usb controller devices
- add usb vbus regulators

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28.dtsi    |   12 ++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index ee520a5..a06d86a 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -73,10 +73,28 @@
 				pinctrl-0 = <&duart_pins_a>;
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
@@ -102,6 +120,24 @@
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
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
index 4634cb8..502ad05 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -441,11 +441,13 @@
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
@@ -459,13 +461,19 @@
 		reg = <0x80080000 0x80000>;
 		ranges;
 
-		usbctrl0: usbctrl at 80080000 {
+		usb0: usb at 80080000 {
+			compatible = "fsl,imx28-usb", "fsl,imx31-usb";
 			reg = <0x80080000 0x10000>;
+			interrupts = <93>;
+			fsl,usbphy = <&usbphy0>;
 			status = "disabled";
 		};
 
-		usbctrl1: usbctrl at 80090000 {
+		usb1: usb at 80090000 {
+			compatible = "fsl,imx28-usb", "fsl,imx31-usb";
 			reg = <0x80090000 0x10000>;
+			interrupts = <92>;
+			fsl,usbphy = <&usbphy1>;
 			status = "disabled";
 		};
 
-- 
1.7.5.4
