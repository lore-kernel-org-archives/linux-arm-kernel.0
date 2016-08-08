From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  8 Aug 2016 21:43:11 +0200
Subject: [PATCH 1/8] ARM: dts: sun8i: Use sun8i-reference-design-tablet for
 gt90h dts
Message-ID: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This results in quite a nice cleanup for this dts file.

As an added bonus this also enables full otg support. I've tested that
this works as advertised.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts | 192 +------------------------------
 1 file changed, 1 insertion(+), 191 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
index b2ce284..f27ebbb 100644
--- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
+++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
@@ -42,70 +42,18 @@
 
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
 	model = "Allwinner GT90H Dual Core Tablet (v4)";
 	compatible = "allwinner,gt90h-v4", "allwinner,sun8i-a23";
-
-	aliases {
-		serial0 = &r_uart;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_en_pin_gt90h>;
-		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <8>;
-		enable-gpios = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
 };
 
 &ehci0 {
 	status = "okay";
 };
 
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
 &lradc {
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
-
 	button at 600 {
 		label = "Back";
 		linux,code = <KEY_BACK>;
@@ -114,144 +62,6 @@
 	};
 };
 
-&mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_gt90h>;
-	vmmc-supply = <&reg_aldo1>;
-	bus-width = <4>;
-	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-	cd-inverted;
-	status = "okay";
-};
-
-&pio {
-	bl_en_pin_gt90h: bl_en_pin at 0 {
-		allwinner,pins = "PH6";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
-	mmc0_cd_pin_gt90h: mmc0_cd_pin at 0 {
-		allwinner,pins = "PB4";
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
-&reg_dldo1 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi";
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
-/*
- * FIXME for now we only support host mode and rely on u-boot to have
- * turned on Vbus which is controlled by the axp223 pmic on the board.
- *
- * Once we have axp223 support we should switch to fully supporting otg.
- */
-&usb_otg {
-	dr_mode = "host";
-	status = "okay";
-};
-
 &usbphy {
 	usb1_vbus-supply = <&reg_dldo1>;
-	status = "okay";
 };
-- 
2.7.4
