From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 12:00:39 -0700
Subject: [PATCH v1 2/4] clk: iproc: Fix error in the pll post divider rate
 calculation
In-Reply-To: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
References: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1502737241-2040-3-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pll post divider code was using DIV_ROUND_UP when determining the
divider value best suited to produce the target frequency.
Using DIV_ROUND_CLOSEST will give us better divider values when
the division results in a small remainder.
Also, change the post divider clock over to the determine_rate api
instead of round_rate.

Signed-off-by: Simran Rai <ssimran@broadcom.com>
Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 drivers/clk/bcm/clk-iproc-pll.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index 9514ecf..7df010b 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -602,25 +602,26 @@ static unsigned long iproc_clk_recalc_rate(struct clk_hw *hw,
 	return clk->rate;
 }
 
-static long iproc_clk_round_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *parent_rate)
+static int iproc_clk_determine_rate(struct clk_hw *hw,
+		struct clk_rate_request *req)
 {
-	unsigned int div;
+	unsigned int bestdiv;
 
-	if (rate == 0 || *parent_rate == 0)
+	if (req->rate == 0)
 		return -EINVAL;
+	if (req->rate == req->best_parent_rate)
+		return 0;
 
-	if (rate == *parent_rate)
-		return *parent_rate;
+	bestdiv = DIV_ROUND_CLOSEST(req->best_parent_rate, req->rate);
+	if (bestdiv < 2)
+		req->rate = req->best_parent_rate;
 
-	div = DIV_ROUND_UP(*parent_rate, rate);
-	if (div < 2)
-		return *parent_rate;
+	if (bestdiv > 256)
+		bestdiv = 256;
 
-	if (div > 256)
-		div = 256;
+	req->rate = req->best_parent_rate / bestdiv;
 
-	return *parent_rate / div;
+	return 0;
 }
 
 static int iproc_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -635,10 +636,10 @@ static int iproc_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (rate == 0 || parent_rate == 0)
 		return -EINVAL;
 
+	div = DIV_ROUND_CLOSEST(parent_rate, rate);
 	if (ctrl->flags & IPROC_CLK_MCLK_DIV_BY_2)
-		div = DIV_ROUND_UP(parent_rate, rate * 2);
-	else
-		div = DIV_ROUND_UP(parent_rate, rate);
+		div /=  2;
+
 	if (div > 256)
 		return -EINVAL;
 
@@ -662,7 +663,7 @@ static int iproc_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	.enable = iproc_clk_enable,
 	.disable = iproc_clk_disable,
 	.recalc_rate = iproc_clk_recalc_rate,
-	.round_rate = iproc_clk_round_rate,
+	.determine_rate = iproc_clk_determine_rate,
 	.set_rate = iproc_clk_set_rate,
 };
 
-- 
1.9.1
