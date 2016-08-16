From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:03 +0200
Subject: [RFC 06/17] clk: gate: Switch to new clock controller API
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate a clock controller and use new clk_register_with_ctrl() API.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-gate.c       | 8 +++++---
 drivers/clk/samsung/clk.c    | 5 +++--
 include/linux/clk-provider.h | 6 ++++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 4e691e35483a..5eea0457778d 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -120,7 +120,8 @@ EXPORT_SYMBOL_GPL(clk_gate_ops);
  * @clk_gate_flags: gate-specific flags for this clock
  * @lock: shared register lock for this clock
  */
-struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_gate(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock)
@@ -166,14 +167,15 @@ struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_gate);
 
-struct clk *clk_register_gate(struct device *dev, const char *name,
+struct clk *clk_register_gate(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock)
 {
 	struct clk_hw *hw;
 
-	hw = clk_hw_register_gate(dev, name, parent_name, flags, reg,
+	hw = clk_hw_register_gate(dev, ctrl, name, parent_name, flags, reg,
 				  bit_idx, clk_gate_flags, lock);
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index cb1e4398d6e5..79332011f258 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -268,8 +268,9 @@ void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_gate(NULL, list->name, list->parent_name,
-				list->flags, ctx->reg_base + list->offset,
+		clk = clk_register_gate(NULL, ctx->clk_ctrl, list->name,
+				list->parent_name, list->flags,
+				ctx->reg_base + list->offset,
 				list->bit_idx, list->gate_flags, &ctx->lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2ee4e337e784..289290655283 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -340,11 +340,13 @@ struct clk_gate {
 #define CLK_GATE_HIWORD_MASK		BIT(1)
 
 extern const struct clk_ops clk_gate_ops;
-struct clk *clk_register_gate(struct device *dev, const char *name,
+struct clk *clk_register_gate(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock);
-struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_gate(struct device *dev, struct clk_ctrl *ctrl,
+		const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock);
-- 
1.9.1
