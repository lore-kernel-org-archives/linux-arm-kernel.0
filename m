From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 11 Apr 2012 11:38:53 +0530
Subject: [PATCH] clk: clk_calc_new_rates() required for parent only if
 CLK_SET_RATE_PARENT is set
Message-ID: <0b5e799807b09e47db1bf2805359aae36d947f60.1334124495.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to call clk_calc_new_rates() for parent clock only when we have
CLK_SET_RATE_PARENT flag set for clock.

This patch fixes it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/clk.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2f58455..56e32a1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -780,15 +780,14 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
 		goto out;
 	}
 
-	if (clk->flags & CLK_SET_RATE_PARENT)
-		new_rate = clk->ops->round_rate(clk->hw, rate, &best_parent_rate);
-	else
-		new_rate = clk->ops->round_rate(clk->hw, rate, NULL);
-
-	if (best_parent_rate != clk->parent->rate) {
-		top = clk_calc_new_rates(clk->parent, best_parent_rate);
+	if (clk->flags & CLK_SET_RATE_PARENT) {
+		new_rate = clk->ops->round_rate(clk->hw, rate,
+				&best_parent_rate);
 
-		goto out;
+		if (best_parent_rate != clk->parent->rate)
+			top = clk_calc_new_rates(clk->parent, best_parent_rate);
+	} else {
+		new_rate = clk->ops->round_rate(clk->hw, rate, NULL);
 	}
 
 out:
-- 
1.7.9
