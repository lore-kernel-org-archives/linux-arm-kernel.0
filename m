From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 24 Jan 2013 17:45:54 +0100
Subject: [PATCH 2/4] clk: Unprepare the unused prepared slow clocks at late
 init
In-Reply-To: <1359045956-30741-1-git-send-email-ulf.hansson@stericsson.com>
References: <1359045956-30741-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1359045956-30741-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The unused ungated fast clocks are already being disabled from
clk_disable_unused at late init. This patch extend this sequence
to the slow unused prepared clocks to be unprepared.

Unless the optional .is_prepared callback is implemented by a
clk_hw the clk_disable_unused sequence will not unprepare any
unused clocks, since it will fall back to use the software
prepare counter.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/clk.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index deb259a..0944348 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -341,6 +341,29 @@ static inline int clk_debug_register(struct clk *clk) { return 0; }
 #endif
 
 /* caller must hold prepare_lock */
+static void clk_unprepare_unused_subtree(struct clk *clk)
+{
+	struct clk *child;
+	struct hlist_node *tmp;
+
+	if (!clk)
+		return;
+
+	hlist_for_each_entry(child, tmp, &clk->children, child_node)
+		clk_unprepare_unused_subtree(child);
+
+	if (clk->prepare_count)
+		return;
+
+	if (clk->flags & CLK_IGNORE_UNUSED)
+		return;
+
+	if (__clk_is_prepared(clk))
+		if (clk->ops->unprepare)
+			clk->ops->unprepare(clk->hw);
+}
+
+/* caller must hold prepare_lock */
 static void clk_disable_unused_subtree(struct clk *clk)
 {
 	struct clk *child;
@@ -393,6 +416,12 @@ static int clk_disable_unused(void)
 	hlist_for_each_entry(clk, tmp, &clk_orphan_list, child_node)
 		clk_disable_unused_subtree(clk);
 
+	hlist_for_each_entry(clk, tmp, &clk_root_list, child_node)
+		clk_unprepare_unused_subtree(clk);
+
+	hlist_for_each_entry(clk, tmp, &clk_orphan_list, child_node)
+		clk_unprepare_unused_subtree(clk);
+
 	mutex_unlock(&prepare_lock);
 
 	return 0;
-- 
1.7.10
