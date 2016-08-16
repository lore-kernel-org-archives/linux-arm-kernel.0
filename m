From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:02 +0200
Subject: [RFC 05/17] clk: fixed-rate: Switch to new clock controller API
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate a clock controller and use new clk_register_with_ctrl() API.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-fixed-rate.c | 28 ++++++++++++++++++----------
 drivers/clk/samsung/clk.c    |  2 +-
 include/linux/clk-provider.h | 10 ++++++++--
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 2edb39342a02..0a5c4f2105da 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -55,6 +55,7 @@ EXPORT_SYMBOL_GPL(clk_fixed_rate_ops);
  * @fixed_accuracy: non-adjustable clock rate
  */
 struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
+		struct clk_ctrl *ctrl, // FIXME: re-align
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate, unsigned long fixed_accuracy)
 {
@@ -81,7 +82,7 @@ struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
 
 	/* register the clock */
 	hw = &fixed->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = clk_hw_register_with_ctrl(dev, ctrl, hw);
 	if (ret) {
 		kfree(fixed);
 		hw = ERR_PTR(ret);
@@ -92,13 +93,14 @@ struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_rate_with_accuracy);
 
 struct clk *clk_register_fixed_rate_with_accuracy(struct device *dev,
+		struct clk_ctrl *ctrl, // FIXME: re-align
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate, unsigned long fixed_accuracy)
 {
 	struct clk_hw *hw;
 
-	hw = clk_hw_register_fixed_rate_with_accuracy(dev, name, parent_name,
-			flags, fixed_rate, fixed_accuracy);
+	hw = clk_hw_register_fixed_rate_with_accuracy(dev, ctrl, name,
+			parent_name, flags, fixed_rate, fixed_accuracy);
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 	return hw->clk;
@@ -114,21 +116,27 @@ EXPORT_SYMBOL_GPL(clk_register_fixed_rate_with_accuracy);
  * @flags: framework-specific flags
  * @fixed_rate: non-adjustable clock rate
  */
-struct clk_hw *clk_hw_register_fixed_rate(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_fixed_rate(struct device *dev,
+		struct clk_ctrl *ctrl, // FIXME: re-align
+		const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate)
 {
-	return clk_hw_register_fixed_rate_with_accuracy(dev, name, parent_name,
-						     flags, fixed_rate, 0);
+	return clk_hw_register_fixed_rate_with_accuracy(dev, ctrl, name,
+							parent_name, flags,
+							fixed_rate, 0);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_rate);
 
-struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
+struct clk *clk_register_fixed_rate(struct device *dev,
+		struct clk_ctrl *ctrl, // FIXME: re-align
+		const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate)
 {
-	return clk_register_fixed_rate_with_accuracy(dev, name, parent_name,
-						     flags, fixed_rate, 0);
+	return clk_register_fixed_rate_with_accuracy(dev, ctrl, name,
+						     parent_name, flags,
+						     fixed_rate, 0);
 }
 EXPORT_SYMBOL_GPL(clk_register_fixed_rate);
 
@@ -174,7 +182,7 @@ void of_fixed_clk_setup(struct device_node *node)
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	clk = clk_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
+	clk = clk_register_fixed_rate_with_accuracy(NULL, NULL, clk_name, NULL,
 						    0, rate, accuracy);
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index fdeb35a48d3a..cb1e4398d6e5 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -147,7 +147,7 @@ void __init samsung_clk_register_fixed_rate(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_fixed_rate(NULL, list->name,
+		clk = clk_register_fixed_rate(NULL, ctx->clk_ctrl, list->name,
 			list->parent_name, list->flags, list->fixed_rate);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 3589f164ff94..2ee4e337e784 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -283,17 +283,23 @@ struct clk_fixed_rate {
 #define to_clk_fixed_rate(_hw) container_of(_hw, struct clk_fixed_rate, hw)
 
 extern const struct clk_ops clk_fixed_rate_ops;
-struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
+struct clk *clk_register_fixed_rate(struct device *dev,
+		struct clk_ctrl *ctrl, // FIXME: re-align
+		const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate);
-struct clk_hw *clk_hw_register_fixed_rate(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_fixed_rate(struct device *dev,
+		struct clk_ctrl *ctrl, // FIXME: re-align
+		const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate);
 struct clk *clk_register_fixed_rate_with_accuracy(struct device *dev,
+		struct clk_ctrl *ctrl, // FIXME: re-align
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate, unsigned long fixed_accuracy);
 void clk_unregister_fixed_rate(struct clk *clk);
 struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
+		struct clk_ctrl *ctrl, // FIXME: re-align
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate, unsigned long fixed_accuracy);
 void clk_hw_unregister_fixed_rate(struct clk_hw *hw);
-- 
1.9.1
