From: chenxg@marvell.com (chenxg at marvell.com)
Date: Fri, 1 Nov 2013 14:27:15 +0800
Subject: [PATCH] clk: align clock rate unit to unsigned long
Message-ID: <1383287235-19583-1-git-send-email-chenxg@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiaoguang Chen <chenxg@marvell.com>

Clock rate unit should use unsigned long instead of long.
Otherwise clock rate that is higher than 2Ghz will become negative.
Align the unit to unsigned long to make sure no long to unsigned
long conversion happens.

Signed-off-by: Xiaoguang Chen <chenxg@marvell.com>
---
 drivers/clk/clk-composite.c    | 4 ++--
 drivers/clk/clk-divider.c      | 4 ++--
 drivers/clk/clk-fixed-factor.c | 4 ++--
 drivers/clk/clk.c              | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index a33f46f..e091b83 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -55,8 +55,8 @@ static unsigned long clk_composite_recalc_rate(struct clk_hw *hw,
 	return rate_ops->recalc_rate(rate_hw, parent_rate);
 }
 
-static long clk_composite_round_rate(struct clk_hw *hw, unsigned long rate,
-				  unsigned long *prate)
+static unsigned long clk_composite_round_rate(struct clk_hw *hw,
+			unsigned long rate, unsigned long *prate)
 {
 	struct clk_composite *composite = to_clk_composite(hw);
 	const struct clk_ops *rate_ops = composite->rate_ops;
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 8d3009e..280fd41 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -201,8 +201,8 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 	return bestdiv;
 }
 
-static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *prate)
+static unsigned long clk_divider_round_rate(struct clk_hw *hw,
+			unsigned long rate, unsigned long *prate)
 {
 	int div;
 	div = clk_divider_bestdiv(hw, rate, prate);
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 0e1d89b..73b99c3 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -36,8 +36,8 @@ static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)rate;
 }
 
-static long clk_factor_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *prate)
+static unsigned long clk_factor_round_rate(struct clk_hw *hw,
+			unsigned long rate, unsigned long *prate)
 {
 	struct clk_fixed_factor *fix = to_clk_fixed_factor(hw);
 
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a004769..4f7f6fc 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -697,7 +697,7 @@ struct clk *__clk_lookup(const char *name)
  * directly as a determine_rate callback (e.g. for a mux), or from a more
  * complex clock that may combine a mux with other operations.
  */
-long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
+unsigned long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
 			      unsigned long *best_parent_rate,
 			      struct clk **best_parent_p)
 {
@@ -967,7 +967,7 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
  * use which is then returned.  If clk doesn't support round_rate operation
  * then the parent rate is returned.
  */
-long clk_round_rate(struct clk *clk, unsigned long rate)
+unsigned long clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	unsigned long ret;
 
-- 
1.8.0
