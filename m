From: dbasehore@chromium.org (Derek Basehore)
Date: Tue, 23 Oct 2018 18:31:30 -0700
Subject: [PATCH 4/6] clk: add pre clk changes support
In-Reply-To: <20181024013132.115907-1-dbasehore@chromium.org>
References: <20181024013132.115907-1-dbasehore@chromium.org>
Message-ID: <20181024013132.115907-5-dbasehore@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new clk_op, pre_rate_req. It allows clks to setup an
intermediate state when clk rates are changed. One use case for this
is when a clk needs to switch to a safe parent when its PLL ancestor
changes rates. This is needed when a PLL cannot guarantee that it will
not exceed the new rate before it locks. The set_rate, set_parent, and
set_rate_and_parent callbacks are used with the pre_rate_req callback.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/clk.c            | 136 +++++++++++++++++++++++++++++++++--
 include/linux/clk-provider.h |  10 +++
 2 files changed, 139 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1db44b4e46b0..36a2f929ab8d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -39,6 +39,7 @@ static int enable_refcnt;
 static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
+static LIST_HEAD(pre_change_free_list);
 
 /***    private data structures    ***/
 
@@ -1896,6 +1897,74 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
 	return fail_clk;
 }
 
+static int clk_pre_rate_req(struct list_head *pre_list, struct clk_core *core)
+{
+	struct clk_core *child, *parent = core->parent;
+	struct clk_rate_request next, pre;
+	struct clk_change *change;
+	int ret;
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		ret = clk_pre_rate_req(pre_list, child);
+		if (ret)
+			return ret;
+	}
+
+	if (core->new_child) {
+		ret = clk_pre_rate_req(pre_list, child);
+		if (ret)
+			return ret;
+	}
+
+	if (!core->ops->pre_rate_req)
+		return 0;
+
+	if (core->change.parent)
+		parent = core->change.parent;
+
+	if (parent) {
+		next.best_parent_hw = parent->hw;
+		next.best_parent_rate = parent->change.rate;
+	}
+
+	next.rate = core->change.rate;
+	clk_core_get_boundaries(core, &next.min_rate, &next.max_rate);
+
+	ret = core->ops->pre_rate_req(core->hw, &next, &pre);
+	if (ret < 0)
+		return ret;
+	else if (!ret)
+		goto out;
+
+	/*
+	 * We allocate a change for each clk with the pre_rate_req op. If we run
+	 * out, that's because we wrapped around to a clk again in the
+	 * pre_rate_req step which is not allowed.
+	 */
+	change = list_first_entry(&pre_change_free_list, struct clk_change,
+				  change_list);
+	if (IS_ERR_OR_NULL(change)) {
+		pr_err("%s: pre_rate_req loop detected on clk %s. All pre_rate_req clk_change structs are used\n",
+				__func__, core->name);
+		return -EDEADLK;
+	}
+
+	change->core = core;
+	change->rate = pre.rate;
+	change->parent = pre.best_parent_hw ? pre.best_parent_hw->core : NULL;
+	list_move(&change->change_list, pre_list);
+
+out:
+	/* If the pre req req pulls in a new parent, add it to the call chain */
+	if (parent != change->parent) {
+		ret = clk_pre_rate_req(pre_list, change->parent);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * walk down a subtree and set the new rates notifying the rate
  * change on the way
@@ -2065,6 +2134,8 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	struct clk_core *top, *fail_clk;
 	struct clk_change *change, *tmp;
 	unsigned long rate;
+	LIST_HEAD(pre_changes);
+	LIST_HEAD(post_changes);
 	LIST_HEAD(changes);
 	int ret = 0;
 
@@ -2092,6 +2163,14 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 
 	clk_calc_subtree(core);
 
+	/* We need a separate list for these changes due to error handling. */
+	ret = clk_pre_rate_req(&pre_changes, top);
+	if (ret) {
+		pr_debug("%s: failed pre_rate_req via top clk %s: %d\n",
+				__func__, top->name, ret);
+		goto pre_rate_req;
+	}
+
 	/* Construct the list of changes */
 	clk_prepare_changes(&changes, top);
 
@@ -2100,11 +2179,19 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	if (fail_clk) {
 		pr_debug("%s: failed to set %s rate\n", __func__,
 				fail_clk->name);
-		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
 		ret = -EBUSY;
-		goto err;
+		goto prop_rate;
+	}
+
+	ret = clk_change_rates(&pre_changes);
+	if (ret) {
+		pr_debug("%s: rate rate changes failed via top clk %s: %d\n",
+				__func__, top->name, ret);
+		goto pre_rate_req;
 	}
 
+	list_splice_tail(&post_changes, &changes);
+
 	/* change the rates */
 	ret = clk_change_rates(&changes);
 	list_for_each_entry_safe(change, tmp, &changes, change_list) {
@@ -2112,16 +2199,28 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 		change->parent = NULL;
 		list_del_init(&change->change_list);
 	}
-
 	if (ret) {
 		pr_debug("%s: failed to set %s rate via top clk %s\n", __func__,
 				core->name, top->name);
-		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
-		goto err;
+		goto change_rates;
 	}
 
+	list_splice(&pre_changes, &pre_change_free_list);
 	core->req_rate = req_rate;
-err:
+
+	return 0;
+
+change_rates:
+	WARN_ON(clk_change_rates(&pre_changes));
+pre_rate_req:
+	list_splice(&pre_changes, &pre_change_free_list);
+prop_rate:
+	clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
+	list_for_each_entry_safe(change, tmp, &changes, change_list) {
+		change->rate = 0;
+		change->parent = NULL;
+		list_del_init(&change->change_list);
+	}
 	clk_pm_runtime_put(core);
 
 	return ret;
@@ -3139,7 +3238,9 @@ static int __clk_core_init(struct clk_core *core)
 
 	/* check that clk_ops are sane.  See Documentation/driver-api/clk.rst */
 	if (core->ops->set_rate &&
-	    !((core->ops->round_rate || core->ops->determine_rate) &&
+	    !((core->ops->round_rate ||
+	       core->ops->determine_rate ||
+	       core->ops->pre_rate_req) &&
 	      core->ops->recalc_rate)) {
 		pr_err("%s: %s must implement .round_rate or .determine_rate in addition to .recalc_rate\n",
 		       __func__, core->name);
@@ -3175,6 +3276,20 @@ static int __clk_core_init(struct clk_core *core)
 				"%s: invalid NULL in %s's .parent_names\n",
 				__func__, core->name);
 
+	/* Allocate a clk_change struct for pre_rate_reqs */
+	if (core->ops->pre_rate_req) {
+		struct clk_change *change = kzalloc(sizeof(*change),
+				GFP_KERNEL);
+		if (!change) {
+			ret = -ENOMEM;
+			kfree(core->parents);
+			goto out;
+		}
+
+		INIT_LIST_HEAD(&change->change_list);
+		list_add(&pre_change_free_list, &change->change_list);
+	}
+
 	core->parent = __clk_init_parent(core);
 
 	/*
@@ -3476,6 +3591,13 @@ static void __clk_release(struct kref *ref)
 	while (--i >= 0)
 		kfree_const(core->parent_names[i]);
 
+	if (core->ops->pre_rate_req) {
+		struct clk_change *change =
+			list_first_entry(&pre_change_free_list,
+					struct clk_change, change_list);
+		list_del(&change->change_list);
+		kfree(change);
+	}
 	kfree(core->parent_names);
 	kfree_const(core->name);
 	kfree(core);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 60c51871b04b..98a65c6c326d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -138,6 +138,13 @@ struct clk_duty {
  *		actually supported by the clock, and optionally the parent clock
  *		that should be used to provide the clock rate.
  *
+ * @pre_rate_req: Given the next state that the clk will enter via a
+ *		clk_rate_request struct, next, fill in another clk_rate_request
+ *		struct, pre, with any desired intermediate state to change to
+ *		before the state in next is applied. Returns positive to request
+ *		an intermediate state transition, 0 for no transition, and
+ *		-EERROR otherwise.
+ *
  * @set_parent:	Change the input source of this clock; for clocks with multiple
  *		possible parents specify a new parent by passing in the index
  *		as a u8 corresponding to the parent in either the .parent_names
@@ -236,6 +243,9 @@ struct clk_ops {
 					unsigned long *parent_rate);
 	int		(*determine_rate)(struct clk_hw *hw,
 					  struct clk_rate_request *req);
+	int		(*pre_rate_req)(struct clk_hw *hw,
+					const struct clk_rate_request *next,
+					struct clk_rate_request *pre);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
 	u8		(*get_parent)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
-- 
2.19.1.568.g152ad8e336-goog
