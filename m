From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Apr 2011 21:08:11 +0200
Subject: [PATCH 06/10] clk: Add support for a generic clock multiplexer
In-Reply-To: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1302894495-6879-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for a common type of clock multiplexer.
The multiplexer is described with register, shift and width and
an array of clocks which correspond to the bit value.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
---
 drivers/clk/Kconfig       |    3 +
 drivers/clk/Makefile      |    1 +
 drivers/clk/clk-divider.c |    2 +-
 drivers/clk/clk-mux.c     |   92 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h       |   28 ++++++++++++++
 5 files changed, 125 insertions(+), 1 deletions(-)
 create mode 100644 drivers/clk/clk-mux.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 76bb4c9..710d73d 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -8,3 +8,6 @@ config USE_COMMON_STRUCT_CLK
 
 config USE_COMMON_CLK_DIVIDER
 	bool
+
+config USE_COMMON_CLK_MUX
+	bool
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 723d884..195a434 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
 obj-$(CONFIG_USE_COMMON_STRUCT_CLK) += clk.o
 obj-$(CONFIG_USE_COMMON_CLK_DIVIDER) += clk-divider.o
+obj-$(CONFIG_USE_COMMON_CLK_MUX) += clk-mux.o
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 2de94df..e3f5b7a 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2011 Sascha Hauer <s.hauer@pengutronix.de>
+ * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
new file mode 100644
index 0000000..d33b15f
--- /dev/null
+++ b/drivers/clk/clk-mux.c
@@ -0,0 +1,92 @@
+/*
+ * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Standard functionality for the common clock API.
+ */
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#define to_clk_mux(clk) (container_of(clk, struct clk_mux, clk))
+
+static struct clk *clk_mux_get_parent(struct clk *clk)
+{
+	struct clk_mux *mux = to_clk_mux(clk);
+	u32 val;
+
+	val = readl(mux->reg) >> mux->shift;
+	val &= (1 << mux->width) - 1;
+
+	if (val >= mux->num_clks)
+		return ERR_PTR(-EINVAL);
+
+	return mux->clks[val];
+}
+
+static int clk_mux_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_mux *mux = to_clk_mux(clk);
+	u32 val;
+	int i;
+	unsigned long flags = 0;
+
+	for (i = 0; i < mux->num_clks; i++)
+		if (mux->clks[i] == parent)
+			break;
+
+	if (i == mux->num_clks)
+		return -EINVAL;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+
+	val = readl(mux->reg);
+	val &= ~(((1 << mux->width) - 1) << mux->shift);
+	val |= i << mux->shift;
+	writel(val, mux->reg);
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+
+	return 0;
+}
+
+static long clk_mux_round_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
+
+	return clk_get_rate(parent);
+}
+
+static int clk_mux_set_rate(struct clk *clk, unsigned long desired)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
+
+	if (desired != clk_get_rate(parent))
+		return -EINVAL;
+
+	return 0;
+}
+
+struct clk_ops clk_mux_ops = {
+	.prepare = clk_parent_prepare,
+	.unprepare = clk_parent_unprepare,
+	.enable = clk_parent_enable,
+	.disable = clk_parent_disable,
+	.get_rate = clk_parent_get_rate,
+	.round_rate = clk_mux_round_rate,
+	.set_rate = clk_mux_set_rate,
+	.get_parent = clk_mux_get_parent,
+	.set_parent = clk_mux_set_parent,
+};
+EXPORT_SYMBOL_GPL(clk_mux_ops);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 6f9771b..fb2c2f5 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -211,6 +211,34 @@ struct clk_divider {
 
 extern struct clk_ops clk_divider_ops;
 
+/**
+ * clock multiplexer
+ *
+ * @clk		clock source
+ * @reg		the register this multiplexer can be configured with
+ * @shift	the shift to the start bit of this multiplexer
+ * @width	the width in bits of this multiplexer
+ * @num_clks	number of parent clocks
+ * @lock	register lock
+ * @clks	array of possible parents for this multiplexer. Can contain
+ *		holes with NULL in it for invalid register settings
+ *
+ * This clock implements get_parent/set_parent. prepare/unprepare,
+ * enable/disable and get_rate operations are passed through to the parent,
+ * the rate is not adjustable.
+ */
+struct clk_mux {
+	struct clk	clk;
+	void __iomem	*reg;
+	unsigned char	shift;
+	unsigned char	width;
+	unsigned char	num_clks;
+	spinlock_t	*lock;
+	struct clk	**clks;
+};
+
+extern struct clk_ops clk_mux_ops;
+
 #else /* !CONFIG_USE_COMMON_STRUCT_CLK */
 
 /*
-- 
1.7.4.1
