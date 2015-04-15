From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 15 Apr 2015 22:26:38 +0800
Subject: [PATCH RFC v1 4/5] clk: core: add CLK_SET_PARENT_ON flags to support
 clocks require parent on
In-Reply-To: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
References: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1429107999-24413-5-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Freescale i.MX7D platform, all clocks operations, including enable/disable,
rate change and re-parent, requires its parent clock on.
Current clock core can not support it well.
This patch introduce a new flag CLK_SET_PARENT_ON to handle this special case
in clock core that enable its parent clock firstly for each operation and disable
it later after operation complete.

The most special case is for set_parent() operation which requires both parent,
old one and new one, to be enabled at the same time during the operation.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/clk/clk.c            | 99 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/clk-provider.h |  5 +++
 2 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7af553d..f2470e5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -43,6 +43,11 @@ static int clk_core_get_phase(struct clk_core *clk);
 static bool clk_core_is_prepared(struct clk_core *clk);
 static bool clk_core_is_enabled(struct clk_core *clk);
 static struct clk_core *clk_core_lookup(const char *name);
+static struct clk *clk_core_get_parent(struct clk_core *clk);
+static int clk_core_prepare(struct clk_core *clk);
+static void clk_core_unprepare(struct clk_core *clk);
+static int clk_core_enable(struct clk_core *clk);
+static void clk_core_disable(struct clk_core *clk);
 
 /***    private data structures    ***/
 
@@ -508,6 +513,7 @@ static void clk_unprepare_unused_subtree(struct clk_core *clk)
 static void clk_disable_unused_subtree(struct clk_core *clk)
 {
 	struct clk_core *child;
+	struct clk *parent = clk_core_get_parent(clk);
 	unsigned long flags;
 
 	lockdep_assert_held(&prepare_lock);
@@ -515,6 +521,13 @@ static void clk_disable_unused_subtree(struct clk_core *clk)
 	hlist_for_each_entry(child, &clk->children, child_node)
 		clk_disable_unused_subtree(child);
 
+	if (clk->flags & CLK_SET_PARENT_ON && parent) {
+		clk_core_prepare(parent->core);
+		flags = clk_enable_lock();
+		clk_core_enable(parent->core);
+		clk_enable_unlock(flags);
+	}
+
 	flags = clk_enable_lock();
 
 	if (clk->enable_count)
@@ -539,6 +552,12 @@ static void clk_disable_unused_subtree(struct clk_core *clk)
 
 unlock_out:
 	clk_enable_unlock(flags);
+	if (clk->flags & CLK_SET_PARENT_ON && parent) {
+		flags = clk_enable_lock();
+		clk_core_disable(parent->core);
+		clk_enable_unlock(flags);
+		clk_core_unprepare(parent->core);
+	}
 }
 
 static bool clk_ignore_unused;
