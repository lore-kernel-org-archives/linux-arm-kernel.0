From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  9 Mar 2016 22:50:30 +0100
Subject: [PATCH] ARM: dts: sun6i: Add dts for colorfly e708 q1 tablet
Message-ID: <1457560230-32199-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The colorfly e708 q1 is a 7" tablet which is clearly marked as colorfly
e708 q1 on the back. It features a 9:16 800x1280 IPS LCD, A31s SoC,
1GB RAM, 8G NAND, ilitek 2139qt004 touchscreen on i2c-1 addr 0x41,
stk8313 accelerometer on i2c-2 addr 0x22 and a rtl8188etv wifi chip.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts | 208 ++++++++++++++++++++++
 2 files changed, 209 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ef39613..02505a0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -655,6 +655,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
 	sun6i-a31-i7.dtb \
 	sun6i-a31-m9.dtb \
 	sun6i-a31-mele-a1000g-quad.dtb \
+	sun6i-a31s-colorfly-e708-q1.dtb \
 	sun6i-a31s-cs908.dtb \
 	sun6i-a31s-primo81.dtb \
 	sun6i-a31s-sina31s.dtb \
diff --git a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
new file mode 100644
index 0000000..e182eec
--- /dev/null
+++ b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
@@ -0,0 +1,208 @@
+/*
+ * Copyright 2016 Hans de Goede <hdegoede@redhat.com>
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
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
+
+/ {
+	model = "Colorfly E708 Q1 tablet";
+	compatible = "colorfly,e708-q1", "allwinner,sun6i-a31s";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
+&ehci0 {
+	/* rtl8188etv wifi is connected here */
+	status = "okay";
+};
+
+&lradc {
+	vref-supply = <&reg_aldo3>;
+	status = "okay";
+
+	button at 1000 {
+		label = "Home";
+		linux,code = <KEY_HOMEPAGE>;
+		channel = <0>;
+		voltage = <1000000>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_e708_q1>;
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <4>;
+	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
+	cd-inverted;
+	status = "okay";
+};
+
+&pio {
+	mma8452_int_e708_q1: mma8452_int_pin at 0 {
+		allwinner,pins = "PA9";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	mmc0_cd_pin_e708_q1: mmc0_cd_pin at 0 {
+		allwinner,pins = "PA8";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+};
+
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
+&reg_dc1sw {
+	regulator-name = "vcc-lcd";
+};
+
+&reg_dc5ldo {
+	regulator-always-on;
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-cpus"; /* This is an educated guess */
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
+&reg_dldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-pg";
+};
+
+&simplefb_lcd {
+	vcc-lcd-supply = <&reg_dc1sw>;
+	vcc-pg-supply = <&reg_dldo2>;
+};
+
+/*
+ * FIXME for now we only support host mode and rely on u-boot to have
+ * turned on Vbus which is controlled by the axp221 pmic on the board.
+ *
+ * Once we have axp221 power-supply and vbus-usb support we should switch
+ * to fully supporting otg.
+ */
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_dldo1>;
+	status = "okay";
+};
-- 
2.7.2
