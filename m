From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 19 Aug 2015 18:43:16 +0200
Subject: [linux-sunxi][PATCH] ARM: sun7i: dt: Add new Olimex A20 EVB device
Message-ID: <1440002596-2611-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The A20-SOM-EVB is a reference design of a 2-layer board for the
A20-SOM.
It expands the features of A20-SOM by adding VGA connector, HDMI
connector, audio In/Out, LCD connector, 2 Mpix camera, gigabit
Ethernet, SATA, USB-OTG and 2 USB hosts.

This patch adds basic support for the device
https://www.olimex.com/Products/SOM/A20/A20-SOM-EVB/

More information on the SOM can be found here
http://linux-sunxi.org/Olimex_A20-SOM.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts | 233 ++++++++++++++++++++++++++
 2 files changed, 234 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6d7cec1..fdbda9b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -613,6 +613,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-olinuxino-lime.dtb \
 	sun7i-a20-olinuxino-lime2.dtb \
 	sun7i-a20-olinuxino-micro.dtb \
+	sun7i-a20-olinuxino-evb.dtb \
 	sun7i-a20-orangepi.dtb \
 	sun7i-a20-orangepi-mini.dtb \
 	sun7i-a20-pcduino3.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts
new file mode 100644
index 0000000..a0071fa
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-evb.dts
@@ -0,0 +1,233 @@
+/*
+ * Copyright 2015 - Marcus Cooper <codekipper@gmail.com>
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
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
+
+/ {
+	model = "Olimex A20-OLinuXino-EVB";
+	compatible = "olimex,a20-olinuxino-evb", "allwinner,sun7i-a20";
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
+		pinctrl-0 = <&led_pins_olinuxinoevb>;
+
+		green {
+			label = "a20-olinuxino-evb:green:usr";
+			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+};
+
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	phy = <&phy1>;
+	phy-mode = "rgmii";
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	axp209: pmic at 34 {
+		compatible = "x-powers,axp209";
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		acin-supply = <&reg_axp_ipsout>;
+		vin2-supply = <&reg_axp_ipsout>;
+		vin3-supply = <&reg_axp_ipsout>;
+		ldo24in-supply = <&reg_axp_ipsout>;
+		ldo3in-supply = <&reg_axp_ipsout>;
+
+		regulators {
+			vdd_rtc: ldo1 {
+				regulator-min-microvolt = <1300000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+			};
+
+			avcc: ldo2 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vcc_csi0: ldo3 {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-always-on;
+			};
+
+			vcc_csi1: ldo4 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_cpu: dcdc2 {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <2275000>;
+				regulator-always-on;
+			};
+
+			vdd_int: dcdc3 {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
+	cd-inverted;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	ahci_pwr_pin_olinuxinoevb: ahci_pwr_pin at 1 {
+		allwinner,pins = "PC3";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	led_pins_olinuxinoevb: led_pins at 0 {
+		allwinner,pins = "PH2";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&reg_ahci_5v {
+	pinctrl-0 = <&ahci_pwr_pin_olinuxinoevb>;
+	gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.5.0
