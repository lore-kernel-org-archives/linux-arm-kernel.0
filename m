From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:12 +0200
Subject: [RFC 15/17] clk: Use per-controller locking
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-16-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace global prepare lock with a more fine-grained solution - per
clock controller locks.  The global lock is unfortunately still present
and used on some paths but at least the prepare path could be
simplified.

This directly removes the deadlocks mentioned in:
1. commit 10ff4c5239a1 ("i2c: exynos5: Fix possible ABBA deadlock by
   keeping I2C clock prepared"),
2. commit 34e81ad5f0b6 ("i2c: s3c2410: fix ABBA deadlock by keeping
   clock prepared").

The locking got unfortunately much more complicated.  Following locking
design was chosen:
1. For prepare/unprepare paths: lock only clock controller and its
   parents.
2. For recalc rates paths: lock global lock, the controller and its
   children.
3. For reparent paths: lock entire tree up down (children and parents)
   and the global lock as well.

In each case of traversing the clock hierarchy, the locking of
controllers is always from children to parents.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk.c | 156 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 100 insertions(+), 56 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ee1cedfbaa29..37113f7cef64 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -710,11 +710,11 @@ EXPORT_SYMBOL_GPL(__clk_mux_determine_rate_closest);
 
 static void clk_core_unprepare(struct clk_core *core)
 {
-	lockdep_assert_held(&prepare_lock);
-
 	if (!core)
 		return;
 
+	lockdep_assert_held(&core->ctrl->prepare_lock);
+
 	if (WARN_ON(core->prepare_count == 0))
 		return;
 
@@ -737,9 +737,13 @@ static void clk_core_unprepare(struct clk_core *core)
 
 static void clk_core_unprepare_lock(struct clk_core *core)
 {
-	clk_prepare_lock();
+	/*
+	 * TODO: optimize, no need to lock parent controllers
+	 * if prepare_count > 1
+	 */
+	clk_prepare_lock_parents_locked(core);
 	clk_core_unprepare(core);
-	clk_prepare_unlock();
+	clk_prepare_unlock_parents(core);
 }
 
 /**
@@ -766,11 +770,11 @@ static int clk_core_prepare(struct clk_core *core)
 {
 	int ret = 0;
 
-	lockdep_assert_held(&prepare_lock);
-
 	if (!core)
 		return 0;
 
+	lockdep_assert_held(&core->ctrl->prepare_lock);
+
 	if (core->prepare_count == 0) {
 		ret = clk_core_prepare(core->parent);
 		if (ret)
@@ -798,9 +802,13 @@ static int clk_core_prepare_lock(struct clk_core *core)
 {
 	int ret;
 
-	clk_prepare_lock();
+	/*
+	 * TODO: optimize, no need to lock parent controllers
+	 * if prepare_count >= 1 already
+	 */
+	clk_prepare_lock_parents_locked(core);
 	ret = clk_core_prepare(core);
-	clk_prepare_unlock();
+	clk_prepare_unlock_parents(core);
 
 	return ret;
 }
@@ -1055,7 +1063,7 @@ static int clk_disable_unused(void)
 		return 0;
 	}
 
-	clk_prepare_lock();
+	clk_prepare_lock_all();
 
 	hlist_for_each_entry(core, &clk_root_list, child_node)
 		clk_disable_unused_subtree(core);
@@ -1069,7 +1077,7 @@ static int clk_disable_unused(void)
 	hlist_for_each_entry(core, &clk_orphan_list, child_node)
 		clk_unprepare_unused_subtree(core);
 
-	clk_prepare_unlock();
+	clk_prepare_unlock_all();
 
 	return 0;
 }
