From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 23 Mar 2016 23:14:16 +0100
Subject: [PATCH] ARM: dts: sun8i: Base Orange Pi Plus dts on the Orange Pi 2
 dts
Message-ID: <1458771256-4069-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orange Pi Plus really is an Orange Pi 2 extended with:
1) A sata <-> usb bridge connected to ehci3
2) An eMMC on mmc2
3) An external gigabit ethernet phy instead of the integrated 100Mbit phy

This commit changes the dts to reflect this by making it include
the Orange Pi 2 dts and then adding the extra bits.

Note that the difference in ethernet phy is not taken into account
because we do not have an ethernet driver for the H3 yet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 136 +--------------------------
 1 file changed, 2 insertions(+), 134 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index 94f8b0b..b0cb417 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -40,61 +40,13 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/dts-v1/;
-#include "sun8i-h3.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
+/* The Orange Pi Plus is an extended version of the Orange Pi 2 */
+#include "sun8i-h3-orangepi-2.dts"
 
 / {
 	model = "Xunlong Orange Pi Plus";
 	compatible = "xunlong,orangepi-plus", "allwinner,sun8i-h3";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_opc>, <&leds_r_opc>;
-
-		status_led {
-			label = "orangepi-plus:red:status";
-			gpios = <&pio 0 15 GPIO_ACTIVE_HIGH>;
-		};
-
-		pwr_led {
-			label = "orangepi-plus:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
-	r_gpio_keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&sw_r_opc>;
-
-		sw2 {
-			label = "sw2";
-			linux,code = <BTN_1>;
-			gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>;
-		};
-
-		sw4 {
-			label = "sw4";
-			linux,code = <BTN_0>;
-			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
-		};
-	};
-
 	reg_usb3_vbus: usb3-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -106,49 +58,12 @@
 		enable-active-high;
 		gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
 	};
-
-	wifi_pwrseq: wifi_pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_pwrseq_pin_orangepi>;
-		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 WIFI_EN */
-	};
-};
-
-&ehci1 {
-	status = "okay";
 };
 
 &ehci3 {
 	status = "okay";
 };
 
-&ir {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
-	status = "okay";
-};
-
-&mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
-	status = "okay";
-};
-
-&mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
-	vmmc-supply = <&reg_vcc3v3>;
-	mmc-pwrseq = <&wifi_pwrseq>;
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
-};
-
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_8bit_pins>;
@@ -167,13 +82,6 @@
 };
 
 &pio {
-	leds_opc: led_pins at 0 {
-		allwinner,pins = "PA15";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
 	usb3_vbus_pin_a: usb3_vbus_pin at 0 {
 		allwinner,pins = "PG11";
 		allwinner,function = "gpio_out";
@@ -182,46 +90,6 @@
 	};
 };
 
-&r_pio {
-	leds_r_opc: led_pins at 0 {
-		allwinner,pins = "PL10";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
-	sw_r_opc: key_pins at 0 {
-		allwinner,pins = "PL3", "PL4";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
-	wifi_pwrseq_pin_orangepi: wifi_pwrseq_pin at 0 {
-		allwinner,pins = "PL7";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-};
-
-&reg_usb1_vbus {
-	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
-	status = "okay";
-};
-
-&usb1_vbus_pin_a {
-	allwinner,pins = "PG13";
-};
-
 &usbphy {
-	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb3_vbus-supply = <&reg_usb3_vbus>;
-	status = "okay";
 };
-- 
2.7.3
