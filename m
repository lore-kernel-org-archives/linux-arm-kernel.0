From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  5 Oct 2015 16:23:10 +0200
Subject: [PATCH v2 5/5] ARM: sun5i: Add C.H.I.P DTS
In-Reply-To: <1444054990-15946-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1444054990-15946-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1444054990-15946-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The C.H.I.P. is a small SBC with an Allwinner R8, 8GB of NAND, 512MB of
RAM, USB host and OTG, a wifi / bluetooth combo chip, an audio/video jack
and two connectors to plug additional boards on top of it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile          |   3 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts | 224 ++++++++++++++++++++++++++++++++++++
 2 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun5i-r8-chip.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c7adaa85ef3f..2cf7e593270a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -600,7 +600,8 @@ dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a13-olinuxino.dtb \
 	sun5i-a13-olinuxino-micro.dtb \
 	sun5i-a13-q8-tablet.dtb \
-	sun5i-a13-utoo-p66.dtb
+	sun5i-a13-utoo-p66.dtb \
+	sun5i-r8-chip.dtb
 dtb-$(CONFIG_MACH_SUN6I) += \
 	sun6i-a31-app4-evb1.dtb \
 	sun6i-a31-colombus.dtb \
diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
new file mode 100644
index 000000000000..08ff70601c79
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -0,1 +1,224 @@
+/*
+ * Copyright 2015 Free Electrons
+ * Copyright 2015 NextThing Co
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
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
+#include "sun5i-a13.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "NextThing C.H.I.P.";
+	compatible = "nextthing,chip", "allwinner,sun5i-r8";
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		serial0 = &uart1;
+		serial1 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	axp209: pmic at 34 {
+		reg = <0x34>;
+
+		/*
+		 * The interrupt is routed through the "External Fast
+		 * Interrupt Request" pin (ball G13 of the module)
+		 * directly to the main interrupt controller, without
+		 * any other controller interfering.
+		 */
+		interrupts = <0>;
+	};
+};
+
+#include "axp209.dtsi"
+
+/*
+ * i2c1 is routed to the external pins and doesn't have any device
+ * attached to it on the C.H.I.P itself.
+ */
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+
+	xio: gpio at 38 {
+		compatible = "nxp,pcf8574a";
+		reg = <0x38>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-parent = <&pio>;
+		interrupts = <6 0 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&pio {
+	chip_vbus_pin: chip_vbus_pin at 0 {
+		allwinner,pins = "PB10";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	chip_id_det_pin: chip_id_det_pin at 0 {
+		allwinner,pins = "PG2";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&reg_dcdc2 {
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "cpuvdd";
+	regulator-always-on;
+};
+
+&reg_dcdc3 {
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1300000>;
+	regulator-name = "corevdd";
+	regulator-always-on;
+};
+
+&reg_ldo1 {
+	regulator-name = "rtcvdd";
+};
+
+&reg_ldo2 {
+	regulator-min-microvolt = <2700000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "avcc";
+	regulator-always-on;
+};
+
+&reg_ldo5 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-1v8";
+};
+
+&reg_usb0_vbus {
+	pinctrl-0 = <&chip_vbus_pin>;
+	vin-supply = <&reg_vcc5v0>;
+	gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>; /* PB10 */
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_b>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins_a>,
+		    <&uart3_pins_cts_rts_a>;
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
+	pinctrl-0 = <&chip_id_det_pin>;
+	status = "okay";
+
+	usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_vcc5v0>;
+};
-- 
2.5.3
