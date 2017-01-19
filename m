From: jagan@openedev.com (Jagan Teki)
Date: Fri, 20 Jan 2017 00:09:35 +0100
Subject: [PATCH v2 3/3] ARM: dts: imx6ul: Add Engicam Is.IoT MX6UL NAND
 initial support
In-Reply-To: <1484867375-22411-1-git-send-email-jagan@openedev.com>
References: <1484867375-22411-1-git-send-email-jagan@openedev.com>
Message-ID: <1484867375-22411-3-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Engicam Is.IoT MX6UL has separate module for NAND, so add nand dts
file for imx6ul-isiot.dtsi.

dmesg:
-----
nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
nand: Micron MT29F2G08ABAEAH4
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
gpmi-nand 1806000.gpmi-nand: enable the asynchronous EDO mode 5
gpmi-nand 1806000.gpmi-nand: driver registered.

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Newly added patch

 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/imx6ul-isiot-nand.dts | 79 +++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot-nand.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f2c9545..f7340ce 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -436,6 +436,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-14x14-evk.dtb \
 	imx6ul-geam-kit.dtb \
 	imx6ul-isiot-emmc.dtb \
+	imx6ul-isiot-nand.dtb \
 	imx6ul-liteboard.dtb \
 	imx6ul-pico-hobbit.dtb \
 	imx6ul-tx6ul-0010.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-isiot-nand.dts b/arch/arm/boot/dts/imx6ul-isiot-nand.dts
new file mode 100644
index 0000000..de15e1c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-isiot-nand.dts
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2016 Amarula Solutions B.V.
+ * Copyright (C) 2016 Engicam S.r.l.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
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
+
+#include "imx6ul-isiot.dtsi"
+
+/ {
+	model = "Engicam Is.IoT MX6UL NAND Starter kit";
+	compatible = "engicam,imx6ul-isiot", "fsl,imx6ul";
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_gpmi_nand: gpmi-nand {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CLE__RAWNAND_CLE         0xb0b1
+			MX6UL_PAD_NAND_ALE__RAWNAND_ALE         0xb0b1
+			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B       0xb0b1
+			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B 0xb000
+			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B     0xb0b1
+			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B       0xb0b1
+			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B       0xb0b1
+			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00   0xb0b1
+			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01   0xb0b1
+			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02   0xb0b1
+			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03   0xb0b1
+			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04   0xb0b1
+			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05   0xb0b1
+			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06   0xb0b1
+			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07   0xb0b1
+		>;
+	};
+};
-- 
1.9.1
