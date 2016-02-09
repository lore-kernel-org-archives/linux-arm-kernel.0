From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  8 Feb 2016 17:45:36 -0800
Subject: [PATCH 09/14] clk: fixed-factor: Add hw based registration APIs
In-Reply-To: <1454982341-22715-1-git-send-email-sboyd@codeaurora.org>
References: <1454982341-22715-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1454982341-22715-10-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add registration APIs in the clk fixed-factor code to return
struct clk_hw pointers instead of struct clk pointers. This way
we hide the struct clk pointer from providers unless they need to
use consumer facing APIs.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-fixed-factor.c | 41 ++++++++++++++++++++++++++++++++++-------
 include/linux/clk-provider.h   |  4 ++++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 83de57aeceea..c10b2eb2759f 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -70,13 +70,14 @@ const struct clk_ops clk_fixed_factor_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
 
-struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
-		const char *parent_name, unsigned long flags,
+struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
 	struct clk_fixed_factor *fix;
 	struct clk_init_data init;
-	struct clk *clk;
+	struct clk_hw *hw;
+	int ret;
 
 	fix = kmalloc(sizeof(*fix), GFP_KERNEL);
 	if (!fix)
@@ -93,15 +94,41 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-	clk = clk_register(dev, &fix->hw);
-
-	if (IS_ERR(clk))
+	hw = &fix->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
 		kfree(fix);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor);
+
+struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned int mult, unsigned int div)
+{
+	struct clk_hw *hw;
 
-	return clk;
+	hw = clk_hw_register_fixed_factor(dev, name, parent_name, flags, mult,
+					  div);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
 }
 EXPORT_SYMBOL_GPL(clk_register_fixed_factor);
 
+void clk_hw_unregister_fixed_factor(struct clk_hw *hw)
+{
+	struct clk_fixed_factor *fix;
+
+	fix = to_clk_fixed_factor(hw);
+
+	clk_hw_unregister(hw);
+	kfree(fix);
+}
+
 #ifdef CONFIG_OF
 /**
  * of_fixed_factor_clk_setup() - Setup function for simple fixed factor clock
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index df6353a086b9..d4d65f60b85e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -513,6 +513,10 @@ extern const struct clk_ops clk_fixed_factor_ops;
 struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
+struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		unsigned int mult, unsigned int div);
+void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
 
 /**
  * struct clk_fractional_divider - adjustable fractional divider clock
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
