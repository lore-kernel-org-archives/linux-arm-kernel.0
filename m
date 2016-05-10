From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 18:50:48 +0900
Subject: [RFC PATCH 07/21] clk: uniphier: add clock driver for UniPhier
 ProXstream2/PH1-LD6b SoC
In-Reply-To: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462873862-30940-8-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is just for review.
Please do not apply this patch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/Kconfig             |  4 ++
 drivers/clk/uniphier/Makefile            |  1 +
 drivers/clk/uniphier/clk-uniphier-pxs2.c | 83 ++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 drivers/clk/uniphier/clk-uniphier-pxs2.c

diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
index de3fada..d4a3d55 100644
--- a/drivers/clk/uniphier/Kconfig
+++ b/drivers/clk/uniphier/Kconfig
@@ -22,4 +22,8 @@ config CLK_UNIPHIER_PRO5
 	tristate "Clock driver for UniPhier PH1-Pro5 SoC"
 	default ARM
 
+config CLK_UNIPHIER_PXS2
+	tristate "Clock driver for UniPhier ProXstream2/PH1-LD6b SoC"
+	default ARM
+
 endif
diff --git a/drivers/clk/uniphier/Makefile b/drivers/clk/uniphier/Makefile
index d1edf30..20a274f 100644
--- a/drivers/clk/uniphier/Makefile
+++ b/drivers/clk/uniphier/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_UNIPHIER_LD4)	+= clk-uniphier-ld4.o
 obj-$(CONFIG_CLK_UNIPHIER_PRO4)	+= clk-uniphier-pro4.o
 obj-$(CONFIG_CLK_UNIPHIER_SLD8)	+= clk-uniphier-sld8.o
 obj-$(CONFIG_CLK_UNIPHIER_PRO5)	+= clk-uniphier-pro5.o
+obj-$(CONFIG_CLK_UNIPHIER_PXS2)	+= clk-uniphier-pxs2.o
diff --git a/drivers/clk/uniphier/clk-uniphier-pxs2.c b/drivers/clk/uniphier/clk-uniphier-pxs2.c
new file mode 100644
index 0000000..07f7969
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-pxs2.c
@@ -0,0 +1,83 @@
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
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "clk-uniphier.h"
+
+static const struct uniphier_clk_data uniphier_pxs2_clk_data[] = {
+	{
+		.name = "spll",
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
+		.output_index = 0,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 27,
+		},
+	},
+	{
+		.name = "fi2c",
+		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+		.output_index = 1,
+		.data.factor = {
+			.parent_name = "spll",
+			.mult = 1,
+			.div = 48,
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
+static int uniphier_pxs2_clk_probe(struct platform_device *pdev)
+{
+	return uniphier_clk_probe(pdev, uniphier_pxs2_clk_data);
+}
+
+static struct platform_driver uniphier_pxs2_clk_driver = {
+	.probe = uniphier_pxs2_clk_probe,
+	.remove = uniphier_clk_remove,
+	.driver = {
+		.name = "uniphier-pxs2-clk",
+	},
+};
+module_platform_driver(uniphier_pxs2_clk_driver);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier ProXstream2 System Clock Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
