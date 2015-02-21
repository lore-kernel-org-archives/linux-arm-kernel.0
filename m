From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 21 Feb 2015 11:40:25 +0100
Subject: [PATCH 3/3] clk: divider: fix calculation of initial best divider
 when rounding to closest
In-Reply-To: <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424515225-6929-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to the reasoning for the previous commit

	DIV_ROUND_CLOSEST(parent_rate, rate)

might not be the best integer divisor to get a good approximation for
rate from parent_rate (given the metric for CLK_DIVIDER_ROUND_CLOSEST).

For example assume a parent rate of 1000 Hz and a target rate of 700.
Using DIV_ROUND_CLOSEST the suggested divisor gets calculated to 1
resulting in a target rate of 1000 with a delta of 300 to the desired
rate. With choosing 2 as divisor however the resulting rate is 500 which
is nearer to 700.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/clk-divider.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 66a6211b8834..202a17e9a38b 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -201,17 +201,18 @@ static int _div_round_up(struct clk_divider *divider,
 static int _div_round_closest(struct clk_divider *divider,
 		unsigned long parent_rate, unsigned long rate)
 {
-	int up, down, div;
+	int up, down;
 	unsigned long up_rate, down_rate;
 
-	up = down = div = DIV_ROUND_CLOSEST(parent_rate, rate);
+	up = DIV_ROUND_UP(parent_rate, rate);
+	down = parent_rate / rate;
 
 	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO) {
-		up = __roundup_pow_of_two(div);
-		down = __rounddown_pow_of_two(div);
+		up = __roundup_pow_of_two(up);
+		down = __rounddown_pow_of_two(down);
 	} else if (divider->table) {
-		up = _round_up_table(divider->table, div);
-		down = _round_down_table(divider->table, div);
+		up = _round_up_table(divider->table, up);
+		down = _round_down_table(divider->table, down);
 	}
 
 	up_rate = DIV_ROUND_UP(parent_rate, up);
-- 
2.1.4
