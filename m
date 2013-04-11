From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 11 Apr 2013 11:31:37 -0700
Subject: [PATCH v2 2/2] clk: composite: allow fixed rates & fixed dividers
In-Reply-To: <1365705097-18899-1-git-send-email-mturquette@linaro.org>
References: <1365631378-16103-1-git-send-email-mturquette@linaro.org>
 <1365705097-18899-1-git-send-email-mturquette@linaro.org>
Message-ID: <1365705097-18899-2-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The composite clock assumes that any clock implementing the .recalc_rate
callback will also implement .round_rate and .set_rate.  This is not
always true; the basic fixed-rate clock will only implement .recalc_rate
and a fixed-divider clock may choose to implement .recalc_rate and
.round_rate but not .set_rate.

Fix this by conditionally registering .round_rate and .set_rate
callbacks based on the rate_ops passed in to clk_composite_register.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Tested-by: Emilio L?pez <emilio@elopez.com.ar>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Changes since v1:
* added WARN if set_rate is present without round_rate

 drivers/clk/clk-composite.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 6f4728c..a33f46f 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -150,17 +150,26 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 	}
 
 	if (rate_hw && rate_ops) {
-		if (!rate_ops->recalc_rate || !rate_ops->round_rate ||
-		    !rate_ops->set_rate) {
+		if (!rate_ops->recalc_rate) {
 			clk = ERR_PTR(-EINVAL);
 			goto err;
 		}
 
+		/* .round_rate is a prerequisite for .set_rate */
+		if (rate_ops->round_rate) {
+			clk_composite_ops->round_rate = clk_composite_round_rate;
+			if (rate_ops->set_rate) {
+				clk_composite_ops->set_rate = clk_composite_set_rate;
+			}
+		} else {
+			WARN(rate_ops->set_rate,
+				"%s: missing round_rate op is required\n",
+				__func__);
+		}
+
 		composite->rate_hw = rate_hw;
 		composite->rate_ops = rate_ops;
 		clk_composite_ops->recalc_rate = clk_composite_recalc_rate;
-		clk_composite_ops->round_rate = clk_composite_round_rate;
-		clk_composite_ops->set_rate = clk_composite_set_rate;
 	}
 
 	if (gate_hw && gate_ops) {
-- 
1.7.10.4
