From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 21 Feb 2015 11:40:23 +0100
Subject: [PATCH 1/3] clk: divider: fix calculation of maximal parent rate for
 a given divider
In-Reply-To: <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424515225-6929-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rate provided at the output of a clk-divider is calculated as:

	DIV_ROUND_UP(parent_rate, div)

since commit b11d282dbea2 (clk: divider: fix rate calculation for
fractional rates). So to yield a rate not bigger than r parent_rate
must be <= r * div.

The effect of choosing a parent rate that is too big as was done before
this patch results in wrongly ruling out good dividers.

Note that this is not a complete fix as __clk_round_rate might return a
value >= its 2nd parameter. Also for dividers with
CLK_DIVIDER_ROUND_CLOSEST set the calculation is not accurate. But this
fixes the test case by Sascha Hauer that uses a chain of three dividers
under a fixed clock.

Fixes: b11d282dbea2 (clk: divider: fix rate calculation for fractional rates)
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/clk-divider.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 531d5a48e69f..fbd9e8270791 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -129,12 +129,6 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_UP(parent_rate, div);
 }
 
-/*
- * The reverse of DIV_ROUND_UP: The maximum number which
- * divided by m is r
- */
-#define MULT_ROUND_UP(r, m) ((r) * (m) + (m) - 1)
-
 static bool _is_valid_table_div(const struct clk_div_table *table,
 							 unsigned int div)
 {
@@ -300,7 +294,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 			return i;
 		}
 		parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
-				MULT_ROUND_UP(rate, i));
+					       rate * i);
 		now = DIV_ROUND_UP(parent_rate, i);
 		if (_is_best_div(divider, rate, now, best)) {
 			bestdiv = i;
-- 
2.1.4
