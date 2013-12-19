From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 19 Dec 2013 13:23:38 +0200
Subject: [PATCHv11 07/49] clk: divider: add support for low level ops
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Message-ID: <1387452260-23276-8-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Divider clock can now be registered to use low level register access ops.
Preferred initialization method is via clock description.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-divider.c    |   11 ++++++++---
 include/linux/clk-provider.h |    4 ++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 8cfed5c..61ab30e 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -108,7 +108,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 	struct clk_divider *divider = to_clk_divider(hw);
 	unsigned int div, val;
 
-	val = clk_readl(divider->reg) >> divider->shift;
+	val = divider->ll_ops->clk_readl(divider->reg) >> divider->shift;
 	val &= div_mask(divider);
 
 	div = _get_div(divider, val);
@@ -234,11 +234,11 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
 		val = div_mask(divider) << (divider->shift + 16);
 	} else {
-		val = clk_readl(divider->reg);
+		val = divider->ll_ops->clk_readl(divider->reg);
 		val &= ~(div_mask(divider) << divider->shift);
 	}
 	val |= value << divider->shift;
-	clk_writel(val, divider->reg);
+	divider->ll_ops->clk_writel(val, divider->reg);
 
 	if (divider->lock)
 		spin_unlock_irqrestore(divider->lock, flags);
@@ -291,6 +291,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 	div->lock = lock;
 	div->hw.init = &init;
 	div->table = table;
+	div->ll_ops = &clk_ll_ops_default;
 
 	/* register the clock */
 	clk = clk_register(dev, &div->hw);
@@ -368,6 +369,10 @@ struct clk_hw *clk_register_divider_desc(struct device *dev,
 	divider->flags = hw_desc->flags;
 	divider->table = hw_desc->table;
 	divider->lock = hw_desc->lock;
+	divider->ll_ops = hw_desc->ll_ops;
+
+	if (!divider->ll_ops)
+		divider->ll_ops = &clk_ll_ops_default;
 
 	if (!desc->ops)
 		desc->ops = &clk_divider_ops;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index cc5bee0..3a88346 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -320,6 +320,7 @@ struct clk_div_table {
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register containing the divider
+ * @ll_ops:	low-level ops for accessing the register
  * @shift:	shift to the divider bit field
  * @width:	width of the divider bit field
  * @table:	array of value/divider pairs, last entry should have div = 0
@@ -348,6 +349,7 @@ struct clk_div_table {
 struct clk_divider {
 	struct clk_hw	hw;
 	void __iomem	*reg;
+	struct clk_ll_ops	*ll_ops;
 	u8		shift;
 	u8		width;
 	u8		flags;
@@ -360,6 +362,7 @@ struct clk_divider {
  *
  * @desc:	handle between common and hardware-specific interfaces
  * @reg:	register containing the divider
+ * @ll_ops:	low-level ops for accessing the register
  * @shift:	shift to the divider bit field
  * @width:	width of the divider bit field
  * @table:	array of value/divider pairs, last entry should have div = 0
@@ -368,6 +371,7 @@ struct clk_divider {
 struct clk_divider_desc {
 	struct clk_desc	desc;
 	void __iomem	*reg;
+	struct clk_ll_ops	*ll_ops;
 	u8		shift;
 	u8		width;
 	u8		flags;
-- 
1.7.9.5
