From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 22 Mar 2016 23:28:18 +0900
Subject: [PATCH] ARM: dts: orion5x: add device tree for kurobox-pro
Message-ID: <1458656898-16183-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dts file to support Buffalo/Revogear Kurobox-Pro, which is marvell
orion5x based 3.5" HDD NAS.

It's a quite old product and already discontinued. So there's no
official website for it. But it was an early product which used marvell
orion5x 88F5182 chipset, it's popular in the community.
Some unofficial site:
  - http://buffalo.nas-central.org/wiki/Category:KuroboxPro
  - http://nice.kaze.com/KUROPRO_ProductSpecifications.pdf

This device tree is based on the board file:
  arch/arm/mach-orion5x/kurobox_pro-setup.c
However, the NAND device, which is supported by board file, is not
supported by device tree yet. So I still want to keep the board file
for the time being.

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/orion5x-kuroboxpro.dts | 113 +++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 arch/arm/boot/dts/orion5x-kuroboxpro.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 52b34a0..de1d67a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -521,6 +521,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
 	dra7-evm.dtb \
 	dra72-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += \
+	orion5x-kuroboxpro.dtb \
 	orion5x-lacie-d2-network.dtb \
 	orion5x-lacie-ethernet-disk-mini-v2.dtb \
 	orion5x-linkstation-lsgl.dtb \
diff --git a/arch/arm/boot/dts/orion5x-kuroboxpro.dts b/arch/arm/boot/dts/orion5x-kuroboxpro.dts
new file mode 100644
index 0000000..c626ddd
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-kuroboxpro.dts
@@ -0,0 +1,113 @@
+/*
+ * Device Tree file for Buffalo/Revogear Kurobox Pro
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
+	model = "Buffalo/Revogear Kurobox Pro";
+	compatible = "buffalo,kurobox-pro", "marvell,orion5x-88f5182", "marvell,orion5x";
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
+				 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
+				 <MBUS_ID(0x01, 0x0f) 0 0xf4000000 0x40000>,
+				 <MBUS_ID(0x01, 0x1e) 0 0xfc000000 0x1000000>;
+	};
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
+&devbus_cs0 {
+	status = "disabled";
+	devbus,keep-config;
+
+	/* According to board file: arch/arm/mach-orion5x/kurobox_pro-setup.c
+	 * There's a NAND flash on Device Bus CS0, but it fails on probing,
+	 * so it's disabled here.
+	 */
+
+	flash at 0 {
+		compatible = "cfi-flash";
+		reg = <0 0x1000000>;
+		bank-width = <1>;
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
+&sata {
+	nr-ports = <2>;
+};
+
+&ehci1 {
+	status = "okay";
+};
-- 
2.7.0
