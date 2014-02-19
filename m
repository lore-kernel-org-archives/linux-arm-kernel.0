From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 18 Feb 2014 21:21:25 -0800
Subject: [PATCH v7 2/8] clk: sunxi: Implement MMC phase control
In-Reply-To: <20140218141532.GH3142@lukather>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100221.15040.47203.stgit@pagira.o2s.ch>
 <20140218141532.GH3142@lukather>
Message-ID: <20140219052125.8345.70717@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2014-02-18 06:15:32)
> Hi,
> 
> On Mon, Feb 17, 2014 at 11:02:21AM +0100, David Lanzend?rfer wrote:
> > From: Emilio L?pez <emilio@elopez.com.ar>
> > 
> > Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> 
> You're missing your Signed-off-by here too.  Remember, for every patch
> you send, your Signed-off-by must be there, regardless wether you're
> the author or not.
> 
> A commit log would be very much welcome too.
> 
> Now, down to the patch itself, I remember Mike saying that he would
> prefer adding a function in the framework instead of hardcoding
> it. Mike, what's your feeling on this? Would merging this seem
> reasonnable to you as is, or do you want to take this to the
> framework?

Hi Maxime & Emilio,

Maybe something like the following RFC? If it seems sufficient for this
case then I will post to the wider list with an eye towards merging it
for 3.15. I've Cc'd Dinh since this came up on the socfpga thread as
well.

Regards,
Mike



>From 56fa297591be5c5e22df6d2ca43fccf285a45636 Mon Sep 17 00:00:00 2001
From: Mike Turquette <mturquette@linaro.org>
Date: Tue, 18 Feb 2014 20:33:50 -0800
Subject: [PATCH] clk: introduce clk_set_phase function & callback

A common operation for a clock signal generator is to shift the phase of
that signal. This patch introduces a new function to the clk.h API to
dynamically adjust the phase of a clock signal. Additionally this patch
introduces support for the new function in the common clock framework
via the .set_phase call back in struct clk_ops.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
This patch is totally untested. It may make your board burst into
flames.

 drivers/clk/clk.c            | 84 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/clk-private.h  |  1 +
 include/linux/clk-provider.h |  5 +++
 include/linux/clk.h          | 29 +++++++++++++++
 4 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ea2ca9f..635170a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -106,11 +106,11 @@ static void clk_summary_show_one(struct seq_file *s, struct clk *c, int level)
 	if (!c)
 		return;
 
-	seq_printf(s, "%*s%-*s %-11d %-12d %-10lu %-11lu",
+	seq_printf(s, "%*s%-*s %-11d %-12d %-10lu %-11lu %-3d",
 		   level * 3 + 1, "",
 		   30 - level * 3, c->name,
 		   c->enable_count, c->prepare_count, clk_get_rate(c),
-		   clk_get_accuracy(c));
+		   clk_get_accuracy(c), clk_get_phase(c));
 	seq_printf(s, "\n");
 }
 
@@ -132,8 +132,8 @@ static int clk_summary_show(struct seq_file *s, void *data)
 {
 	struct clk *c;
 
-	seq_printf(s, "   clock                        enable_cnt  prepare_cnt  rate        accuracy\n");
-	seq_printf(s, "---------------------------------------------------------------------------------\n");
+	seq_printf(s, "   clock                        enable_cnt  prepare_cnt  rate        accuracy   phase\n");
+	seq_printf(s, "-----------------------------------------------------------------------------------------\n");
 
 	clk_prepare_lock();
 
@@ -171,6 +171,7 @@ static void clk_dump_one(struct seq_file *s, struct clk *c, int level)
 	seq_printf(s, "\"prepare_count\": %d,", c->prepare_count);
 	seq_printf(s, "\"rate\": %lu", clk_get_rate(c));
 	seq_printf(s, "\"accuracy\": %lu", clk_get_accuracy(c));
+	seq_printf(s, "\"phase\": %d", clk_get_phase(c));
 }
 
 static void clk_dump_subtree(struct seq_file *s, struct clk *c, int level)
@@ -257,6 +258,11 @@ static int clk_debug_create_one(struct clk *clk, struct dentry *pdentry)
 	if (!d)
 		goto err_out;
 
+	d = debugfs_create_u32("clk_phase", S_IRUGO, clk->dentry,
+			(u32 *)&clk->phase);
+	if (!d)
+		goto err_out;
+
 	d = debugfs_create_x32("clk_flags", S_IRUGO, clk->dentry,
 			(u32 *)&clk->flags);
 	if (!d)
