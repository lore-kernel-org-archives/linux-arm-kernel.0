From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Jan 2016 16:24:46 +0100
Subject: [PATCH v2 03/26] clk: Add regmap support
In-Reply-To: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1452785109-6172-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Some devices like SoCs from Mediatek need to use the clock
through a regmap interface.
This patch adds regmap support for the simple multiplexer clock,
the divider clock and the clock gate code.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/Makefile         |  1 +
 drivers/clk/clk-divider.c    | 68 +++++++++++++++++++++++++-------
 drivers/clk/clk-gate.c       | 54 +++++++++++++++++++------
 drivers/clk/clk-io.c         | 48 ++++++++++++++++++++++
 drivers/clk/clk-io.h         | 22 +++++++++++
 drivers/clk/clk-mux.c        | 94 +++++++++++++++++++++++++++++++++++++-------
 include/linux/clk-provider.h | 54 +++++++++++++++++++++++--
 7 files changed, 298 insertions(+), 43 deletions(-)
 create mode 100644 drivers/clk/clk-io.c
 create mode 100644 drivers/clk/clk-io.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 820714c72d36..31a888c0c182 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fractional-divider.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gpio.o
+obj-$(CONFIG_COMMON_CLK)	+= clk-io.o
 ifeq ($(CONFIG_OF), y)
 obj-$(CONFIG_COMMON_CLK)	+= clk-conf.o
 endif
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 3ace102a2a0a..1ddb353b3fff 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -18,6 +18,8 @@
 #include <linux/string.h>
 #include <linux/log2.h>
 
+#include "clk-io.h"
+
 /*
  * DOC: basic adjustable divider clock that cannot gate
  *
@@ -142,7 +144,8 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 	struct clk_divider *divider = to_clk_divider(hw);
 	unsigned int val;
 
-	val = clk_readl(divider->reg) >> divider->shift;
+	val = clk_io_readl(hw, divider->reg, divider->regmap, divider->offset);
+	val >>= divider->shift;
 	val &= div_mask(divider->width);
 
 	return divider_recalc_rate(hw, parent_rate, val, divider->table,
@@ -354,7 +357,10 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	/* if read only, just return current value */
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
-		bestdiv = readl(divider->reg) >> divider->shift;
+		bestdiv = clk_io_readl(hw, divider->reg, divider->regmap,
+				       divider->offset);
+
+		bestdiv >>= divider->shift;
 		bestdiv &= div_mask(divider->width);
 		bestdiv = _get_div(divider->table, bestdiv, divider->flags,
 			divider->width);
@@ -400,12 +406,16 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
 		val = div_mask(divider->width) << (divider->shift + 16);
+		val |= value << divider->shift;
+		clk_io_writel(hw, divider->reg, divider->regmap,
+			      divider->offset, val);
 	} else {
-		val = clk_readl(divider->reg);
-		val &= ~(div_mask(divider->width) << divider->shift);
+		u32 mask = div_mask(divider->width) << divider->shift;
+
+		val = value << divider->shift;
+		clk_io_update_bits(hw, divider->reg, divider->regmap,
+				   divider->offset, mask, val);
 	}
-	val |= value << divider->shift;
-	clk_writel(val, divider->reg);
 
 	if (divider->lock)
 		spin_unlock_irqrestore(divider->lock, flags);
@@ -424,9 +434,9 @@ EXPORT_SYMBOL_GPL(clk_divider_ops);
 
 static struct clk *_register_divider(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, const struct clk_div_table *table,
-		spinlock_t *lock)
+		void __iomem *reg, struct regmap *regmap, u32 offset,
+		u8 shift, u8 width, u8 clk_divider_flags,
+		const struct clk_div_table *table, spinlock_t *lock)
 {
 	struct clk_divider *div;
 	struct clk *clk;
@@ -451,7 +461,12 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 	init.num_parents = (parent_name ? 1 : 0);
 
 	/* struct clk_divider assignments */
-	div->reg = reg;
+	if (flags & CLK_USE_REGMAP)
+		div->regmap = regmap;
+	else
+		div->reg = reg;
+
+	div->offset = offset;
 	div->shift = shift;
 	div->width = width;
 	div->flags = clk_divider_flags;
@@ -485,8 +500,8 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, spinlock_t *lock)
 {
-	return _register_divider(dev, name, parent_name, flags, reg, shift,
-			width, clk_divider_flags, NULL, lock);
+	return _register_divider(dev, name, parent_name, flags, reg, NULL, 0,
+			shift, width, clk_divider_flags, NULL, lock);
 }
 EXPORT_SYMBOL_GPL(clk_register_divider);
 
