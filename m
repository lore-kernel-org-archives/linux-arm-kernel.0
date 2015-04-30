From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 30 Apr 2015 08:08:06 +0200
Subject: [RFC] clk: introduce critical clocks
Message-ID: <20150430060806.GY6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks are so critical to the system that they must never be turned
off unless explicitly requested. Normally unused clocks get disabled in
the clk_disable_unused initcall. Currently there are two ways for
keeping clocks enabled even if they are unused, both with their own
drawbacks:

- The CLK_IGNORE_UNUSED flag. Clocks with this flags are not disabled
  during clk_disable_unused. The problem with this is that these clocks
  are skipped during the clk_disable_unused initcall, but can get
  disabled due to normal clk_enable/disable at any time, not necessarily
  even on operations on the critical clocks themselves but on operations
  on their ancestors, siblings or children.

- call clk_prepare_enable right after registration in the clock
  driver. This works properly, but due to the increased enable counter
  the clock will never get disabled, even not when a proper user
  comes along who knows when the clock can safely be disabled.

This patch solves this by introducing two new API calls:

clk_prepare_enable_critical() will call clk_prepare_enable() on a clock
and additionally set a 'critical' flag on the clock. This call is
intended for clock providers which provide a critical clock.

clk_disable_unprepare_critical() is intended for consumers of a critical
clock.  Consumers should first call clk_prepare_enable() on a clock to
get their own prepare/enable reference and call
clk_disable_unprepare_critical() afterwards.  This will clear the
'critical' flag from the clock and decrease the prepare/enable counter.
The ownership of the clock is now transferred to the consumer. Calling
clk_disable_unprepare_critical() on a clock which doesn't have the
'critical' flag set is just a no-op, so consumers can safely call this
on their clocks.

To make this more versatile a clk flag could be introduced which could
be set during registration so that clk providers would not have to make
this API call on each critical clock. I haven't implemented this yet
because it turned out not to be trivial. clk_prepare_enable can only
be called when the clock is not orphaned which may not be the case
during registration time. I can implement this if this way of handling
critical clocks is considered suitable for mainline.


Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/clk.c            | 46 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  2 ++
 include/linux/clk.h          | 10 ++++++++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 459ce9d..d57d4fd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -64,6 +64,7 @@ struct clk_core {
 	unsigned long		flags;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
+	bool			enable_critical;
 	unsigned long		accuracy;
 	int			phase;
 	struct hlist_head	children;
@@ -940,7 +941,13 @@ void clk_unprepare(struct clk *clk)
 		return;
 
 	clk_prepare_lock();
+
+	if (clk->core->enable_critical)
+		goto out;
+
 	clk_core_unprepare(clk->core);
+
+out:
 	clk_prepare_unlock();
 }
 EXPORT_SYMBOL_GPL(clk_unprepare);
@@ -995,7 +1002,9 @@ int clk_prepare(struct clk *clk)
 		return 0;
 
 	clk_prepare_lock();
+
 	ret = clk_core_prepare(clk->core);
+
 	clk_prepare_unlock();
 
 	return ret;
@@ -2250,6 +2259,43 @@ bool clk_is_match(const struct clk *p, const struct clk *q)
 }
 EXPORT_SYMBOL_GPL(clk_is_match);
 
+int clk_prepare_enable_critical(struct clk *clk)
+{
+	if (!clk)
+		return 0;
+
+	clk_prepare_lock();
+	if (clk->core->enable_critical) {
+		clk_prepare_unlock();
+		return -EBUSY;
+	}
+
+	clk->core->enable_critical = true;
+
+	clk_prepare_unlock();
+
+	return clk_prepare_enable(clk);
+
+}
+
+void clk_disable_unprepare_critical(struct clk *clk)
+{
+	if (!clk)
+		return;
+
+	clk_prepare_lock();
+	if (!clk->core->enable_critical) {
+		clk_prepare_unlock();
+		return;
+	}
+
+	clk->core->enable_critical = false;
+
+	clk_prepare_unlock();
+
+	clk_disable_unprepare(clk);
+}
+
 /**
  * __clk_init - initialize the data structures in a struct clk
  * @dev:	device initializing this clk, placeholder for now
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index df69531..8727c12 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -694,5 +694,7 @@ struct dentry *clk_debugfs_add_file(struct clk_hw *hw, char *name, umode_t mode,
 				void *data, const struct file_operations *fops);
 #endif
 
+int clk_prepare_enable_critical(struct clk *clk);
+
 #endif /* CONFIG_COMMON_CLK */
 #endif /* CLK_PROVIDER_H */
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 68c16a6..b259e36 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -138,6 +138,16 @@ int clk_get_phase(struct clk *clk);
  */
 bool clk_is_match(const struct clk *p, const struct clk *q);
 
+/**
+ * clk_disable_unprepare_critical - remove critical flag from clock
+ * @clk: clock source
+ *
+ * This removes the critical flag from a clock and disables it. The
+ * consumer should have enabled the clock by itself now if it wants
+ * to keep the clock enabled.
+ */
+void clk_disable_unprepare_critical(struct clk *clk);
+
 #else
 
 static inline long clk_get_accuracy(struct clk *clk)
-- 
2.1.4

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
