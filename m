From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 24 Jun 2016 12:10:01 +0200
Subject: [PATCH v3] ARM: sun8i: Add Parrot Board DTS
Message-ID: <1466763001-24117-1-git-send-email-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Parrot Board is an evaluation board with an Allwinner R16 (assumed
to be close to an Allwinner A33), 4GB of eMMC, 512MB of RAM, USB host
and OTG, a WiFi/Bluetooth combo chip, a micro SD Card reader, 2
controllable buttons, an LVDS port with separated backlight and
capacitive touch panel ports, an audio/microphone jack, a camera CSI
port, 2 sets of 22 GPIOs and an accelerometer.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---

Patch dependency:
 - phy-sun4i-usb: Add workaround for missing Vbus det interrupts on A31
or the micro USB port would not be powered.

v2:
 - correct typos,
 - chose less generic name suffix for nodes (now_parrot_r16),
 - add comment for i2c childless node,
 - add comment for two regulators-powered WiFi chip,
 - add comment to explicit the use of some regulators,
 - add usb_vbus_power-supply property in usbphy node (this adds a
   dependance to an other patch),

v3:
 - change compatible name from "allwinner,parrot-evb-r16" to
   "allwinner,parrot",
 - rename name suffix for nodes (now _parrot),
 - edited and removed comments,
 - removed dependencies that are already merged,
 - re-order alphabetically the DTB Makefile,

 arch/arm/boot/dts/Makefile             |   3 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts | 348 +++++++++++++++++++++++++++++++++
 2 files changed, 350 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun8i-r16-parrot.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2b6472c..bbabc58 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -777,7 +777,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-orangepi-one.dtb \
 	sun8i-h3-orangepi-pc.dtb \
 	sun8i-h3-orangepi-plus.dtb \
-	sun8i-h3-sinovoip-bpi-m2-plus.dtb
+	sun8i-h3-sinovoip-bpi-m2-plus.dtb \
+	sun8i-r16-parrot.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb
diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
new file mode 100644
index 0000000..39c40be
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
@@ -0,0 +1,348 @@
+/*
+ * Copyright 2016 Quentin Schulz
+ *
+ * Quentin Schulz <quentin.schulz@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "sun8i-a33.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Allwinner R16 EVB (Parrot)";
+	compatible = "allwinner,parrot", "allwinner,sun8i-a33";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_parrot>;
+
+		led1 {
+			label = "parrot:led1:usr";
+			gpio = <&pio 4 17 GPIO_ACTIVE_HIGH>; /* PE17 */
+		};
+
+		led2 {
+			label = "parrot:led2:usr";
+			gpio = <&pio 4 16 GPIO_ACTIVE_HIGH>; /* PE16 */
+		};
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL06 */
+	};
+
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+
+	/* FIXME: An as-yet-unknown accelerometer is connected to this i2c bus. */
+};
+
+&lradc {
+	vref-supply = <&reg_aldo3>;
+	status = "okay";
+
+	button at 0 {
+		label = "V+";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <190000>;
+	};
+
+	button at 1 {
+		label = "V-";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <390000>;
+	};
+
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_parrot>;
+	vmmc-supply = <&reg_dcdc1>;
+	cd-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>, <&wifi_reset_pin_parrot>;
+	vmmc-supply = <&reg_aldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&mmc2_8bit_pins {
+	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pio {
+	mmc0_cd_pin_parrot: mmc0_cd_pin at 0 {
+		allwinner,pins = "PD14";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	led_pins_parrot: led_pins at 0 {
+		allwinner,pins = "PE16", "PE17";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	usb0_id_det: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PD10";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	usb1_vbus_pin_parrot: usb1_vbus_pin at 0 {
+		allwinner,pins = "PD12";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&r_pio {
+	wifi_reset_pin_parrot: wifi_reset_pin at 0 {
+		allwinner,pins = "PL6";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&r_rsb {
+	status = "okay";
+
+	axp22x: pmic at 3a3 {
+		compatible = "x-powers,axp223";
+		reg = <0x3a3>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		drivevbus-supply = <&reg_vcc5v0>;
+		x-powers,drive-vbus-en;
+	};
+};
+
+#include "axp22x.dtsi"
+
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-io";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <2350000>;
+	regulator-max-microvolt = <2650000>;
+	regulator-name = "vdd-dll";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2700000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-pll-avcc";
+};
+
+&reg_dc5ldo {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpus";
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-3v0";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_dldo1 {
+	/*
+	 * TODO: WiFi chip needs dldo1 AND dldo2 to be on to be powered.
+	 * Remove next line once it is possible to sync two regulators.
+	 */
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi0";
+};
+
+&reg_dldo2 {
+	/*
+	 * TODO: WiFi chip needs dldo1 AND dldo2 to be on to be powered.
+	 * Remove next line once it is possible to sync two regulators.
+	 */
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi1";
+};
+
+&reg_dldo3 {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-3v0-csi";
+};
+
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
+&reg_eldo1 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vcc-1v2-hsic";
+};
+
+&reg_eldo2 {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-dsp";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "eldo3";
+};
+
+&reg_usb1_vbus {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_vbus_pin_parrot>;
+	gpio = <&pio 3 12 GPIO_ACTIVE_HIGH>; /* PD12 */
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_b>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_det>;
+	usb0_vbus-supply = <&reg_drivevbus>;
+	usb0_id_det-gpios = <&pio 3 10 GPIO_ACTIVE_HIGH>; /* PD10 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+};
-- 
2.5.0