@@ -510,8 +525,8 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock)
 {
-	return _register_divider(dev, name, parent_name, flags, reg, shift,
-			width, clk_divider_flags, table, lock);
+	return _register_divider(dev, name, parent_name, flags, reg, NULL, 0,
+			shift, width, clk_divider_flags, table, lock);
 }
 EXPORT_SYMBOL_GPL(clk_register_divider_table);
 
@@ -530,3 +545,28 @@ void clk_unregister_divider(struct clk *clk)
 	kfree(div);
 }
 EXPORT_SYMBOL_GPL(clk_unregister_divider);
+
+struct clk *clk_regm_register_divider(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		struct regmap *regmap, u32 offset, u8 shift, u8 width,
+		u8 clk_divider_flags, spinlock_t *lock)
+{
+	flags |= CLK_USE_REGMAP;
+
+	return _register_divider(dev, name, parent_name, flags, NULL, regmap,
+			offset,	shift, width, clk_divider_flags, NULL, lock);
+}
+EXPORT_SYMBOL_GPL(clk_regm_register_divider);
+
+struct clk *clk_regm_register_divider_table(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		struct regmap *regmap, u32 offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock)
+{
+	flags |= CLK_USE_REGMAP;
+
+	return _register_divider(dev, name, parent_name, flags, NULL, regmap,
+			offset,	shift, width, clk_divider_flags, table, lock);
+}
+EXPORT_SYMBOL_GPL(clk_regm_register_divider_table);
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index de0b322f5f58..38b558397631 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -16,6 +16,8 @@
 #include <linux/err.h>
 #include <linux/string.h>
 
+#include "clk-io.h"
+
 /**
  * DOC: basic gatable clock which can gate and ungate it's ouput
  *
@@ -46,7 +48,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 	struct clk_gate *gate = to_clk_gate(hw);
 	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
 	unsigned long uninitialized_var(flags);
-	u32 reg;
+	u32 reg, mask;
 
 	set ^= enable;
 
@@ -59,16 +61,20 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 		reg = BIT(gate->bit_idx + 16);
 		if (set)
 			reg |= BIT(gate->bit_idx);
-	} else {
-		reg = clk_readl(gate->reg);
 
+		clk_io_writel(hw, gate->reg, gate->regmap, gate->offset, reg);
+	} else {
 		if (set)
-			reg |= BIT(gate->bit_idx);
+			reg = BIT(gate->bit_idx);
 		else
-			reg &= ~BIT(gate->bit_idx);
+			reg = 0x0;
+
+		mask = BIT(gate->bit_idx);
+
+		clk_io_update_bits(hw, gate->reg, gate->regmap, gate->offset,
+				   mask, reg);
 	}
 
-	clk_writel(reg, gate->reg);
 
 	if (gate->lock)
 		spin_unlock_irqrestore(gate->lock, flags);
@@ -93,7 +99,7 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
 	u32 reg;
 	struct clk_gate *gate = to_clk_gate(hw);
 
-	reg = clk_readl(gate->reg);
+	reg = clk_io_readl(hw, gate->reg, gate->regmap, gate->offset);
 
 	/* if a set bit disables this clk, flip it before masking */
 	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
@@ -122,10 +128,10 @@ EXPORT_SYMBOL_GPL(clk_gate_ops);
  * @clk_gate_flags: gate-specific flags for this clock
  * @lock: shared register lock for this clock
  */
-struct clk *clk_register_gate(struct device *dev, const char *name,
+struct clk *__clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
-		void __iomem *reg, u8 bit_idx,
-		u8 clk_gate_flags, spinlock_t *lock)
+		void __iomem *reg, struct regmap *regmap, u32 offset,
+		u8 bit_idx, u8 clk_gate_flags, spinlock_t *lock)
 {
 	struct clk_gate *gate;
 	struct clk *clk;
@@ -150,7 +156,12 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	init.num_parents = (parent_name ? 1 : 0);
 
 	/* struct clk_gate assignments */
-	gate->reg = reg;
+	if (flags & CLK_USE_REGMAP)
+		gate->regmap = regmap;
+	else
+		gate->reg = reg;
+
+	gate->offset = offset;
 	gate->bit_idx = bit_idx;
 	gate->flags = clk_gate_flags;
 	gate->lock = lock;
@@ -163,6 +174,15 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 
 	return clk;
 }
