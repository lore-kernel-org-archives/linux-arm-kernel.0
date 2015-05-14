From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 14 May 2015 21:29:03 +0800
Subject: [PATCH v2 5/5] clk: core: add CLK_OPS_PARENT_ON flags to support
 clocks require parent on
In-Reply-To: <1431610143-21853-1-git-send-email-aisheng.dong@freescale.com>
References: <1431610143-21853-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1431610143-21853-6-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Freescale i.MX7D platform, all clocks operations, including
enable/disable, rate change and re-parent, requires its parent clock on.
Current clock core can not support it well.
This patch adding flag CLK_OPS_PARENT_ON to handle this special case in
clock core that enable its parent clock firstly for each operation and
disable it later after operation complete.

This patch fixes changing clock rate and switch parent while its parent
is off. The most special case is for set_parent() operation which requires
both parent, including old one and new one, to be enabled at the same time
during the operation.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/clk/clk.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 44a2f55..348f371 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1133,7 +1133,7 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *core,
 	struct clk_core *old_parent = core->parent;
 
 	/*
-	 * Migrate prepare state between parents and prevent race with
+	 * 1. Migrate prepare state between parents and prevent race with
 	 * clk_enable().
 	 *
 	 * If the clock is not prepared, then a race with
@@ -1148,13 +1148,17 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *core,
 	 * hardware and software states.
 	 *
 	 * See also: Comment for clk_set_parent() below.
+	 *
+	 * 2. enable two parents clock for .set_parent() operation if finding
+	 * flag CLK_OPS_PARENT_ON
 	 */
-	if (core->prepare_count) {
-		clk_core_prepare(parent);
-		flags = clk_enable_lock();
-		clk_core_enable(parent);
-		clk_core_enable(core);
-		clk_enable_unlock(flags);
+	if (core->prepare_count || core->flags & CLK_OPS_PARENT_ON) {
+		clk_core_prepare_enable(parent);
+		if (core->prepare_count)
+			clk_core_enable_lock(core);
+		else
+			clk_core_prepare_enable(old_parent);
+
 	}
 
 	/* update the clk tree topology */
@@ -1169,18 +1173,16 @@ static void __clk_set_parent_after(struct clk_core *core,
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
+	if (core->prepare_count || core->flags & CLK_OPS_PARENT_ON) {
+		clk_core_disable_unprepare(old_parent);
+		if (core->prepare_count)
+			clk_core_disable_lock(core);
+		else
+			clk_core_disable_unprepare(parent);
 	}
 }
 
@@ -1419,13 +1421,17 @@ static void clk_change_rate(struct clk_core *core)
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
 
 	if (core->new_parent && core->new_parent != core->parent) {
 		old_parent = __clk_set_parent_before(core, core->new_parent);
@@ -1446,6 +1452,9 @@ static void clk_change_rate(struct clk_core *core)
 
 	trace_clk_set_rate(core, core->new_rate);
 
+	if (core->flags & CLK_OPS_PARENT_ON)
+		clk_core_prepare_enable(parent);
+
 	if (!skip_set_rate && core->ops->set_rate)
 		core->ops->set_rate(core->hw, core->new_rate, best_parent_rate);
 
@@ -1453,6 +1462,9 @@ static void clk_change_rate(struct clk_core *core)
 
 	core->rate = clk_recalc(core, best_parent_rate);
 
+	if (core->flags & CLK_OPS_PARENT_ON)
+		clk_core_disable_unprepare(parent);
+
 	if (core->notifier_count && old_rate != core->rate)
 		__clk_notify(core, POST_RATE_CHANGE, old_rate, core->rate);
 
-- 
1.9.1
