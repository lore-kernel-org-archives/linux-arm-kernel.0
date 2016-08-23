From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 23 Aug 2016 14:44:50 +0800
Subject: [PATCH 1/2] ARM: dts: sun8i: Add dts file for inet-d978_rev2 tablets
In-Reply-To: <20160823064451.25997-1-icenowy@aosc.xyz>
References: <20160823064451.25997-1-icenowy@aosc.xyz>
Message-ID: <20160823064451.25997-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inet-d978_rev2 is a pcb used in generic A33 based tablets. It features
volume buttons, micro-usb otg, headphone connector and a power button.

On the board a Realtek RTL8723BS SDIO Wi-Fi module are soldered, and there
is also a accompanied board which has a Goodix GT9271 soldered.

As this board is desired to create tablets with a Home key dealed by
GT9271, a LED is present at the front panel at the position of the
Home key.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/Makefile                     |  1 +
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts | 87 ++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index faacd52..d1812a0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -782,6 +782,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a23-q8-tablet.dtb \
 	sun8i-a33-et-q8-v1.6.dtb \
 	sun8i-a33-ga10h-v1.1.dtb \
+	sun8i-a33-inet-d978-rev2.dtb \
 	sun8i-a33-ippo-q8h-v1.2.dtb \
 	sun8i-a33-q8-tablet.dtb \
 	sun8i-a33-sinlinx-sina33.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
new file mode 100644
index 0000000..78823d8
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
@@ -0,0 +1,87 @@
+/*
+ * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
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
+#include "sun8i-reference-design-tablet.dtsi"
+
+/ {
+	model = "INet-D978 Rev 02";
+	compatible = "primux,inet-d978-rev2", "allwinner,sun8i-a33";
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pin_d978>;
+
+		home {
+			label = "d978:home";
+			gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		};
+	};
+};
+
+&mmc1_pins_a {
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>;
+	vmmc-supply = <&reg_dldo1>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	rtl8723bs: sdio_wifi at 1 {
+		reg = <1>;
+	};
+};
+
+&r_pio {
+	led_pin_d978: led_pin_d978 at 0 {
+		allwinner,pins = "PL5";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
-- 
2.9.3