+
+struct clk *clk_register_gate(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	return __clk_register_gate(dev, name, parent_name, flags,
+			reg, NULL, 0, bit_idx, clk_gate_flags, lock);
+}
 EXPORT_SYMBOL_GPL(clk_register_gate);
 
 void clk_unregister_gate(struct clk *clk)
@@ -180,3 +200,15 @@ void clk_unregister_gate(struct clk *clk)
 	kfree(gate);
 }
 EXPORT_SYMBOL_GPL(clk_unregister_gate);
+
+struct clk *clk_regm_register_gate(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		struct regmap *regmap, u32 offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	flags |= CLK_USE_REGMAP;
+
+	return __clk_register_gate(dev, name, parent_name, flags,
+			NULL, regmap, offset, bit_idx, clk_gate_flags, lock);
+}
+EXPORT_SYMBOL_GPL(clk_regm_register_gate);
diff --git a/drivers/clk/clk-io.c b/drivers/clk/clk-io.c
new file mode 100644
index 000000000000..ceeb64e15ddb
--- /dev/null
+++ b/drivers/clk/clk-io.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2015 Matthias Brugger <matthias.bgg@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/clk-provider.h>
+
+void clk_io_writel(struct clk_hw *hw, void __iomem *reg, struct regmap *regmap,
+		   u32 offset, u32 val)
+{
+	if (__clk_get_flags(hw->clk) & CLK_USE_REGMAP)
+		regmap_write(regmap, offset, val);
+	else
+		clk_writel(val, reg);
+}
+
+u32 clk_io_readl(struct clk_hw *hw, void __iomem *reg, struct regmap *regmap,
+		 u32 offset)
+{
+	u32 val;
+
+	if (__clk_get_flags(hw->clk) & CLK_USE_REGMAP)
+		regmap_read(regmap, offset, &val);
+	else
+		val = clk_readl(reg);
+
+	return val;
+}
+
+int clk_io_update_bits(struct clk_hw *hw, void __iomem *reg,
+		       struct regmap *regmap, u32 offset, u32 mask, u32 val)
+{
+	unsigned int tmp;
+
+	if (__clk_get_flags(hw->clk) & CLK_USE_REGMAP)
+		return regmap_update_bits(regmap, offset, mask, val);
+
+	tmp = clk_readl(reg);
+	tmp &= ~mask;
+	tmp |= val;
+	clk_writel(tmp, reg);
+
+	return 0;
+}
diff --git a/drivers/clk/clk-io.h b/drivers/clk/clk-io.h
new file mode 100644
index 000000000000..b5599ba02084
--- /dev/null
+++ b/drivers/clk/clk-io.h
@@ -0,0 +1,22 @@
+/*
+ * linux/drivers/clk/clk-io.h
+ *
+ * Copyright (C) 2015 Matthias Brugger <matthias.bgg@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __LINUX_CLK_IO_H
+#define __LINUX_CLK_IO_H
+
+#include <linux/clk-provider.h>
+
+void clk_io_writel(struct clk_hw *hw, void __iomem *reg, struct regmap *regmap,
+		   u32 offset, u32 val);
+u32 clk_io_readl(struct clk_hw *hw, void __iomem *reg, struct regmap *regmap,
+		 u32 offset);
+int clk_io_update_bits(struct clk_hw *hw, void __iomem *reg,
+		       struct regmap *regmap, u32 offset, u32 mask, u32 val);
+
+#endif
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 7129c86a79db..d3831eca8b56 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -16,6 +16,8 @@
 #include <linux/io.h>
 #include <linux/err.h>
 
+#include "clk-io.h"
+
 /*
  * DOC: basic adjustable multiplexer clock that cannot gate
  *
@@ -41,7 +43,9 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
 	 * val = 0x4 really means "bit 2, index starts at bit 0"
 	 */
