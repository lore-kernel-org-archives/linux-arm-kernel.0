From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:05 +0200
Subject: [RFC 08/17] clk: fixed-factor: Switch to new clock controller API
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-9-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate a clock controller and use new clk_register_with_ctrl() API.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-fixed-factor.c | 11 +++++++----
 drivers/clk/samsung/clk.c      |  2 +-
 include/linux/clk-provider.h   |  4 +++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 4db3be214077..921a99b6e421 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -69,6 +69,7 @@ const struct clk_ops clk_fixed_factor_ops = {
 EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
 
 struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
+		struct clk_ctrl *ctrl,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
@@ -103,13 +104,14 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor);
 
-struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+struct clk *clk_register_fixed_factor(struct device *dev,
+		struct clk_ctrl *ctrl, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
 	struct clk_hw *hw;
 
-	hw = clk_hw_register_fixed_factor(dev, name, parent_name, flags, mult,
+	hw = clk_hw_register_fixed_factor(dev, ctrl, name, parent_name, flags, mult,
 					  div);
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
@@ -176,8 +178,9 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
 	if (of_match_node(set_rate_parent_matches, node))
 		flags |= CLK_SET_RATE_PARENT;
 
-	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, flags,
-					mult, div);
+	/* TODO: convert to clk_ctrl */
+	clk = clk_register_fixed_factor(NULL, NULL, clk_name, parent_name,
+					flags, mult, div);
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 1a296bbabd47..7bfd895781c5 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -176,7 +176,7 @@ void __init samsung_clk_register_fixed_factor(struct samsung_clk_provider *ctx,
 	unsigned int idx;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_fixed_factor(NULL, list->name,
+		clk = clk_register_fixed_factor(NULL, ctx->clk_ctrl, list->name,
 			list->parent_name, list->flags, list->mult, list->div);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f5f062d267a9..26171815948e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -545,11 +545,13 @@ struct clk_fixed_factor {
 #define to_clk_fixed_factor(_hw) container_of(_hw, struct clk_fixed_factor, hw)
 
 extern const struct clk_ops clk_fixed_factor_ops;
-struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+struct clk *clk_register_fixed_factor(struct device *dev,
+		struct clk_ctrl *ctrl, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
 void clk_unregister_fixed_factor(struct clk *clk);
 struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
+		struct clk_ctrl *ctrl,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
 void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
-- 
1.9.1
