From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 16 Sep 2016 16:40:04 +0900
Subject: [PATCH v7 2/2] clk: uniphier: add clock data for UniPhier SoCs
In-Reply-To: <1474011604-12577-1-git-send-email-yamada.masahiro@socionext.com>
References: <1474011604-12577-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1474011604-12577-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock data arrays for all UniPhier SoCs with a binding document.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Rob Herring <robh@kernel.org>
---

 .../devicetree/bindings/clock/uniphier-clock.txt   | 134 ++++++++++++++++++
 drivers/clk/uniphier/Makefile                      |   3 +
 drivers/clk/uniphier/clk-uniphier-core.c           |  91 +++++++++++++
 drivers/clk/uniphier/clk-uniphier-mio.c            | 101 ++++++++++++++
 drivers/clk/uniphier/clk-uniphier-peri.c           |  57 ++++++++
 drivers/clk/uniphier/clk-uniphier-sys.c            | 151 +++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h                |  13 ++
 7 files changed, 550 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/uniphier-clock.txt
 create mode 100644 drivers/clk/uniphier/clk-uniphier-mio.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-peri.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-sys.c

diff --git a/Documentation/devicetree/bindings/clock/uniphier-clock.txt b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
new file mode 100644
index 0000000..c7179d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
@@ -0,0 +1,134 @@
+UniPhier clock controller
+
+
+System clock
+------------
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-sld3-clock" - for sLD3 SoC.
+    "socionext,uniphier-ld4-clock"  - for LD4 SoC.
+    "socionext,uniphier-pro4-clock" - for Pro4 SoC.
+    "socionext,uniphier-sld8-clock" - for sLD8 SoC.
+    "socionext,uniphier-pro5-clock" - for Pro5 SoC.
+    "socionext,uniphier-pxs2-clock" - for PXs2/LD6b SoC.
+    "socionext,uniphier-ld11-clock" - for LD11 SoC.
+    "socionext,uniphier-ld20-clock" - for LD20 SoC.
+- #clock-cells: should be 1.
+
+Example:
+
+	sysctrl at 61840000 {
+		compatible = "socionext,uniphier-sysctrl",
+			     "simple-mfd", "syscon";
+		reg = <0x61840000 0x4000>;
+
+		clock {
+			compatible = "socionext,uniphier-ld20-clock";
+			#clock-cells = <1>;
+		};
+
+		other nodes ...
+	};
+
+Provided clocks:
+
+ 8: ST DMAC
+12: GIO (Giga bit stream I/O)
+14: USB3 ch0 host
+15: USB3 ch1 host
+16: USB3 ch0 PHY0
+17: USB3 ch0 PHY1
+20: USB3 ch1 PHY0
+21: USB3 ch1 PHY1
+
+
+Media I/O (MIO) clock
+---------------------
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-sld3-mio-clock" - for sLD3 SoC.
+    "socionext,uniphier-ld4-mio-clock"  - for LD4 SoC.
+    "socionext,uniphier-pro4-mio-clock" - for Pro4 SoC.
+    "socionext,uniphier-sld8-mio-clock" - for sLD8 SoC.
+    "socionext,uniphier-pro5-mio-clock" - for Pro5 SoC.
+    "socionext,uniphier-pxs2-mio-clock" - for PXs2/LD6b SoC.
+    "socionext,uniphier-ld11-mio-clock" - for LD11 SoC.
+    "socionext,uniphier-ld20-mio-clock" - for LD20 SoC.
+- #clock-cells: should be 1.
+
+Example:
+
+	mioctrl at 59810000 {
+		compatible = "socionext,uniphier-mioctrl",
+			     "simple-mfd", "syscon";
+		reg = <0x59810000 0x800>;
+
+		clock {
+			compatible = "socionext,uniphier-ld20-mio-clock";
+			#clock-cells = <1>;
+		};
+
+		other nodes ...
+	};
+
+Provided clocks:
+
+ 0: SD ch0 host
+ 1: eMMC host
+ 2: SD ch1 host
+ 7: MIO DMAC
+ 8: USB2 ch0 host
+ 9: USB2 ch1 host
+10: USB2 ch2 host
+11: USB2 ch3 host
+12: USB2 ch0 PHY
+13: USB2 ch1 PHY
+14: USB2 ch2 PHY
+15: USB2 ch3 PHY
+
+
+Peripheral clock
+----------------
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-sld3-peri-clock" - for sLD3 SoC.
+    "socionext,uniphier-ld4-peri-clock"  - for LD4 SoC.
+    "socionext,uniphier-pro4-peri-clock" - for Pro4 SoC.
+    "socionext,uniphier-sld8-peri-clock" - for sLD8 SoC.
+    "socionext,uniphier-pro5-peri-clock" - for Pro5 SoC.
+    "socionext,uniphier-pxs2-peri-clock" - for PXs2/LD6b SoC.
+    "socionext,uniphier-ld11-peri-clock" - for LD11 SoC.
+    "socionext,uniphier-ld20-peri-clock" - for LD20 SoC.
+- #clock-cells: should be 1.
+
+Example:
+
+	perictrl at 59820000 {
+		compatible = "socionext,uniphier-perictrl",
+			     "simple-mfd", "syscon";
+		reg = <0x59820000 0x200>;
+
+		clock {
+			compatible = "socionext,uniphier-ld20-peri-clock";
+			#clock-cells = <1>;
+		};
+
+		other nodes ...
+	};
+
+Provided clocks:
+
+ 0: UART ch0
+ 1: UART ch1
+ 2: UART ch2
+ 3: UART ch3
+ 4: I2C ch0
+ 5: I2C ch1
+ 6: I2C ch2
+ 7: I2C ch3
+ 8: I2C ch4
+ 9: I2C ch5
+10: I2C ch6
diff --git a/drivers/clk/uniphier/Makefile b/drivers/clk/uniphier/Makefile
index 88a28ca..f27b3603 100644
--- a/drivers/clk/uniphier/Makefile
+++ b/drivers/clk/uniphier/Makefile
@@ -3,3 +3,6 @@ obj-y	+= clk-uniphier-fixed-factor.o
 obj-y	+= clk-uniphier-fixed-rate.o
 obj-y	+= clk-uniphier-gate.o
 obj-y	+= clk-uniphier-mux.o
