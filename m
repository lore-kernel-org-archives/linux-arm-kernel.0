From: stephan@soliotek.com (=?UTF-8?q?St=C3=A9phan=20Rafin?=)
Date: Fri,  4 Nov 2016 00:53:56 +0100
Subject: [PATCH] clk: sunxi: Fix M factor computation for APB1
Message-ID: <1478217236-12831-1-git-send-email-stephan@soliotek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit cfa636886033 ("clk: sunxi: factors: Consolidate get_factors
parameters into a struct") introduced a regression for m factor
computation in sun4i_get_apb1_factors function.

The old code reassigned the "parent_rate" parameter to the targeted
divisor value and was buggy for the returned frequency but not for the
computed factors. Now, returned frequency is good but m factor is
incorrectly computed (its max value 31 is always set resulting in a
significantly slower frequency than the requested one...)

This patch simply restores the original proper computation for m while
keeping the good changes for returned rate.

Signed-off-by: St?phan Rafin <stephan@soliotek.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 838b22a..f2c9274 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -373,7 +373,7 @@ static void sun4i_get_apb1_factors(struct factors_request *req)
 	else
 		calcp = 3;
 
-	calcm = (req->parent_rate >> calcp) - 1;
+	calcm = (div >> calcp) - 1;
 
 	req->rate = (req->parent_rate >> calcp) / (calcm + 1);
 	req->m = calcm;
-- 
2.6.6
