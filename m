From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 19 Dec 2015 16:05:19 +0100
Subject: [linux-sunxi][PATCH v2 3/5] ARM: dts: sun7i: Add Itead Ibox support
In-Reply-To: <1450537521-6476-1-git-send-email-codekipper@gmail.com>
References: <1450537521-6476-1-git-send-email-codekipper@gmail.com>
Message-ID: <1450537521-6476-4-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The Itead Ibox is a multi board device based on the Allwinner A20 SoC.
It contains the A20 Itead Core module and a base board for the external
interfaces.

The core module comes with 4GB NAND and 1GB DDR RAM.

The base board to which the core board is connected provides 3 USB 2.0 Host
ports, 1 USB 2.0 OTG, 1 uSD slot, 10/100 Ethernet port, HDMI, IR receiver,
SPDIF and a 32-pin GPIO header. This header expands the features of core
board by exposing the VGA pins, audio In/Out pins, SATA, SPI, I2C, UARTS,
USB-OTG and power.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts | 111 +++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cc7309b..ee8a1dc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -637,6 +637,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-cubieboard2.dtb \
 	sun7i-a20-cubietruck.dtb \
 	sun7i-a20-hummingbird.dtb \
+	sun7i-a20-itead-ibox.dtb \
 	sun7i-a20-i12-tvbox.dtb \
 	sun7i-a20-icnova-swac.dtb \
 	sun7i-a20-m3.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
new file mode 100644
index 0000000..87125d9
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
@@ -0,0 +1,111 @@
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
+#include "sun7i-a20-itead-core.dtsi"
+
+/ {
+	model = "Itead Ibox A20";
+	compatible = "itead,itead_ibox_a20", "allwinner,sun7i-a20";
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_itead_core>;
+
+		green {
+			label = "itead_core:green:usr";
+			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		blue {
+			label = "itead_core:blue:usr";
+			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins_mii_a>;
+	phy = <&phy1>;
+	phy-mode = "mii";
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
+&ir0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir0_rx_pins_a>;
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
+&pio {
+	led_pins_itead_core: led_pins at 0 {
+		allwinner,pins = "PH20","PH21";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_a>,
+		    <&spi0_cs0_pins_a>;
+	status = "okay";
+};
-- 
1.9.1
