From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 14 May 2015 21:29:01 +0800
Subject: [PATCH v2 3/5] clk: move clk_disable_unused after
 clk_core_disable_unprepare function
In-Reply-To: <1431610143-21853-1-git-send-email-aisheng.dong@freescale.com>
References: <1431610143-21853-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1431610143-21853-4-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No function level change, just moving code place.
clk_disable_unused function will need to call clk_core_prepare_enable/
clk_core_disable_unprepare when adding CLK_OPS_PARENT_ON features.
So move it after clk_core_disable_unprepare to avoid adding forward
declared functions.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/clk/clk.c | 196 +++++++++++++++++++++++++++---------------------------
 1 file changed, 98 insertions(+), 98 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2f44c8c..597d6d2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -162,104 +162,6 @@ static bool clk_core_is_enabled(struct clk_core *core)
 	return core->ops->is_enabled(core->hw);
 }
 
-static void clk_unprepare_unused_subtree(struct clk_core *core)
-{
-	struct clk_core *child;
-
-	lockdep_assert_held(&prepare_lock);
-
-	hlist_for_each_entry(child, &core->children, child_node)
-		clk_unprepare_unused_subtree(child);
-
-	if (core->prepare_count)
-		return;
-
-	if (core->flags & CLK_IGNORE_UNUSED)
-		return;
-
-	if (clk_core_is_prepared(core)) {
-		trace_clk_unprepare(core);
-		if (core->ops->unprepare_unused)
-			core->ops->unprepare_unused(core->hw);
-		else if (core->ops->unprepare)
-			core->ops->unprepare(core->hw);
-		trace_clk_unprepare_complete(core);
-	}
-}
-
-static void clk_disable_unused_subtree(struct clk_core *core)
-{
-	struct clk_core *child;
-	unsigned long flags;
-
-	lockdep_assert_held(&prepare_lock);
-
-	hlist_for_each_entry(child, &core->children, child_node)
-		clk_disable_unused_subtree(child);
-
-	flags = clk_enable_lock();
-
-	if (core->enable_count)
-		goto unlock_out;
-
-	if (core->flags & CLK_IGNORE_UNUSED)
-		goto unlock_out;
-
-	/*
-	 * some gate clocks have special needs during the disable-unused
-	 * sequence.  call .disable_unused if available, otherwise fall
-	 * back to .disable
-	 */
-	if (clk_core_is_enabled(core)) {
-		trace_clk_disable(core);
-		if (core->ops->disable_unused)
-			core->ops->disable_unused(core->hw);
-		else if (core->ops->disable)
-			core->ops->disable(core->hw);
-		trace_clk_disable_complete(core);
-	}
-
-unlock_out:
-	clk_enable_unlock(flags);
-}
-
-static bool clk_ignore_unused;
-static int __init clk_ignore_unused_setup(char *__unused)
-{
-	clk_ignore_unused = true;
-	return 1;
-}
-__setup("clk_ignore_unused", clk_ignore_unused_setup);
-
-static int clk_disable_unused(void)
-{
-	struct clk_core *core;
-
-	if (clk_ignore_unused) {
-		pr_warn("clk: Not disabling unused clocks\n");
-		return 0;
-	}
-
-	clk_prepare_lock();
-
-	hlist_for_each_entry(core, &clk_root_list, child_node)
-		clk_disable_unused_subtree(core);
-
-	hlist_for_each_entry(core, &clk_orphan_list, child_node)
-		clk_disable_unused_subtree(core);
-
-	hlist_for_each_entry(core, &clk_root_list, child_node)
-		clk_unprepare_unused_subtree(core);
-
-	hlist_for_each_entry(core, &clk_orphan_list, child_node)
-		clk_unprepare_unused_subtree(core);
-
-	clk_prepare_unlock();
-
-	return 0;
-}
-late_initcall_sync(clk_disable_unused);
-
 /***    helper functions   ***/
 
 const char *__clk_get_name(struct clk *clk)
@@ -799,6 +701,104 @@ static void clk_core_disable_unprepare(struct clk_core *core)
 	clk_core_unprepare_lock(core);
 }
 
+static void clk_unprepare_unused_subtree(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	lockdep_assert_held(&prepare_lock);
+
+	hlist_for_each_entry(child, &core->children, child_node)
+		clk_unprepare_unused_subtree(child);
+
+	if (core->prepare_count)
+		return;
+
+	if (core->flags & CLK_IGNORE_UNUSED)
+		return;
+
+	if (clk_core_is_prepared(core)) {
+		trace_clk_unprepare(core);
+		if (core->ops->unprepare_unused)
+			core->ops->unprepare_unused(core->hw);
+		else if (core->ops->unprepare)
+			core->ops->unprepare(core->hw);
+		trace_clk_unprepare_complete(core);
+	}
+}
+
+static void clk_disable_unused_subtree(struct clk_core *core)
+{
+	struct clk_core *child;
+	unsigned long flags;
+
+	lockdep_assert_held(&prepare_lock);
+
+	hlist_for_each_entry(child, &core->children, child_node)
+		clk_disable_unused_subtree(child);
+
+	flags = clk_enable_lock();
+
+	if (core->enable_count)
+		goto unlock_out;
+
+	if (core->flags & CLK_IGNORE_UNUSED)
+		goto unlock_out;
+
+	/*
+	 * some gate clocks have special needs during the disable-unused
+	 * sequence.  call .disable_unused if available, otherwise fall
+	 * back to .disable
+	 */
+	if (clk_core_is_enabled(core)) {
+		trace_clk_disable(core);
+		if (core->ops->disable_unused)
+			core->ops->disable_unused(core->hw);
+		else if (core->ops->disable)
+			core->ops->disable(core->hw);
+		trace_clk_disable_complete(core);
+	}
+
+unlock_out:
+	clk_enable_unlock(flags);
+}
+
+static bool clk_ignore_unused;
+static int __init clk_ignore_unused_setup(char *__unused)
+{
+	clk_ignore_unused = true;
+	return 1;
+}
+__setup("clk_ignore_unused", clk_ignore_unused_setup);
+
+static int clk_disable_unused(void)
+{
+	struct clk_core *core;
+
+	if (clk_ignore_unused) {
+		pr_warn("clk: Not disabling unused clocks\n");
+		return 0;
+	}
+
+	clk_prepare_lock();
+
+	hlist_for_each_entry(core, &clk_root_list, child_node)
+		clk_disable_unused_subtree(core);
+
+	hlist_for_each_entry(core, &clk_orphan_list, child_node)
+		clk_disable_unused_subtree(core);
+
+	hlist_for_each_entry(core, &clk_root_list, child_node)
+		clk_unprepare_unused_subtree(core);
+
+	hlist_for_each_entry(core, &clk_orphan_list, child_node)
+		clk_unprepare_unused_subtree(core);
+
+	clk_prepare_unlock();
+
+	return 0;
+}
+late_initcall_sync(clk_disable_unused);
+
 static unsigned long clk_core_round_rate_nolock(struct clk_core *core,
 						unsigned long rate,
 						unsigned long min_rate,
-- 
1.9.1
