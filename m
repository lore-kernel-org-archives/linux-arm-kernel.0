From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Apr 2016 15:22:03 -0700
Subject: [PATCH v2 12/13] clk: fixed-rate: Add hw based registration APIs
In-Reply-To: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
References: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1461277324-27185-13-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add registration APIs in the clk fixed-rate code to return struct
clk_hw pointers instead of struct clk pointers. This way we hide
the struct clk pointer from providers unless they need to use
consumer facing APIs.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-fixed-rate.c | 44 ++++++++++++++++++++++++++++++++++++--------
 include/linux/clk-provider.h |  7 +++++++
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index cd9dc925b3f8..8e4453eb54e8 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -45,8 +45,8 @@ const struct clk_ops clk_fixed_rate_ops = {
 EXPORT_SYMBOL_GPL(clk_fixed_rate_ops);
 
 /**
- * clk_register_fixed_rate_with_accuracy - register fixed-rate clock with the
- *					   clock framework
+ * clk_hw_register_fixed_rate_with_accuracy - register fixed-rate clock with
+ * the clock framework
  * @dev: device that is registering this clock
  * @name: name of this clock
  * @parent_name: name of clock's parent
@@ -54,13 +54,14 @@ EXPORT_SYMBOL_GPL(clk_fixed_rate_ops);
  * @fixed_rate: non-adjustable clock rate
  * @fixed_accuracy: non-adjustable clock rate
  */
-struct clk *clk_register_fixed_rate_with_accuracy(struct device *dev,
+struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate, unsigned long fixed_accuracy)
 {
 	struct clk_fixed_rate *fixed;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	/* allocate fixed-rate clock */
 	fixed = kzalloc(sizeof(*fixed), GFP_KERNEL);
@@ -79,22 +80,49 @@ struct clk *clk_register_fixed_rate_with_accuracy(struct device *dev,
 	fixed->hw.init = &init;
 
 	/* register the clock */
-	clk = clk_register(dev, &fixed->hw);
-	if (IS_ERR(clk))
+	hw = &fixed->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
 		kfree(fixed);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_fixed_rate_with_accuracy);
+
+struct clk *clk_register_fixed_rate_with_accuracy(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		unsigned long fixed_rate, unsigned long fixed_accuracy)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_fixed_rate_with_accuracy(dev, name, parent_name,
+			flags, fixed_rate, fixed_accuracy);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
 }
 EXPORT_SYMBOL_GPL(clk_register_fixed_rate_with_accuracy);
 
 /**
- * clk_register_fixed_rate - register fixed-rate clock with the clock framework
+ * clk_hw_register_fixed_rate - register fixed-rate clock with the clock
+ * framework
  * @dev: device that is registering this clock
  * @name: name of this clock
  * @parent_name: name of clock's parent
  * @flags: framework-specific flags
  * @fixed_rate: non-adjustable clock rate
  */
+struct clk_hw *clk_hw_register_fixed_rate(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned long fixed_rate)
+{
+	return clk_hw_register_fixed_rate_with_accuracy(dev, name, parent_name,
+						     flags, fixed_rate, 0);
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_fixed_rate);
+
 struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 6c36c5e8ccbe..c3fc042d517c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -282,10 +282,17 @@ extern const struct clk_ops clk_fixed_rate_ops;
 struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate);
+struct clk_hw *clk_hw_register_fixed_rate(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned long fixed_rate);
 struct clk *clk_register_fixed_rate_with_accuracy(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate, unsigned long fixed_accuracy);
 void clk_unregister_fixed_rate(struct clk *clk);
+struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		unsigned long fixed_rate, unsigned long fixed_accuracy);
+
 void of_fixed_clk_setup(struct device_node *np);
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
