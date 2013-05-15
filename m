From: james.hogan@imgtec.com (James Hogan)
Date: Wed, 15 May 2013 14:41:01 +0100
Subject: [PATCH v3 2/4] clk: add support for clock reparent on set_rate
In-Reply-To: <1368625263-23136-1-git-send-email-james.hogan@imgtec.com>
References: <1368625263-23136-1-git-send-email-james.hogan@imgtec.com>
Message-ID: <1368625263-23136-3-git-send-email-james.hogan@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add core support to allow clock implementations to select the best
parent clock when rounding a rate, e.g. the one which can provide the
closest clock rate to that requested. This is by way of adding a new
clock op, determine_rate(), which is like round_rate() but has an extra
parameter to allow the clock implementation to optionally select a
different parent clock. The core then takes care of reparenting the
clock when setting the rate.

The parent change takes place with the help of two new private data
members. struct clk::new_parent specifies a clock's new parent (NULL
indicates no change), and struct clk::new_child specifies a clock's new
child (whose new_parent member points back to it). The purpose of these
are to allow correct walking of the future tree for notifications prior
to actually reparenting any clocks, specifically to skip child clocks
who are being reparented to another clock (they will be notified via the
new parent), and to include any new child clock. These pointers are set
by clk_calc_subtree(), and the new_child pointer gets cleared when a
child is actually reparented to avoid duplicate POST_RATE_CHANGE
notifications.

Each place where round_rate() is called, determine_rate is checked first
and called in preference, passing NULL to the new parent argument if not
needed (e.g. in __clk_round_rate). This restructures a few of the call
sites to simplify the logic into if/else blocks.

A new __clk_set_parent_no_recalc() is created similar to
clk_set_parent() but without calling __clk_recalc_rates(). This is for
clk_change_rate() to use, where rate recalculation and notifications are
already handled.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
Changes in v3:

* rebased on v3.10-rc1
* store new_parent_index in struct clk too (calculated from
  clk_fetch_parent_index, and passed through __clk_set_parent_no_recalc
  to __clk_set_parent).
* allow determine_rate to satisfy recalc_rate check in __clk_init.

 Documentation/clk.txt        |   4 +
 drivers/clk/clk.c            | 208 +++++++++++++++++++++++++++++--------------
 include/linux/clk-private.h  |   3 +
 include/linux/clk-provider.h |   7 ++
 4 files changed, 154 insertions(+), 68 deletions(-)

diff --git a/Documentation/clk.txt b/Documentation/clk.txt
index b9911c2..3110ba4 100644
--- a/Documentation/clk.txt
+++ b/Documentation/clk.txt
@@ -70,6 +70,10 @@ the operations defined in clk.h:
 						unsigned long parent_rate);
 		long		(*round_rate)(struct clk_hw *hw, unsigned long,
 						unsigned long *);
+		long		(*determine_rate)(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long *best_parent_rate,
+						struct clk **best_parent_clk);
 		int		(*set_parent)(struct clk_hw *hw, u8 index);
 		u8		(*get_parent)(struct clk_hw *hw);
 		int		(*set_rate)(struct clk_hw *hw, unsigned long);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9bf4167..a04ca28 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -34,6 +34,9 @@ static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
 