@@ -1081,11 +1089,11 @@ static int clk_core_round_rate_nolock(struct clk_core *core,
 	struct clk_core *parent;
 	long rate;
 
-	lockdep_assert_held(&prepare_lock);
-
 	if (!core)
 		return 0;
 
+	lockdep_assert_held(&core->ctrl->prepare_lock);
+
 	parent = core->parent;
 	if (parent) {
 		req->best_parent_hw = parent->hw;
@@ -1164,13 +1172,13 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 	if (!clk)
 		return 0;
 
-	clk_prepare_lock();
+	clk_prepare_lock_parents(clk->core);
 
 	clk_core_get_boundaries(clk->core, &req.min_rate, &req.max_rate);
 	req.rate = rate;
 
 	ret = clk_core_round_rate_nolock(clk->core, &req);
-	clk_prepare_unlock();
+	clk_prepare_unlock_parents(clk->core);
 
 	if (ret)
 		return ret;
@@ -1228,7 +1236,7 @@ static void __clk_recalc_accuracies(struct clk_core *core)
 	unsigned long parent_accuracy = 0;
 	struct clk_core *child;
 
-	lockdep_assert_held(&prepare_lock);
+	lockdep_assert_held(&core->ctrl->prepare_lock);
 
 	if (core->parent)
 		parent_accuracy = core->parent->accuracy;
@@ -1247,12 +1255,12 @@ static long clk_core_get_accuracy(struct clk_core *core)
 {
 	unsigned long accuracy;
 
-	clk_prepare_lock();
+	clk_prepare_lock_children(core);
 	if (core && (core->flags & CLK_GET_ACCURACY_NOCACHE))
 		__clk_recalc_accuracies(core);
 
 	accuracy = __clk_get_accuracy(core);
-	clk_prepare_unlock();
+	clk_prepare_unlock_children(core);
 
 	return accuracy;
 }
@@ -1301,7 +1309,7 @@ static void __clk_recalc_rates(struct clk_core *core, unsigned long msg)
 	unsigned long parent_rate = 0;
 	struct clk_core *child;
 
-	lockdep_assert_held(&prepare_lock);
+	lockdep_assert_held(&core->ctrl->prepare_lock);
 
 	old_rate = core->rate;
 
@@ -1325,13 +1333,14 @@ static unsigned long clk_core_get_rate(struct clk_core *core)
 {
 	unsigned long rate;
 
-	clk_prepare_lock();
+	clk_prepare_lock_tree(core);
 
 	if (core && (core->flags & CLK_GET_RATE_NOCACHE))
 		__clk_recalc_rates(core, 0);
 
 	rate = clk_core_get_rate_nolock(core);
-	clk_prepare_unlock();
+
+	clk_prepare_unlock_tree(core);
 
 	return rate;
 }
@@ -1525,7 +1534,7 @@ static int __clk_speculate_rates(struct clk_core *core,
 	unsigned long new_rate;
 	int ret = NOTIFY_DONE;
 
-	lockdep_assert_held(&prepare_lock);
+	lockdep_assert_held(&core->ctrl->prepare_lock);
 
 	new_rate = clk_recalc(core, parent_rate);
 
@@ -1867,11 +1876,11 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 		return 0;
 
 	/* prevent racing with updates to the clock topology */
-	clk_prepare_lock();
+	clk_prepare_lock_tree(clk->core);
 
 	ret = clk_core_set_rate_nolock(clk->core, rate);
 
-	clk_prepare_unlock();
+	clk_prepare_unlock_tree(clk->core);
 
 	return ret;
 }
@@ -1899,7 +1908,7 @@ int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
 		return -EINVAL;
 	}
 
-	clk_prepare_lock();
+	clk_prepare_lock_parents(clk->core);
 
 	if (min != clk->min_rate || max != clk->max_rate) {
 		clk->min_rate = min;
@@ -1907,7 +1916,7 @@ int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
 		ret = clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
 	}
 
-	clk_prepare_unlock();
+	clk_prepare_unlock_parents(clk->core);
 
 	return ret;
 }
@@ -1958,10 +1967,13 @@ struct clk *clk_get_parent(struct clk *clk)
 	if (!clk)
 		return NULL;
 
-	clk_prepare_lock();
-	/* TODO: Create a per-user clk and change callers to call clk_put */
+	clk_prepare_lock_ctrl(clk->core);
+	/*
+	 * TODO: Create a per-user clk and change callers to call clk_put.
+	 * Switch to tree locking then.
+	 */
 	parent = !clk->core->parent ? NULL : clk->core->parent->hw->clk;
-	clk_prepare_unlock();
+	clk_prepare_unlock_ctrl(clk->core);
 
 	return parent;
 }
@@ -1981,8 +1993,11 @@ static void clk_core_reparent(struct clk_core *core,
 				  struct clk_core *new_parent)
 {
 	clk_reparent(core, new_parent);
+
+	clk_prepare_lock_children(core);
 	__clk_recalc_accuracies(core);
 	__clk_recalc_rates(core, POST_RATE_CHANGE);
+	clk_prepare_unlock_children(core);
 }
 
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent)
@@ -2032,26 +2047,31 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
 	int ret = 0;
 	int p_index = 0;
 	unsigned long p_rate = 0;
+	struct clk_core *old_parent;
 
 	if (!core)
 		return 0;
 
 	/* prevent racing with updates to the clock topology */