-	val = clk_readl(mux->reg) >> mux->shift;
+	val = clk_io_readl(hw, mux->reg, mux->regmap, mux->offset);
+
+	val >>= mux->shift;
 	val &= mux->mask;
 
 	if (mux->table) {
@@ -70,6 +74,7 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	struct clk_mux *mux = to_clk_mux(hw);
 	u32 val;
 	unsigned long flags = 0;
+	int ret = 0;
 
 	if (mux->table)
 		index = mux->table[index];
@@ -89,19 +94,22 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		val = mux->mask << (mux->shift + 16);
+		val |= index << mux->shift;
+		clk_io_writel(hw, mux->reg, mux->regmap, mux->offset, val);
 	} else {
-		val = clk_readl(mux->reg);
-		val &= ~(mux->mask << mux->shift);
+		u32 mask = mux->mask << mux->shift;
+
+		val = index << mux->shift;
+		ret = clk_io_update_bits(hw, mux->reg, mux->regmap,
+					 mux->offset, mask, val);
 	}
-	val |= index << mux->shift;
-	clk_writel(val, mux->reg);
 
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
 	else
 		__release(mux->lock);
 
-	return 0;
+	return ret;
 }
 
 const struct clk_ops clk_mux_ops = {
@@ -116,10 +124,11 @@ const struct clk_ops clk_mux_ro_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
-struct clk *clk_register_mux_table(struct device *dev, const char *name,
+struct clk *__clk_register_mux_table(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
+		void __iomem *reg, struct regmap *regmap,
+		u32 offset, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
@@ -152,7 +161,12 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 	init.num_parents = num_parents;
 
 	/* struct clk_mux assignments */
-	mux->reg = reg;
+	if (flags & CLK_USE_REGMAP)
+		mux->regmap = regmap;
+	else
+		mux->reg = reg;
+
+	mux->offset = offset;
 	mux->shift = shift;
 	mux->mask = mask;
 	mux->flags = clk_mux_flags;
@@ -167,19 +181,40 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 
 	return clk;
 }
+
+struct clk *clk_register_mux_table(struct device *dev, const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, void __iomem *reg, u8 shift, u32 mask,
+		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+{
+	return __clk_register_mux_table(dev, name, parent_names, num_parents,
+						flags, reg, NULL, 0,
+						shift, mask, clk_mux_flags,
+						table, lock);
+}
 EXPORT_SYMBOL_GPL(clk_register_mux_table);
 
-struct clk *clk_register_mux(struct device *dev, const char *name,
+struct clk *__clk_register_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
-		unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
+		unsigned long flags, void __iomem *reg, struct regmap *regmap,
+		u32 offset, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock)
 {
 	u32 mask = BIT(width) - 1;
 
-	return clk_register_mux_table(dev, name, parent_names, num_parents,
-				      flags, reg, shift, mask, clk_mux_flags,
-				      NULL, lock);
+	return __clk_register_mux_table(dev, name, parent_names, num_parents,
+					flags, reg, regmap, offset, shift, mask,
+					clk_mux_flags, NULL, lock);
+}
+
+struct clk *clk_register_mux(struct device *dev, const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
+		u8 clk_mux_flags, spinlock_t *lock)
+{
+	return __clk_register_mux(dev, name, parent_names, num_parents, flags,
+					reg, NULL, 0, shift, width,
+					clk_mux_flags, lock);
 }
 EXPORT_SYMBOL_GPL(clk_register_mux);
 
@@ -198,3 +233,32 @@ void clk_unregister_mux(struct clk *clk)
 	kfree(mux);
 }
 EXPORT_SYMBOL_GPL(clk_unregister_mux);
+
+struct clk *clk_regm_register_mux(struct device *dev, const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, struct regmap *regmap,
+		u32 offset, u8 shift, u8 width,
+		u8 clk_mux_flags, spinlock_t *lock)
+{
+	flags |= CLK_USE_REGMAP;
+
+	return __clk_register_mux(dev, name, parent_names, num_parents, flags,
+					NULL, regmap, offset, shift, width,
+					clk_mux_flags, lock);
+}
+EXPORT_SYMBOL_GPL(clk_regm_register_mux);
+
+struct clk *clk_regm_register_mux_table(struct device *dev, const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, struct regmap *regmap,
+		u32 offset, u8 shift, u32 mask,
+		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+{
+	flags |= CLK_USE_REGMAP;
+
+	return __clk_register_mux_table(dev, name, parent_names, num_parents,
+					flags, NULL, regmap, offset,
+					shift, mask, clk_mux_flags,
+					table, lock);
+}
+EXPORT_SYMBOL_GPL(clk_regm_register_mux_table);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c56988ac63f7..0c55a37cf8f7 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -13,6 +13,7 @@
 
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 
 #ifdef CONFIG_COMMON_CLK
 
@@ -31,6 +32,7 @@
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
 #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
 #define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
+#define CLK_USE_REGMAP		BIT(10) /* uses regmap to access registers */
 
 struct clk;
 struct clk_hw;
@@ -290,6 +292,8 @@ void of_fixed_clk_setup(struct device_node *np);
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register controlling gate
+ * @regmap:	regmap used to control the gate
+ * @offset:	offset inside the regmap
  * @bit_idx:	single bit controlling gate
  * @flags:	hardware-specific flags
  * @lock:	register lock
@@ -307,7 +311,11 @@ void of_fixed_clk_setup(struct device_node *np);
  */
 struct clk_gate {
 	struct clk_hw hw;
-	void __iomem	*reg;
+	union {
+		void __iomem	*reg;
+		struct regmap	*regmap;
+	};
+	u32		offset;
 	u8		bit_idx;
 	u8		flags;
 	spinlock_t	*lock;
@@ -323,6 +331,11 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 		u8 clk_gate_flags, spinlock_t *lock);
 void clk_unregister_gate(struct clk *clk);
 
+struct clk *clk_regm_register_gate(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		struct regmap *regmap, u32 offset, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock);
+
 struct clk_div_table {
 	unsigned int	val;
 	unsigned int	div;
@@ -333,6 +346,8 @@ struct clk_div_table {
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register containing the divider
+ * @regmap:	regmap used to access the divider
+ * @offest:	offset inside the regmap
  * @shift:	shift to the divider bit field
  * @width:	width of the divider bit field
  * @table:	array of value/divider pairs, last entry should have div = 0
@@ -367,7 +382,11 @@ struct clk_div_table {
  */
 struct clk_divider {
 	struct clk_hw	hw;
-	void __iomem	*reg;
+	union {
+		void __iomem	*reg;
+		struct regmap	*regmap;
+	};
+	u32		offset;
 	u8		shift;
 	u8		width;
 	u8		flags;
@@ -406,11 +425,24 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 		spinlock_t *lock);
 void clk_unregister_divider(struct clk *clk);
 
+struct clk *clk_regm_register_divider(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		struct regmap *regmap, u32 offset, u8 shift, u8 width,
+		u8 clk_divider_flags, spinlock_t *lock);
+
+struct clk *clk_regm_register_divider_table(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		struct regmap *regmap, u32 offset, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock);
+
 /**
  * struct clk_mux - multiplexer clock
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register controlling multiplexer
+ * @regmap:	regmap for controlling multiplexer
+ * @offset:	offset inside the regmap
  * @shift:	shift to multiplexer bit field
  * @width:	width of mutliplexer bit field
  * @flags:	hardware-specific flags
@@ -431,8 +463,12 @@ void clk_unregister_divider(struct clk *clk);
  */
 struct clk_mux {
 	struct clk_hw	hw;
-	void __iomem	*reg;
+	union {
+		void __iomem	*reg;
+		struct regmap	*regmap;
+	};
 	u32		*table;
+	u32		offset;
 	u32		mask;
 	u8		shift;
 	u8		flags;
@@ -462,6 +498,18 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 
 void clk_unregister_mux(struct clk *clk);
 
+struct clk *clk_regm_register_mux_table(struct device *dev, const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, struct regmap *regmap,
+		u32 offset, u8 shift, u32 mask,
+		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+
+struct clk *clk_regm_register_mux(struct device *dev, const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, struct regmap *regmap,
+		u32 offset, u8 shift, u8 width,
+		u8 clk_mux_flags, spinlock_t *lock);
+
 void of_fixed_factor_clk_setup(struct device_node *node);
 
 /**
-- 
2.6.4
