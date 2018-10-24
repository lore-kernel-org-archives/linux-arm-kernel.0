From: dbasehore@chromium.org (Derek Basehore)
Date: Tue, 23 Oct 2018 18:31:28 -0700
Subject: [PATCH 2/6] clk: fix clk_calc_subtree compute duplications
In-Reply-To: <20181024013132.115907-1-dbasehore@chromium.org>
References: <20181024013132.115907-1-dbasehore@chromium.org>
Message-ID: <20181024013132.115907-3-dbasehore@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_calc_subtree was called at every step up the clk tree in
clk_calc_new_rates. Since it recursively calls itself for its
children, this means it would be called once on each clk for each
step above the top clk is.

This fixes this by breaking the subtree calculation into two parts.
The first part recalcs the rate for each child of the parent clk in
clk_calc_new_rates. This part is not recursive itself. The second part
recursively calls a new clk_calc_subtree on the clk_core that was
passed into clk_set_rate.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/clk.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 95d818f5edb2..61de8ad3e4cf 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1717,11 +1717,19 @@ static int __clk_speculate_rates(struct clk_core *core,
 	return ret;
 }
 
-static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
-			     struct clk_core *new_parent, u8 p_index)
+static void clk_calc_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 
+	hlist_for_each_entry(child, &core->children, child_node) {
+		child->new_rate = clk_recalc(child, core->new_rate);
+		clk_calc_subtree(child);
+	}
+}
+
+static void clk_set_change(struct clk_core *core, unsigned long new_rate,
+			   struct clk_core *new_parent, u8 p_index)
+{
 	core->new_rate = new_rate;
 	core->new_parent = new_parent;
 	core->new_parent_index = p_index;
@@ -1729,11 +1737,6 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
 	core->new_child = NULL;
 	if (new_parent && new_parent != core->parent)
 		new_parent->new_child = core;
-
-	hlist_for_each_entry(child, &core->children, child_node) {
-		child->new_rate = clk_recalc(child, new_rate);
-		clk_calc_subtree(child, child->new_rate, NULL, 0);
-	}
 }
 
 /*
@@ -1744,7 +1747,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 					   unsigned long rate)
 {
 	struct clk_core *top = core;
-	struct clk_core *old_parent, *parent;
+	struct clk_core *old_parent, *parent, *child;
 	unsigned long best_parent_rate = 0;
 	unsigned long new_rate;
 	unsigned long min_rate;
@@ -1791,6 +1794,8 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 		/* pass-through clock with adjustable parent */
 		top = clk_calc_new_rates(parent, rate);
 		new_rate = parent->new_rate;
+		hlist_for_each_entry(child, &parent->children, child_node)
+			child->new_rate = clk_recalc(child, new_rate);
 		goto out;
 	}
 
@@ -1813,11 +1818,14 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 	}
 
 	if ((core->flags & CLK_SET_RATE_PARENT) && parent &&
-	    best_parent_rate != parent->rate)
+	    best_parent_rate != parent->rate) {
 		top = clk_calc_new_rates(parent, best_parent_rate);
+		hlist_for_each_entry(child, &parent->children, child_node)
+			child->new_rate = clk_recalc(child, parent->new_rate);
+	}
 
 out:
-	clk_calc_subtree(core, new_rate, parent, p_index);
+	clk_set_change(core, new_rate, parent, p_index);
 
 	return top;
 }
@@ -2018,6 +2026,8 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	if (ret)
 		return ret;
 
+	clk_calc_subtree(core);
+
 	/* notify that we are about to change rates */
 	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
 	if (fail_clk) {
-- 
2.19.1.568.g152ad8e336-goog