-	clk_prepare_lock();
+	clk_prepare_lock_tree(core);
 
+	old_parent = core->parent;
 	if (core->parent == parent)
-		goto out;
+		goto unlock_tree;
+
+	if (parent && (parent->ctrl != core->ctrl))
+		clk_ctrl_prepare_lock(parent->ctrl);
 
 	/* verify ops for for multi-parent clks */
 	if ((core->num_parents > 1) && (!core->ops->set_parent)) {
 		ret = -ENOSYS;
-		goto out;
+		goto unlock_new_parent;
 	}
 
 	/* check that we are allowed to re-parent if the clock is in use */
 	if ((core->flags & CLK_SET_PARENT_GATE) && core->prepare_count) {
 		ret = -EBUSY;
-		goto out;
+		goto unlock_new_parent;
 	}
 
 	/* try finding the new parent index */
@@ -2061,7 +2081,7 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
 			pr_debug("%s: clk %s can not be parent of clk %s\n",
 					__func__, parent->name, core->name);
 			ret = p_index;
-			goto out;
+			goto unlock_new_parent;
 		}
 		p_rate = parent->rate;
 	}
@@ -2071,7 +2091,7 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
 
 	/* abort if a driver objects */
 	if (ret & NOTIFY_STOP_MASK)
-		goto out;
+		goto unlock_new_parent;
 
 	/* do the re-parent */
 	ret = __clk_set_parent(core, parent, p_index);
@@ -2084,8 +2104,13 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
 		__clk_recalc_accuracies(core);
 	}
 
-out:
-	clk_prepare_unlock();
+
+unlock_new_parent:
+	if (parent && (parent->ctrl != core->ctrl))
+		clk_ctrl_prepare_unlock(parent->ctrl);
+
+unlock_tree:
+	clk_prepare_unlock_oldtree(core, old_parent);
 
 	return ret;
 }
@@ -2148,7 +2173,7 @@ int clk_set_phase(struct clk *clk, int degrees)
 	if (degrees < 0)
 		degrees += 360;
 
-	clk_prepare_lock();
+	clk_prepare_lock_parents(clk->core);
 
 	/* bail early if nothing to do */
 	if (degrees == clk->core->phase)
@@ -2165,7 +2190,7 @@ int clk_set_phase(struct clk *clk, int degrees)
 		clk->core->phase = degrees;
 
 out:
-	clk_prepare_unlock();
+	clk_prepare_unlock_parents(clk->core);
 
 	return ret;
 }
@@ -2175,9 +2200,9 @@ static int clk_core_get_phase(struct clk_core *core)
 {
 	int ret;
 
-	clk_prepare_lock();
+	clk_prepare_lock_parents(core);
 	ret = core->phase;
-	clk_prepare_unlock();
+	clk_prepare_unlock_parents(core);
 
 	return ret;
 }
@@ -2280,13 +2305,13 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	seq_puts(s, "   clock                         enable_cnt  prepare_cnt        rate   accuracy   phase\n");
 	seq_puts(s, "----------------------------------------------------------------------------------------\n");
 
-	clk_prepare_lock();
+	clk_prepare_lock_all();
 
 	for (; *lists; lists++)
 		hlist_for_each_entry(c, *lists, child_node)
 			clk_summary_show_subtree(s, c, 0);
 
-	clk_prepare_unlock();
+	clk_prepare_unlock_all();
 
 	return 0;
 }
@@ -2343,7 +2368,7 @@ static int clk_dump(struct seq_file *s, void *data)
 
 	seq_printf(s, "{");
 
-	clk_prepare_lock();
+	clk_prepare_lock_all();
 
 	for (; *lists; lists++) {
 		hlist_for_each_entry(c, *lists, child_node) {
@@ -2354,7 +2379,7 @@ static int clk_dump(struct seq_file *s, void *data)
 		}
 	}
 
-	clk_prepare_unlock();
+	clk_prepare_unlock_all();
 
 	seq_puts(s, "}\n");
 	return 0;
@@ -2572,7 +2597,7 @@ static int __clk_core_init(struct clk_core *core)
 	if (!core)
 		return -EINVAL;
 
-	clk_prepare_lock();
+	clk_prepare_lock_ctrl(core);
 
 	/* check to see if a clock with this name is already registered */
 	if (clk_core_lookup(core->name)) {
@@ -2696,10 +2721,12 @@ static int __clk_core_init(struct clk_core *core)
 		 * redundant call to the .set_rate op, if it exists
 		 */
 		if (parent) {
+			clk_prepare_lock_children(orphan);
 			__clk_set_parent_before(orphan, parent);
 			__clk_set_parent_after(orphan, parent, NULL);
 			__clk_recalc_accuracies(orphan);
 			__clk_recalc_rates(orphan, 0);
+			clk_prepare_unlock_children(orphan);
 		}
 	}
 
