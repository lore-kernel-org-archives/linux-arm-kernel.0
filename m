From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 18:50:44 +0900
Subject: [RFC PATCH 03/21] clk: uniphier: add clock driver for UniPhier
 PH1-LD4 SoC
In-Reply-To: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462873862-30940-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is just for review.
Please do not apply this patch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/Kconfig            |   4 ++
 drivers/clk/uniphier/Makefile           |   2 +
 drivers/clk/uniphier/clk-uniphier-ld4.c | 112 ++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 drivers/clk/uniphier/clk-uniphier-ld4.c

diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
index f36529a..f5a7fbb 100644
--- a/drivers/clk/uniphier/Kconfig
+++ b/drivers/clk/uniphier/Kconfig
@@ -6,4 +6,8 @@ menuconfig CLK_UNIPHIER
 
 if CLK_UNIPHIER
 
+config CLK_UNIPHIER_LD4
+	tristate "Clock driver for UniPhier PH1-LD4 SoC"
+	default ARM
+
 endif
diff --git a/drivers/clk/uniphier/Makefile b/drivers/clk/uniphier/Makefile
index 4d6daa8..2ca2070 100644
--- a/drivers/clk/uniphier/Makefile
+++ b/drivers/clk/uniphier/Makefile
@@ -3,3 +3,5 @@ obj-y				+= clk-uniphier-fixed-factor.o
 obj-y				+= clk-uniphier-fixed-rate.o
 obj-y				+= clk-uniphier-gate.o
 obj-y				+= clk-uniphier-mux.o
+
+obj-$(CONFIG_CLK_UNIPHIER_LD4)	+= clk-uniphier-ld4.o
diff --git a/drivers/clk/uniphier/clk-uniphier-ld4.c b/drivers/clk/uniphier/clk-uniphier-ld4.c
new file mode 100644
index 0000000..229729a
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-ld4.c
@@ -0,0 +1,112 @@
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
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "clk-uniphier.h"
+
+static const struct uniphier_clk_data uniphier_ld4_clk_data[] = {
+	{
+		.name = "spll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 65,
+			.div = 1,
+		},
+	},
+	{
+		.name = "upll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 288000,
+			.div = 24576,
+		},
+	},
+	{
+		.name = "a2pll",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = -1,
+		.data.factor = {
+			.parent_name = "ref",
+			.mult = 24,
+			.div = 1,
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
+	{
+		.name = "ehci",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 5,
+		.data.factor = {
+			.parent_name = "upll",
+			.mult = 1,
+			.div = 12,
+		},
+	},
+	{
+		.name = "stdmac",
+		.type = UNIPHIER_CLK_TYPE_GATE,
+		.output_index = 7,
+		.data.gate = {
+			.parent_name = NULL,
+			.reg = 0x2104,
+			.mask = BIT(10),
+			.enable_val = BIT(10),
+		},
+	},
+	{ /* sentinel */ }
+};
+
+static int uniphier_ld4_clk_probe(struct platform_device *pdev)
+{
+	return uniphier_clk_probe(pdev, uniphier_ld4_clk_data);
+}
+
+static struct platform_driver uniphier_ld4_clk_driver = {
+	.probe = uniphier_ld4_clk_probe,
+	.remove = uniphier_clk_remove,
+	.driver = {
+		.name = "uniphier-ld4-clk",
+	},
+};
+module_platform_driver(uniphier_ld4_clk_driver);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier PH1-LD4 System Clock Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
