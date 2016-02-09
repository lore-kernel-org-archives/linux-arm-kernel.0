From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  8 Feb 2016 17:45:37 -0800
Subject: [PATCH 10/14] clk: fractional-divider: Add hw based registration APIs
In-Reply-To: <1454982341-22715-1-git-send-email-sboyd@codeaurora.org>
References: <1454982341-22715-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1454982341-22715-11-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add registration APIs in the clk fractional divider code to
return struct clk_hw pointers instead of struct clk pointers.
This way we hide the struct clk pointer from providers unless
they need to use consumer facing APIs.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-fractional-divider.c | 40 +++++++++++++++++++++++++++++++-----
 include/linux/clk-provider.h         |  5 +++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 5c4955e33f7a..e7a315e840e6 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -118,14 +118,15 @@ const struct clk_ops clk_fractional_divider_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_fractional_divider_ops);
 
-struct clk *clk_register_fractional_divider(struct device *dev,
+struct clk_hw *clk_hw_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
 		u8 clk_divider_flags, spinlock_t *lock)
 {
 	struct clk_fractional_divider *fd;
 	struct clk_init_data init;
-	struct clk *clk;
+	struct clk_hw *hw;
+	int ret;
 
 	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
 	if (!fd)
@@ -148,10 +149,39 @@ struct clk *clk_register_fractional_divider(struct device *dev,
 	fd->lock = lock;
 	fd->hw.init = &init;
 
-	clk = clk_register(dev, &fd->hw);
-	if (IS_ERR(clk))
+	hw = &fd->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
 		kfree(fd);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_fractional_divider);
 
-	return clk;
+struct clk *clk_register_fractional_divider(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
+		u8 clk_divider_flags, spinlock_t *lock)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_fractional_divider(dev, name, parent_name, flags,
+			reg, mshift, mwidth, nshift, nwidth, clk_divider_flags,
+			lock);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
 }
 EXPORT_SYMBOL_GPL(clk_register_fractional_divider);
+
+void clk_hw_unregister_fractional_divider(struct clk_hw *hw)
+{
+	struct clk_fractional_divider *fd;
+
+	fd = to_clk_fd(hw);
+
+	clk_hw_unregister(hw);
+	kfree(fd);
+}
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d4d65f60b85e..549ed3844876 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -549,6 +549,11 @@ struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
 		u8 clk_divider_flags, spinlock_t *lock);
+struct clk_hw *clk_hw_register_fractional_divider(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
+		u8 clk_divider_flags, spinlock_t *lock);
+void clk_hw_unregister_fractional_divider(struct clk_hw *hw);
 
 /**
  * struct clk_multiplier - adjustable multiplier clock
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
