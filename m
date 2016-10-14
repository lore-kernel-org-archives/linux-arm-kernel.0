From: jteki@openedev.com (Jagan Teki)
Date: Fri, 14 Oct 2016 14:57:19 +0530
Subject: [PATCH v7 1/5] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 initial support
In-Reply-To: <1476437243-13297-1-git-send-email-jteki@openedev.com>
References: <1476437243-13297-1-git-send-email-jteki@openedev.com>
Message-ID: <1476437243-13297-2-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

i.CoreM6 Quad/Dual modules are system on module solutions manufactured
by Engicam with following characteristics:
CPU           NXP i.MX6 DQ, 800MHz
RAM           1GB, 32, 64 bit, DDR3-800/1066
NAND          SLC,512MB
Power supply  Single 5V
MAX LCD RES   FULLHD

and more info at
http://www.engicam.com/en/products/embedded/som/sodimm/i-core-m6s-dl-d-q

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v7:
        - none
Changes for v6:
        - none
Changes for v5:
        - removed fsl,legacy-bch-geometry property from gpmi node
Changes for v4:
        - new patch
Changes for v3:
        - Use compatible as engicam,imx6-icore instead of fsl,imx6-icore
        - Update IOMUX value for can1 and can2 nodes
        - Added reg_3p3v for can1 and can2 nodes
Changes for v2:
        - s/oaky/okay/g

 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/imx6q-icore.dts    |  59 +++++++++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi | 196 +++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-icore.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-icore.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index befcd26..89a3eea 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -381,6 +381,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-gw553x.dtb \
 	imx6q-h100.dtb \
 	imx6q-hummingboard.dtb \
+	imx6q-icore.dtb \
 	imx6q-icore-rqs.dtb \
 	imx6q-marsboard.dtb \
 	imx6q-nitrogen6x.dtb \
diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/imx6q-icore.dts
new file mode 100644
index 0000000..025f543
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-icore.dts
@@ -0,0 +1,59 @@
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
+#include "imx6q.dtsi"
+#include "imx6qdl-icore.dtsi"
+
+/ {
+	model = "Engicam i.CoreM6 Quad/Dual Starter Kit";
+	compatible = "engicam,imx6-icore", "fsl,imx6q";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
new file mode 100644
index 0000000..f424cd5
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -0,0 +1,196 @@
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
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	memory {
+		reg = <0x10000000 0x80000000>;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_3p3v>;
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_3p3v>;
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6QDL_CLK_LVDS2_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_OSC>;
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0x1b020
+			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0x1b020
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x1b020
+			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x1b020
+		>;
+	};
+
+	pinctrl_gpmi_nand: gpmi-nand {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
+			MX6QDL_PAD_NANDF_CS1__NAND_CE1_B   0xb0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B      0xb0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B      0xb0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00   0xb0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01   0xb0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02   0xb0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03   0xb0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04   0xb0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05   0xb0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06   0xb0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07   0xb0b1
+			MX6QDL_PAD_SD4_DAT0__NAND_DQS      0x00b1
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
+			MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_EB2__I2C2_SCL  0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_5__I2C3_SCL  0x4001b8b1
+			MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x130b0
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17070
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10070
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17070
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17070
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17070
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17070
+		>;
+	};
+};
-- 
2.7.4
