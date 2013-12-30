From: alex.elder@linaro.org (Alex Elder)
Date: Sun, 29 Dec 2013 23:58:50 -0600
Subject: [PATCH] clk: support hardware-specific debugfs entries
Message-ID: <1388383130-8029-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new clk_ops->debug_init method to allow a clock hardware
driver to populate the clock's debugfs directory with entries
beyond those common for every clock.

Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: - Define debug_init unconditionally (suggested by Gerhard Sittig).

 drivers/clk/clk.c            |    4 ++++
 include/linux/clk-provider.h |    8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2cf2ea6..c82a1bc 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -268,6 +268,10 @@ static int clk_debug_create_one(struct clk *clk, struct dentry *pdentry)
 	if (!d)
 		goto err_out;
 
+	if (clk->ops->debug_init)
+		if (clk->ops->debug_init(clk->hw, clk->dentry))
+			goto err_out;
+
 	ret = 0;
 	goto out;
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7e59253..76ba2b2 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -31,6 +31,7 @@
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
 
 struct clk_hw;
+struct dentry;
 
 /**
  * struct clk_ops -  Callback operations for hardware clocks; these are to
@@ -108,6 +109,12 @@ struct clk_hw;
  *		which is likely helpful for most .set_rate implementation.
  *		Returns 0 on success, -EERROR otherwise.
  *
+ * @debug_init:	Set up type-specific debugfs entries for this clock.  This
+ *		is called once, after the debugfs directory entry for this
+ *		clock has been created.  The dentry pointer representing that
+ *		directory is provided as an argument.  Called with
+ *		prepare_lock held.  Returns 0 on success, -EERROR otherwise.
+ *
  * The clk_enable/clk_disable and clk_prepare/clk_unprepare pairs allow
  * implementations to split any work between atomic (enable) and sleepable
  * (prepare) contexts.  If enabling a clock requires code that might sleep,
@@ -140,6 +147,7 @@ struct clk_ops {
 	int		(*set_rate)(struct clk_hw *hw, unsigned long,
 				    unsigned long);
 	void		(*init)(struct clk_hw *hw);
+	int		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
 };
 
 /**
-- 
1.7.9.5
