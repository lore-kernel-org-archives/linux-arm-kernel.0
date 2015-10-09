From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Fri,  9 Oct 2015 14:09:38 +0300
Subject: [PATCH v2 2/3] ARM: sun4i: dt: Add new LinkSprite pcDuino2 board
In-Reply-To: <1444388979-12072-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1444388979-12072-1-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <1444388979-12072-3-git-send-email-siarhei.siamashka@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LinkSprite pcDuino2 board is almost identical to the older
LinkSprite pcDuino1 board according to the schematic pdf files.
So we just include the existing "sun4i-a10-pcduino.dts" file and
make the necessary adjustments.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
---
 arch/arm/boot/dts/Makefile               |  3 +-
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts | 78 ++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-pcduino2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 342ab31..c10d5aa 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -587,7 +587,8 @@ dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-mk802.dtb \
 	sun4i-a10-mk802ii.dtb \
 	sun4i-a10-olinuxino-lime.dtb \
-	sun4i-a10-pcduino.dtb
+	sun4i-a10-pcduino.dtb \
+	sun4i-a10-pcduino2.dtb
 dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a10s-auxtek-t003.dtb \
 	sun5i-a10s-auxtek-t004.dtb \
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino2.dts b/arch/arm/boot/dts/sun4i-a10-pcduino2.dts
new file mode 100644
index 0000000..de483a1
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino2.dts
@@ -0,0 +1,78 @@
+/*
+ * Copyright 2015 Siarhei Siamashka <siarhei.siamashka@gmail.com>
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
+/*
+ * The LinkSprite pcDuino2 board is almost identical to the older
+ * LinkSprite pcDuino1 board. The only software visible difference
+ * is that the pcDuino2 board got a USB VBUS voltage regulator, which
+ * is controlled by the PD2 pin (pulled-up by default). Also one of
+ * the USB host ports has been replaced with a USB WIFI chip.
+ */
+
+#include "sun4i-a10-pcduino.dts"
+
+/ {
+	model = "LinkSprite pcDuino2";
+	compatible = "linksprite,a10-pcduino2", "allwinner,sun4i-a10";
+};
+
+&pio {
+	usb2_vbus_pin_pcduino2: usb2_vbus_pin at 0 {
+		allwinner,pins = "PD2";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&reg_usb2_vbus {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_vbus_pin_pcduino2>;
+	gpio = <&pio 3 2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc3v3>; /* USB WIFI is always on */
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.4.9
