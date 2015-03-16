From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Mar 2015 06:55:08 +0100
Subject: [PATCH 2/5] clk: mediatek: Add reset controller support
In-Reply-To: <1426485311-31428-1-git-send-email-s.hauer@pengutronix.de>
References: <1426485311-31428-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1426485311-31428-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pericfg and infracfg units also provide reset lines to several
other SoC internal units. Add support for the reset controller.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/mediatek/Makefile  |  1 +
 drivers/clk/mediatek/clk-mtk.h | 10 +++++
 drivers/clk/mediatek/reset.c   | 99 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 drivers/clk/mediatek/reset.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index c384e97..0b6f1c3 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1 +1,2 @@
 obj-y += clk-mtk.o clk-pll.o clk-gate.o
+obj-$(CONFIG_RESET_CONTROLLER) += reset.o
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index c660a9e..fc98101 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -152,4 +152,14 @@ void __init mtk_clk_register_plls(struct device_node *node,
 		const struct mtk_pll_data *plls, int num_plls,
 		struct clk_onecell_data *clk_data);
 
+#ifdef CONFIG_RESET_CONTROLLER
+void mtk_register_reset_controller(struct device_node *np,
+			unsigned int num_regs, int regofs);
+#else
+static inline void mtk_register_reset_controller(struct device_node *np,
+			unsigned int num_regs, int regofs)
+{
+}
+#endif
+
 #endif /* __DRV_CLK_MTK_H */
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
new file mode 100644
index 0000000..3a85a53
--- /dev/null
+++ b/drivers/clk/mediatek/reset.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+
+#include "clk-mtk.h"
+
+struct mtk_reset {
+	struct regmap *regmap;
+	int regofs;
+	struct reset_controller_dev rcdev;
+};
+
+static int mtk_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
+
+	return regmap_update_bits(data->regmap, data->regofs + ((id / 32) << 2),
+			BIT(id % 32), ~0);
+}
+
+static int mtk_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
+
+	return regmap_update_bits(data->regmap, data->regofs + ((id / 32) << 2),
+			BIT(id % 32), 0);
+}
+
+static int mtk_reset(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	int ret;
+
+	ret = mtk_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return mtk_reset_deassert(rcdev, id);
+}
+
+static struct reset_control_ops mtk_reset_ops = {
+	.assert = mtk_reset_assert,
+	.deassert = mtk_reset_deassert,
+	.reset = mtk_reset,
+};
+
+void mtk_register_reset_controller(struct device_node *np,
+			unsigned int num_regs, int regofs)
+{
+	struct mtk_reset *data;
+	int ret;
+	struct regmap *regmap;
+
+	regmap = syscon_node_to_regmap(np);
+	if (IS_ERR(regmap)) {
+		pr_err("Cannot find regmap for %s: %ld\n", np->full_name,
+				PTR_ERR(regmap));
+		return;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->regmap = regmap;
+	data->regofs = regofs;
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = num_regs * 32;
+	data->rcdev.ops = &mtk_reset_ops;
+	data->rcdev.of_node = np;
+
+	ret = reset_controller_register(&data->rcdev);
+	if (ret) {
+		pr_err("could not register reset controller: %d\n", ret);
+		kfree(data);
+		return;
+	}
+}
-- 
2.1.4
