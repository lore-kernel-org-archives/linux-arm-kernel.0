From: jagan@openedev.com (Jagan Teki)
Date: Fri, 20 Jan 2017 00:09:34 +0100
Subject: [PATCH v2 2/3] ARM: dts: imx6ul: Add Engicam Is.IoT MX6UL eMMC
 initial support
In-Reply-To: <1484867375-22411-1-git-send-email-jagan@openedev.com>
References: <1484867375-22411-1-git-send-email-jagan@openedev.com>
Message-ID: <1484867375-22411-2-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Engicam Is.IoT MX6UL has separate module for eMMC, so add emmc dts
file for imx6ul-isiot.dtsi, usdhc2 node represent eMMC.

dmesg:
-----
mmc1: SDHCI controller on 2194000.usdhc [2194000.usdhc] using ADMA
mmc1: new DDR MMC card at address 0001
mmcblk1: mmc1:0001 M62704 3.53 GiB

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Newly added with the reference of '[PATCH 1/2] ARM: dts: imx6ul-isiot: Add eMMC node'

 arch/arm/boot/dts/Makefile                         |  2 +-
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts            | 77 ++++++++++++++++++++++
 .../dts/{imx6ul-isiot.dts => imx6ul-isiot.dtsi}    |  3 -
 3 files changed, 78 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot-emmc.dts
 rename arch/arm/boot/dts/{imx6ul-isiot.dts => imx6ul-isiot.dtsi} (97%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fa68843..f2c9545 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -435,7 +435,7 @@ dtb-$(CONFIG_SOC_IMX6SX) += \
 dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-14x14-evk.dtb \
 	imx6ul-geam-kit.dtb \
-	imx6ul-isiot.dtb \
+	imx6ul-isiot-emmc.dtb \
 	imx6ul-liteboard.dtb \
 	imx6ul-pico-hobbit.dtb \
 	imx6ul-tx6ul-0010.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-isiot-emmc.dts b/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
new file mode 100644
index 0000000..f5b4228
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
@@ -0,0 +1,77 @@
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
+	model = "Engicam Is.IoT MX6UL eMMC Starter kit";
+	compatible = "engicam,imx6ul-isiot", "fsl,imx6ul";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	cd-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
+	bus-width = <8>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK      0x17070
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD      0x10070
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0  0x17070
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1  0x17070
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2  0x17070
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3  0x17070
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4  0x17070
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5  0x17070
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6  0x17070
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7  0x17070
+			MX6UL_PAD_NAND_ALE__USDHC2_RESET_B   0x17070
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dts b/arch/arm/boot/dts/imx6ul-isiot.dtsi
similarity index 97%
rename from arch/arm/boot/dts/imx6ul-isiot.dts
rename to arch/arm/boot/dts/imx6ul-isiot.dtsi
index 077bc26..edfa0ab 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dts
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -47,9 +47,6 @@
 #include "imx6ul.dtsi"
 
 / {
-	model = "Engicam Is.IoT MX6UL Starter kit";
-	compatible = "engicam,imx6ul-isiot", "fsl,imx6ul";
-
 	memory {
 		reg = <0x80000000 0x20000000>;
 	};
-- 
1.9.1
