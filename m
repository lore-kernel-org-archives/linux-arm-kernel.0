From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:06 +0200
Subject: [RFC 09/17] clk: divider: Switch to new clock controller API
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-10-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate a clock controller and use new clk_register_with_ctrl() API.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-divider.c            | 10 +++++++---
 drivers/clk/clk-fractional-divider.c |  5 +++--
 drivers/clk/samsung/clk.c            |  8 ++++----
 include/linux/clk-provider.h         | 13 +++++++++----
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a0f55bc1ad3d..8e9e89f8c5a8 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -490,7 +490,8 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
  * @clk_divider_flags: divider-specific flags for this clock
  * @lock: shared register lock for this clock
  */
-struct clk *clk_register_divider(struct device *dev, const char *name,
+struct clk *clk_register_divider(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, spinlock_t *lock)
@@ -517,7 +518,8 @@ EXPORT_SYMBOL_GPL(clk_register_divider);
  * @clk_divider_flags: divider-specific flags for this clock
  * @lock: shared register lock for this clock
  */
-struct clk_hw *clk_hw_register_divider(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_divider(struct device *dev,
+		struct clk_ctrl *ctrl, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, spinlock_t *lock)
@@ -541,7 +543,8 @@ EXPORT_SYMBOL_GPL(clk_hw_register_divider);
  * @table: array of divider/value pairs ending with a div set to 0
  * @lock: shared register lock for this clock
  */
-struct clk *clk_register_divider_table(struct device *dev, const char *name,
+struct clk *clk_register_divider_table(struct device *dev,
+		struct clk_ctrl *ctrl, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
@@ -572,6 +575,7 @@ EXPORT_SYMBOL_GPL(clk_register_divider_table);
  * @lock: shared register lock for this clock
  */
 struct clk_hw *clk_hw_register_divider_table(struct device *dev,
+		struct clk_ctrl *ctrl,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index aab904618eb6..1b712a424fd4 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -117,6 +117,7 @@ const struct clk_ops clk_fractional_divider_ops = {
 EXPORT_SYMBOL_GPL(clk_fractional_divider_ops);
 
 struct clk_hw *clk_hw_register_fractional_divider(struct device *dev,
+		struct clk_ctrl *ctrl,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
 		u8 clk_divider_flags, spinlock_t *lock)
@@ -158,14 +159,14 @@ struct clk_hw *clk_hw_register_fractional_divider(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fractional_divider);
 
-struct clk *clk_register_fractional_divider(struct device *dev,
+struct clk *clk_register_fractional_divider(struct device *dev, struct clk_ctrl *ctrl,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
 		u8 clk_divider_flags, spinlock_t *lock)
 {
 	struct clk_hw *hw;
 
-	hw = clk_hw_register_fractional_divider(dev, name, parent_name, flags,
+	hw = clk_hw_register_fractional_divider(dev, ctrl, name, parent_name, flags,
 			reg, mshift, mwidth, nshift, nwidth, clk_divider_flags,
 			lock);
 	if (IS_ERR(hw))
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 7bfd895781c5..9a8068d4da77 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -230,14 +230,14 @@ void __init samsung_clk_register_div(struct samsung_clk_provider *ctx,
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		if (list->table)
-			clk = clk_register_divider_table(NULL, list->name,
-				list->parent_name, list->flags,
+			clk = clk_register_divider_table(NULL, ctx->clk_ctrl,
+				list->name, list->parent_name, list->flags,
 				ctx->reg_base + list->offset,
 				list->shift, list->width, list->div_flags,
 				list->table, &ctx->lock);
 		else
-			clk = clk_register_divider(NULL, list->name,
-				list->parent_name, list->flags,
+			clk = clk_register_divider(NULL, ctx->clk_ctrl,
+				list->name, list->parent_name, list->flags,
 				ctx->reg_base + list->offset, list->shift,
 				list->width, list->div_flags, &ctx->lock);
 		if (IS_ERR(clk)) {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 26171815948e..cfb3aa3912c5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -428,20 +428,23 @@ int divider_get_val(unsigned long rate, unsigned long parent_rate,
 		const struct clk_div_table *table, u8 width,
 		unsigned long flags);
 
-struct clk *clk_register_divider(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
+struct clk *clk_register_divider(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, spinlock_t *lock);
-struct clk_hw *clk_hw_register_divider(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_divider(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, spinlock_t *lock);
-struct clk *clk_register_divider_table(struct device *dev, const char *name,
+struct clk *clk_register_divider_table(struct device *dev,
+		struct clk_ctrl *ctrl, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock);
 struct clk_hw *clk_hw_register_divider_table(struct device *dev,
+		struct clk_ctrl *ctrl,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
@@ -586,10 +589,12 @@ struct clk_fractional_divider {
 
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
+		struct clk_ctrl *ctrl,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
 		u8 clk_divider_flags, spinlock_t *lock);
 struct clk_hw *clk_hw_register_fractional_divider(struct device *dev,
+		struct clk_ctrl *ctrl,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
 		u8 clk_divider_flags, spinlock_t *lock);
-- 
1.9.1
