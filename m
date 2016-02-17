From: stefan@agner.ch (Stefan Agner)
Date: Tue, 16 Feb 2016 16:18:35 -0800
Subject: [PATCH v2 1/3] ARM: dts: vf-colibri: remove regulator container node
Message-ID: <1455668317-15728-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the fake simple-bus container 'regulators' and put the
regulators directly under the root node. This also makes the
artificial 'reg' properties superfluous. While at it, name
the regulators according to schematics.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes since v1:
- Rename regulators according to schematics
- Drop sys prefix

 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 43 ++++++++++++-------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index b494673..ca061c9 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -50,32 +50,23 @@
 		clock-frequency = <16000000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		sys_5v0_reg: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "5v0";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 
-		/* USBH_PEN */
-		usbh_vbus_reg: regulator at 1 {
-			compatible = "regulator-fixed";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usbh1_reg>;
-			reg = <1>;
-			regulator-name = "usbh_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio2 19 GPIO_ACTIVE_LOW>;
-			vin-supply = <&sys_5v0_reg>;
-		};
+	reg_usbh_vbus: regulator-usbh-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh1_reg>;
+		regulator-name = "VCC_USB[1-4]";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_LOW>; /* USBH_PEN resp. USBH_P_EN */
+		vin-supply = <&reg_5v0>;
 	};
 };
 
@@ -145,7 +136,7 @@
 };
 
 &usbh1 {
-	vbus-supply = <&usbh_vbus_reg>;
+	vbus-supply = <&reg_usbh_vbus>;
 };
 
 &iomuxc {
-- 
2.7.1
