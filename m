From: stefan.mavrodiev@gmail.com (Stefan Mavrodiev)
Date: Mon, 15 Aug 2016 10:36:33 +0300
Subject: [PATCH v5] ARM: dts: sun8i: Add dts file for Olimex A33-OLinuXino
In-Reply-To: <20160728175330.GC6682@lukather>
References: <20160728175330.GC6682@lukather>
Message-ID: <1471246595-9316-1-git-send-email-stefan.mavrodiev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A33-OLinuXino is A33 development board designed by Olimex LTD.

It has AXP233 PMU, 1GB DRAM, a micro SD card, one USB-OTG connector,
headphone and mic jacks, connector for LiPo battery and optional
4GB NAND Flash.

It has two 40-pin headers. One for LCD panel, and one for
additional modules. Also there is CSI/DSI connector.

Signed-off-by: Stefan Mavrodiev <stefan.mavrodiev@gmail.com>
---
Changes for v2:
        - Removed unused power nodes
        - Removed default-trigger for green led
        - Removed "always-on" option for LCD power

Changes for v3:
        - Nodes are sorted alphabetically

Changes for v4:
        - Green led renamed
        - Added OTG support

Changes for v5:
	- Renamed dcdc1 regulator
	- indentation fixes

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 226 ++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a33-olinuxino.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6b3bdb6..75cd98a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -783,6 +783,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a33-et-q8-v1.6.dtb \
 	sun8i-a33-ga10h-v1.1.dtb \
 	sun8i-a33-ippo-q8h-v1.2.dtb \
+	sun8i-a33-olinuxino.dtb \
 	sun8i-a33-q8-tablet.dtb \
 	sun8i-a33-sinlinx-sina33.dtb \
 	sun8i-a83t-allwinner-h8homlet-v2.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
new file mode 100644
index 0000000..9ea637e
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -0,0 +1,226 @@
+/*
+ * Copyright 2016 - Stefan Mavrodiev <stefan.mavrodiev@gmail.com>
+ *                  Olimex LTD. <support@olimex.com>
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
+	model = "Olimex A33-OLinuXino";
+	compatible = "olimex,a33-olinuxino","allwinner,sun8i-a33";
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
+		pinctrl-0 = <&led_pin_olinuxino>;
+
+		green {
+			label = "a33-olinuxino:green:usr";
+			gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino>;
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <4>;
+	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
+	cd-inverted;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pio {
+	led_pin_olinuxino: led_pins at 0 {
+		allwinner,pins = "PB7";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	mmc0_cd_pin_olinuxino: mmc0_cd_pin at 0 {
+		allwinner,pins = "PB4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PB3";
+		allwinner,function = "gpio_in";
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
+		eldoin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
+	};
+};
+
+#include "axp22x.dtsi"
+
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
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
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-avcc";
+};
+
+&reg_dc1sw {
+	regulator-name = "vcc-lcd";
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
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
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
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
+&reg_rtc_ldo {
+	regulator-name = "vcc-rtc";
+};
+
+&simplefb_lcd {
+	vcc-lcd-supply = <&reg_dc1sw>;
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>;
+	usb0_id_det-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_drivevbus>;
+	status = "okay";
+};
-- 
2.8.1
