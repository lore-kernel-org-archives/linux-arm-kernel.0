From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 16:53:06 +0000
Subject: [PATCH 12/13] ARM: dts: imx6qdl-cubox-i: rename regulators to match
 schematic
In-Reply-To: <20171127165134.GH31757@n2100.armlinux.org.uk>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
Message-ID: <E1eJMeY-0002rm-9W@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the regulators match the schematic - name the regulators after
one of their schematic supply names, and arrange them into their
heirarchy.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 98ec7ce1f2a3..7a3fba776661 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -62,34 +62,36 @@
 		};
 	};
 
-	reg_3p3v: 3p3v {
+	v_5v0: regulator-v-5v0 {
 		compatible = "regulator-fixed";
-		regulator-name = "3P3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "v_5v0";
 	};
 
-	reg_usbh1_vbus: usb-h1-vbus {
+	v_usb2: regulator-v-usb2 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 0 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_cubox_i_usbh1_vbus>;
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
 		gpio = <&gpio3 22 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_cubox_i_usbotg_vbus>;
-		regulator-name = "usb_otg_vbus";
-		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "v_usb1";
+		vin-supply = <&v_5v0>;
 	};
 
 	sound-spdif {
@@ -237,21 +239,25 @@
 &usbh1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cubox_i_usbh1>;
-	vbus-supply = <&reg_usbh1_vbus>;
+	vbus-supply = <&v_usb2>;
 	status = "okay";
 };
 
 &usbotg {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cubox_i_usbotg>;
-	vbus-supply = <&reg_usbotg_vbus>;
+	vbus-supply = <&v_usb1>;
 	status = "okay";
 };
 
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2>;
-	vmmc-supply = <&reg_3p3v>;
+	vmmc-supply = <&vcc_3v3>;
 	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&vcc_3v3 {
+	vin-supply = <&v_5v0>;
+};
-- 
2.7.4
