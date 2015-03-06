From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:12:55 +0100
Subject: [PATCH v2 02/11] clk: convert clock gate to accept regmap
In-Reply-To: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654784-27354-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework the clk_gate helpers to either use an iomem base address or a
regmap.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/clk/clk-gate.c       | 94 +++++++++++++++++++++++++++++++++-----------
 include/linux/clk-provider.h | 12 ++++--
 2 files changed, 80 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 3f0e4200cb5d..d62732f5b417 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -11,6 +11,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/err.h>
@@ -50,15 +51,18 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 
 	set ^= enable;
 
-	if (gate->lock)
-		spin_lock_irqsave(gate->lock, flags);
+	if (gate->reg_type == CLK_REG_TYPE_IOMEM && gate->reg.lock)
+		spin_lock_irqsave(gate->reg.lock, flags);
 
 	if (gate->flags & CLK_GATE_HIWORD_MASK) {
 		reg = BIT(gate->bit_idx + 16);
 		if (set)
 			reg |= BIT(gate->bit_idx);
 	} else {
-		reg = clk_readl(gate->reg);
+		if (gate->reg_type == CLK_REG_TYPE_IOMEM)
+			reg = clk_readl(gate->reg.iomem);
+		else
+			regmap_read(gate->reg.regmap, gate->reg.offset, &reg);
 
 		if (set)
 			reg |= BIT(gate->bit_idx);
@@ -66,10 +70,13 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 			reg &= ~BIT(gate->bit_idx);
 	}
 
-	clk_writel(reg, gate->reg);
+	if (gate->reg_type == CLK_REG_TYPE_IOMEM)
+		clk_writel(reg, gate->reg.iomem);
+	else
+		regmap_write(gate->reg.regmap, gate->reg.offset, reg);
 
-	if (gate->lock)
-		spin_unlock_irqrestore(gate->lock, flags);
+	if (gate->reg_type == CLK_REG_TYPE_IOMEM && gate->reg.lock)
+		spin_unlock_irqrestore(gate->reg.lock, flags);
 }
 
 static int clk_gate_enable(struct clk_hw *hw)
@@ -89,7 +96,10 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
 	u32 reg;
 	struct clk_gate *gate = to_clk_gate(hw);
 
-	reg = clk_readl(gate->reg);
+	if (gate->reg_type == CLK_REG_TYPE_IOMEM)
+		reg = clk_readl(gate->reg.iomem);
+	else
+		regmap_read(gate->reg.regmap, gate->reg.offset, &reg);
 
 	/* if a set bit disables this clk, flip it before masking */
 	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
@@ -107,21 +117,10 @@ const struct clk_ops clk_gate_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_gate_ops);
 
-/**
- * clk_register_gate - register a gate clock with the clock framework
- * @dev: device that is registering this clock
- * @name: name of this clock
- * @parent_name: name of this clock's parent
- * @flags: framework-specific flags for this clock
- * @reg: register address to control gating of this clock
- * @bit_idx: which bit in the register controls gating of this clock
- * @clk_gate_flags: gate-specific flags for this clock
- * @lock: shared register lock for this clock
- */
-struct clk *clk_register_gate(struct device *dev, const char *name,
+struct clk *__clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
-		void __iomem *reg, u8 bit_idx,
-		u8 clk_gate_flags, spinlock_t *lock)
+		union clk_reg reg, enum clk_reg_type type, u8 bit_idx,
+		u8 clk_gate_flags)
 {
 	struct clk_gate *gate;
 	struct clk *clk;
@@ -149,9 +148,9 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 
 	/* struct clk_gate assignments */
 	gate->reg = reg;
+	gate->reg_type = type;
 	gate->bit_idx = bit_idx;
 	gate->flags = clk_gate_flags;
-	gate->lock = lock;
 	gate->hw.init = &init;
 
 	clk = clk_register(dev, &gate->hw);
@@ -161,8 +160,59 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 
 	return clk;
 }
+
+/**
+ * clk_register_gate - register a gate clock with the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of this clock's parent
+ * @flags: framework-specific flags for this clock
+ * @reg: register address to control gating of this clock
+ * @bit_idx: which bit in the register controls gating of this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+struct clk *clk_register_gate(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	union clk_reg clk_reg;
+
+	clk_reg.iomem = reg;
+	clk_reg.lock = lock;
+
+	return __clk_register_gate(dev, name, parent_name, flags, clk_reg,
+				   CLK_REG_TYPE_IOMEM, bit_idx, clk_gate_flags);
+}
 EXPORT_SYMBOL_GPL(clk_register_gate);
 
+/**
+ * clk_register_gate_regmap - register a gate clock with the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of this clock's parent
+ * @flags: framework-specific flags for this clock
+ * @reg: regmap to control the gating of this clock
+ * @bit_idx: which bit in the register controls gating of this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+struct clk *clk_register_gate_regmap(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		struct regmap *reg, unsigned int offset, u8 bit_idx,
+		u8 clk_gate_flags)
+{
+	union clk_reg clk_reg;
+
+	clk_reg.regmap = reg;
+	clk_reg.offset = offset;
+	return __clk_register_gate(dev, name, parent_name, flags, clk_reg,
+				   CLK_REG_TYPE_REGMAP, bit_idx,
+				   clk_gate_flags);
+}
+EXPORT_SYMBOL_GPL(clk_register_gate_regmap);
+
 void clk_unregister_gate(struct clk *clk)
 {
 	struct clk_gate *gate;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5e9278d5506d..a9c755adcf70 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -305,10 +305,10 @@ enum clk_reg_type {
  */
 struct clk_gate {
 	struct clk_hw hw;
-	void __iomem	*reg;
-	u8		bit_idx;
-	u8		flags;
-	spinlock_t	*lock;
+	union clk_reg		reg;
+	enum clk_reg_type	reg_type;
+	u8			bit_idx;
+	u8			flags;
 };
 
 #define CLK_GATE_SET_TO_DISABLE		BIT(0)
@@ -319,6 +319,10 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock);
+struct clk *clk_register_gate_regmap(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		struct regmap *reg, unsigned int offset, u8 bit_idx,
+		u8 clk_gate_flags);
 void clk_unregister_gate(struct clk *clk);
 
 struct clk_div_table {
-- 
2.3.1
