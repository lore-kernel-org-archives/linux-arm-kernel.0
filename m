From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 29 Jun 2016 22:59:07 +0800
Subject: [PATCH V2 4/8] clk: core: support clocks which requires parents
 enable (part 2)
In-Reply-To: <1467212351-16626-1-git-send-email-aisheng.dong@nxp.com>
References: <1467212351-16626-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1467212351-16626-5-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Freescale i.MX7D platform, all clocks operations, including
enable/disable, rate change and re-parent, requires its parent clock on.
Current clock core can not support it well.
This patch adding flag CLK_OPS_PARENT_ENABLE to handle this special case in
clock core that enable its parent clock firstly for each operation and
disable it later after operation complete.

The patch part 2 fixes set clock rate and set parent while its parent
is off. The most special case is for set_parent() operation which requires
all parents including both old and new one to be enabled at the same time
during the operation.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e3bd28c9ef28..f1f56158b8c7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1172,7 +1172,7 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *core,
 	struct clk_core *old_parent = core->parent;
 
 	/*
-	 * Migrate prepare state between parents and prevent race with
+	 * 1. Migrate prepare state between parents and prevent race with
 	 * clk_enable().
 	 *
 	 * If the clock is not prepared, then a race with
@@ -1187,13 +1187,20 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *core,
 	 * hardware and software states.
 	 *
 	 * See also: Comment for clk_set_parent() below.
+	 *
+	 * 2. enable parent clocks for CLK_OPS_PARENT_ENABLE clock
 	 */
+
+	/* enable old_parent & parent if CLK_OPS_PARENT_ENABLE is set */
+	if (core->flags & CLK_OPS_PARENT_ENABLE) {
+		clk_core_prepare_enable(old_parent);
+		clk_core_prepare_enable(parent);
+	}
+
+	/* migrate prepare count if > 0 */
 	if (core->prepare_count) {
-		clk_core_prepare(parent);
-		flags = clk_enable_lock();
-		clk_core_enable(parent);
-		clk_core_enable(core);
-		clk_enable_unlock(flags);
+		clk_core_prepare_enable(parent);
+		clk_core_enable_lock(core);
 	}
 
 	/* update the clk tree topology */
@@ -1208,19 +1215,20 @@ static void __clk_set_parent_after(struct clk_core *core,
 				   struct clk_core *parent,
 				   struct clk_core *old_parent)
 {
-	unsigned long flags;
-
 	/*
 	 * Finish the migration of prepare state and undo the changes done
 	 * for preventing a race with clk_enable().
 	 */
-	if (core->prepare_count) {
-		flags = clk_enable_lock();
-		clk_core_disable(core);
-		clk_core_disable(old_parent);
-		clk_enable_unlock(flags);
-		clk_core_unprepare(old_parent);
-	}
+        if (core->prepare_count) {
+                clk_core_disable_lock(core);
+                clk_core_disable_unprepare(old_parent);
+
+        /* re-balance ref counting if CLK_OPS_PARENT_ENABLE is set */
+        if (core->flags & CLK_OPS_PARENT_ENABLE) {
+                clk_core_disable_unprepare(parent);
+                clk_core_disable_unprepare(old_parent);
+        }
+
 }
 
 static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
@@ -1466,13 +1474,17 @@ static void clk_change_rate(struct clk_core *core)
 	unsigned long best_parent_rate = 0;
 	bool skip_set_rate = false;
 	struct clk_core *old_parent;
+	struct clk_core *parent = NULL;
 
 	old_rate = core->rate;
 
-	if (core->new_parent)
+	if (core->new_parent) {
+		parent = core->new_parent;
 		best_parent_rate = core->new_parent->rate;
-	else if (core->parent)
+	} else if (core->parent) {
+		parent = core->parent;
 		best_parent_rate = core->parent->rate;
+	}
 
 	if (core->flags & CLK_SET_RATE_UNGATE) {
 		unsigned long flags;
@@ -1502,6 +1514,9 @@ static void clk_change_rate(struct clk_core *core)
 
 	trace_clk_set_rate(core, core->new_rate);
 
+	if (core->flags & CLK_OPS_PARENT_ON)
+		clk_core_prepare_enable(parent);
+
 	if (!skip_set_rate && core->ops->set_rate)
 		core->ops->set_rate(core->hw, core->new_rate, best_parent_rate);
 
@@ -1518,6 +1533,9 @@ static void clk_change_rate(struct clk_core *core)
 		clk_core_unprepare(core);
 	}
 
+	if (core->flags & CLK_OPS_PARENT_ON)
+		clk_core_disable_unprepare(parent);
+
 	if (core->notifier_count && old_rate != core->rate)
 		__clk_notify(core, POST_RATE_CHANGE, old_rate, core->rate);
 
-- 
1.9.1