+static int __clk_set_parent_no_recalc(struct clk *clk, struct clk *parent,
+				      u8 p_index);
+
 /***           locking             ***/
 static void clk_prepare_lock(void)
 {
@@ -892,17 +895,20 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
 	if (!clk)
 		return 0;
 
-	if (!clk->ops->round_rate) {
-		if (clk->flags & CLK_SET_RATE_PARENT)
-			return __clk_round_rate(clk->parent, rate);
-		else
-			return clk->rate;
-	}
 
 	if (clk->parent)
 		parent_rate = clk->parent->rate;
 
-	return clk->ops->round_rate(clk->hw, rate, &parent_rate);
+	if (clk->ops->determine_rate)
+		return clk->ops->determine_rate(clk->hw, rate, &parent_rate,
+						NULL);
+	else if (clk->ops->round_rate)
+		return clk->ops->round_rate(clk->hw, rate, &parent_rate);
+	else if (clk->flags & CLK_SET_RATE_PARENT)
+		return __clk_round_rate(clk->parent, rate);
+	else
+		return clk->rate;
+
 }
 
 /**
@@ -1027,6 +1033,32 @@ unsigned long clk_get_rate(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_get_rate);
 
+static u8 clk_fetch_parent_index(struct clk *clk, struct clk *parent)
+{
+	u8 i;
+
+	if (!clk->parents)
+		clk->parents = kzalloc((sizeof(struct clk*) * clk->num_parents),
+								GFP_KERNEL);
+
+	/*
+	 * find index of new parent clock using cached parent ptrs,
+	 * or if not yet cached, use string name comparison and cache
+	 * them now to avoid future calls to __clk_lookup.
+	 */
+	for (i = 0; i < clk->num_parents; i++) {
+		if (clk->parents && clk->parents[i] == parent)
+			break;
+		else if (!strcmp(clk->parent_names[i], parent->name)) {
+			if (clk->parents)
+				clk->parents[i] = __clk_lookup(parent->name);
+			break;
+		}
+	}
+
+	return i;
+}
+
 /**
  * __clk_speculate_rates
  * @clk: first clk in the subtree
@@ -1071,18 +1103,24 @@ out:
 	return ret;
 }
 
-static void clk_calc_subtree(struct clk *clk, unsigned long new_rate)
+static void clk_calc_subtree(struct clk *clk, unsigned long new_rate,
+			     struct clk *new_parent, u8 p_index)
 {
 	struct clk *child;
 
 	clk->new_rate = new_rate;
+	clk->new_parent = new_parent;
+	clk->new_parent_index = p_index;
+	clk->new_child = NULL;
+	if (new_parent && new_parent != clk->parent)
+		new_parent->new_child = clk;
 
 	hlist_for_each_entry(child, &clk->children, child_node) {
 		if (child->ops->recalc_rate)
 			child->new_rate = child->ops->recalc_rate(child->hw, new_rate);
 		else
 			child->new_rate = new_rate;
-		clk_calc_subtree(child, child->new_rate);
+		clk_calc_subtree(child, child->new_rate, NULL, 0);
 	}
 }
 
@@ -1093,50 +1131,63 @@ static void clk_calc_subtree(struct clk *clk, unsigned long new_rate)
 static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
 {
 	struct clk *top = clk;
+	struct clk *old_parent, *parent;
 	unsigned long best_parent_rate = 0;
 	unsigned long new_rate;
+	u8 p_index = 0;
 
 	/* sanity */
 	if (IS_ERR_OR_NULL(clk))
 		return NULL;
 
 	/* save parent rate, if it exists */
