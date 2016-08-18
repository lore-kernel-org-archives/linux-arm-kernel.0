From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 18 Aug 2016 17:11:34 +0200
Subject: [PATCH 1/2] ARM: dts: sun6i: Add
 sun6i-a31-reference-design-tablet.dtsi
Message-ID: <1471533095-13432-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like with a13/a23/a33 most a31 tablets are derived from the same
reference design. Add a .dtsi file with all the common bits to avoid
endless copy and pasting of these.

The sun6i-a31-reference-design-tablet.dtsi this commit adds is a copy
of sun6i-a31s-colorfly-e708-q1.dts with a few tablet specific bits
removed / left in sun6i-a31s-colorfly-e708-q1.dts.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ....dts => sun6i-a31-reference-design-tablet.dtsi} |  26 +---
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts  | 147 +--------------------
 2 files changed, 2 insertions(+), 171 deletions(-)
 copy arch/arm/boot/dts/{sun6i-a31s-colorfly-e708-q1.dts => sun6i-a31-reference-design-tablet.dtsi} (90%)

diff --git a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts b/arch/arm/boot/dts/sun6i-a31-reference-design-tablet.dtsi
similarity index 90%
copy from arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
copy to arch/arm/boot/dts/sun6i-a31-reference-design-tablet.dtsi
index 34d8710..0c43430 100644
--- a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
+++ b/arch/arm/boot/dts/sun6i-a31-reference-design-tablet.dtsi
@@ -40,8 +40,6 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/dts-v1/;
-#include "sun6i-a31s.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
@@ -49,9 +47,6 @@
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
-	model = "Colorfly E708 Q1 tablet";
-	compatible = "colorfly,e708-q1", "allwinner,sun6i-a31s";
-
 	aliases {
 		serial0 = &uart0;
 	};
@@ -66,20 +61,8 @@
 };
 
 &ehci0 {
-	/* rtl8188etv wifi is connected here */
-	status = "okay";
-};
-
-&lradc {
-	vref-supply = <&reg_aldo3>;
+	/* Wifi is connected here */
 	status = "okay";
-
-	button at 1000 {
-		label = "Home";
-		linux,code = <KEY_HOMEPAGE>;
-		channel = <0>;
-		voltage = <1000000>;
-	};
 };
 
 &mmc0 {
@@ -181,12 +164,6 @@
 	regulator-name = "vcc-wifi";
 };
 
-&reg_dldo2 {
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <1800000>;
-	regulator-name = "vcc-pg";
-};
-
 &reg_drivevbus {
 	regulator-name = "usb0-vbus";
 	status = "okay";
@@ -194,7 +171,6 @@
 
 &simplefb_lcd {
 	vcc-lcd-supply = <&reg_dc1sw>;
-	vcc-pg-supply = <&reg_dldo2>;
 };
 
 &usb_otg {
diff --git a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
index 34d8710..e26988a 100644
--- a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
@@ -42,32 +42,11 @@
 
 /dts-v1/;
 #include "sun6i-a31s.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
+#include "sun6i-a31-reference-design-tablet.dtsi"
 
 / {
 	model = "Colorfly E708 Q1 tablet";
 	compatible = "colorfly,e708-q1", "allwinner,sun6i-a31s";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc3>;
-};
-
-&ehci0 {
-	/* rtl8188etv wifi is connected here */
-	status = "okay";
 };
 
 &lradc {
@@ -82,136 +61,12 @@
 	};
 };
 
-&mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_e708_q1>;
-	vmmc-supply = <&reg_dcdc1>;
-	bus-width = <4>;
-	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
-	cd-inverted;
-	status = "okay";
-};
-
-&pio {
-	mmc0_cd_pin_e708_q1: mmc0_cd_pin at 0 {
-		allwinner,pins = "PA8";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-	};
-
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
-		allwinner,pins = "PA15";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-	};
-};
-
-&p2wi {
-	status = "okay";
-
-	axp22x: pmic at 68 {
-		compatible = "x-powers,axp221";
-		reg = <0x68>;
-		interrupt-parent = <&nmi_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-		drivevbus-supply = <&reg_vcc5v0>;
-		x-powers,drive-vbus-en;
-	};
-};
-
-#include "axp22x.dtsi"
-
-&reg_aldo3 {
-	regulator-always-on;
-	regulator-min-microvolt = <2700000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "avcc";
-};
-
-&reg_dc1sw {
-	regulator-name = "vcc-lcd";
-};
-
-&reg_dc5ldo {
-	regulator-always-on;
-	regulator-min-microvolt = <700000>;
-	regulator-max-microvolt = <1320000>;
-	regulator-name = "vdd-cpus"; /* This is an educated guess */
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
-	regulator-min-microvolt = <700000>;
-	regulator-max-microvolt = <1320000>;
-	regulator-name = "vdd-gpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <700000>;
-	regulator-max-microvolt = <1320000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc4 {
-	regulator-always-on;
-	regulator-min-microvolt = <700000>;
-	regulator-max-microvolt = <1320000>;
-	regulator-name = "vdd-sys-dll";
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
 &reg_dldo2 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
 	regulator-name = "vcc-pg";
 };
 
-&reg_drivevbus {
-	regulator-name = "usb0-vbus";
-	status = "okay";
-};
-
 &simplefb_lcd {
-	vcc-lcd-supply = <&reg_dc1sw>;
 	vcc-pg-supply = <&reg_dldo2>;
 };
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
-	usb0_id_det-gpio = <&pio 0 15 GPIO_ACTIVE_HIGH>; /* PA15 */
-	usb0_vbus_power-supply = <&usb_power_supply>;
-	usb0_vbus-supply = <&reg_drivevbus>;
-	usb1_vbus-supply = <&reg_dldo1>;
-	status = "okay";
-};
-- 
2.7.4
