From: atx@atx.name (Josef Gajdusek)
Date: Sun, 19 Jul 2015 15:45:03 +0200
Subject: [PATCH] ARM: dts: sun4i: Add Iteaduino Plus A10
Message-ID: <20150719134501.GA19235@maud>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Iteaduino Plus A10 is a breakout board + Itead Core A10. It features 1GB RAM,
has most of the A10 pins on a .1" header, 2 USB ports, 1 OTG USB port,
Ethernet, HDMI, SATA, Speaker/Microphone 3.5mm jacks and an SD card slot.

Link to manufacturer wiki: http://wiki.iteadstudio.com/Iteaduino_Plus_A10/A20

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/sun4i-a10-iteaduino-plus.dts | 202 +++++++++++++++++++++++++
 2 files changed, 203 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-iteaduino-plus.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index adb1826..6104ed1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -529,6 +529,7 @@ dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-hackberry.dtb \
 	sun4i-a10-hyundai-a7hd.dtb \
 	sun4i-a10-inet97fv2.dtb \
+	sun4i-a10-iteaduino-plus.dts \
 	sun4i-a10-jesurun-q5.dtb \
 	sun4i-a10-marsboard.dtb \
 	sun4i-a10-mini-xplus.dtb \
diff --git a/arch/arm/boot/dts/sun4i-a10-iteaduino-plus.dts b/arch/arm/boot/dts/sun4i-a10-iteaduino-plus.dts
new file mode 100644
index 0000000..985e155
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i-a10-iteaduino-plus.dts
@@ -0,0 +1,202 @@
+/*
+ * Copyright 2015 Josef Gajdusek <atx@atx.name>
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
+#include "sun4i-a10.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
+
+/ {
+	model = "Iteaduino Plus A10";
+	compatible = "itead,iteaduino-plus-a10", "allwinner,sun4i-a10";
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
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
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
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_pins_a>;
+	phy = <&phy1>;
+	status = "okay";
+};
+
+&emac_sram {
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
+		interrupts = <0>;
+	};
+};
+
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
+};
+
+&ir0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir0_rx_pins_a>;
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
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
+&reg_ahci_5v {
+	status = "okay";
+};
+
+#include "axp209.dtsi"
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1450000>;
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
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_a>,
+		    <&spi0_cs0_pins_a>;
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
2.3.6
