From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 26 Aug 2016 16:42:24 +0200
Subject: [PATCH 2/4] ARM: dts: sun5i: Convert inet-98v-rev2 dts to use
 reference-design-tablet.dtsi
In-Reply-To: <20160826144226.29969-1-hdegoede@redhat.com>
References: <20160826144226.29969-1-hdegoede@redhat.com>
Message-ID: <20160826144226.29969-2-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This results in a nice cleanup :)

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts | 164 +-------------------------
 1 file changed, 1 insertion(+), 163 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts b/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
index 1b11ec9..439ae3b 100644
--- a/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
+++ b/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
@@ -42,171 +42,9 @@
 
 /dts-v1/;
 #include "sun5i-a13.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
+#include "sun5i-reference-design-tablet.dtsi"
 
 / {
 	model = "INet-98V Rev 02";
 	compatible = "primux,inet98v-rev2", "allwinner,sun5i-a13";
-
-	aliases {
-		serial0 = &uart1;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
-	status = "okay";
-
-	axp209: pmic at 34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
-};
-
-#include "axp209.dtsi"
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
-	status = "okay";
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
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_inet98fv2>;
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
-	cd-inverted;
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&pio {
-	mmc0_cd_pin_inet98fv2: mmc0_cd_pin at 0 {
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
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1250000>;
-	regulator-max-microvolt = <1250000>;
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
-};
-
-&reg_usb0_vbus {
-	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_b>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usb0_vbus_pin_a {
-	allwinner,pins = "PG12";
-};
-
-&usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
-	usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
-	usb0_vbus_det-gpio = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_ldo3>;
-	status = "okay";
 };
-- 
2.9.3
