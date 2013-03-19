From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 19 Mar 2013 12:57:52 -0700
Subject: [RESEND PATCH 2/4] clk: Unprepare the unused prepared slow clocks
 at late init
In-Reply-To: <1363116365-3960-3-git-send-email-ulf.hansson@stericsson.com>
References: <1363116365-3960-1-git-send-email-ulf.hansson@stericsson.com>
 <1363116365-3960-3-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20130319195752.8663.43172@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ulf Hansson (2013-03-12 12:26:03)
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> The unused ungated fast clocks are already being disabled from
> clk_disable_unused at late init. This patch extend this sequence
> to the slow unused prepared clocks to be unprepared.
> 
> Unless the optional .is_prepared callback is implemented by a
> clk_hw the clk_disable_unused sequence will not unprepare any
> unused clocks, since it will fall back to use the software
> prepare counter.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Hi Ulf,

I've taken all of these patches into clk-next.  Thanks for the resend.

I had to fix up this patch due to commit b67bfe0d, "hlist: drop the node
parameter from iterators".  The merged version is below.  Let me know if
you have any issues with it.

Regards,
Mike



>From ae3865ca119ad82afbf003b4eee38533f32bd0fe Mon Sep 17 00:00:00 2001
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Mar 2013 20:26:03 +0100
Subject: [PATCH] clk: Unprepare the unused prepared slow clocks at late init

The unused ungated fast clocks are already being disabled from
clk_disable_unused at late init. This patch extend this sequence
to the slow unused prepared clocks to be unprepared.

Unless the optional .is_prepared callback is implemented by a
clk_hw the clk_disable_unused sequence will not unprepare any
unused clocks, since it will fall back to use the software
prepare counter.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
[mturquette at linaro.org: fixed hlist accessors per b67bfe0d]
---
 drivers/clk/clk.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7571b50..c0141f3 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -336,6 +336,28 @@ static inline int clk_debug_register(struct clk *clk) { return 0; }
 #endif
 
 /* caller must hold prepare_lock */
+static void clk_unprepare_unused_subtree(struct clk *clk)
+{
+	struct clk *child;
+
+	if (!clk)
+		return;
+
+	hlist_for_each_entry(child, &clk->children, child_node)
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
@@ -386,6 +408,12 @@ static int clk_disable_unused(void)
 	hlist_for_each_entry(clk, &clk_orphan_list, child_node)
 		clk_disable_unused_subtree(clk);
 
+	hlist_for_each_entry(clk, &clk_root_list, child_node)
+		clk_unprepare_unused_subtree(clk);
+
+	hlist_for_each_entry(clk, &clk_orphan_list, child_node)
+		clk_unprepare_unused_subtree(clk);
+
 	mutex_unlock(&prepare_lock);
 
 	return 0;
-- 
1.7.10.4
