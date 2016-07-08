From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  8 Jul 2016 18:05:49 +0200
Subject: [PATCH 08/15] ARM: dts: Copy sun8i-q8-common.dtsi
 sun8i-reference-design-tablet.dtsi
In-Reply-To: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467993956-19535-9-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy sun8i-q8-common.dtsi to sun8i-reference-design-tablet.dtsi. This
is part of renaming all the sun?i-q8-common.dtsi files to
sun?i-reference-design-tablet.dtsi since most of the hw-config in there
is shared by all sunxi tablets.

Note that in this case we keep sun5i-q8-common.dtsi as it is shared
between a23 / a33 q8 tablets. Also we leave the usb-wifi config in
there (rather then in sun8i-reference-design-tablet.dtsi) as most
sun8i tablets use sdio wifi rather then usb wifi.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-q8-common.dtsi             | 171 +--------------------
 ...mon.dtsi => sun8i-reference-design-tablet.dtsi} |  13 +-
 2 files changed, 5 insertions(+), 179 deletions(-)
 copy arch/arm/boot/dts/{sun8i-q8-common.dtsi => sun8i-reference-design-tablet.dtsi} (96%)

diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
index 0b85ea4..60fa958 100644
--- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
@@ -40,181 +40,12 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 #include "sunxi-reference-design-tablet.dtsi"
-
-#include <dt-bindings/pwm/pwm.h>
-
-/ {
-	aliases {
-		serial0 = &r_uart;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_en_pin_q8>;
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
+#include "sun8i-reference-design-tablet.dtsi"
 
 &ehci0 {
 	status  = "okay";
 };
 
-&mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_q8>;
-	vmmc-supply = <&reg_dcdc1>;
-	bus-width = <4>;
-	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-	cd-inverted;
-	status = "okay";
-};
-
-&pio {
-	bl_en_pin_q8: bl_en_pin at 0 {
-		allwinner,pins = "PH6";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
-	mmc0_cd_pin_q8: mmc0_cd_pin at 0 {
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
-&reg_drivevbus {
-	regulator-name = "usb0-vbus";
-	status = "okay";
-};
-
-&reg_rtc_ldo {
-	regulator-name = "vcc-rtc";
-};
-
-&r_uart {
-	pinctrl-names = "default";
-	pinctrl-0 = <&r_uart_pins_a>;
-	status = "okay";
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
 &usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_detect_pin>;
-	usb0_id_det-gpio = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
-	usb0_vbus_power-supply = <&usb_power_supply>;
-	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_dldo1>;
-	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
similarity index 96%
copy from arch/arm/boot/dts/sun8i-q8-common.dtsi
copy to arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 0b85ea4..b8546ef 100644
--- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -51,7 +51,7 @@
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
-		pinctrl-0 = <&bl_en_pin_q8>;
+		pinctrl-0 = <&bl_en_pin>;
 		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
 		default-brightness-level = <8>;
@@ -63,13 +63,9 @@
 	};
 };
 
-&ehci0 {
-	status  = "okay";
-};
-
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_q8>;
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
@@ -78,14 +74,14 @@
 };
 
 &pio {
-	bl_en_pin_q8: bl_en_pin at 0 {
+	bl_en_pin: bl_en_pin at 0 {
 		allwinner,pins = "PH6";
 		allwinner,function = "gpio_in";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	mmc0_cd_pin_q8: mmc0_cd_pin at 0 {
+	mmc0_cd_pin: mmc0_cd_pin at 0 {
 		allwinner,pins = "PB4";
 		allwinner,function = "gpio_in";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
@@ -215,6 +211,5 @@
 	usb0_id_det-gpio = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
 	usb0_vbus_power-supply = <&usb_power_supply>;
 	usb0_vbus-supply = <&reg_drivevbus>;
-	usb1_vbus-supply = <&reg_dldo1>;
 	status = "okay";
 };
-- 
2.7.4
