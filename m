From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Oct 2015 09:36:45 +0200
Subject: [PATCH v6 1/5] clk: Add a basic multiplier clock
In-Reply-To: <1445326609-6314-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1445326609-6314-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1445326609-6314-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks are using a multiplier component, however, unlike their mux,
gate or divider counterpart, these factors don't have a basic clock
implementation.

This leads to code duplication across platforms that want to use that kind
of clocks, and the impossibility to use the composite clocks with such a
clock without defining your own rate operations.

Create such a driver in order to remove these issues, and hopefully factor
the implementations, reducing code size across platforms and consolidating
the various implementations.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/Makefile         |   1 +
 drivers/clk/clk-multiplier.c | 181 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  42 ++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 drivers/clk/clk-multiplier.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d08b3e5985be..0b2101039508 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-divider.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-factor.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-rate.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gate.o
+obj-$(CONFIG_COMMON_CLK)	+= clk-multiplier.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fractional-divider.o
diff --git a/drivers/clk/clk-multiplier.c b/drivers/clk/clk-multiplier.c
new file mode 100644
index 000000000000..43ec269fcbff
--- /dev/null
+++ b/drivers/clk/clk-multiplier.c
@@ -0,0 +1,181 @@
+/*
+ * Copyright (C) 2015 Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#define to_clk_multiplier(_hw) container_of(_hw, struct clk_multiplier, hw)
+
+static unsigned long __get_mult(struct clk_multiplier *mult,
+				unsigned long rate,
+				unsigned long parent_rate)
+{
+	if (mult->flags & CLK_MULTIPLIER_ROUND_CLOSEST)
+		return DIV_ROUND_CLOSEST(rate, parent_rate);
+
+	return rate / parent_rate;
+}
+
+static unsigned long clk_multiplier_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct clk_multiplier *mult = to_clk_multiplier(hw);
+	unsigned long val;
+
+	val = clk_readl(mult->reg) >> mult->shift;
+	val &= GENMASK(mult->width - 1, 0);
+
+	if (!val && mult->flags & CLK_MULTIPLIER_ZERO_BYPASS)
+		val = 1;
+
+	return parent_rate * val;
+}
+
+static bool __is_best_rate(unsigned long rate, unsigned long new,
+			   unsigned long best, unsigned long flags)
+{
+	if (flags & CLK_MULTIPLIER_ROUND_CLOSEST)
+		return abs(rate - new) < abs(rate - best);
+
+	return new >= rate && new < best;
+}
+
+static unsigned long __bestmult(struct clk_hw *hw, unsigned long rate,
+				unsigned long *best_parent_rate,
+				u8 width, unsigned long flags)
+{
+	unsigned long orig_parent_rate = *best_parent_rate;
+	unsigned long parent_rate, current_rate, best_rate = ~0;
+	unsigned int i, bestmult = 0;
+
+	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT))
+		return rate / *best_parent_rate;
+
+	for (i = 1; i < ((1 << width) - 1); i++) {
+		if (rate == orig_parent_rate * i) {
+			/*
+			 * This is the best case for us if we have a
+			 * perfect match without changing the parent
+			 * rate.
+			 */
+			*best_parent_rate = orig_parent_rate;
+			return i;
+		}
+
+		parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
+						rate / i);
+		current_rate = parent_rate * i;
+
+		if (__is_best_rate(rate, current_rate, best_rate, flags)) {
+			bestmult = i;
+			best_rate = current_rate;
+			*best_parent_rate = parent_rate;
+		}
+	}
+
+	return bestmult;
+}
+
+static long clk_multiplier_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *parent_rate)
+{
+	struct clk_multiplier *mult = to_clk_multiplier(hw);
+	unsigned long factor = __bestmult(hw, rate, parent_rate,
+					  mult->width, mult->flags);
+
+	return *parent_rate * factor;
+}
+
+static int clk_multiplier_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct clk_multiplier *mult = to_clk_multiplier(hw);
+	unsigned long factor = __get_mult(mult, rate, parent_rate);
+	unsigned long flags = 0;
+	unsigned long val;
+
+	if (mult->lock)
+		spin_lock_irqsave(mult->lock, flags);
+	else
+		__acquire(mult->lock);
+
+	val = clk_readl(mult->reg);
+	val &= ~GENMASK(mult->width + mult->shift - 1, mult->shift);
+	val |= factor << mult->shift;
+	clk_writel(val, mult->reg);
+
+	if (mult->lock)
+		spin_unlock_irqrestore(mult->lock, flags);
+	else
+		__release(mult->lock);
+
+	return 0;
+}
+
+const struct clk_ops clk_multiplier_ops = {
+	.recalc_rate	= clk_multiplier_recalc_rate,
+	.round_rate	= clk_multiplier_round_rate,
+	.set_rate	= clk_multiplier_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_multiplier_ops);
+
+struct clk *clk_register_multiplier(struct device *dev, const char *name,
+				    const char *parent_name,
+				    unsigned long flags,
+				    void __iomem *reg, u8 shift, u8 width,
+				    u8 clk_mult_flags, spinlock_t *lock)
+{
+	struct clk_init_data init;
+	struct clk_multiplier *mult;
+	struct clk *clk;
+
+	mult = kmalloc(sizeof(*mult), GFP_KERNEL);
+	if (!mult)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_multiplier_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	mult->reg = reg;
+	mult->shift = shift;
+	mult->width = width;
+	mult->flags = clk_mult_flags;
+	mult->lock = lock;
+	mult->hw.init = &init;
+
+	clk = clk_register(dev, &mult->hw);
+	if (IS_ERR(clk))
+		kfree(mult);
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(clk_register_multiplier);
+
+void clk_unregister_multiplier(struct clk *clk)
+{
+	struct clk_multiplier *mult;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	mult = to_clk_multiplier(hw);
+
+	clk_unregister(clk);
+	kfree(mult);
+}
+EXPORT_SYMBOL_GPL(clk_unregister_multiplier);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 3ecc07d0da77..6a7dfe33a317 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -518,6 +518,48 @@ struct clk *clk_register_fractional_divider(struct device *dev,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
 		u8 clk_divider_flags, spinlock_t *lock);
 
+/**
+ * struct clk_multiplier - adjustable multiplier clock
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @reg:	register containing the multiplier
+ * @shift:	shift to the multiplier bit field
+ * @width:	width of the multiplier bit field
+ * @lock:	register lock
+ *
+ * Clock with an adjustable multiplier affecting its output frequency.
+ * Implements .recalc_rate, .set_rate and .round_rate
+ *
+ * Flags:
+ * CLK_MULTIPLIER_ZERO_BYPASS - By default, the multiplier is the value read
+ *	from the register, with 0 being a valid value effectively
+ *	zeroing the output clock rate. If CLK_MULTIPLIER_ZERO_BYPASS is
+ *	set, then a null multiplier will be considered as a bypass,
+ *	leaving the parent rate unmodified.
+ * CLK_MULTIPLIER_ROUND_CLOSEST - Makes the best calculated divider to be
+ *	rounded to the closest integer instead of the down one.
+ */
+struct clk_multiplier {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u8		shift;
+	u8		width;
+	u8		flags;
+	spinlock_t	*lock;
+};
+
+#define CLK_MULTIPLIER_ZERO_BYPASS		BIT(0)
+#define CLK_MULTIPLIER_ROUND_CLOSEST	BIT(1)
+
+extern const struct clk_ops clk_multiplier_ops;
+
+struct clk *clk_register_multiplier(struct device *dev, const char *name,
+				    const char *parent_name,
+				    unsigned long flags,
+				    void __iomem *reg, u8 shift, u8 width,
+				    u8 clk_mult_flags, spinlock_t *lock);
+void clk_unregister_multiplier(struct clk *clk);
+
 /***
  * struct clk_composite - aggregate clock of mux, divider and gate clocks
  *
-- 
2.6.2
