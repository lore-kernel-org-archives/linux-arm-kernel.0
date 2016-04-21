From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Apr 2016 15:21:57 -0700
Subject: [PATCH v2 06/13] clk: gate: Add hw based registration APIs
In-Reply-To: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
References: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1461277324-27185-7-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add registration APIs in the clk gate code to return struct
clk_hw pointers instead of struct clk pointers. This way we hide
the struct clk pointer from providers unless they need to use
consumer facing APIs.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-gate.c       | 43 ++++++++++++++++++++++++++++++++++++-------
 include/linux/clk-provider.h |  5 +++++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index d0d8ec8e1f1b..4e691e35483a 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -110,7 +110,7 @@ const struct clk_ops clk_gate_ops = {
 EXPORT_SYMBOL_GPL(clk_gate_ops);
 
 /**
- * clk_register_gate - register a gate clock with the clock framework
+ * clk_hw_register_gate - register a gate clock with the clock framework
  * @dev: device that is registering this clock
  * @name: name of this clock
  * @parent_name: name of this clock's parent
@@ -120,14 +120,15 @@ EXPORT_SYMBOL_GPL(clk_gate_ops);
  * @clk_gate_flags: gate-specific flags for this clock
  * @lock: shared register lock for this clock
  */
-struct clk *clk_register_gate(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock)
 {
 	struct clk_gate *gate;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	if (clk_gate_flags & CLK_GATE_HIWORD_MASK) {
 		if (bit_idx > 15) {
@@ -154,12 +155,29 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	gate->lock = lock;
 	gate->hw.init = &init;
 
-	clk = clk_register(dev, &gate->hw);
-
-	if (IS_ERR(clk))
+	hw = &gate->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
 		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_gate);
+
+struct clk *clk_register_gate(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_gate(dev, name, parent_name, flags, reg,
+				  bit_idx, clk_gate_flags, lock);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
 }
 EXPORT_SYMBOL_GPL(clk_register_gate);
 
@@ -178,3 +196,14 @@ void clk_unregister_gate(struct clk *clk)
 	kfree(gate);
 }
 EXPORT_SYMBOL_GPL(clk_unregister_gate);
+
+void clk_hw_unregister_gate(struct clk_hw *hw)
+{
+	struct clk_gate *gate;
+
+	gate = to_clk_gate(hw);
+
+	clk_hw_unregister(hw);
+	kfree(gate);
+}
+EXPORT_SYMBOL_GPL(clk_hw_unregister_gate);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 8885d0350596..bf12050aadd5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -326,7 +326,12 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock);
+struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock);
 void clk_unregister_gate(struct clk *clk);
+void clk_hw_unregister_gate(struct clk_hw *hw);
 
 struct clk_div_table {
 	unsigned int	val;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
