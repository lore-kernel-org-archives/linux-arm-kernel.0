From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 21 Feb 2015 11:40:24 +0100
Subject: [PATCH 2/3] clk: divider: fix selection of divider when rounding to
 closest
In-Reply-To: <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424515225-6929-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's an invalid approach to assume that among two divider values
the one nearer the exact divider is the better one.

Assume a parent rate of 1000 Hz, a divider with CLK_DIVIDER_POWER_OF_TWO
and a target rate of 89 Hz. The exact divider is ~ 11.236 so 8 and 16
are the candidates to choose from yielding rates 125 Hz and 62.5 Hz
respectivly. While 8 is nearer to 11.236 than 16 is, the latter is still
the better divider as 62.5 is nearer to 89 than 125 is.

Fixes: 774b514390b1 (clk: divider: Add round to closest divider)
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/clk-divider.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index fbd9e8270791..66a6211b8834 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -202,6 +202,7 @@ static int _div_round_closest(struct clk_divider *divider,
 		unsigned long parent_rate, unsigned long rate)
 {
 	int up, down, div;
+	unsigned long up_rate, down_rate;
 
 	up = down = div = DIV_ROUND_CLOSEST(parent_rate, rate);
 
@@ -213,7 +214,10 @@ static int _div_round_closest(struct clk_divider *divider,
 		down = _round_down_table(divider->table, div);
 	}
 
-	return (up - div) <= (div - down) ? up : down;
+	up_rate = DIV_ROUND_UP(parent_rate, up);
+	down_rate = DIV_ROUND_UP(parent_rate, down);
+
+	return (rate - up_rate) <= (down_rate - rate) ? up : down;
 }
 
 static int _div_round(struct clk_divider *divider, unsigned long parent_rate,
-- 
2.1.4
