From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 16:52:56 +0000
Subject: [PATCH 10/13] ARM: dts: imx6qdl-hummingboard: rename regulators to
 match schematic
In-Reply-To: <20171127165134.GH31757@n2100.armlinux.org.uk>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
Message-ID: <E1eJMeO-0002rX-0U@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the regulators match the schematic - name the regulators after
one of their schematic supply names, and arrange them into their
heirarchy.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 43 +++++++++++++++++++----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 1b33cd6752f4..66bda5a04582 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -51,12 +51,21 @@
 		pinctrl-0 = <&pinctrl_hummingboard_gpio3_5>;
 	};
 
-	reg_3p3v: 3p3v {
+	v_3v2: regulator-v-3v2 {
 		compatible = "regulator-fixed";
-		regulator-name = "3P3V";
-		regulator-min-microvolt = <3300000>;
+		regulator-always-on;
 		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "v_3v2";
+		vin-supply = <&v_5v0>;
+	};
+
+	v_5v0: regulator-v-5v0 {
+		compatible = "regulator-fixed";
 		regulator-always-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "v_5v0";
 	};
 
 	v_sd: regulator-v-sd {
@@ -69,29 +78,31 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-name = "v_sd";
 		startup-delay-us = <1000>;
-		vin-supply = <&reg_3p3v>;
+		vin-supply = <&v_3v2>;
 	};
 
-	reg_usbh1_vbus: usb-h1-vbus {
+	v_usb2: regulator-v-usb2 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard_usbh1_vbus>;
-		regulator-name = "usb_h1_vbus";
-		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "v_usb2";
+		vin-supply = <&v_5v0>;
 	};
 
-	reg_usbotg_vbus: usb-otg-vbus {
+	v_usb1: regulator-v-usb1 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard_usbotg_vbus>;
-		regulator-name = "usb_otg_vbus";
-		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "v_usb1";
+		vin-supply = <&v_5v0>;
 	};
 
 	sound-sgtl5000 {
@@ -151,8 +162,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard_sgtl5000>;
 		reg = <0x0a>;
-		VDDA-supply = <&reg_3p3v>;
-		VDDIO-supply = <&reg_3p3v>;
+		VDDA-supply = <&v_3v2>;
+		VDDIO-supply = <&v_3v2>;
 	};
 };
 
@@ -292,7 +303,7 @@
 
 &usbh1 {
 	disable-over-current;
-	vbus-supply = <&reg_usbh1_vbus>;
+	vbus-supply = <&v_usb2>;
 	status = "okay";
 };
 
@@ -300,7 +311,7 @@
 	disable-over-current;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hummingboard_usbotg_id>;
-	vbus-supply = <&reg_usbotg_vbus>;
+	vbus-supply = <&v_usb1>;
 	status = "okay";
 };
 
@@ -314,3 +325,7 @@
 	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&vcc_3v3 {
+	vin-supply = <&v_3v2>;
+};
-- 
2.7.4
