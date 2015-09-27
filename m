From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sun, 27 Sep 2015 08:16:42 +0200
Subject: [PATCH v4] ARM: sun7i: dt: Add new Olimex A20 EVB device
Message-ID: <1443334602-1236-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The A20-SOM-EVB is a reference design of a 2-layer board for the
A20-SOM.
It expands the features of A20-SOM by adding VGA connector, HDMI
connector, audio In/Out, LCD connector, 2 Mpix camera, gigabit
Ethernet, SATA, USB-OTG and 2 USB hosts.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
Changes since v3:
- removed i2c1 as it's not used
- removed axp_ipsout regulator
Changes since v2:
- changed dcdc2 to have max voltage of 1.4V
Changes since v1:
- renamed dts from sun7i-a20-olinuxino-evb to sun7i-a20-olimex-som-evb
- added "axp209 dtsi"
- change regulator settings
---
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 202 +++++++++++++++++++++++++
 2 files changed, 203 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1c5f225..0e87a54 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -618,6 +618,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-i12-tvbox.dtb \
 	sun7i-a20-m3.dtb \
 	sun7i-a20-mk808c.dtb \
+	sun7i-a20-olimex-som-evb.dtb \
 	sun7i-a20-olinuxino-lime.dtb \
 	sun7i-a20-olinuxino-lime2.dtb \
 	sun7i-a20-olinuxino-micro.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
new file mode 100644
index 0000000..3317c22
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -0,0 +1,202 @@
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
+	model = "Olimex A20-Olimex-SOM-EVB";
+	compatible = "olimex,a20-olimex-som-evb", "allwinner,sun7i-a20";
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
+		pinctrl-0 = <&led_pins_olimex_som_evb>;
+
+		green {
+			label = "a20-olimex-som-evb:green:usr";
+			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
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
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
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
+	ahci_pwr_pin_olimex_som_evb: ahci_pwr_pin at 1 {
+		allwinner,pins = "PC3";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	led_pins_olimex_som_evb: led_pins at 0 {
+		allwinner,pins = "PH2";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&reg_ahci_5v {
+	pinctrl-0 = <&ahci_pwr_pin_olimex_som_evb>;
+	gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+#include "axp209.dtsi"
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_usb0_vbus {
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
2.5.3
