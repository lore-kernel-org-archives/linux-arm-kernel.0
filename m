From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 07 Nov 2016 15:39:33 +0530
Subject: [PATCH 3/6] clk: Add driver for Maxim-8997 PMIC clocks
In-Reply-To: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
References: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1478513376-14307-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MAX8997 PMIC has 32.786kHz crystal oscillator which provides an
accurate low frequency clock for MAX8997 internal circuit as well as
external circuit. This patch adds support for these two clocks.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: devicetree at vger.kernel.org
CC: linux-clk at vger.kernel.org
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/clk/Kconfig                       | 10 ++++
 drivers/clk/Makefile                      |  1 +
 drivers/clk/clk-max8997.c                 | 76 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/maxim,max8997.h | 23 ++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 drivers/clk/clk-max8997.c
 create mode 100644 include/dt-bindings/clock/maxim,max8997.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e2d9bd7..5339cbe 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -48,6 +48,16 @@ config COMMON_CLK_MAX77802
 	---help---
 	  This driver supports Maxim 77802 crystal oscillator clock.
 
+config COMMON_CLK_MAX8997
+	tristate "Clock driver for Maxim 8997 MFD"
+	depends on MFD_MAX8997
+	select COMMON_CLK_MAX_GEN
+	---help---
+	  This driver supports Maxim 8997 crystal oscillator clock.
+	  The 32.768kHz crystal oscillator clock provides an accurate
+	  low frequency clock for MAX8997 internal circuit as well as
+	  external circuit.
+
 config COMMON_CLK_RK808
 	tristate "Clock driver for RK808/RK818"
 	depends on MFD_RK808
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 3b6f9cf..1cfa9ab 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_MACH_LOONGSON32)		+= clk-ls1x.o
 obj-$(CONFIG_COMMON_CLK_MAX_GEN)	+= clk-max-gen.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 obj-$(CONFIG_COMMON_CLK_MAX77802)	+= clk-max77802.o
+obj-$(CONFIG_COMMON_CLK_MAX8997)	+= clk-max8997.o
 obj-$(CONFIG_ARCH_MB86S7X)		+= clk-mb86s7x.o
 obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
diff --git a/drivers/clk/clk-max8997.c b/drivers/clk/clk-max8997.c
new file mode 100644
index 0000000..9158354
--- /dev/null
+++ b/drivers/clk/clk-max8997.c
@@ -0,0 +1,76 @@
+/*
+ * clk-max8997.c - Clock driver for Maxim 8997
+ *
+ * Copyright (C) 2016 Samsung Electornics
+ * Pankaj Dubey <pankaj.dubey@samsung.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/max8997.h>
+#include <linux/mfd/max8997-private.h>
+#include <linux/clk-provider.h>
+#include <linux/mutex.h>
+#include <linux/clkdev.h>
+
+#include <dt-bindings/clock/maxim,max8997.h>
+#include "clk-max-gen.h"
+
+static struct clk_init_data max8997_clks_init[MAX8997_CLKS_NUM] = {
+	[MAX8997_CLK_AP] = {
+		.name = "32khz_ap",
+		.ops = &max_gen_clk_ops,
+	},
+	[MAX8997_CLK_CP] = {
+		.name = "32khz_cp",
+		.ops = &max_gen_clk_ops,
+	},
+};
+
+static int max8997_clk_probe(struct platform_device *pdev)
+{
+	struct max8997_dev *iodev = dev_get_drvdata(pdev->dev.parent);
+
+	return max_gen_clk_probe(pdev, iodev->regmap, MAX8997_REG_MAINCON1,
+				 max8997_clks_init, MAX8997_CLKS_NUM);
+}
+
+static int max8997_clk_remove(struct platform_device *pdev)
+{
+	return max_gen_clk_remove(pdev, MAX8997_CLKS_NUM);
+}
+
+static const struct platform_device_id max8997_clk_id[] = {
+	{ "max8997-clk", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, max8997_clk_id);
+
+static struct platform_driver max8997_clk_driver = {
+	.driver = {
+		.name  = "max8997-clk",
+	},
+	.probe = max8997_clk_probe,
+	.remove = max8997_clk_remove,
+	.id_table = max8997_clk_id,
+};
+
+module_platform_driver(max8997_clk_driver);
+
+MODULE_DESCRIPTION("MAXIM 8997 Clock Driver");
+MODULE_AUTHOR("Pankaj Dubey <pankaj.dubey@samsung.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/dt-bindings/clock/maxim,max8997.h b/include/dt-bindings/clock/maxim,max8997.h
new file mode 100644
index 0000000..f2dd972
--- /dev/null
+++ b/include/dt-bindings/clock/maxim,max8997.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ *	Author: Pankaj Dubey <pankaj.dubey@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Device Tree binding constants clocks for the Maxim 8997 PMIC.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_MAXIM_MAX8997_CLOCK_H
+#define _DT_BINDINGS_CLOCK_MAXIM_MAX8997_CLOCK_H
+
+/* Fixed rate clocks. */
+
+#define MAX8997_CLK_AP		0
+#define MAX8997_CLK_CP		1
+
+/* Total number of clocks. */
+#define MAX8997_CLKS_NUM		(MAX8997_CLK_CP + 1)
+
+#endif /* _DT_BINDINGS_CLOCK_MAXIM_MAX8997_CLOCK_H */
-- 
2.7.4
