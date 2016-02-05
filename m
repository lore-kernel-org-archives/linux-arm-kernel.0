From: rogershimizu@gmail.com (Roger Shimizu)
Date: Sat,  6 Feb 2016 01:33:18 +0900
Subject: [PATCH 3/3] ARM: dts: orion5x: add device tree for buffalo
 linkstation ls-gl
In-Reply-To: <1454689998-9579-1-git-send-email-rogershimizu@gmail.com>
References: <1454689998-9579-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1454689998-9579-4-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dts file to support Buffalo Linkstation LS-GL
(a.k.a Buffalo Linkstation Pro/Live), which is marvell orion5x based
3.5" HDD NAS.

Product info:
  - (JPN) http://buffalo.jp/products/catalog/item/l/ls-gl/
  - (ENG) http://www.buffalotech.com/products/network-storage/linkstation/linkstation-pro

This device tree is based on the board file:
  arch/arm/mach-orion5x/kurobox_pro-setup.c
However, that board file also support Kurobox Pro, which is not supported by
device tree yet. So the board file is not removed.

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 arch/arm/boot/dts/Makefile                     |  1 +
 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts | 87 ++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 68625754f398..15a52c1be78a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -496,6 +496,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
 dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-lacie-d2-network.dtb \
 	orion5x-lacie-ethernet-disk-mini-v2.dtb \
+	orion5x-linkstation-lsgl.dtb \
 	orion5x-linkstation-lswtgl.dtb \
 	orion5x-lswsgl.dtb \
 	orion5x-maxtor-shared-storage-2.dtb \
diff --git a/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
new file mode 100644
index 000000000000..1cf644bfd7ea
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
@@ -0,0 +1,87 @@
+/*
+ * Device Tree file for Buffalo Linkstation LS-GL
+ *       (also known as Buffalo Linkstation Pro/Live)
+ *
+ * Copyright (C) 2016
+ * Roger Shimizu <rogershimizu@gmail.com>
+ *
+ * Based on the board file arch/arm/mach-orion5x/kurobox_pro-setup.c
+ * Copyright (C) Ronen Shitrit <rshitrit@marvell.com>
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
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "orion5x-linkstation.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Buffalo Linkstation Pro/Live";
+	compatible = "buffalo,lsgl", "marvell,orion5x-88f5182", "marvell,orion5x";
+
+	memory { /* 128 MB */
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+};
+
+&pinctrl {
+	pmx_power_hdd: pmx-power-hdd {
+		marvell,pins = "mpp1";
+		marvell,function = "gpio";
+	};
+
+	pmx_power_usb: pmx-power-usb {
+		marvell,pins = "mpp9";
+		marvell,function = "gpio";
+	};
+};
+
+&hdd_power {
+	gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+};
+
+&usb_power {
+	gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+};
+
+&ehci1 {
+	status = "okay";
+};
-- 
2.1.4
