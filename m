From: hdegoede@redhat.com (Hans de Goede)
Date: Tue,  2 Jun 2015 22:08:02 +0200
Subject: [PATCH v2] ARM: dts: sun8i: Add dts file for the GA10H-A33 tablet
In-Reply-To: <1433275682-10886-1-git-send-email-hdegoede@redhat.com>
References: <1433275682-10886-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433275682-10886-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ga10h is an 10" tablet with an A33 or A23 soc, 1G RAM, 8G or 16G nand,
sdio wifi, 2 micro usb ports, 1 otg and 1 host and 1 micro sd slot.

This commit adds a dts file for the v1.1 pcb with an a33 soc.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts | 125 +++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b308baf..37b7f75 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -574,6 +574,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a23-ippo-q8h-v5.dtb \
 	sun8i-a23-ippo-q8h-v1.2.dtb \
 	sun8i-a33-et-q8-v1.6.dtb \
+	sun8i-a33-ga10h-v1.1.dtb \
 	sun8i-a33-ippo-q8h-v1.2-lcd1024x600.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
new file mode 100644
index 0000000..8667033
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
@@ -0,0 +1,125 @@
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
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
+
+/ {
+	model = "Allwinner GA10H Quad Core Tablet (v1.1)";
+	compatible = "allwinner,ga10h-v1.1", "allwinner,sun8i-a33";
+
+	aliases {
+		serial0 = &r_uart;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&lradc {
+	vref-supply = <&reg_vcc3v0>;
+	status = "okay";
+
+	button at 200 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <200000>;
+	};
+
+	button at 400 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <400000>;
+	};
+
+	button at 600 {
+		label = "Back";
+		linux,code = <KEY_BACK>;
+		channel = <0>;
+		voltage = <600000>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_q8h>;
+	vmmc-supply = <&reg_vcc3v0>;
+	bus-width = <4>;
+	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
+	cd-inverted;
+	status = "okay";
+};
+
+&pio {
+	mmc0_cd_pin_q8h: mmc0_cd_pin at 0 {
+		allwinner,pins = "PB4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+};
+
+&r_uart {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_uart_pins_a>;
+	status = "okay";
+};
-- 
2.3.6
