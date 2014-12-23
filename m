From: Ying.Liu@freescale.com (Liu Ying)
Date: Tue, 23 Dec 2014 11:46:22 +0800
Subject: [PATCH RFC v3 01/18] clk: divider: Correct parent clk round rate if
 no bestdiv is normally found
In-Reply-To: <1419306399-9387-1-git-send-email-Ying.Liu@freescale.com>
References: <1419306399-9387-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1419306399-9387-2-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If no best divider is normally found, we will try to use the maximum divider.
We should not set the parent clock rate to be 1Hz by force for being rounded.
Instead, we should take the maximum divider as a base and calculate a correct
parent clock rate for being rounded.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v2->v3:
 * None.

v1->v2:
 * None.

 drivers/clk/clk-divider.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index c0a842b..f641d4b 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -311,7 +311,8 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 
 	if (!bestdiv) {
 		bestdiv = _get_maxdiv(divider);
-		*best_parent_rate = __clk_round_rate(__clk_get_parent(hw->clk), 1);
+		*best_parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
+						MULT_ROUND_UP(rate, bestdiv));
 	}
 
 	return bestdiv;
-- 
2.1.0