-	if (clk->parent)
-		best_parent_rate = clk->parent->rate;
-
-	/* never propagate up to the parent */
-	if (!(clk->flags & CLK_SET_RATE_PARENT)) {
-		if (!clk->ops->round_rate) {
-			clk->new_rate = clk->rate;
-			return NULL;
-		}
-		new_rate = clk->ops->round_rate(clk->hw, rate, &best_parent_rate);
+	parent = old_parent = clk->parent;
+	if (parent)
+		best_parent_rate = parent->rate;
+
+	/* find the closest rate and parent clk/rate */
+	if (clk->ops->determine_rate) {
+		new_rate = clk->ops->determine_rate(clk->hw, rate,
+						    &best_parent_rate,
+						    &parent);
+	} else if (clk->ops->round_rate) {
+		new_rate = clk->ops->round_rate(clk->hw, rate,
+						&best_parent_rate);
+	} else if (!parent || !(clk->flags & CLK_SET_RATE_PARENT)) {
+		/* pass-through clock without adjustable parent */
+		clk->new_rate = clk->rate;
+		return NULL;
+	} else {
+		/* pass-through clock with adjustable parent */
+		top = clk_calc_new_rates(parent, rate);
+		new_rate = parent->new_rate;
 		goto out;
 	}
 
-	/* need clk->parent from here on out */
-	if (!clk->parent) {
-		pr_debug("%s: %s has NULL parent\n", __func__, clk->name);
+	/* some clocks must be gated to change parent */
+	if (parent != old_parent &&
+	    (clk->flags & CLK_SET_PARENT_GATE) && clk->prepare_count) {
+		pr_debug("%s: %s not gated but wants to reparent\n",
+			 __func__, clk->name);
 		return NULL;
 	}
 
-	if (!clk->ops->round_rate) {
-		top = clk_calc_new_rates(clk->parent, rate);
-		new_rate = clk->parent->new_rate;
-
-		goto out;
+	/* try finding the new parent index */
+	if (parent) {
+		p_index = clk_fetch_parent_index(clk, parent);
+		if (p_index == clk->num_parents) {
+			pr_debug("%s: clk %s can not be parent of clk %s\n",
+				 __func__, parent->name, clk->name);
+			return NULL;
+		}
 	}
 
-	new_rate = clk->ops->round_rate(clk->hw, rate, &best_parent_rate);
-
-	if (best_parent_rate != clk->parent->rate) {
-		top = clk_calc_new_rates(clk->parent, best_parent_rate);
-
-		goto out;
-	}
+	if ((clk->flags & CLK_SET_RATE_PARENT) && parent &&
+	    best_parent_rate != parent->rate)
+		top = clk_calc_new_rates(parent, best_parent_rate);
 
 out:
-	clk_calc_subtree(clk, new_rate);
+	clk_calc_subtree(clk, new_rate, parent, p_index);
 
 	return top;
 }
@@ -1148,7 +1199,7 @@ out:
  */
 static struct clk *clk_propagate_rate_change(struct clk *clk, unsigned long event)
 {
-	struct clk *child, *fail_clk = NULL;
+	struct clk *child, *tmp_clk, *fail_clk = NULL;
 	int ret = NOTIFY_DONE;
 
 	if (clk->rate == clk->new_rate)
@@ -1161,9 +1212,19 @@ static struct clk *clk_propagate_rate_change(struct clk *clk, unsigned long even
 	}
 
 	hlist_for_each_entry(child, &clk->children, child_node) {
-		clk = clk_propagate_rate_change(child, event);
-		if (clk)
-			fail_clk = clk;
+		/* Skip children who will be reparented to another clock */
+		if (child->new_parent && child->new_parent != clk)
+			continue;
+		tmp_clk = clk_propagate_rate_change(child, event);
+		if (tmp_clk)
+			fail_clk = tmp_clk;
+	}
+
+	/* handle the new child who might not be in clk->children yet */
+	if (clk->new_child) {
+		tmp_clk = clk_propagate_rate_change(clk->new_child, event);
+		if (tmp_clk)
+			fail_clk = tmp_clk;
 	}
 
 	return fail_clk;
@@ -1181,6 +1242,11 @@ static void clk_change_rate(struct clk *clk)
 
 	old_rate = clk->rate;
 
+	/* set parent */
+	if (clk->new_parent && clk->new_parent != clk->parent)
+		__clk_set_parent_no_recalc(clk, clk->new_parent,
+					   clk->new_parent_index);
+
 	if (clk->parent)
 		best_parent_rate = clk->parent->rate;
 
@@ -1195,8 +1261,15 @@ static void clk_change_rate(struct clk *clk)
 	if (clk->notifier_count && old_rate != clk->rate)
 		__clk_notify(clk, POST_RATE_CHANGE, old_rate, clk->rate);
 
-	hlist_for_each_entry(child, &clk->children, child_node)
+	hlist_for_each_entry(child, &clk->children, child_node) {
+		/* Skip children who will be reparented to another clock */
+		if (child->new_parent && child->new_parent != clk)
+			continue;
 		clk_change_rate(child);
+	}
+
+	if (clk->new_child)
+		clk_change_rate(clk->new_child);
 }
 
 /**
@@ -1336,6 +1409,9 @@ out:
 
 static void clk_reparent(struct clk *clk, struct clk *new_parent)
 {
+	if (new_parent->new_child == clk)
+		new_parent->new_child = NULL;
+
 	hlist_del(&clk->child_node);
 
 	if (new_parent)
@@ -1353,32 +1429,6 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
 	__clk_recalc_rates(clk, POST_RATE_CHANGE);
 }
 
-static u8 clk_fetch_parent_index(struct clk *clk, struct clk *parent)
-{
-	u8 i;
-
-	if (!clk->parents)
-		clk->parents = kzalloc((sizeof(struct clk*) * clk->num_parents),
-								GFP_KERNEL);
-
-	/*
-	 * find index of new parent clock using cached parent ptrs,
-	 * or if not yet cached, use string name comparison and cache
-	 * them now to avoid future calls to __clk_lookup.
-	 */
-	for (i = 0; i < clk->num_parents; i++) {
-		if (clk->parents && clk->parents[i] == parent)
-			break;
-		else if (!strcmp(clk->parent_names[i], parent->name)) {
-			if (clk->parents)
-				clk->parents[i] = __clk_lookup(parent->name);
-			break;
-		}
-	}
-
-	return i;
-}
-
 static int __clk_set_parent(struct clk *clk, struct clk *parent, u8 p_index)
 {
 	unsigned long flags;
@@ -1451,6 +1501,27 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent, u8 p_index)
 	return 0;
 }
 
