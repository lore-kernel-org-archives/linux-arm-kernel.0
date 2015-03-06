From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:12:54 +0100
Subject: [PATCH v2 01/11] clk: convert clock mux to accept regmap
In-Reply-To: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654784-27354-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework the clk_mux helpers to either use an iomem base address or a
regmap.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/clk/clk-mux.c        | 72 +++++++++++++++++++++++++++++++++++++-------
 include/linux/clk-provider.h | 39 +++++++++++++++++++-----
 2 files changed, 93 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 69a094c3783d..360191155bbd 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -42,7 +42,11 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
 	 * val = 0x4 really means "bit 2, index starts at bit 0"
 	 */
-	val = clk_readl(mux->reg) >> mux->shift;
+	if (mux->reg_type == CLK_REG_TYPE_IOMEM)
+		val = clk_readl(mux->reg.iomem) >> mux->shift;
+	else
+		regmap_read(mux->reg.regmap, mux->reg.offset, &val);
+
 	val &= mux->mask;
 
 	if (mux->table) {
@@ -83,20 +87,24 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 			index++;
 	}
 
-	if (mux->lock)
-		spin_lock_irqsave(mux->lock, flags);
+	if (mux->reg_type == CLK_REG_TYPE_IOMEM && mux->reg.lock)
+		spin_lock_irqsave(mux->reg.lock, flags);
 
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		val = mux->mask << (mux->shift + 16);
 	} else {
-		val = clk_readl(mux->reg);
+		val = clk_readl(mux->reg.iomem);
 		val &= ~(mux->mask << mux->shift);
 	}
 	val |= index << mux->shift;
-	clk_writel(val, mux->reg);
 
-	if (mux->lock)
-		spin_unlock_irqrestore(mux->lock, flags);
+	if (mux->reg_type == CLK_REG_TYPE_IOMEM)
+		clk_writel(val, mux->reg.iomem);
+	else
+		regmap_write(mux->reg.regmap, mux->reg.offset, val);
+
+	if (mux->reg_type == CLK_REG_TYPE_IOMEM && mux->reg.lock)
+		spin_unlock_irqrestore(mux->reg.lock, flags);
 
 	return 0;
 }
@@ -113,10 +121,10 @@ const struct clk_ops clk_mux_ro_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
-struct clk *clk_register_mux_table(struct device *dev, const char *name,
+struct clk *__clk_register_mux_table(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+		union clk_reg reg, enum clk_reg_type reg_type, u8 shift,
+		u32 mask, u8 clk_mux_flags, u32 *table)
 {
 	struct clk_mux *mux;
 	struct clk *clk;
@@ -149,10 +157,10 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 
 	/* struct clk_mux assignments */
 	mux->reg = reg;
+	mux->reg_type = reg_type;
 	mux->shift = shift;
 	mux->mask = mask;
 	mux->flags = clk_mux_flags;
-	mux->lock = lock;
 	mux->table = table;
 	mux->hw.init = &init;
 
@@ -163,8 +171,37 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 
 	return clk;
 }
+
+struct clk *clk_register_mux_table(struct device *dev, const char *name,
+		const char **parent_names, u8 num_parents, unsigned long flags,
+		void __iomem *reg, u8 shift, u32 mask,
+		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+{
+	union clk_reg clk_reg;
+
+	clk_reg.iomem = reg;
+	clk_reg.lock = lock;
+	return __clk_register_mux_table(dev, name, parent_names, num_parents,
+					flags, clk_reg, CLK_REG_TYPE_IOMEM,
+					shift, mask, clk_mux_flags, table);
+}
 EXPORT_SYMBOL_GPL(clk_register_mux_table);
 
+struct clk *clk_register_mux_table_regmap(struct device *dev, const char *name,
+		const char **parent_names, u8 num_parents, unsigned long flags,
+		struct regmap *regmap, unsigned int offset, u8 shift, u32 mask,
+		u8 clk_mux_flags, u32 *table)
+{
+	union clk_reg clk_reg;
+
+	clk_reg.regmap = regmap;
+	clk_reg.offset = offset;
+	return __clk_register_mux_table(dev, name, parent_names, num_parents,
+					flags, clk_reg, CLK_REG_TYPE_REGMAP,
+					shift, mask, clk_mux_flags, table);
+}
+EXPORT_SYMBOL_GPL(clk_register_mux_table_regmap);
+
 struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
@@ -178,6 +215,19 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(clk_register_mux);
 
+struct clk *clk_register_mux_regmap(struct device *dev, const char *name,
+		const char **parent_names, u8 num_parents, unsigned long flags,
+		struct regmap *regmap, unsigned int offset, u8 shift, u8 width,
+		u8 clk_mux_flags)
+{
+	u32 mask = BIT(width) - 1;
+
+	return clk_register_mux_table_regmap(dev, name, parent_names,
+				      num_parents, flags, regmap, offset, shift,
+				      mask, clk_mux_flags, NULL);
+}
+EXPORT_SYMBOL_GPL(clk_register_mux_regmap);
+
 void clk_unregister_mux(struct clk *clk)
 {
 	struct clk_mux *mux;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5591ea71a8d1..5e9278d5506d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 
 #ifdef CONFIG_COMMON_CLK
 
@@ -266,6 +267,22 @@ struct clk *clk_register_fixed_rate_with_accuracy(struct device *dev,
 
 void of_fixed_clk_setup(struct device_node *np);
 
+union clk_reg {
+	struct {
+		void __iomem	*iomem;
+		spinlock_t	*lock;
+	};
+	struct {
+		struct regmap	*regmap;
+		unsigned int	offset;
+	};
+};
+
+enum clk_reg_type {
+	CLK_REG_TYPE_IOMEM,
+	CLK_REG_TYPE_REGMAP,
+};
+
 /**
  * struct clk_gate - gating clock
  *
@@ -407,13 +424,13 @@ void clk_unregister_divider(struct clk *clk);
  *	frequency.
  */
 struct clk_mux {
-	struct clk_hw	hw;
-	void __iomem	*reg;
-	u32		*table;
-	u32		mask;
-	u8		shift;
-	u8		flags;
-	spinlock_t	*lock;
+	struct clk_hw		hw;
+	union clk_reg		reg;
+	enum clk_reg_type	reg_type;
+	u32			*table;
+	u32			mask;
+	u8			shift;
+	u8			flags;
 };
 
 #define CLK_MUX_INDEX_ONE		BIT(0)
@@ -429,11 +446,19 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock);
+struct clk *clk_register_mux_regmap(struct device *dev, const char *name,
+		const char **parent_names, u8 num_parents, unsigned long flags,
+		struct regmap *regmap, unsigned int offset, u8 shift, u8 width,
+		u8 clk_mux_flags);
 
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+struct clk *clk_register_mux_table_regmap(struct device *dev, const char *name,
+		const char **parent_names, u8 num_parents, unsigned long flags,
+		struct regmap *regmap, unsigned int offset, u8 shift, u32 mask,
+		u8 clk_mux_flags, u32 *table);
 
 void clk_unregister_mux(struct clk *clk);
 
-- 
2.3.1
