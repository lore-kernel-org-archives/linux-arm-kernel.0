From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Jul 2014 01:58:14 +0200
Subject: [PATCH v5 03/14] clk: composite: improve rate_hw sanity check logic
In-Reply-To: <156042792.J76K6jxIGl@diego>
References: <156042792.J76K6jxIGl@diego>
Message-ID: <2694753.hNjIfgCHO5@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Turquette <mturquette@linaro.org>

The function pointer population and sanity checking logic got a bit ugly
with the advent of the .determine_rate callback. Clean it up.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/clk-composite.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index faf7c32..b9355da 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -226,21 +226,27 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 			clk = ERR_PTR(-EINVAL);
 			goto err;
 		}
+		clk_composite_ops->recalc_rate = clk_composite_recalc_rate;
 
-		/* .round_rate is a prerequisite for .set_rate */
-		if (rate_ops->round_rate) {
-			clk_composite_ops->round_rate = clk_composite_round_rate;
-			if (rate_ops->set_rate) {
-				clk_composite_ops->set_rate = clk_composite_set_rate;
-			}
+		if (rate_ops->determine_rate)
+			clk_composite_ops->determine_rate =
+				clk_composite_determine_rate;
+		else if (rate_ops->round_rate)
+			clk_composite_ops->round_rate =
+				clk_composite_round_rate;
+
+		/* .set_rate requires either .round_rate or .determine_rate */
+		if (rate_ops->set_rate) {
+			if (rate_ops->determine_rate || rate_ops->round_rate)
+				clk_composite_ops->set_rate =
+						clk_composite_set_rate;
+			else
+				WARN(1, "%s: missing round_rate op is required\n",
+						__func__);
 		}
 
 		composite->rate_hw = rate_hw;
 		composite->rate_ops = rate_ops;
-		clk_composite_ops->recalc_rate = clk_composite_recalc_rate;
-		if (rate_ops->determine_rate ||
-		    (rate_ops->round_rate && clk_composite_ops->set_parent))
-			clk_composite_ops->determine_rate = clk_composite_determine_rate;
 	}
 
 	if (gate_hw && gate_ops) {
-- 
1.9.0