+static int __clk_set_parent_no_recalc(struct clk *clk, struct clk *parent,
+				      u8 p_index)
+{
+	int ret = 0;
+
+	if (clk->parent == parent)
+		goto out;
+
+	/* only re-parent if the clock is not in use */
+	ret = __clk_set_parent(clk, parent, p_index);
+	if (ret)
+		goto out;
+
+	/* reparent, but don't propagate rate recalculation downstream */
+	clk_reparent(clk, parent);
+	clk_debug_reparent(clk, parent);
+
+out:
+	return ret;
+}
+
 /**
  * clk_set_parent - switch the parent of a mux clk
  * @clk: the mux clk whose input we are switching
@@ -1553,8 +1624,9 @@ int __clk_init(struct device *dev, struct clk *clk)
 
 	/* check that clk_ops are sane.  See Documentation/clk.txt */
 	if (clk->ops->set_rate &&
-			!(clk->ops->round_rate && clk->ops->recalc_rate)) {
-		pr_warning("%s: %s must implement .round_rate & .recalc_rate\n",
+	    !((clk->ops->round_rate || clk->ops->determine_rate) &&
+	      clk->ops->recalc_rate)) {
+		pr_warning("%s: %s must implement .round_rate or .determine_rate in addition to .recalc_rate\n",
 				__func__, clk->name);
 		ret = -EINVAL;
 		goto out;
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index dd7adff..8138c94 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -33,8 +33,11 @@ struct clk {
 	const char		**parent_names;
 	struct clk		**parents;
 	u8			num_parents;
+	u8			new_parent_index;
 	unsigned long		rate;
 	unsigned long		new_rate;
+	struct clk		*new_parent;
+	struct clk		*new_child;
 	unsigned long		flags;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 76b1667..24cb2ee 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -79,6 +79,10 @@ struct clk_hw;
  * @round_rate:	Given a target rate as input, returns the closest rate actually
  * 		supported by the clock.
  *
+ * @determine_rate: Given a target rate as input, returns the closest rate
+ *		actually supported by the clock, and optionally the parent clock
+ *		that should be used to provide the clock rate.
+ *
  * @get_parent:	Queries the hardware to determine the parent of a clock.  The
  * 		return value is a u8 which specifies the index corresponding to
  * 		the parent clock.  This index can be applied to either the
@@ -126,6 +130,9 @@ struct clk_ops {
 					unsigned long parent_rate);
 	long		(*round_rate)(struct clk_hw *hw, unsigned long,
 					unsigned long *);
+	long		(*determine_rate)(struct clk_hw *hw, unsigned long rate,
+					unsigned long *best_parent_rate,
+					struct clk **best_parent_clk);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
 	u8		(*get_parent)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long,
-- 
1.8.1.2
