From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 25 Jan 2016 21:15:44 +0800
Subject: [PATCH RFC 08/11] clk: sunxi: factors: Drop round_rate from clk ops
In-Reply-To: <1453727747-23307-1-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
Message-ID: <1453727747-23307-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common clock framework requires either determine_rate or round_rate
to be implemented. We use determine_rate so we can pass the parent index
to the get_factors callback. This cannot be done easily with round_rate,
so just drop it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-factors.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index ac259305d5d5..5769e6532c1d 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -89,21 +89,6 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
-static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *parent_rate)
-{
-	struct clk_factors *factors = to_clk_factors(hw);
-	struct factors_request req = {
-		.rate = rate,
-		.parent_rate = *parent_rate,
-	};
-
-	factors->get_factors(&req);
-
-
-	return rate;
-}
-
 static int clk_factors_determine_rate(struct clk_hw *hw,
 				      struct clk_rate_request *req)
 {
@@ -189,7 +174,6 @@ static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
 static const struct clk_ops clk_factors_ops = {
 	.determine_rate = clk_factors_determine_rate,
 	.recalc_rate = clk_factors_recalc_rate,
-	.round_rate = clk_factors_round_rate,
 	.set_rate = clk_factors_set_rate,
 };
 
-- 
2.7.0
