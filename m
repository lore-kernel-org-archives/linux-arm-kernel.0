From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 31 Jul 2015 16:44:43 -0700
Subject: [PATCH 1/3] clk: versatile: Switch to assigned clock parents
In-Reply-To: <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
References: <55BBB2FC.9030102@codeaurora.org>
 <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1438386285-5070-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're removing struct clk from the clk provider API. This code is
calling the consumer APIs to change the parent to a 1 MHz fixed
rate clock for each of the clocks that the driver provides. Move
to using the assigned-clock-parents DT property for this instead.
Because this is an ABI break, detect if the property is missing
and fall back to setting the parent explicitly before the clocks
are registered.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/versatile/clk-sp810.c | 76 ++++++++-------------------------------
 1 file changed, 15 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/versatile/clk-sp810.c b/drivers/clk/versatile/clk-sp810.c
index 7fbe4d4bf35e..a1cdef6b0f90 100644
--- a/drivers/clk/versatile/clk-sp810.c
+++ b/drivers/clk/versatile/clk-sp810.c
@@ -33,12 +33,9 @@ struct clk_sp810_timerclken {
 
 struct clk_sp810 {
 	struct device_node *node;
-	int refclk_index, timclk_index;
 	void __iomem *base;
 	spinlock_t lock;
 	struct clk_sp810_timerclken timerclken[4];
-	struct clk *refclk;
-	struct clk *timclk;
 };
 
 static u8 clk_sp810_timerclken_get_parent(struct clk_hw *hw)
@@ -71,55 +68,7 @@ static int clk_sp810_timerclken_set_parent(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
-/*
- * FIXME - setting the parent every time .prepare is invoked is inefficient.
- * This is better handled by a dedicated clock tree configuration mechanism at
- * init-time.  Revisit this later when such a mechanism exists
- */
-static int clk_sp810_timerclken_prepare(struct clk_hw *hw)
-{
-	struct clk_sp810_timerclken *timerclken = to_clk_sp810_timerclken(hw);
-	struct clk_sp810 *sp810 = timerclken->sp810;
-	struct clk *old_parent = __clk_get_parent(hw->clk);
-	struct clk *new_parent;
-
-	if (!sp810->refclk)
-		sp810->refclk = of_clk_get(sp810->node, sp810->refclk_index);
-
-	if (!sp810->timclk)
-		sp810->timclk = of_clk_get(sp810->node, sp810->timclk_index);
-
-	if (WARN_ON(IS_ERR(sp810->refclk) || IS_ERR(sp810->timclk)))
-		return -ENOENT;
-
-	/* Select fastest parent */
-	if (clk_get_rate(sp810->refclk) > clk_get_rate(sp810->timclk))
-		new_parent = sp810->refclk;
-	else
-		new_parent = sp810->timclk;
-
-	/* Switch the parent if necessary */
-	if (old_parent != new_parent) {
-		clk_prepare(new_parent);
-		clk_set_parent(hw->clk, new_parent);
-		clk_unprepare(old_parent);
-	}
-
-	return 0;
-}
-
-static void clk_sp810_timerclken_unprepare(struct clk_hw *hw)
-{
-	struct clk_sp810_timerclken *timerclken = to_clk_sp810_timerclken(hw);
-	struct clk_sp810 *sp810 = timerclken->sp810;
-
-	clk_put(sp810->timclk);
-	clk_put(sp810->refclk);
-}
-
 static const struct clk_ops clk_sp810_timerclken_ops = {
-	.prepare = clk_sp810_timerclken_prepare,
-	.unprepare = clk_sp810_timerclken_unprepare,
 	.get_parent = clk_sp810_timerclken_get_parent,
 	.set_parent = clk_sp810_timerclken_set_parent,
 };
@@ -140,24 +89,18 @@ static void __init clk_sp810_of_setup(struct device_node *node)
 {
 	struct clk_sp810 *sp810 = kzalloc(sizeof(*sp810), GFP_KERNEL);
 	const char *parent_names[2];
+	int num = ARRAY_SIZE(parent_names);
 	char name[12];
 	struct clk_init_data init;
 	int i;
+	bool deprecated;
 
 	if (!sp810) {
 		pr_err("Failed to allocate memory for SP810!\n");
 		return;
 	}
 
-	sp810->refclk_index = of_property_match_string(node, "clock-names",
-			"refclk");
-	parent_names[0] = of_clk_get_parent_name(node, sp810->refclk_index);
-
-	sp810->timclk_index = of_property_match_string(node, "clock-names",
-			"timclk");
-	parent_names[1] = of_clk_get_parent_name(node, sp810->timclk_index);
-
-	if (!parent_names[0] || !parent_names[1]) {
+	if (of_clk_parent_fill(node, parent_names, num) != num) {
 		pr_warn("Failed to obtain parent clocks for SP810!\n");
 		return;
 	}
@@ -170,7 +113,9 @@ static void __init clk_sp810_of_setup(struct device_node *node)
 	init.ops = &clk_sp810_timerclken_ops;
 	init.flags = CLK_IS_BASIC;
 	init.parent_names = parent_names;
-	init.num_parents = ARRAY_SIZE(parent_names);
+	init.num_parents = num;
+
+	deprecated = !of_find_property(node, "assigned-clock-parents", NULL);
 
 	for (i = 0; i < ARRAY_SIZE(sp810->timerclken); i++) {
 		snprintf(name, ARRAY_SIZE(name), "timerclken%d", i);
@@ -179,6 +124,15 @@ static void __init clk_sp810_of_setup(struct device_node *node)
 		sp810->timerclken[i].channel = i;
 		sp810->timerclken[i].hw.init = &init;
 
+		/*
+		 * If DT isn't setting the parent, force it to be
+		 * the 1 MHz clock without going through the framework.
+		 * We do this before clk_register() so that it can determine
+		 * the parent and setup the tree properly.
+		 */
+		if (deprecated)
+			init.ops->set_parent(&sp810->timerclken[i].hw, 1);
+
 		sp810->timerclken[i].clk = clk_register(NULL,
 				&sp810->timerclken[i].hw);
 		WARN_ON(IS_ERR(sp810->timerclken[i].clk));
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