@@ -608,6 +627,14 @@ struct clk *__clk_get_parent(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(__clk_get_parent);
 
+static struct clk *clk_core_get_parent(struct clk_core *clk)
+{
+	if (!clk)
+		return NULL;
+
+	return !clk->parent ? NULL : clk->parent->hw->clk;
+}
+
 static struct clk_core *clk_core_get_parent_by_index(struct clk_core *clk,
 							 u8 index)
 {
@@ -1441,7 +1468,7 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *clk,
 	struct clk_core *old_parent = clk->parent;
 
 	/*
-	 * Migrate prepare state between parents and prevent race with
+	 * 1. Migrate prepare state between parents and prevent race with
 	 * clk_enable().
 	 *
 	 * If the clock is not prepared, then a race with
@@ -1456,13 +1483,27 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *clk,
 	 * hardware and software states.
 	 *
 	 * See also: Comment for clk_set_parent() below.
+	 *
+	 * 2. enable two parents clock for .set_parent() operation if finding
+	 * flag CLK_SET_PARENT_ON
 	 */
-	if (clk->prepare_count) {
+	if (clk->prepare_count || clk->flags & CLK_SET_PARENT_ON) {
 		clk_core_prepare(parent);
 		flags = clk_enable_lock();
 		clk_core_enable(parent);
-		clk_core_enable(clk);
 		clk_enable_unlock(flags);
+
+		if (clk->prepare_count) {
+			flags = clk_enable_lock();
+			clk_core_enable(clk);
+			clk_enable_unlock(flags);
+		} else {
+
+			clk_core_prepare(old_parent);
+			flags = clk_enable_lock();
+			clk_core_enable(old_parent);
+			clk_enable_unlock(flags);
+		}
 	}
 
 	/* update the clk tree topology */
@@ -1483,12 +1524,22 @@ static void __clk_set_parent_after(struct clk_core *clk,
 	 * Finish the migration of prepare state and undo the changes done
 	 * for preventing a race with clk_enable().
 	 */
-	if (clk->prepare_count) {
+	if (clk->prepare_count || clk->flags & CLK_SET_PARENT_ON) {
 		flags = clk_enable_lock();
-		clk_core_disable(clk);
 		clk_core_disable(old_parent);
 		clk_enable_unlock(flags);
 		clk_core_unprepare(old_parent);
+
+		if (clk->prepare_count) {
+			flags = clk_enable_lock();
+			clk_core_disable(clk);
+			clk_enable_unlock(flags);
+		} else {
+			flags = clk_enable_lock();
+			clk_core_disable(parent);
+			clk_enable_unlock(flags);
+			clk_core_unprepare(parent);
+		}
 	}
 }
 
@@ -1514,12 +1565,23 @@ static int __clk_set_parent(struct clk_core *clk, struct clk_core *parent,
 		clk_reparent(clk, old_parent);
 		clk_enable_unlock(flags);
 
-		if (clk->prepare_count) {
+		if (clk->prepare_count || clk->flags & CLK_SET_PARENT_ON) {
 			flags = clk_enable_lock();
-			clk_core_disable(clk);
 			clk_core_disable(parent);
 			clk_enable_unlock(flags);
 			clk_core_unprepare(parent);
+
+			if (clk->prepare_count) {
+				flags = clk_enable_lock();
+				clk_core_disable(clk);
+				clk_enable_unlock(flags);
+			} else {
+				flags = clk_enable_lock();
+				clk_core_disable(old_parent);
+				clk_enable_unlock(flags);
+				clk_core_unprepare(old_parent);
+			}
+
 		}
 		return ret;
 	}
@@ -1735,13 +1797,18 @@ static void clk_change_rate(struct clk_core *clk)
 	unsigned long best_parent_rate = 0;
 	bool skip_set_rate = false;
 	struct clk_core *old_parent;
+	struct clk_core *parent = NULL;
+	unsigned long flags;
 
 	old_rate = clk->rate;
 
-	if (clk->new_parent)
+	if (clk->new_parent) {
+		parent = clk->new_parent;
 		best_parent_rate = clk->new_parent->rate;
-	else if (clk->parent)
+	} else if (clk->parent) {
+		parent = clk->parent;
 		best_parent_rate = clk->parent->rate;
+	}
 
 	if (clk->new_parent && clk->new_parent != clk->parent) {
 		old_parent = __clk_set_parent_before(clk, clk->new_parent);
@@ -1762,6 +1829,13 @@ static void clk_change_rate(struct clk_core *clk)
 
 	trace_clk_set_rate(clk, clk->new_rate);
 
+	if (clk->flags & CLK_SET_PARENT_ON && parent) {
+		clk_core_prepare(parent);
+		flags = clk_enable_lock();
+		clk_core_enable(parent);
+		clk_enable_unlock(flags);
+	}
+
 	if (!skip_set_rate && clk->ops->set_rate)
 		clk->ops->set_rate(clk->hw, clk->new_rate, best_parent_rate);
 
@@ -1769,6 +1843,13 @@ static void clk_change_rate(struct clk_core *clk)
 
 	clk->rate = clk_recalc(clk, best_parent_rate);
 
+	if (clk->flags & CLK_SET_PARENT_ON && parent) {
+		flags = clk_enable_lock();
+		clk_core_disable(parent);
+		clk_enable_unlock(flags);
+		clk_core_unprepare(parent);
+	}
+
 	if (clk->notifier_count && old_rate != clk->rate)
 		__clk_notify(clk, POST_RATE_CHANGE, old_rate, clk->rate);
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index df69531..242b966 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -31,6 +31,11 @@
 #define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
 #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
+/*
+ * parent clock must be on across any operation including
+ * clock gate/ungate, rate change and re-parent
+ */
+#define CLK_SET_PARENT_ON	BIT(9)
 
 struct clk_hw;
 struct clk_core;
-- 
1.9.1
