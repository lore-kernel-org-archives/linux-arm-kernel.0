From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Mar 2012 14:35:59 +0100
Subject: [PATCH 1/8] clk: add a fixed factor clock
In-Reply-To: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
References: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1332164166-6055-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having fixed factors/dividers in hardware is a common pattern, so
add a clock doing this. Currently no rate propagation is supported.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/Makefile           |    2 +-
 drivers/clk/clk-fixed-factor.c |   97 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h   |    4 ++
 3 files changed, 102 insertions(+), 1 deletions(-)
 create mode 100644 drivers/clk/clk-fixed-factor.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 1f736bc..24aa714 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -1,4 +1,4 @@
 
 obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
 obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
-				   clk-mux.o clk-divider.o
+				   clk-mux.o clk-divider.o clk-fixed-factor.o
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
new file mode 100644
index 0000000..7c5e1fc
--- /dev/null
+++ b/drivers/clk/clk-fixed-factor.c
@@ -0,0 +1,97 @@
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
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+
+struct clk_fixed_factor {
+	struct clk_hw	hw;
+	unsigned int	mult;
+	unsigned int	div;
+	char		*parent[1];
+};
+
+#define to_clk_fixed_factor(_hw) container_of(_hw, struct clk_fixed_factor, hw)
+
+static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_fixed_factor *fix = to_clk_fixed_factor(hw);
+
+	return (parent_rate / fix->div) * fix->mult;
+}
+
+static long clk_factor_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	struct clk_fixed_factor *fix = to_clk_fixed_factor(hw);
+
+	if (prate) {
+		unsigned long best_parent;
+		best_parent = (rate / fix->mult) * fix->div;
+		*prate = __clk_round_rate(__clk_get_parent(hw->clk),
+				best_parent);
+		return (*prate / fix->div) * fix->mult;
+	} else {
+		return (__clk_get_rate(__clk_get_parent(hw->clk)) / fix->div) * fix->mult;
+	}
+}
+
+static int clk_factor_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	return 0;
+}
+
+struct clk_ops clk_fixed_factor_ops = {
+	.round_rate = clk_factor_round_rate,
+	.set_rate = clk_factor_set_rate,
+	.recalc_rate = clk_factor_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
+
+struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned int mult, unsigned int div)
+{
+	struct clk_fixed_factor *fix;
+	struct clk *clk;
+
+	fix = kmalloc(sizeof(struct clk_gate), GFP_KERNEL);
+
+	if (!fix) {
+		pr_err("%s: could not allocate gated clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* struct clk_gate assignments */
+	fix->mult = mult;
+	fix->div = div;
+
+	if (parent_name) {
+		fix->parent[0] = kstrdup(parent_name, GFP_KERNEL);
+		if (!fix->parent[0])
+			goto out;
+	}
+
+	clk = clk_register(dev, name,
+			&clk_fixed_factor_ops, &fix->hw,
+			fix->parent,
+			(parent_name ? 1 : 0),
+			flags);
+	if (clk)
+		return clk;
+
+out:
+	kfree(fix->parent[0]);
+	kfree(fix);
+
+	return NULL;
+}
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5508897..21ca2f8 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -257,6 +257,10 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock);
 
+struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned int mult, unsigned int div);
+
 /**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
-- 
1.7.9.1