+obj-y	+= clk-uniphier-sys.o
+obj-y	+= clk-uniphier-mio.o
+obj-y	+= clk-uniphier-peri.o
diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index a6e2a94..5ffb898 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -109,6 +109,97 @@ static int uniphier_clk_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id uniphier_clk_match[] = {
+	/* System clock */
+	{
+		.compatible = "socionext,uniphier-ld4-clock",
+		.data = uniphier_ld4_sys_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro4-clock",
+		.data = uniphier_pro4_sys_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-sld8-clock",
+		.data = uniphier_sld8_sys_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro5-clock",
+		.data = uniphier_pro5_sys_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-clock",
+		.data = uniphier_pxs2_sys_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld11-clock",
+		.data = uniphier_ld11_sys_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-clock",
+		.data = uniphier_ld20_sys_clk_data,
+	},
+	/* Media I/O clock */
+	{
+		.compatible = "socionext,uniphier-sld3-mio-clock",
+		.data = uniphier_sld3_mio_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld4-mio-clock",
+		.data = uniphier_sld3_mio_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro4-mio-clock",
+		.data = uniphier_sld3_mio_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-sld8-mio-clock",
+		.data = uniphier_sld3_mio_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro5-mio-clock",
+		.data = uniphier_pro5_mio_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-mio-clock",
+		.data = uniphier_pro5_mio_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld11-mio-clock",
+		.data = uniphier_sld3_mio_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-mio-clock",
+		.data = uniphier_pro5_mio_clk_data,
+	},
+	/* Peripheral clock */
+	{
+		.compatible = "socionext,uniphier-ld4-peri-clock",
+		.data = uniphier_ld4_peri_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro4-peri-clock",
+		.data = uniphier_pro4_peri_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-sld8-peri-clock",
+		.data = uniphier_ld4_peri_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro5-peri-clock",
+		.data = uniphier_pro4_peri_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-peri-clock",
+		.data = uniphier_pro4_peri_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld11-peri-clock",
+		.data = uniphier_pro4_peri_clk_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-peri-clock",
+		.data = uniphier_pro4_peri_clk_data,
+	},
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/clk/uniphier/clk-uniphier-mio.c b/drivers/clk/uniphier/clk-uniphier-mio.c
new file mode 100644
index 0000000..6aa7ec7
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-mio.c
@@ -0,0 +1,101 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "clk-uniphier.h"
+
+#define UNIPHIER_MIO_CLK_SD_FIXED					\
+	UNIPHIER_CLK_FACTOR("sd-44m", -1, "sd-133m", 1, 3),		\
+	UNIPHIER_CLK_FACTOR("sd-33m", -1, "sd-200m", 1, 6),		\
+	UNIPHIER_CLK_FACTOR("sd-50m", -1, "sd-200m", 1, 4),		\
+	UNIPHIER_CLK_FACTOR("sd-67m", -1, "sd-200m", 1, 3),		\
+	UNIPHIER_CLK_FACTOR("sd-100m", -1, "sd-200m", 1, 2),		\
+	UNIPHIER_CLK_FACTOR("sd-40m", -1, "sd-200m", 1, 5),		\
+	UNIPHIER_CLK_FACTOR("sd-25m", -1, "sd-200m", 1, 8),		\
+	UNIPHIER_CLK_FACTOR("sd-22m", -1, "sd-133m", 1, 6)
+
+#define UNIPHIER_MIO_CLK_SD(_idx, ch)					\
+	{								\
+		.name = "sd" #ch "-sel",				\
+		.type = UNIPHIER_CLK_TYPE_MUX,				\
+		.idx = -1,						\
+		.data.mux = {						\
+			.parent_names = {				\
+				"sd-44m",				\
+				"sd-33m",				\
+				"sd-50m",				\
+				"sd-67m",				\
+				"sd-100m",				\
+				"sd-40m",				\
+				"sd-25m",				\
+				"sd-22m",				\
+			},						\
+			.num_parents = 8,				\
+			.reg = 0x30 + 0x200 * (ch),			\
+			.masks = {					\
+				0x00031000,				\
+				0x00031000,				\
+				0x00031000,				\
+				0x00031000,				\
+				0x00001300,				\
+				0x00001300,				\
+				0x00001300,				\
+				0x00001300,				\
+			},						\
+			.vals = {					\
+				0x00000000,				\
+				0x00010000,				\
+				0x00020000,				\
+				0x00030000,				\
+				0x00001000,				\
+				0x00001100,				\
+				0x00001200,				\
+				0x00001300,				\
+			},						\
+		},							\
+	},								\
+	UNIPHIER_CLK_GATE("sd" #ch, (_idx), "sd" #ch "-sel", 0x20 + 0x200 * (ch), 8)
+
+#define UNIPHIER_MIO_CLK_USB2(idx, ch)					\
+	UNIPHIER_CLK_GATE("usb2" #ch, (idx), "usb2", 0x20 + 0x200 * (ch), 28)
+
+#define UNIPHIER_MIO_CLK_USB2_PHY(idx, ch)				\
+	UNIPHIER_CLK_GATE("usb2" #ch "-phy", (idx), "usb2", 0x20 + 0x200 * (ch), 29)
+
+#define UNIPHIER_MIO_CLK_DMAC(idx)					\
+	UNIPHIER_CLK_GATE("miodmac", (idx), "stdmac", 0x20, 25)
+
+const struct uniphier_clk_data uniphier_sld3_mio_clk_data[] = {
+	UNIPHIER_MIO_CLK_SD_FIXED,
+	UNIPHIER_MIO_CLK_SD(0, 0),
+	UNIPHIER_MIO_CLK_SD(1, 1),
+	UNIPHIER_MIO_CLK_SD(2, 2),
+	UNIPHIER_MIO_CLK_DMAC(7),
+	UNIPHIER_MIO_CLK_USB2(8, 0),
+	UNIPHIER_MIO_CLK_USB2(9, 1),
+	UNIPHIER_MIO_CLK_USB2(10, 2),
+	UNIPHIER_MIO_CLK_USB2(11, 3),
+	UNIPHIER_MIO_CLK_USB2_PHY(12, 0),
+	UNIPHIER_MIO_CLK_USB2_PHY(13, 1),
+	UNIPHIER_MIO_CLK_USB2_PHY(14, 2),
+	UNIPHIER_MIO_CLK_USB2_PHY(15, 3),
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_pro5_mio_clk_data[] = {
+	UNIPHIER_MIO_CLK_SD_FIXED,
+	UNIPHIER_MIO_CLK_SD(0, 0),
+	UNIPHIER_MIO_CLK_SD(1, 1),
+	{ /* sentinel */ }
+};
diff --git a/drivers/clk/uniphier/clk-uniphier-peri.c b/drivers/clk/uniphier/clk-uniphier-peri.c
new file mode 100644
index 0000000..521c80e
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-peri.c
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "clk-uniphier.h"
+
+#define UNIPHIER_PERI_CLK_UART(idx, ch)					\
+	UNIPHIER_CLK_GATE("uart" #ch, (idx), "uart", 0x24, 19 + (ch))
+
+#define UNIPHIER_PERI_CLK_I2C_COMMON					\
+	UNIPHIER_CLK_GATE("i2c-common", -1, "i2c", 0x20, 1)
+
+#define UNIPHIER_PERI_CLK_I2C(idx, ch)					\
+	UNIPHIER_CLK_GATE("i2c" #ch, (idx), "i2c-common", 0x24, 5 + (ch))
+
+#define UNIPHIER_PERI_CLK_FI2C(idx, ch)					\
+	UNIPHIER_CLK_GATE("i2c" #ch, (idx), "i2c", 0x24, 24 + (ch))
+
+const struct uniphier_clk_data uniphier_ld4_peri_clk_data[] = {
+	UNIPHIER_PERI_CLK_UART(0, 0),
+	UNIPHIER_PERI_CLK_UART(1, 1),
+	UNIPHIER_PERI_CLK_UART(2, 2),
+	UNIPHIER_PERI_CLK_UART(3, 3),
+	UNIPHIER_PERI_CLK_I2C_COMMON,
+	UNIPHIER_PERI_CLK_I2C(4, 0),
+	UNIPHIER_PERI_CLK_I2C(5, 1),
+	UNIPHIER_PERI_CLK_I2C(6, 2),
+	UNIPHIER_PERI_CLK_I2C(7, 3),
+	UNIPHIER_PERI_CLK_I2C(8, 4),
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_pro4_peri_clk_data[] = {
+	UNIPHIER_PERI_CLK_UART(0, 0),
+	UNIPHIER_PERI_CLK_UART(1, 1),
+	UNIPHIER_PERI_CLK_UART(2, 2),
+	UNIPHIER_PERI_CLK_UART(3, 3),
+	UNIPHIER_PERI_CLK_FI2C(4, 0),
+	UNIPHIER_PERI_CLK_FI2C(5, 1),
+	UNIPHIER_PERI_CLK_FI2C(6, 2),
+	UNIPHIER_PERI_CLK_FI2C(7, 3),
+	UNIPHIER_PERI_CLK_FI2C(8, 4),
+	UNIPHIER_PERI_CLK_FI2C(9, 5),
+	UNIPHIER_PERI_CLK_FI2C(10, 6),
+	{ /* sentinel */ }
+};
diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
new file mode 100644
index 0000000..5d02999
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -0,0 +1,151 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/stddef.h>
+
+#include "clk-uniphier.h"
+
+#define UNIPHIER_SLD3_SYS_CLK_SD					\
+	UNIPHIER_CLK_FACTOR("sd-200m", -1, "spll", 1, 8),		\
+	UNIPHIER_CLK_FACTOR("sd-133m", -1, "vpll27a", 1, 2)
+
+#define UNIPHIER_PRO5_SYS_CLK_SD					\
+	UNIPHIER_CLK_FACTOR("sd-200m", -1, "spll", 1, 12),		\
+	UNIPHIER_CLK_FACTOR("sd-133m", -1, "spll", 1, 18)
+
+#define UNIPHIER_LD20_SYS_CLK_SD					\
+	UNIPHIER_CLK_FACTOR("sd-200m", -1, "spll", 1, 10),		\
+	UNIPHIER_CLK_FACTOR("sd-133m", -1, "spll", 1, 15)
+
+#define UNIPHIER_SLD3_SYS_CLK_STDMAC(idx)				\
+	UNIPHIER_CLK_GATE("stdmac", (idx), NULL, 0x2104, 10)
+
+#define UNIPHIER_LD11_SYS_CLK_STDMAC(idx)				\
+	UNIPHIER_CLK_GATE("stdmac", (idx), NULL, 0x210c, 8)
+
+#define UNIPHIER_PRO4_SYS_CLK_GIO(idx)					\
+	UNIPHIER_CLK_GATE("gio", (idx), NULL, 0x2104, 6)
+
+#define UNIPHIER_PRO4_SYS_CLK_USB3(idx, ch)				\
+	UNIPHIER_CLK_GATE("usb3" #ch, (idx), NULL, 0x2104, 16 + (ch))
+
+const struct uniphier_clk_data uniphier_sld3_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 65, 1),		/* 1597.44 MHz */
+	UNIPHIER_CLK_FACTOR("upll", -1, "ref", 6000, 512),	/* 288 MHz */
+	UNIPHIER_CLK_FACTOR("a2pll", -1, "ref", 24, 1),		/* 589.824 MHz */
+	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 5625, 512),	/* 270 MHz */
+	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 16),
+	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
+	UNIPHIER_SLD3_SYS_CLK_SD,
+	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_ld4_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 65, 1),		/* 1597.44 MHz */
+	UNIPHIER_CLK_FACTOR("upll", -1, "ref", 6000, 512),	/* 288 MHz */
+	UNIPHIER_CLK_FACTOR("a2pll", -1, "ref", 24, 1),		/* 589.824 MHz */
+	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 5625, 512),	/* 270 MHz */
+	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 16),
+	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
+	UNIPHIER_SLD3_SYS_CLK_SD,
+	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),		/* Ether, HSC, MIO */
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 64, 1),		/* 1600 MHz */
+	UNIPHIER_CLK_FACTOR("upll", -1, "ref", 288, 25),	/* 288 MHz */
+	UNIPHIER_CLK_FACTOR("a2pll", -1, "upll", 256, 125),	/* 589.824 MHz */
+	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 270, 25),	/* 270 MHz */
+	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 8),
+	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 32),
+	UNIPHIER_SLD3_SYS_CLK_SD,
+	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),		/* HSC, MIO, RLE */
+	UNIPHIER_PRO4_SYS_CLK_GIO(12),			/* Ether, SATA, USB3 */
+	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
+	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_sld8_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 64, 1),		/* 1600 MHz */
+	UNIPHIER_CLK_FACTOR("upll", -1, "ref", 288, 25),	/* 288 MHz */
+	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 270, 25),	/* 270 MHz */
+	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 20),
+	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
+	UNIPHIER_SLD3_SYS_CLK_SD,
+	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),		/* Ether, HSC, MIO */
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 120, 1),		/* 2400 MHz */
+	UNIPHIER_CLK_FACTOR("dapll1", -1, "ref", 128, 1),	/* 2560 MHz */
+	UNIPHIER_CLK_FACTOR("dapll2", -1, "ref", 144, 125),	/* 2949.12 MHz */
+	UNIPHIER_CLK_FACTOR("uart", 0, "dapll2", 1, 40),
+	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
+	UNIPHIER_PRO5_SYS_CLK_SD,
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),			/* HSC */
+	UNIPHIER_PRO4_SYS_CLK_GIO(12),				/* PCIe, USB3 */
+	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
+	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 96, 1),		/* 2400 MHz */
+	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 27),
+	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
+	UNIPHIER_PRO5_SYS_CLK_SD,
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),			/* HSC, RLE */
+	/* GIO is always clock-enabled: no function for 0x2104 bit6 */
+	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
+	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
+	/* The document mentions 0x2104 bit 18, but not functional */
+	UNIPHIER_CLK_GATE("usb30-phy", 16, NULL, 0x2104, 19),
+	UNIPHIER_CLK_GATE("usb31-phy", 20, NULL, 0x2104, 20),
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 80, 1),		/* 2000 MHz */
+	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
+	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
+	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC, MIO */
+	UNIPHIER_CLK_FACTOR("usb2", -1, "ref", 24, 25),
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 80, 1),		/* 2000 MHz */
+	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
+	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
+	UNIPHIER_LD20_SYS_CLK_SD,
+	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC */
+	/* GIO is always clock-enabled: no function for 0x210c bit5 */
+	/*
+	 * clock for USB Link is enabled by the logic "OR" of bit 14 and bit 15.
+	 * We do not use bit 15 here.
+	 */
+	UNIPHIER_CLK_GATE("usb30", 14, NULL, 0x210c, 14),
+	UNIPHIER_CLK_GATE("usb30-phy0", 16, NULL, 0x210c, 12),
+	UNIPHIER_CLK_GATE("usb30-phy1", 17, NULL, 0x210c, 13),
+	{ /* sentinel */ }
+};
diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
index 3e354e9..3ae1840 100644
--- a/drivers/clk/uniphier/clk-uniphier.h
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -106,4 +106,17 @@ struct clk_hw *uniphier_clk_register_mux(struct device *dev,
 					 const char *name,
 				const struct uniphier_clk_mux_data *data);
 
+extern const struct uniphier_clk_data uniphier_sld3_sys_clk_data[];
+extern const struct uniphier_clk_data uniphier_ld4_sys_clk_data[];
+extern const struct uniphier_clk_data uniphier_pro4_sys_clk_data[];
+extern const struct uniphier_clk_data uniphier_sld8_sys_clk_data[];
+extern const struct uniphier_clk_data uniphier_pro5_sys_clk_data[];
+extern const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[];
+extern const struct uniphier_clk_data uniphier_ld11_sys_clk_data[];
+extern const struct uniphier_clk_data uniphier_ld20_sys_clk_data[];
+extern const struct uniphier_clk_data uniphier_sld3_mio_clk_data[];
+extern const struct uniphier_clk_data uniphier_pro5_mio_clk_data[];
+extern const struct uniphier_clk_data uniphier_ld4_peri_clk_data[];
+extern const struct uniphier_clk_data uniphier_pro4_peri_clk_data[];
+
 #endif /* __CLK_UNIPHIER_H__ */
-- 
1.9.1
