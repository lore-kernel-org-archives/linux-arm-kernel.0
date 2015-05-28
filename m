From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 28 May 2015 20:41:46 +0200
Subject: [PATCH 1/3] clk: mux: Add regmap support for simple mux
In-Reply-To: <1432838508-5184-1-git-send-email-matthias.bgg@gmail.com>
References: <1432838508-5184-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1432838508-5184-2-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices like SoCs from Mediatek need to use the clock muxes
through a regmap interface.
This patch adds regmap support for simple the simple multiplexer
clock code.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/clk/clk-mux.c        | 103 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/clk-provider.h |  40 +++++++++++++++++
 2 files changed, 132 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 1fa2a8d..c7c692a 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -29,6 +29,26 @@
 
 #define to_clk_mux(_hw) container_of(_hw, struct clk_mux, hw)
 
+static void clk_mux_writel(struct clk_mux *mux, u32 val)
+{
+	if (mux->flags && CLK_MUX_USE_REGMAP)
+		regmap_write(mux->regmap, mux->offset, val);
+	else
+		clk_writel(val, mux->reg);
+}
+
+static u32 clk_mux_readl(struct clk_mux *mux)
+{
+	u32 val;
+
+	if (mux->flags && CLK_MUX_USE_REGMAP)
+		regmap_read(mux->regmap, mux->offset, &val);
+	else
+		val = clk_readl(mux->reg);
+
+	return val;
+}
+
 static u8 clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
@@ -42,7 +62,10 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
 	 * val = 0x4 really means "bit 2, index starts at bit 0"
 	 */
-	val = clk_readl(mux->reg) >> mux->shift;
+
+	val = clk_mux_readl(mux);
+
+	val >>= mux->shift;
 	val &= mux->mask;
 
 	if (mux->table) {
@@ -89,11 +112,11 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		val = mux->mask << (mux->shift + 16);
 	} else {
-		val = clk_readl(mux->reg);
+		val = clk_mux_readl(mux);
 		val &= ~(mux->mask << mux->shift);
 	}
 	val |= index << mux->shift;
-	clk_writel(val, mux->reg);
+	clk_mux_writel(mux, val);
 
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
@@ -113,9 +136,10 @@ const struct clk_ops clk_mux_ro_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
-struct clk *clk_register_mux_table(struct device *dev, const char *name,
+struct clk *__clk_register_mux_table(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
+		void __iomem *reg, struct regmap *regmap,
+		u32 offset, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
@@ -149,6 +173,8 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 
 	/* struct clk_mux assignments */
 	mux->reg = reg;
+	mux->regmap = regmap;
+	mux->offset = offset;
 	mux->shift = shift;
 	mux->mask = mask;
 	mux->flags = clk_mux_flags;
@@ -163,18 +189,40 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 
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
-		const char * const *parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
+struct clk *__clk_register_mux(struct device *dev, const char *name,
+		const char * const *parent_names, u8 num_parents,
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
 
@@ -193,3 +241,36 @@ void clk_unregister_mux(struct clk *clk)
 	kfree(mux);
 }
 EXPORT_SYMBOL_GPL(clk_unregister_mux);
+
+#ifdef CONFIG_REGMAP
+
+struct clk *clk_regm_register_mux(struct device *dev, const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, struct regmap *regmap,
+		u32 offset, u8 shift, u8 width,
+		u8 clk_mux_flags, spinlock_t *lock)
+{
+	clk_mux_flags |= CLK_MUX_USE_REGMAP;
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
+	clk_mux_flags |= CLK_MUX_USE_REGMAP;
+
+	return __clk_register_mux_table(dev, name, parent_names, num_parents,
+					flags, NULL, regmap, offset,
+					shift, mask, clk_mux_flags,
+					table, lock);
+}
+EXPORT_SYMBOL_GPL(clk_regm_register_mux_table);
+
+#endif
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index ec609e5..7fd56ca 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 
 #ifdef CONFIG_COMMON_CLK
 
@@ -409,7 +410,9 @@ void clk_unregister_divider(struct clk *clk);
 struct clk_mux {
 	struct clk_hw	hw;
 	void __iomem	*reg;
+	struct regmap	*regmap;
 	u32		*table;
+	u32		offset;
 	u32		mask;
 	u8		shift;
 	u8		flags;
@@ -421,6 +424,7 @@ struct clk_mux {
 #define CLK_MUX_HIWORD_MASK		BIT(2)
 #define CLK_MUX_READ_ONLY		BIT(3) /* mux can't be changed */
 #define CLK_MUX_ROUND_CLOSEST		BIT(4)
+#define CLK_MUX_USE_REGMAP		BIT(5)
 
 extern const struct clk_ops clk_mux_ops;
 extern const struct clk_ops clk_mux_ro_ops;
@@ -437,6 +441,42 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 
 void clk_unregister_mux(struct clk *clk);
 
+#ifdef CONFIG_REGMAP
+
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
+#else
+
+struct clk *clk_regm_register_mux_table(struct device *dev, const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, struct regmap *reg,
+		u32 offset, u8 shift, u32 mask,
+		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+{
+	return NULL;
+}
+
+struct clk *clk_regm_register_mux(struct device *dev, const char *name,
+		const char * const *parent_names, u8 num_parents,
+		unsigned long flags, struct regmap *reg,
+		u32 offset, u8 shift, u8 width,
+		u8 clk_mux_flags, spinlock_t *lock)
+{
+	return NULL;
+}
+
+#endif
+
 void of_fixed_factor_clk_setup(struct device_node *node);
 
 /**
-- 
1.9.1
