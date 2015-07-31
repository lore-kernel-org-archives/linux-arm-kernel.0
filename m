From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 11:39:59 +0200
Subject: [PATCH 23/23] clk: at91: Revert "keep slow clk enabled to prevent
 system hang"
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438335599-3301-24-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
hang") added a workaround for the slow clock as it is not properly handled
by its users.

Now that the slow clock is taken properly by the drivers, this workaround
is not necessary anymore, revert it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
 drivers/clk/at91/clk-slow.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index 98a84a865fe1..2c59d6a64dd5 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -70,7 +70,6 @@ struct clk_sam9x5_slow {
 
 #define to_clk_sam9x5_slow(hw) container_of(hw, struct clk_sam9x5_slow, hw)
 
-static struct clk *slow_clk;
 
 static int clk_slow_osc_prepare(struct clk_hw *hw)
 {
@@ -358,8 +357,6 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 	clk = clk_register(NULL, &slowck->hw);
 	if (IS_ERR(clk))
 		kfree(slowck);
-	else
-		slow_clk = clk;
 
 	return clk;
 }
@@ -436,8 +433,6 @@ at91_clk_register_sam9260_slow(struct at91_pmc *pmc,
 	clk = clk_register(NULL, &slowck->hw);
 	if (IS_ERR(clk))
 		kfree(slowck);
-	else
-		slow_clk = clk;
 
 	return clk;
 }
@@ -470,25 +465,3 @@ void __init of_at91sam9260_clk_slow_setup(struct device_node *np,
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
-
-/*
- * FIXME: All slow clk users are not properly claiming it (get + prepare +
- * enable) before using it.
- * If all users properly claiming this clock decide that they don't need it
- * anymore (or are removed), it is disabled while faulty users are still
- * requiring it, and the system hangs.
- * Prevent this clock from being disabled until all users are properly
- * requesting it.
- * Once this is done we should remove this function and the slow_clk variable.
- */
-static int __init of_at91_clk_slow_retain(void)
-{
-	if (!slow_clk)
-		return 0;
-
-	__clk_get(slow_clk);
-	clk_prepare_enable(slow_clk);
-
-	return 0;
-}
-arch_initcall(of_at91_clk_slow_retain);
-- 
2.1.4
