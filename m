From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 15 Apr 2015 22:26:39 +0800
Subject: [PATCH RFC v1 5/5] clk: introduce clk_core_enable_lock and
 clk_core_disable_lock functions
In-Reply-To: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
References: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1429107999-24413-6-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be usefully when clock core wants to enable/disable clocks.
Then we don't have to convert the struct clk_core to struct clk to call
clk_enable/clk_disable which is a bit un-align with exist using.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/clk/clk.c | 79 +++++++++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 43 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f2470e5..6c481e7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -48,6 +48,8 @@ static int clk_core_prepare(struct clk_core *clk);
 static void clk_core_unprepare(struct clk_core *clk);
 static int clk_core_enable(struct clk_core *clk);
 static void clk_core_disable(struct clk_core *clk);
+static int clk_core_enable_lock(struct clk_core *clk);
+static void clk_core_disable_lock(struct clk_core *clk);
 
 /***    private data structures    ***/
 
@@ -523,9 +525,7 @@ static void clk_disable_unused_subtree(struct clk_core *clk)
 
 	if (clk->flags & CLK_SET_PARENT_ON && parent) {
 		clk_core_prepare(parent->core);
-		flags = clk_enable_lock();
-		clk_core_enable(parent->core);
-		clk_enable_unlock(flags);
+		clk_core_enable_lock(parent->core);
 	}
 
 	flags = clk_enable_lock();
@@ -553,9 +553,7 @@ static void clk_disable_unused_subtree(struct clk_core *clk)
 unlock_out:
 	clk_enable_unlock(flags);
 	if (clk->flags & CLK_SET_PARENT_ON && parent) {
-		flags = clk_enable_lock();
-		clk_core_disable(parent->core);
-		clk_enable_unlock(flags);
+		clk_core_disable_lock(parent->core);
 		clk_core_unprepare(parent->core);
 	}
 }
@@ -1050,6 +1048,15 @@ static void clk_core_disable(struct clk_core *clk)
 	clk_core_disable(clk->parent);
 }
 
+static void clk_core_disable_lock(struct clk_core *clk)
+{
+	unsigned long flags;
+
+	flags = clk_enable_lock();
+	clk_core_disable(clk);
+	clk_enable_unlock(flags);
+}
+
 /**
  * clk_disable - gate a clock
  * @clk: the clk being gated
@@ -1108,6 +1115,18 @@ static int clk_core_enable(struct clk_core *clk)
 	return 0;
 }
 
+static int clk_core_enable_lock(struct clk_core *clk)
+{
+	unsigned long flags;
+	int ret;
+
+	flags = clk_enable_lock();
+	ret = clk_core_enable(clk);
+	clk_enable_unlock(flags);
+
+	return ret;
+}
+
 /**
  * clk_enable - ungate a clock
  * @clk: the clk being ungated
@@ -1489,20 +1508,13 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *clk,
 	 */
 	if (clk->prepare_count || clk->flags & CLK_SET_PARENT_ON) {
 		clk_core_prepare(parent);
-		flags = clk_enable_lock();
-		clk_core_enable(parent);
-		clk_enable_unlock(flags);
+		clk_core_enable_lock(parent);
 
 		if (clk->prepare_count) {
-			flags = clk_enable_lock();
-			clk_core_enable(clk);
-			clk_enable_unlock(flags);
+			clk_core_enable_lock(clk);
 		} else {
-
 			clk_core_prepare(old_parent);
-			flags = clk_enable_lock();
-			clk_core_enable(old_parent);
-			clk_enable_unlock(flags);
+			clk_core_enable_lock(old_parent);
 		}
 	}
 
@@ -1518,26 +1530,18 @@ static void __clk_set_parent_after(struct clk_core *clk,
 				   struct clk_core *parent,
 				   struct clk_core *old_parent)
 {
-	unsigned long flags;
-
 	/*
 	 * Finish the migration of prepare state and undo the changes done
 	 * for preventing a race with clk_enable().
 	 */
 	if (clk->prepare_count || clk->flags & CLK_SET_PARENT_ON) {
-		flags = clk_enable_lock();
-		clk_core_disable(old_parent);
-		clk_enable_unlock(flags);
+		clk_core_disable_lock(old_parent);
 		clk_core_unprepare(old_parent);
 
 		if (clk->prepare_count) {
-			flags = clk_enable_lock();
-			clk_core_disable(clk);
-			clk_enable_unlock(flags);
+			clk_core_disable_lock(clk);
 		} else {
-			flags = clk_enable_lock();
-			clk_core_disable(parent);
-			clk_enable_unlock(flags);
+			clk_core_disable_lock(parent);
 			clk_core_unprepare(parent);
 		}
 	}
@@ -1566,19 +1570,13 @@ static int __clk_set_parent(struct clk_core *clk, struct clk_core *parent,
 		clk_enable_unlock(flags);
 
 		if (clk->prepare_count || clk->flags & CLK_SET_PARENT_ON) {
-			flags = clk_enable_lock();
-			clk_core_disable(parent);
-			clk_enable_unlock(flags);
+			clk_core_disable_lock(parent);
 			clk_core_unprepare(parent);
 
 			if (clk->prepare_count) {
-				flags = clk_enable_lock();
-				clk_core_disable(clk);
-				clk_enable_unlock(flags);
+				clk_core_disable_lock(clk);
 			} else {
-				flags = clk_enable_lock();
-				clk_core_disable(old_parent);
-				clk_enable_unlock(flags);
+				clk_core_disable_lock(old_parent);
 				clk_core_unprepare(old_parent);
 			}
 
@@ -1798,7 +1796,6 @@ static void clk_change_rate(struct clk_core *clk)
 	bool skip_set_rate = false;
 	struct clk_core *old_parent;
 	struct clk_core *parent = NULL;
-	unsigned long flags;
 
 	old_rate = clk->rate;
 
@@ -1831,9 +1828,7 @@ static void clk_change_rate(struct clk_core *clk)
 
 	if (clk->flags & CLK_SET_PARENT_ON && parent) {
 		clk_core_prepare(parent);
-		flags = clk_enable_lock();
-		clk_core_enable(parent);
-		clk_enable_unlock(flags);
+		clk_core_enable_lock(parent);
 	}
 
 	if (!skip_set_rate && clk->ops->set_rate)
@@ -1844,9 +1839,7 @@ static void clk_change_rate(struct clk_core *clk)
 	clk->rate = clk_recalc(clk, best_parent_rate);
 
 	if (clk->flags & CLK_SET_PARENT_ON && parent) {
-		flags = clk_enable_lock();
-		clk_core_disable(parent);
-		clk_enable_unlock(flags);
+		clk_core_disable_lock(parent);
 		clk_core_unprepare(parent);
 	}
 
-- 
1.9.1
