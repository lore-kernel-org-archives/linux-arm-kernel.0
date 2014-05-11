From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 11 May 2014 16:39:17 -0300
Subject: [PATCH 2/2] ARM: dts: imx23-olinuxino: Restructure device tree file
In-Reply-To: <1399837157-28080-1-git-send-email-festevam@gmail.com>
References: <1399837157-28080-1-git-send-email-festevam@gmail.com>
Message-ID: <1399837157-28080-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Use the device tree format as used on other imx dts files. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23-olinuxino.dts | 153 ++++++++++++++++------------------
 arch/arm/boot/dts/imx23.dtsi          |   2 +-
 2 files changed, 74 insertions(+), 81 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index 7e6eef2..fd3f573 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -22,79 +22,14 @@
 		reg = <0x40000000 0x04000000>;
 	};
 
-	apb at 80000000 {
-		apbh at 80000000 {
-			ssp0: ssp at 80010000 {
-				compatible = "fsl,imx23-mmc";
-				pinctrl-names = "default";
-				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
-				bus-width = <4>;
-				broken-cd;
-				status = "okay";
-			};
-
-			pinctrl at 80018000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&hog_pins_a>;
-
-				hog_pins_a: hog at 0 {
-					reg = <0>;
-					fsl,pinmux-ids = <
-						MX23_PAD_GPMI_ALE__GPIO_0_17
-					>;
-					fsl,drive-strength = <MXS_DRIVE_4mA>;
-					fsl,voltage = <MXS_VOLTAGE_HIGH>;
-					fsl,pull-up = <MXS_PULL_DISABLE>;
-				};
-
-				led_pin_gpio2_1: led_gpio2_1 at 0 {
-					reg = <0>;
-					fsl,pinmux-ids = <
-						MX23_PAD_SSP1_DETECT__GPIO_2_1
-					>;
-					fsl,drive-strength = <MXS_DRIVE_4mA>;
-					fsl,voltage = <MXS_VOLTAGE_HIGH>;
-					fsl,pull-up = <MXS_PULL_DISABLE>;
-				};
-			};
-
-			ssp1: ssp at 80034000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx23-spi";
-				pinctrl-names = "default";
-				pinctrl-0 = <&spi2_pins_a>;
-				status = "okay";
-			};
-		};
-
-		apbx at 80040000 {
-			lradc at 80050000 {
-				status = "okay";
-			};
-
-			duart: serial at 80070000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&duart_pins_a>;
-				status = "okay";
-			};
-
-			auart0: serial at 8006c000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&auart0_2pins_a>;
-				status = "okay";
-			};
-
-			usbphy0: usbphy at 8007c000 {
-				status = "okay";
-			};
-		};
-	};
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pin_gpio2_1>;
 
-	ahb at 80080000 {
-		usb0: usb at 80080000 {
-			vbus-supply = <&reg_usb0_vbus>;
-			status = "okay";
+		user {
+			label = "green";
+			gpios = <&gpio2 1 1>;
 		};
 	};
 
@@ -115,14 +50,72 @@
 		};
 	};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pin_gpio2_1>;
+};
 
-		user {
-			label = "green";
-			gpios = <&gpio2 1 1>;
-		};
+&auart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&auart0_2pins_a>;
+	status = "okay";
+};
+
+&duart {
+	pinctrl-names = "default";
+	pinctrl-0 = <&duart_pins_a>;
+	status = "okay";
+};
+
+&lradc {
+	status = "okay";
+};
+
+&ssp0 {
+	compatible = "fsl,imx23-mmc";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
+	bus-width = <4>;
+	broken-cd;
+	status = "okay";
+};
+
+&ssp1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,imx23-spi";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>;
+	status = "okay";
+};
+
+&usb0 {
+	vbus-supply = <&reg_usb0_vbus>;
+	status = "okay";
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hog_pins_a>;
+
+	hog_pins_a: hog at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX23_PAD_GPMI_ALE__GPIO_0_17
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+
+	led_pin_gpio2_1: led_gpio2_1 at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX23_PAD_SSP1_DETECT__GPIO_2_1
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index bbcfb5a..b8b4a3d 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -103,7 +103,7 @@
 				status = "disabled";
 			};
 
-			pinctrl at 80018000 {
+			pinctrl: pinctrl at 80018000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx23-pinctrl", "simple-bus";
-- 
1.8.3.2
