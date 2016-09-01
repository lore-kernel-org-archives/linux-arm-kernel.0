From: james@innovum.com.au (james at innovum.com.au)
Date: Thu,  1 Sep 2016 13:48:54 +1000
Subject: [PATCH 1/1] ARM: dts: sun8i: Add dts file for the NanoPi NEO SBC
Message-ID: <1472701734-1837-1-git-send-email-james@innovum.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Pettigrew <james@innovum.com.au>

The NanoPi NEO is a minimal H3 based SBC. It comes with 256/512M RAM, a
micro SD slot, 10/100Mbit ethernet and a single USB-A port.

Signed-off-by: James Pettigrew <james@innovum.com.au>
---
 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts | 126 ++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7dd4a07..a35f986 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -792,6 +792,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a83t-allwinner-h8homlet-v2.dtb \
 	sun8i-a83t-cubietruck-plus.dtb \
 	sun8i-h3-bananapi-m2-plus.dtb \
+	sun8i-h3-nanopi-neo.dtb \
 	sun8i-h3-orangepi-2.dtb \
 	sun8i-h3-orangepi-lite.dtb \
 	sun8i-h3-orangepi-one.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
new file mode 100644
index 0000000..3a9eb19
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 2016 James Pettigrew <james@innovum.com.au>
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
+#include "sun8i-h3.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
+
+/ {
+	model = "FriendlyARM NanoPi NEO";
+	compatible = "friendlyarm,nanopi-neo", "allwinner,sun8i-h3";
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
+		pinctrl-0 = <&leds_opc>, <&leds_r_opc>;
+
+		pwr_led {
+			label = "nanopi:green:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		status_led {
+			label = "nanopi:blue:status";
+			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
+	cd-inverted;
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&pio {
+	leds_opc: led_pins at 0 {
+		allwinner,pins = "PA10";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&r_pio {
+	leds_r_opc: led_pins at 0 {
+		allwinner,pins = "PL10";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usbphy {
+	/* USB VBUS is always on */
+	status = "okay";
+};
-- 
1.9.1
