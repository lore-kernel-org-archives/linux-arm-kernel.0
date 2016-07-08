From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  8 Jul 2016 18:05:48 +0200
Subject: [PATCH 07/15] ARM: dts: sun5i: Use sun5i-reference-design-tablet.dtsi
 for utoo p66 dts
In-Reply-To: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467993956-19535-8-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This results in a nice cleanup for this dts file.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 180 ++++---------------------------
 1 file changed, 21 insertions(+), 159 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index fa9ddfd..a8b0bcc 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -42,24 +42,20 @@
 
 /dts-v1/;
 #include "sun5i-a13.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
+#include "sun5i-reference-design-tablet.dtsi"
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
-#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Utoo P66";
 	compatible = "utoo,p66", "allwinner,sun5i-a13";
 
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
-		/* Note levels of 10 / 20% result in backlight off */
-		brightness-levels = <0 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <6>;
-		/* TODO: backlight uses axp gpio1 as enable pin */
+	/* The P66 uses the uart pins as gpios */
+	aliases {
+		/delete-property/serial0;
+	};
+
+	chosen {
+		/delete-property/stdout-path;
 	};
 
 	i2c_lcd: i2c at 0 {
@@ -73,39 +69,21 @@
 	};
 };
 
-&codec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&codec_pa_pin>;
-	allwinner,pa-gpios = <&pio 6 3 GPIO_ACTIVE_HIGH>; /* PG3 */
-	status = "okay";
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
+&backlight {
+	/* Note levels of 10 / 20% result in backlight off */
+	brightness-levels = <0 30 40 50 60 70 80 90 100>;
+	default-brightness-level = <6>;
 };
 
-&ehci0 {
-	status = "okay";
+&codec {
+	allwinner,pa-gpios = <&pio 6 3 GPIO_ACTIVE_HIGH>; /* PG3 */
 };
 
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
-	status = "okay";
-
-	axp209: pmic at 34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
+&codec_pa_pin {
+	allwinner,pins = "PG3";
 };
 
-#include "axp209.dtsi"
-
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
-	status = "okay";
-
 	icn8318: touchscreen at 40 {
 		compatible = "chipone,icn8318";
 		reg = <0x40>;
@@ -119,40 +97,6 @@
 		touchscreen-inverted-x;
 		touchscreen-swapped-x-y;
 	};
-
-	pcf8563: rtc at 51 {
-		compatible = "nxp,pcf8563";
-		reg = <0x51>;
-	};
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button at 200 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <200000>;
-	};
-
-	button at 400 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <400000>;
-	};
-};
-
-&mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_p66>;
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
-	cd-inverted;
-	status = "okay";
 };
 
 &mmc2 {
@@ -170,39 +114,7 @@
 	};
 };
 
-&otg_sram {
-	status = "okay";
-};
-
 &pio {
-	codec_pa_pin: codec_pa_pin at 0 {
-		allwinner,pins = "PG3";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
-	mmc0_cd_pin_p66: mmc0_cd_pin at 0 {
-		allwinner,pins = "PG0";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-	};
-
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
-		allwinner,pins = "PG1";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_PULL_DOWN>;
-	};
-
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
-		allwinner,pins = "PG2";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-	};
-
 	i2c_lcd_pins: i2c_lcd_pin at 0 {
 		allwinner,pins = "PG10", "PG12";
 		allwinner,function = "gpio_out";
@@ -217,67 +129,17 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
-		allwinner,pins = "PB4";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-};
-
-&pwm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins>;
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1500000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-int-pll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_ldo3 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi";
 };
 
 &reg_usb0_vbus {
 	gpio = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-	status = "okay";
 };
 
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
+&uart1 {
+	/* The P66 uses the uart pins as gpios */
+	status = "disabled";
 };
 
-&usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
-	usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
-	usb0_vbus_det-gpio = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_ldo3>;
-	status = "okay";
+&usb0_vbus_pin_a {
+	allwinner,pins = "PB4";
 };
-- 
2.7.4
