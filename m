From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Apr 2012 20:50:17 +0800
Subject: [PATCH 1/3] clk: always pass parent_rate into .round_rate
In-Reply-To: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
Message-ID: <1334235019-15553-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The parent_rate will likely be used by most .round_rate implementation
no matter whether flag CLK_SET_RATE_PARENT is set or not, so let's
always pass parent_rate into .round_rate.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/clk-divider.c |   12 +++---------
 drivers/clk/clk.c         |   16 +++++++---------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index add784b..04439f1 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -67,8 +67,8 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 	if (divider->flags & CLK_DIVIDER_ONE_BASED)
 		maxdiv--;
 
-	if (!best_parent_rate) {
-		parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
+	if (!(__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT)) {
+		parent_rate = *best_parent_rate;
 		bestdiv = DIV_ROUND_UP(parent_rate, rate);
 		bestdiv = bestdiv == 0 ? 1 : bestdiv;
 		bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
@@ -108,13 +108,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 	int div;
 	div = clk_divider_bestdiv(hw, rate, prate);
 
-	if (prate)
-		return *prate / div;
-	else {
-		unsigned long r;
-		r = __clk_get_rate(__clk_get_parent(hw->clk));
-		return r / div;
-	}
+	return *prate / div;
 }
 
 static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate)
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af2bf12..19caa0a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -582,7 +582,7 @@ EXPORT_SYMBOL_GPL(clk_get_rate);
  */
 unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	unsigned long unused;
+	unsigned long parent_rate = 0;
 
 	if (!clk)
 		return -EINVAL;
@@ -590,10 +590,10 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
 	if (!clk->ops->round_rate)
 		return clk->rate;
 
-	if (clk->flags & CLK_SET_RATE_PARENT)
-		return clk->ops->round_rate(clk->hw, rate, &unused);
-	else
-		return clk->ops->round_rate(clk->hw, rate, NULL);
+	if (clk->parent)
+		parent_rate = clk->parent->rate;
+
+	return clk->ops->round_rate(clk->hw, rate, &parent_rate);
 }
 
 /**
@@ -763,7 +763,7 @@ static void clk_calc_subtree(struct clk *clk, unsigned long new_rate)
 static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
 {
 	struct clk *top = clk;
-	unsigned long best_parent_rate;
+	unsigned long best_parent_rate = 0;
 	unsigned long new_rate;
 
 	/* sanity */
@@ -775,9 +775,6 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
 		if (!clk->ops->round_rate) {
 			clk->new_rate = clk->rate;
 			return NULL;
-		} else {
-			new_rate = clk->ops->round_rate(clk->hw, rate, NULL);
-			goto out;
 		}
 	}
 
@@ -794,6 +791,7 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
 		goto out;
 	}
 
+	best_parent_rate = clk->parent->rate;
 	new_rate = clk->ops->round_rate(clk->hw, rate, &best_parent_rate);
 
 	if (best_parent_rate != clk->parent->rate) {
-- 
1.7.5.4
