From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:51 +0200
Subject: [PATCH 16/20] ARM: dts: sun9i: Remove GPIO pinctrl nodes to avoid
 warnings
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <349ac0811adc34fb98bd66cbe6ee9cdd720236de.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 boards still define some GPIO pinctrl nodes that are not really
useful, and redundant with the muxing already happening on gpio_request.

Let's remove those nodes. This will also remove DTC warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 16 +----------
 arch/arm/boot/dts/sun9i-a80-optimus.dts     | 36 +----------------------
 2 files changed, 2 insertions(+), 50 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 1a09a35d266a..15cc82350360 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -62,8 +62,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_cubieboard4>;
 
 		green {
 			label = "cubieboard4:green:usr";
@@ -97,7 +95,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>, <&wifi_en_pin_cubieboard4>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_dldo1>;
 	vqmmc-supply = <&reg_cldo3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
@@ -131,11 +129,6 @@
 };
 
 &pio {
-	led_pins_cubieboard4: led-pins at 0 {
-		pins = "PH6", "PH17";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_cubieboard4: mmc0_cd_pin at 0 {
 		pins = "PH18";
 		function = "gpio_in";
@@ -147,13 +140,6 @@
 	status = "okay";
 };
 
-&r_pio {
-	wifi_en_pin_cubieboard4: wifi_en_pin at 0 {
-		pins = "PL2";
-		function = "gpio_out";
-	};
-};
-
 &r_rsb {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index cc9e6a88f2a2..199777e1c5ea 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -62,11 +62,8 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_optimus>, <&led_r_pins_optimus>;
 
 		/* The LED names match those found on the board */
-
 		led2 {
 			label = "optimus:led2:usr";
 			gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>;
@@ -86,8 +83,6 @@
 	reg_usb1_vbus: usb1-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-		pinctrl-0 = <&usb1_vbus_pin_optimus>;
-		regulator-name = "usb1-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
@@ -97,8 +92,6 @@
 	reg_usb3_vbus: usb3-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-		pinctrl-0 = <&usb3_vbus_pin_optimus>;
-		regulator-name = "usb3-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
@@ -139,7 +132,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>, <&wifi_en_pin_optimus>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_dldo1>;
 	vqmmc-supply = <&reg_cldo3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
@@ -181,44 +174,17 @@
 };
 
 &pio {
-	led_pins_optimus: led-pins at 0 {
-		pins = "PH0", "PH1";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_optimus: mmc0_cd_pin at 0 {
 		pins = "PH18";
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb1_vbus_pin_optimus: usb1_vbus_pin at 1 {
-		pins = "PH4";
-		function = "gpio_out";
-	};
-
-	usb3_vbus_pin_optimus: usb3_vbus_pin at 1 {
-		pins = "PH5";
-		function = "gpio_out";
-	};
 };
 
 &r_ir {
 	status = "okay";
 };
 
-&r_pio {
-	led_r_pins_optimus: led-pins at 1 {
-		pins = "PM15";
-		function = "gpio_out";
-	};
-
-	wifi_en_pin_optimus: wifi_en_pin at 0 {
-		pins = "PL2";
-		function = "gpio_out";
-	};
-};
-
 &r_rsb {
 	status = "okay";
 
-- 
git-series 0.9.1