@@ -1766,6 +1772,76 @@ out:
 EXPORT_SYMBOL_GPL(clk_set_parent);
 
 /**
+ * clk_set_phase - adjust the phase shift of a clock signal
+ * @clk: clock signal source
+ * @degrees: number of degrees the signal is shifted
+ *
+ * Shifts the phase of a clock signal by the specified degrees. Returns 0 on
+ * success, -EERROR otherwise.
+ *
+ * This function makes no distiction about the input or reference signal that
+ * we adjust the clock signal phase against. For example phase locked-loop
+ * clock signal generators we may shift phase with respect to feedback clock
+ * signal input, but for other cases the clock phase may be shifted with
+ * respect to some other, unspecified signal.
+ *
+ * Additionally the concept of phase shift does not propagate through the clock
+ * tree hierarchy, which sets it appart from clock rates and clock accuracy. A
+ * parent clock phase attribute does not have an impact on the phase attribute
+ * of a child clock.
+ */
+int clk_set_phase(struct clk *clk, int degrees)
+{
+	int ret = 0;
+
+	if (!clk)
+		goto out;
+
+	/* sanity check degrees */
+	degrees %= 360;
+	if (degrees < 0)
+		degrees += 360;
+
+	clk_prepare_lock();
+
+	if (!clk->ops->set_phase)
+		goto out_unlock;
+
+	ret = clk->ops->set_phase(clk->hw, degrees);
+
+	if (!ret)
+		clk->phase = degrees;
+
+out_unlock:
+	clk_prepare_unlock();
+
+out:
+	return ret;
+}
+
+/**
+ * clk_get_phase - return the phase shift of a clock signal
+ * @clk: clock signal source
+ *
+ * Returns the phase shift of a clock node in degrees, otherwise returns
+ * -EERROR.
+ */
+int clk_get_phase(struct clk *clk)
+{
+	int ret = 0;
+
+	if (!clk)
+		goto out;
+
+	clk_prepare_lock();
+	ret = clk->phase;
+	clk_prepare_unlock();
+
+out:
+	return ret;
+}
+
+/**
  * __clk_init - initialize the data structures in a struct clk
  * @dev:	device initializing this clk, placeholder for now
  * @clk:	clk being initialized
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index efbf70b..845be30 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -46,6 +46,7 @@ struct clk {
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
 	unsigned long		accuracy;
+	int			phase;
 	struct hlist_head	children;
 	struct hlist_node	child_node;
 	unsigned int		notifier_count;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 939533d..cc49fb8 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -127,6 +127,10 @@ struct clk_hw;
  *		separately via calls to .set_parent and .set_rate.
  *		Returns 0 on success, -EERROR otherwise.
  *
+ * @set_phase:	Shift the phase this clock signal in degrees specified
+ *		by the second argument. Valid values for degrees are
+ *		0-359. Return 0 on success, otherwise -EERROR.
+ *
  *
  * The clk_enable/clk_disable and clk_prepare/clk_unprepare pairs allow
  * implementations to split any work between atomic (enable) and sleepable
@@ -164,6 +168,7 @@ struct clk_ops {
 				    unsigned long parent_rate, u8 index);
 	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
 					   unsigned long parent_accuracy);
+	int		(*set_phase)(struct clk_hw *hw, int degrees);
 	void		(*init)(struct clk_hw *hw);
 };
 
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0dd9114..ae2b2f4 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -92,6 +92,25 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
  */
 long clk_get_accuracy(struct clk *clk);
 
+/**
+ * clk_set_phase - adjust the phase shift of a clock signal
+ * @clk: clock signal source
+ * @degrees: number of degrees the signal is shifted
+ *
+ * Shifts the phase of a clock signal by the specified degrees. Returns 0 on
+ * success, -EERROR otherwise.
+ */
+int clk_set_phase(struct clk *clk, int degrees);
+
+/**
+ * clk_get_phase - return the phase shift of a clock signal
+ * @clk: clock signal source
+ *
+ * Returns the phase shift of a clock node in degrees, otherwise returns
+ * -EERROR.
+ */
+int clk_get_phase(struct clk *clk);
+
 #else
 
 static inline long clk_get_accuracy(struct clk *clk)
@@ -99,6 +118,16 @@ static inline long clk_get_accuracy(struct clk *clk)
 	return -ENOTSUPP;
 }
 
+static inline long clk_set_phase(struct clk *clk, int phase)
+{
+	return -ENOTSUPP;
+}
+
+static inline long clk_get_phase(struct clk *clk)
+{
+	return -ENOTSUPP;
+}
+
 #endif
 
 /**
-- 
1.8.3.2
