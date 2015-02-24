From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 24 Feb 2015 11:39:25 +0100
Subject: [PATCH] clk: divider: return real rate instead of divider value
Message-ID: <2011929.fOsbjMkSp9@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit bca9690b9426 ("clk: divider: Make generic for usage elsewhere")
returned only the divider value for read-only dividers instead of the
actual rate.

Fixes: bca9690b9426 ("clk: divider: Make generic for usage elsewhere")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk-divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a213455..5b4c018 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -355,7 +355,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 		bestdiv = readl(divider->reg) >> divider->shift;
 		bestdiv &= div_mask(divider->width);
 		bestdiv = _get_div(divider->table, bestdiv, divider->flags);
-		return bestdiv;
+		return DIV_ROUND_UP(*prate, bestdiv);
 	}
 
 	return divider_round_rate(hw, rate, prate, divider->table,
-- 
2.1.4
