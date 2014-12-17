From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 18 Dec 2014 00:59:18 +0800
Subject: [PATCH] clk: sunxi: Fix sun6i_ahb1_clk_determine_rate clock to return
 clk_hw
Message-ID: <1418835558-3907-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The determine_rate clock op callback was changed to return clk_hw in
commit 646cafc6aa4d ("clk: Change clk_ops->determine_rate to return a
clk_hw as the best parent"). This fixes the sun6i AHB1 clock driver.

Fixes: 544473f clk: sunxi: unify sun6i AHB1 clock with proper PLL6 pre-divider
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Maxime,

Since you've queued the sun6i ahb1 patches for 3.20, but haven't published
them, could you squash this one in when you do?

---
 drivers/clk/sunxi/clk-sunxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 68ac9f0..9ba2c5f 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -120,7 +120,7 @@ static long sun6i_ahb1_clk_round(unsigned long rate, u8 *divp, u8 *pre_divp,
 
 static long sun6i_ahb1_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 					  unsigned long *best_parent_rate,
-					  struct clk **best_parent_clk)
+					  struct clk_hw **best_parent_clk)
 {
 	struct clk *clk = hw->clk, *parent, *best_parent = NULL;
 	int i, num_parents;
@@ -148,7 +148,7 @@ static long sun6i_ahb1_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 	}
 
 	if (best_parent)
-		*best_parent_clk = best_parent;
+		*best_parent_clk = __clk_get_hw(best_parent);
 	*best_parent_rate = best;
 
 	return best_child_rate;
-- 
2.1.3