@@ -2726,7 +2753,7 @@ static int __clk_core_init(struct clk_core *core)
 
 	kref_init(&core->ref);
 out:
-	clk_prepare_unlock();
+	clk_prepare_unlock_ctrl(core);
 
 	if (!ret)
 		clk_debug_register(core);
@@ -2752,18 +2779,19 @@ struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
 	clk->con_id = con_id;
 	clk->max_rate = ULONG_MAX;
 
-	clk_prepare_lock();
+	/* FIXME: Check if core->ctrl is always initialized here (in all paths) */
+	clk_prepare_lock_ctrl(clk->core);
 	hlist_add_head(&clk->clks_node, &hw->core->clks);
-	clk_prepare_unlock();
+	clk_prepare_unlock_ctrl(clk->core);
 
 	return clk;
 }
 
 void __clk_free_clk(struct clk *clk)
 {
-	clk_prepare_lock();
+	clk_prepare_lock_ctrl(clk->core);
 	hlist_del(&clk->clks_node);
-	clk_prepare_unlock();
+	clk_prepare_unlock_ctrl(clk->core);
 
 	kfree(clk);
 }
@@ -2979,12 +3007,18 @@ void clk_unregister(struct clk *clk)
 
 	clk_debug_unregister(clk->core);
 
+	/*
+	 * Take prepare lock again because controller lock
+	 * will have to be released before final clk_release.
+	 */
 	clk_prepare_lock();
+	clk_prepare_lock_parents(clk->core);
 
 	if (clk->core->ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__,
 		       clk->core->name);
-		goto unlock;
+		clk_prepare_unlock_parents(clk->core);
+		goto half_unlock;
 	}
 	/*
 	 * Assign empty clock ops for consumers that might still hold
@@ -3009,8 +3043,10 @@ void clk_unregister(struct clk *clk)
 	if (clk->core->prepare_count)
 		pr_warn("%s: unregistering prepared clock: %s\n",
 					__func__, clk->core->name);
+	clk_prepare_unlock_parents(clk->core);
 	kref_put(&clk->core->ref, __clk_release);
-unlock:
+
+half_unlock:
 	clk_prepare_unlock();
 }
 EXPORT_SYMBOL_GPL(clk_unregister);
@@ -3166,7 +3202,12 @@ void __clk_put(struct clk *clk)
 	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
 		return;
 
+	/*
+	 * Take prepare lock again because controller lock
+	 * will have to be released before final clk_release.
+	 */
 	clk_prepare_lock();
+	clk_prepare_lock_parents(clk->core);
 
 	hlist_del(&clk->clks_node);
 	if (clk->min_rate > clk->core->req_rate ||
@@ -3174,6 +3215,9 @@ void __clk_put(struct clk *clk)
 		clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
 
 	owner = clk->core->owner;
+
+	clk_prepare_unlock_parents(clk->core);
+
 	kref_put(&clk->core->ref, __clk_release);
 
 	clk_prepare_unlock();
@@ -3213,7 +3257,7 @@ int clk_notifier_register(struct clk *clk, struct notifier_block *nb)
 	if (!clk || !nb)
 		return -EINVAL;
 
-	clk_prepare_lock();
+	clk_prepare_lock_ctrl(clk->core);
 
 	/* search the list of notifiers for this clk */
 	list_for_each_entry(cn, &clk_notifier_list, node)
@@ -3237,7 +3281,7 @@ int clk_notifier_register(struct clk *clk, struct notifier_block *nb)
 	clk->core->notifier_count++;
 
 out:
-	clk_prepare_unlock();
+	clk_prepare_unlock_ctrl(clk->core);
 
 	return ret;
 }
@@ -3262,7 +3306,7 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
 	if (!clk || !nb)
 		return -EINVAL;
 
-	clk_prepare_lock();
+	clk_prepare_lock_ctrl(clk->core);
 
 	list_for_each_entry(cn, &clk_notifier_list, node)
 		if (cn->clk == clk)
@@ -3284,7 +3328,7 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
 		ret = -ENOENT;
 	}
 
-	clk_prepare_unlock();
+	clk_prepare_unlock_ctrl(clk->core);
 
 	return ret;
 }
-- 
1.9.1
