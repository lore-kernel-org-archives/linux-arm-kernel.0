From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:32 +0200
Subject: [PATCH v3 03/21] clk: sunxi-ng: div: Switch to divider_round_rate
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <13c78d9da524cd9f123a75f56e097fa7bd07cc74.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

divider_round_rate_parent already evaluates changing the parent rate if
CLK_SET_RATE_PARENT is set. Now that we can do that on muxes too, let's
just use it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_div.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
index a489f18a3c01..419463375bc1 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -20,18 +20,11 @@ static unsigned long ccu_div_round_rate(struct ccu_mux_internal *mux,
 					void *data)
 {
 	struct ccu_div *cd = data;
-	unsigned long val;
-
-	/*
-	 * We can't use divider_round_rate that assumes that there's
-	 * several parents, while we might be called to evaluate
-	 * several different parents.
-	 */
-	val = divider_get_val(rate, *parent_rate, cd->div.table, cd->div.width,
-			      cd->div.flags);
 
-	return divider_recalc_rate(&cd->common.hw, *parent_rate, val,
-				   cd->div.table, cd->div.flags);
+	return divider_round_rate_parent(&cd->common.hw, parent,
+					 rate, parent_rate,
+					 cd->div.table, cd->div.width,
+					 cd->div.flags);
 }
 
 static void ccu_div_disable(struct clk_hw *hw)
@@ -78,18 +71,6 @@ static int ccu_div_determine_rate(struct clk_hw *hw,
 {
 	struct ccu_div *cd = hw_to_ccu_div(hw);
 
-	if (clk_hw_get_num_parents(hw) == 1) {
-		req->rate = divider_round_rate(hw, req->rate,
-					       &req->best_parent_rate,
-					       cd->div.table,
-					       cd->div.width,
-					       cd->div.flags);
-
-		req->best_parent_hw = clk_hw_get_parent(hw);
-
-		return 0;
-	}
-
 	return ccu_mux_helper_determine_rate(&cd->common, &cd->mux,
 					     req, ccu_div_round_rate, cd);
 }
-- 
git-series 0.9.1
