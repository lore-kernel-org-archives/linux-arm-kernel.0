From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 29 Mar 2015 03:48:48 +0200
Subject: [PATCH] clk: check ->determine/round_rate() return value in
 clk_calc_new_rates
Message-ID: <1427593728-9366-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

->determine_rate() and ->round_rate() can return the closest rate to the
requested one or an error code.
clk_calc_new_rates is assuming these functions can't return a negative
value, which leads to a undefined behavior when the clk implementation
returns such an error code.
Fix this by returning NULL in case ->determine_rate() or ->round_rate()
returned an error code.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/clk/clk.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 237f23f..b59c1b4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1580,6 +1580,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *clk,
 	unsigned long min_rate;
 	unsigned long max_rate;
 	int p_index = 0;
+	long ret;
 
 	/* sanity */
 	if (IS_ERR_OR_NULL(clk))
@@ -1595,15 +1596,23 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *clk,
 	/* find the closest rate and parent clk/rate */
 	if (clk->ops->determine_rate) {
 		parent_hw = parent ? parent->hw : NULL;
-		new_rate = clk->ops->determine_rate(clk->hw, rate,
-						    min_rate,
-						    max_rate,
-						    &best_parent_rate,
-						    &parent_hw);
+		ret = clk->ops->determine_rate(clk->hw, rate,
+					       min_rate,
+					       max_rate,
+					       &best_parent_rate,
+					       &parent_hw);
+		if (ret < 0)
+			return NULL;
+
+		new_rate = ret;
 		parent = parent_hw ? parent_hw->core : NULL;
 	} else if (clk->ops->round_rate) {
-		new_rate = clk->ops->round_rate(clk->hw, rate,
-						&best_parent_rate);
+		ret = clk->ops->round_rate(clk->hw, rate,
+					   &best_parent_rate);
+		if (ret < 0)
+			return NULL;
+
+		new_rate = ret;
 		if (new_rate < min_rate || new_rate > max_rate)
 			return NULL;
 	} else if (!parent || !(clk->flags & CLK_SET_RATE_PARENT)) {
-- 
1.9.1
