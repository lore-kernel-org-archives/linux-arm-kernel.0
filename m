From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 27 Jul 2016 03:09:53 +0900
Subject: [PATCH v5 2/2] clk: uniphier: add clock data for UniPhier SoCs
In-Reply-To: <1469556593-11369-1-git-send-email-yamada.masahiro@socionext.com>
References: <1469556593-11369-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1469556593-11369-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock data arrays for all UniPhier SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../devicetree/bindings/clock/uniphier-clock.txt   | 123 ++++
 drivers/clk/uniphier/Makefile                      |   3 +
 drivers/clk/uniphier/clk-uniphier-core.c           |  91 +++
 drivers/clk/uniphier/clk-uniphier-mio.c            | 195 +++++++
 drivers/clk/uniphier/clk-uniphier-peri.c           |  95 ++++
 drivers/clk/uniphier/clk-uniphier-sys.c            | 626 +++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h                |  13 +
 7 files changed, 1146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/uniphier-clock.txt
 create mode 100644 drivers/clk/uniphier/clk-uniphier-mio.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-peri.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-sys.c

diff --git a/Documentation/devicetree/bindings/clock/uniphier-clock.txt b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
new file mode 100644
index 0000000..1a4fee1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
@@ -0,0 +1,123 @@
+UniPhier clock controller
+
+
+System clock
+------------
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-sld3-clock" - for PH1-sLD3 SoC.
+    "socionext,uniphier-ld4-clock"  - for PH1-LD4 SoC.
+    "socionext,uniphier-pro4-clock" - for PH1-Pro4 SoC.
+    "socionext,uniphier-sld8-clock" - for PH1-sLD8 SoC.
+    "socionext,uniphier-pro5-clock" - for PH1-Pro5 SoC.
+    "socionext,uniphier-pxs2-clock" - for ProXstream2/PH1-LD6b SoC.
+    "socionext,uniphier-ld11-clock" - for PH1-LD11 SoC.
+    "socionext,uniphier-ld20-clock" - for PH1-LD20 SoC.
+- #clock-cells: should be 1.
+
+Note:
+The clock node should be a child of a syscon node.
+
+Example:
+
+	sysctrl at 61840000 {
+		compatible = "simple-mfd", "syscon";
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
+
+Media I/O (MIO) clock
+---------------------
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-sld3-mio-clock" - for PH1-sLD3 SoC.
+    "socionext,uniphier-ld4-mio-clock"  - for PH1-LD4 SoC.
+    "socionext,uniphier-pro4-mio-clock" - for PH1-Pro4 SoC.
+    "socionext,uniphier-sld8-mio-clock" - for PH1-sLD8 SoC.
+    "socionext,uniphier-pro5-mio-clock" - for PH1-Pro5 SoC.
+    "socionext,uniphier-pxs2-mio-clock" - for ProXstream2/PH1-LD6b SoC.
+    "socionext,uniphier-ld11-mio-clock" - for PH1-LD11 SoC.
+    "socionext,uniphier-ld20-mio-clock" - for PH1-LD20 SoC.
+- #clock-cells: should be 1.
+
+Note:
+The clock node should be a child of a syscon node.
+
+Example:
+
+	mioctrl at 59810000 {
+		compatible = "simple-mfd", "syscon";
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
+0: SD host ch0
+1: eMMC host
+2: SD host ch1
+3: MIO DMAC
+4: USB2 host ch0
+5: USB2 host ch1
+6: USB2 host ch2
+7: USB2 host ch3
+
+
+Peripheral clock
+----------------
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-sld3-peri-clock" - for PH1-sLD3 SoC.
+    "socionext,uniphier-ld4-peri-clock"  - for PH1-LD4 SoC.
+    "socionext,uniphier-pro4-peri-clock" - for PH1-Pro4 SoC.
+    "socionext,uniphier-sld8-peri-clock" - for PH1-sLD8 SoC.
+    "socionext,uniphier-pro5-peri-clock" - for PH1-Pro5 SoC.
+    "socionext,uniphier-pxs2-peri-clock" - for ProXstream2/PH1-LD6b SoC.
+    "socionext,uniphier-ld11-peri-clock" - for PH1-LD11 SoC.
+    "socionext,uniphier-ld20-peri-clock" - for PH1-LD20 SoC.
+- #clock-cells: should be 1.
+
+Note:
+The clock node should be a child of a syscon node.
+
+Example:
+
+	perictrl at 59820000 {
+		compatible = "simple-mfd", "syscon";
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
index 8f359aa..6822691 100644
--- a/drivers/clk/uniphier/Makefile
+++ b/drivers/clk/uniphier/Makefile
@@ -4,3 +4,6 @@ clk-uniphier-y			+= clk-uniphier-fixed-factor.o
 clk-uniphier-y			+= clk-uniphier-fixed-rate.o
 clk-uniphier-y			+= clk-uniphier-gate.o
 clk-uniphier-y			+= clk-uniphier-mux.o
+clk-uniphier-y			+= clk-uniphier-sys.o
+clk-uniphier-y			+= clk-uniphier-mio.o
+clk-uniphier-y			+= clk-uniphier-peri.o
diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index fcb7582..57e6762 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -45,6 +45,97 @@ static struct clk_hw *uniphier_clk_register(struct device *dev,
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
 MODULE_DEVICE_TABLE(of, uniphier_clk_match);
diff --git a/drivers/clk/uniphier/clk-uniphier-mio.c b/drivers/clk/uniphier/clk-uniphier-mio.c
new file mode 100644
index 0000000..711bab5
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-mio.c
@@ -0,0 +1,195 @@
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
+#include <linux/bitops.h>
+
+#include "clk-uniphier.h"
+
+#define UNIPHIER_MIO_CLK_SD_FIXED					\
+	{								\
+		.name = "sd-44m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,			\
+		.output_index = -1,					\
+		.data.factor = {					\
+			.parent_name = "sd-133m",			\
+			.mult = 1,					\
+			.div = 3,					\
+		},							\
+	},								\
+	{								\
+		.name = "sd-33m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,			\
+		.output_index = -1,					\
+		.data.factor = {					\
+			.parent_name = "sd-200m",			\
+			.mult = 1,					\
+			.div = 6,					\
+		},							\
+	},								\
+	{								\
+		.name = "sd-50m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,			\
+		.output_index = -1,					\
+		.data.factor = {					\
+			.parent_name = "sd-200m",			\
+			.mult = 1,					\
+			.div = 4,					\
+		},							\
+	},								\
+	{								\
+		.name = "sd-67m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,			\
+		.output_index = -1,					\
+		.data.factor = {					\
+			.parent_name = "sd-200m",			\
+			.mult = 1,					\
+			.div = 3,					\
+		},							\
+	},								\
+	{								\
+		.name = "sd-100m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,			\
+		.output_index = -1,					\
+		.data.factor = {					\
+			.parent_name = "sd-200m",			\
+			.mult = 1,					\
+			.div = 2,					\
+		},							\
+	},								\
+	{								\
+		.name = "sd-40m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,			\
+		.output_index = -1,					\
+		.data.factor = {					\
+			.parent_name = "sd-200m",			\
+			.mult = 1,					\
+			.div = 5,					\
+		},							\
+	},								\
+	{								\
+		.name = "sd-25m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,			\
+		.output_index = -1,					\
+		.data.factor = {					\
+			.parent_name = "sd-200m",			\
+			.mult = 1,					\
+			.div = 8,					\
+		},							\
+	},								\
+	{								\
+		.name = "sd-22m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,			\
+		.output_index = -1,					\
+		.data.factor = {					\
+			.parent_name = "sd-133m",			\
+			.mult = 1,					\
+			.div = 6,					\
+		},							\
+	}
+
+#define UNIPHIER_MIO_CLK_SD(index, ch)					\
+	{								\
+		.name = "sd" #ch "-sel",				\
+		.type = UNIPHIER_CLK_TYPE_MUX,				\
+		.output_index = -1,					\
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
+			.reg = 0x30 + 0x200 * ch,			\
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
+	{								\
+		.name = "sd" #ch,					\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = (index),				\
+		.data.gate = {						\
+			.parent_name = "sd" #ch "-sel",			\
+			.reg = 0x20 + 0x200 * ch,			\
+			.mask = BIT(8),					\
+		},							\
+	}
+
+#define UNIPHIER_MIO_CLK_USB2(index, ch)				\
+	{								\
+		.name = "usb2" #ch,					\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = (index),				\
+		.data.gate = {						\
+			.parent_name = "usb2",				\
+			.reg = 0x20 + 0x200 * ch,			\
+			.mask = BIT(29) | BIT(28),			\
+		},							\
+	}
+
+#define UNIPHIER_MIO_CLK_DMAC(index)					\
+	{								\
+		.name = "miodmac",					\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = (index),				\
+		.data.gate = {						\
+			.parent_name = "stdmac",			\
+			.reg = 0x20,					\
+			.mask = BIT(25),				\
+		},							\
+	}
+
+const struct uniphier_clk_data uniphier_sld3_mio_clk_data[] = {
+	UNIPHIER_MIO_CLK_SD_FIXED,
+	UNIPHIER_MIO_CLK_SD(0, 0),
+	UNIPHIER_MIO_CLK_SD(1, 1),
+	UNIPHIER_MIO_CLK_SD(2, 2),
+	UNIPHIER_MIO_CLK_DMAC(3),
+	UNIPHIER_MIO_CLK_USB2(4, 0),
+	UNIPHIER_MIO_CLK_USB2(5, 1),
+	UNIPHIER_MIO_CLK_USB2(6, 2),
+	UNIPHIER_MIO_CLK_USB2(7, 3),
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
index 0000000..029c65f
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-peri.c
@@ -0,0 +1,95 @@
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
+#include <linux/bitops.h>
+
+#include "clk-uniphier.h"
+
+#define UNIPHIER_PERI_CLK_UART(index, ch)			\
+	{							\
+		.name = "uart" #ch,				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = "uart",			\
+			.reg = 0x24,				\
+			.mask = BIT(19 + (ch)),			\
+		},						\
+	}
+
+#define UNIPHIER_PERI_CLK_I2C_COMMON				\
+	{							\
+		.name = "i2c-common",				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = -1,				\
+		.data.gate = {					\
+			.parent_name = "i2c",			\
+			.reg = 0x20,				\
+			.mask = BIT(1),				\
+		},						\
+	}
+
+#define UNIPHIER_PERI_CLK_I2C(index, ch)			\
+	{							\
+		.name = "i2c" #ch,				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = "i2c-common",		\
+			.reg = 0x24,				\
+			.mask = BIT(5 + (ch)),			\
+		},						\
+	}
+
+#define UNIPHIER_PERI_CLK_FI2C(index, ch)			\
+	{							\
+		.name = "i2c" #ch,				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = "i2c",			\
+			.reg = 0x24,				\
+			.mask = BIT(24 + (ch)),			\
+		},						\
+	}
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
index 0000000..2e1e4cc
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -0,0 +1,626 @@
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
+#include <linux/bitops.h>
+
+#include "clk-uniphier.h"
+
+#define UNIPHIER_SLD3_SYS_CLK_SD				\
+	{							\
+		.name = "sd-200m",				\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,		\
+		.output_index = -1,				\
+		.data.factor = {				\
+			.parent_name = "spll",			\
+			.mult = 1,				\
+			.div = 8,				\
+		},						\
+	},							\
+	{							\
+		.name = "sd-133m",				\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,		\
+		.output_index = -1,				\
+		.data.factor = {				\
+			.parent_name = "vpll27a",		\
+			.mult = 1,				\
+			.div = 2,				\
+		},						\
+	}
+
+#define UNIPHIER_PRO5_SYS_CLK_SD				\
+	{							\
+		.name = "sd-200m",				\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,		\
+		.output_index = -1,				\
+		.data.factor = {				\
+			.parent_name = "spll",			\
+			.mult = 1,				\
+			.div = 12,				\
+		},						\
+	},							\
+	{							\
+		.name = "sd-133m",				\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,		\
+		.output_index = -1,				\
+		.data.factor = {				\
+			.parent_name = "spll",			\
+			.mult = 1,				\
+			.div = 18,				\
+		},						\
+	}
+
+#define UNIPHIER_LD20_SYS_CLK_SD				\
+	{							\
+		.name = "sd-200m",				\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,		\
+		.output_index = -1,				\
+		.data.factor = {				\
+			.parent_name = "spll",			\
+			.mult = 1,				\
+			.div = 10,				\
+		},						\
+	},							\
+	{							\
+		.name = "sd-133m",				\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,		\
+		.output_index = -1,				\
+		.data.factor = {				\
+			.parent_name = "spll",			\
+			.mult = 1,				\
+			.div = 15,				\
+		},						\
+	}
+
+#define UNIPHIER_PRO5_SYS_CLK_I2C				\
+	{							\
+		.name = "i2c",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,		\
+		.output_index = -1,				\
+		.data.factor = {				\
+			.parent_name = "spll",			\
+			.mult = 1,				\
+			.div = 48,				\
+		},						\
+	}
+
+#define UNIPHIER_LD11_SYS_CLK_I2C				\
+	{							\
+		.name = "i2c",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,		\
+		.output_index = -1,				\
+		.data.factor = {				\
+			.parent_name = "spll",			\
+			.mult = 1,				\
+			.div = 40,				\
+		},						\
+	}
+
+#define UNIPHIER_SLD3_SYS_CLK_STDMAC(index)			\
+	{							\
+		.name = "stdmac",				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = NULL,			\
+			.reg = 0x2104,				\
+			.mask = BIT(10),			\
+		},						\
+	}
+
+#define UNIPHIER_LD11_SYS_CLK_STDMAC(index)			\
+	{							\
+		.name = "stdmac",				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = NULL,			\
+			.reg = 0x210c,				\
+			.mask = BIT(8),				\
+		},						\
+	}
+
+#define UNIPHIER_PRO4_SYS_CLK_GIO(index)			\
+	{							\
+		.name = "gio",					\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = NULL,			\
+			.reg = 0x2104,				\
+			.mask = BIT(6),				\
+		},						\
+	}
+
+#define UNIPHIER_PRO4_SYS_CLK_USB3(index, ch)			\
+	{							\
+		.name = "usb3" #ch,				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = NULL,			\
+			.reg = 0x2104,				\
+			.mask = BIT(16 + (ch)),			\
+		},						\
+	}
+
+#define UNIPHIER_PXS2_SYS_CLK_USB3PHY(index, ch)		\
+	{							\
+		.name = "usb3" #ch "phy",			\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = NULL,			\
+			.reg = 0x2104,				\
+			.mask = BIT(19 + (ch)),			\
+		},						\
+	}
+
+const struct uniphier_clk_data uniphier_sld3_sys_clk_data[] = {
+	{
+		.name = "spll",		/* 1597.44 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 65,
+			.div = 1,
+		},
+	},
+	{
+		.name = "upll",		/* 288 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 288000,
+			.div = 24576,
+		},
+	},
+	{
+		.name = "a2pll",	/* 589.824 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 24,
+			.div = 1,
+		},
+	},
+	{
+		.name = "vpll27a",	/* 270 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 270000,
+			.div = 24576,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 0,
+		.data.factor = {
+			.parent_name = "a2pll",
+			.mult = 1,
+			.div = 16,
+		},
+	},
+	{
+		.name = "i2c",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 1,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 16,
+		},
+	},
+	UNIPHIER_SLD3_SYS_CLK_SD,
+	{
+		.name = "usb2",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "upll",
+			.mult = 1,
+			.div = 12,
+		},
+	},
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_ld4_sys_clk_data[] = {
+	{
+		.name = "spll",		/* 1597.44 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 65,
+			.div = 1,
+		},
+	},
+	{
+		.name = "upll",		/* 288 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 288000,
+			.div = 24576,
+		},
+	},
+	{
+		.name = "a2pll",	/* 589.824 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 24,
+			.div = 1,
+		},
+	},
+	{
+		.name = "vpll27a",	/* 270 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 270000,
+			.div = 24576,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "a2pll",
+			.mult = 1,
+			.div = 16,
+		},
+	},
+	{
+		.name = "i2c",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 16,
+		},
+	},
+	UNIPHIER_SLD3_SYS_CLK_SD,
+	{
+		.name = "usb2",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "upll",
+			.mult = 1,
+			.div = 12,
+		},
+	},
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),	/* Ether, HSC, MIO */
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
+	{
+		.name = "spll",		/* 1600 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 64,
+			.div = 1,
+		},
+	},
+	{
+		.name = "upll",		/* 288 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 288,
+			.div = 25,
+		},
+	},
+	{
+		.name = "a2pll",	/* 589.824 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "upll",
+			.mult = 256,
+			.div = 125,
+		},
+	},
+	{
+		.name = "vpll27a",	/* 270 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 270,
+			.div = 25,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "a2pll",
+			.mult = 1,
+			.div = 8,
+		},
+	},
+	{
+		.name = "i2c",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 32,
+		},
+	},
+	UNIPHIER_SLD3_SYS_CLK_SD,
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),	/* HSC, MIO, RLE */
+	UNIPHIER_PRO4_SYS_CLK_GIO(12),		/* Ether, SATA, USB3 */
+	UNIPHIER_PRO4_SYS_CLK_USB3(16, 0),
+	UNIPHIER_PRO4_SYS_CLK_USB3(17, 1),
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_sld8_sys_clk_data[] = {
+	{
+		.name = "spll",		/* 1600 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 64,
+			.div = 1,
+		},
+	},
+	{
+		.name = "upll",		/* 288 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 288,
+			.div = 25,
+		},
+	},
+	{
+		.name = "vpll27a",	/* 270 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 270,
+			.div = 25,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 20,
+		},
+	},
+	{
+		.name = "i2c",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 16,
+		},
+	},
+	UNIPHIER_SLD3_SYS_CLK_SD,
+	{
+		.name = "usb2",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "upll",
+			.mult = 1,
+			.div = 12,
+		},
+	},
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),	/* Ether, HSC, MIO */
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
+	{
+		.name = "spll",		/* 2400 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 120,
+			.div = 1,
+		},
+	},
+	{
+		.name = "dapll1",	/* 2560 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 128,
+			.div = 1,
+		},
+	},
+	{
+		.name = "dapll2",	/* 2949.12 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "dapll1",
+			.mult = 144,
+			.div = 125,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "dapll2",
+			.mult = 1,
+			.div = 40,
+		},
+	},
+	UNIPHIER_PRO5_SYS_CLK_I2C,
+	UNIPHIER_PRO5_SYS_CLK_SD,
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),	/* HSC */
+	UNIPHIER_PRO4_SYS_CLK_GIO(12),		/* PCIe, USB3 */
+	UNIPHIER_PRO4_SYS_CLK_USB3(16, 0),
+	UNIPHIER_PRO4_SYS_CLK_USB3(17, 1),
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
+	{
+		.name = "spll",		/* 2400 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 96,
+			.div = 1,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 27,
+		},
+	},
+	UNIPHIER_PRO5_SYS_CLK_I2C,
+	UNIPHIER_PRO5_SYS_CLK_SD,
+	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),	/* HSC, RLE */
+	/* GIO is always clock-enabled: no function for 0x2104 bit6 */
+	UNIPHIER_PRO4_SYS_CLK_USB3(16, 0),
+	UNIPHIER_PRO4_SYS_CLK_USB3(17, 1),
+	/* The document mentions 0x2104 bit 18, but not functional */
+	UNIPHIER_PXS2_SYS_CLK_USB3PHY(18, 0),
+	UNIPHIER_PXS2_SYS_CLK_USB3PHY(19, 1),
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
+	{
+		.name = "spll",		/* 2000 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 80,
+			.div = 1,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 34,
+		},
+	},
+	UNIPHIER_LD11_SYS_CLK_I2C,
+	UNIPHIER_LD11_SYS_CLK_STDMAC(8),	/* HSC, MIO */
+	{
+		.name = "usb2",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 24,
+			.div = 25,
+		},
+	},
+	{ /* sentinel */ }
+};
+
+const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
+	{
+		.name = "spll",		/* 2000 MHz */
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 80,
+			.div = 1,
+		},
+	},
+	{
+		.name = "uart",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 34,
+		},
+	},
+	UNIPHIER_LD11_SYS_CLK_I2C,
+	UNIPHIER_LD20_SYS_CLK_SD,
+	UNIPHIER_LD11_SYS_CLK_STDMAC(8),	/* HSC */
+	/* GIO is always clock-enabled: no function for 0x210c bit5 */
+	{
+		.name = "usb30",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = 16,
+		.data.gate = {
+			.parent_name = NULL,
+			.reg = 0x210c,
+			/*
+			 * clock for USB Link is enabled by the logic "OR"
+			 * of bit 14 and bit 15.  We do not use bit 15 here.
+			 */
+			.mask = BIT(14),
+		},
+	},
+	{
+		.name = "usb30phy",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = 18,
+		.data.gate = {
+			.parent_name = NULL,
+			.reg = 0x210c,
+			.mask = BIT(12) | BIT(13),
+		},
+	},
+	{ /* sentinel */ }
+};
diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
index 364953c..be4fd92 100644
--- a/drivers/clk/uniphier/clk-uniphier.h
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -80,4 +80,17 @@ struct clk_hw *uniphier_clk_register_mux(struct device *dev,
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
