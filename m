From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Oct 2015 22:49:00 +0800
Subject: [PATCH v2 5/5] ARM: dts: sun6i: Add support for Sinlinx A31s SDK board
In-Reply-To: <1444488540-11263-1-git-send-email-wens@csie.org>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
Message-ID: <1444488540-11263-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Sinlinx A31s SDK is a A31s based module/baseboard development kit.

The core module has the SoC, PMIC, DRAM, eMMC and supporting components.
There are also pads for UART0, JTAG and I2S.

The baseboard has 100 Mbps Ethernet, 5x USB 2.0 host ports via a USB 2.0
hub chip, MMC, HDMI, SPDIF, CIR, audio jacks, 2 tablet-like volume
buttons, RS232 style UART and USB OTG (though VBUS is not connected).
Various headers are available for other addon modules, such as SDIO
WiFi, LCD display, camera sensor, UARTs, I2C, SPI and GPIOs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi | 140 +++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts       | 167 +++++++++++++++++++++++++
 3 files changed, 308 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sina31s.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 342ab3116feb..9fb5ece17b8e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -609,6 +609,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
 	sun6i-a31-m9.dtb \
 	sun6i-a31-mele-a1000g-quad.dtb \
 	sun6i-a31s-cs908.dtb \
+	sun6i-a31s-sina31s.dtb \
 	sun6i-a31s-yones-toptech-bs1078-v2.dtb
 dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-bananapi.dtb \
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
new file mode 100644
index 000000000000..ea69fb8ad4d8
--- /dev/null
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
@@ -0,0 +1,140 @@
+/*
+ * Copyright 2015 Chen-Yu Tsai <wens@csie.org>
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
+#include "sun6i-a31s.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
+
+/ {
+	model = "Sinlinx SinA31s Core Board";
+	compatible = "sinlinx,sina31s", "allwinner,sun6i-a31s";
+
+	aliases {
+		serial0 = &uart0;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
+/* eMMC on core board */
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+/* AXP221s PMIC on core board */
+&p2wi {
+	status = "okay";
+
+	axp22x: pmic at 68 {
+		compatible = "x-powers,axp221";
+		reg = <0x68>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+#include "axp22x.dtsi"
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2700000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "avcc";
+};
+
+&reg_dc5ldo {
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
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
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-gpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc4 {
+	regulator-always-on;
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-sys-dll";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+/* UART0 pads available on core board */
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
new file mode 100644
index 000000000000..80e4fc7138ec
--- /dev/null
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -0,0 +1,167 @@
+/*
+ * Copyright 2015 Chen-Yu Tsai <wens@csie.org>
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
+/* The SinA31s development board has the SinA31s core board soldered on */
+#include "sun6i-a31s-sina31s-core.dtsi"
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Sinlinx SinA31s Development Board";
+	compatible = "sinlinx,sina31s-sdk", "allwinner,sun6i-a31s";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pin_sina31s>;
+
+		status {
+			label = "sina31s:status:usr";
+			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* PH13 */
+		};
+	};
+};
+
+&ehci0 {
+	/* USB 2.0 4 port hub IC */
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins_mii_a>;
+	phy = <&phy1>;
+	phy-mode = "mii";
+	phy-supply = <&reg_dldo1>;
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
+&i2c0 {
+	/* Available on camera header */
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+};
+
+&i2c1 {
+	/* Available on LCD header */
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&ir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir_pins_a>;
+	status = "okay";
+};
+
+&lradc {
+	vref-supply = <&reg_aldo3>;
+	status = "okay";
+
+	button at 158 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <158730>;
+	};
+
+	button at 349 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <349206>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_sina31s>;
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <4>;
+	cd-gpios = <&pio 0 4 GPIO_ACTIVE_HIGH>; /* PA4 */
+	cd-inverted;
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	led_pin_sina31s: led_pin at 0 {
+		allwinner,pins = "PH13";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	mmc0_cd_pin_sina31s: mmc0_cd_pin at 0 {
+		allwinner,pins = "PA4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+};
+
+&reg_dldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-gmac-phy";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.5.3
