From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  8 Jul 2016 18:05:51 +0200
Subject: [PATCH 10/15] ARM: dts: sun8i: Use sun8i-reference-design-tablet for
 polaroid mid2809pxe04
In-Reply-To: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467993956-19535-11-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This results in quite a nice cleanup for this dts file.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   | 207 +--------------------
 1 file changed, 1 insertion(+), 206 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
index e8c3f21..6d06e24 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
@@ -42,214 +42,9 @@
 
 /dts-v1/;
 #include "sun8i-a23.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
-#include <dt-bindings/pwm/pwm.h>
+#include "sun8i-reference-design-tablet.dtsi"
 
 / {
 	model = "Polaroid MID2809PXE04 tablet";
 	compatible = "polaroid,mid2809pxe04", "allwinner,sun8i-a23";
-
-	aliases {
-		serial0 = &r_uart;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_en_pin_mid2809>;
-		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <8>;
-		enable-gpios = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
-	status = "okay";
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
-	status = "okay";
-};
-
-&lradc {
-	vref-supply = <&reg_vcc3v0>;
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
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_mid2809>;
-	vmmc-supply = <&reg_dcdc1>;
-	bus-width = <4>;
-	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-	cd-inverted;
-	status = "okay";
-};
-
-&pio {
-	bl_en_pin_mid2809: bl_en_pin at 0 {
-		allwinner,pins = "PH6";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
-	mmc0_cd_pin_mid2809: mmc0_cd_pin at 0 {
-		allwinner,pins = "PB4";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-	};
-
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
-		allwinner,pins = "PH8";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-	};
-};
-
-&pwm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins>;
-	status = "okay";
-};
-
-&r_rsb {
-	status = "okay";
-
-	axp22x: pmic at 3a3 {
-		compatible = "x-powers,axp223";
-		reg = <0x3a3>;
-		interrupt-parent = <&nmi_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-		eldoin-supply = <&reg_dcdc1>;
-		x-powers,drive-vbus-en;
-	};
-};
-
-&r_uart {
-	pinctrl-names = "default";
-	pinctrl-0 = <&r_uart_pins_a>;
-	status = "okay";
-};
-
-#include "axp22x.dtsi"
-
-&reg_aldo1 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "vcc-io";
-};
-
-&reg_aldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <2350000>;
-	regulator-max-microvolt = <2650000>;
-	regulator-name = "vdd-dll";
-};
-
-&reg_aldo3 {
-	regulator-always-on;
-	regulator-min-microvolt = <2700000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-pll-avcc";
-};
-
-&reg_dc1sw {
-	regulator-name = "vcc-lcd";
-};
-
-&reg_dc5ldo {
-	regulator-always-on;
-	regulator-min-microvolt = <900000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpus";
-};
-
-&reg_dcdc1 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "vcc-3v0";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <900000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-sys";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <900000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc5 {
-	regulator-always-on;
-	regulator-min-microvolt = <1500000>;
-	regulator-max-microvolt = <1500000>;
-	regulator-name = "vcc-dram";
-};
-
-&reg_drivevbus {
-	regulator-name = "usb0-vbus";
-	status = "okay";
-};
-
-&reg_rtc_ldo {
-	regulator-name = "vcc-rtc";
-};
-
-&simplefb_lcd {
-	vcc-lcd-supply = <&reg_dc1sw>;
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usb_power_supply {
-	status = "okay";
-};
-
-&usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_detect_pin>;
-	usb0_id_det-gpio = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
-	usb0_vbus_power-supply = <&usb_power_supply>;
-	usb0_vbus-supply = <&reg_drivevbus>;
-	status = "okay";
 };
-- 
2.7.4
