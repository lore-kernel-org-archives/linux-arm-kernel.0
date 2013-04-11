From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 11 Apr 2013 11:31:36 -0700
Subject: [PATCH v2 1/2] clk: composite: rename 'div' references to 'rate'
In-Reply-To: <1365631378-16103-1-git-send-email-mturquette@linaro.org>
References: <1365631378-16103-1-git-send-email-mturquette@linaro.org>
Message-ID: <1365705097-18899-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename all div_hw and div_ops related variables and functions to use
rate_hw, rate_ops, etc.  This is to make the rate-change portion of the
composite clk implementation more generic.  A patch following this one
will allow for fixed-rate clocks to reuse this infrastructure.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
Reviewed-by: Prashant Gaikwad <pgaikwad@nvidia.com>
Tested-by: Emilio L?pez <emilio@elopez.com.ar>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Changes since v1:
* fixed regex typo in kerneldoc

 drivers/clk/clk-composite.c  |   40 ++++++++++++++++++++--------------------
 include/linux/clk-provider.h |   14 +++++++-------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 097dee4..6f4728c 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -47,36 +47,36 @@ static unsigned long clk_composite_recalc_rate(struct clk_hw *hw,
 					    unsigned long parent_rate)
 {
 	struct clk_composite *composite = to_clk_composite(hw);
-	const struct clk_ops *div_ops = composite->div_ops;
-	struct clk_hw *div_hw = composite->div_hw;
+	const struct clk_ops *rate_ops = composite->rate_ops;
+	struct clk_hw *rate_hw = composite->rate_hw;
 
-	div_hw->clk = hw->clk;
+	rate_hw->clk = hw->clk;
 
-	return div_ops->recalc_rate(div_hw, parent_rate);
+	return rate_ops->recalc_rate(rate_hw, parent_rate);
 }
 
 static long clk_composite_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *prate)
 {
 	struct clk_composite *composite = to_clk_composite(hw);
-	const struct clk_ops *div_ops = composite->div_ops;
-	struct clk_hw *div_hw = composite->div_hw;
+	const struct clk_ops *rate_ops = composite->rate_ops;
+	struct clk_hw *rate_hw = composite->rate_hw;
 
-	div_hw->clk = hw->clk;
+	rate_hw->clk = hw->clk;
 
-	return div_ops->round_rate(div_hw, rate, prate);
+	return rate_ops->round_rate(rate_hw, rate, prate);
 }
 
 static int clk_composite_set_rate(struct clk_hw *hw, unsigned long rate,
 			       unsigned long parent_rate)
 {
 	struct clk_composite *composite = to_clk_composite(hw);
-	const struct clk_ops *div_ops = composite->div_ops;
-	struct clk_hw *div_hw = composite->div_hw;
+	const struct clk_ops *rate_ops = composite->rate_ops;
+	struct clk_hw *rate_hw = composite->rate_hw;
 
-	div_hw->clk = hw->clk;
+	rate_hw->clk = hw->clk;
 
-	return div_ops->set_rate(div_hw, rate, parent_rate);
+	return rate_ops->set_rate(rate_hw, rate, parent_rate);
 }
 
 static int clk_composite_is_enabled(struct clk_hw *hw)
@@ -115,7 +115,7 @@ static void clk_composite_disable(struct clk_hw *hw)
 struct clk *clk_register_composite(struct device *dev, const char *name,
 			const char **parent_names, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
-			struct clk_hw *div_hw, const struct clk_ops *div_ops,
+			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
 			unsigned long flags)
 {
@@ -149,15 +149,15 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		clk_composite_ops->set_parent = clk_composite_set_parent;
 	}
 
-	if (div_hw && div_ops) {
-		if (!div_ops->recalc_rate || !div_ops->round_rate ||
-		    !div_ops->set_rate) {
+	if (rate_hw && rate_ops) {
+		if (!rate_ops->recalc_rate || !rate_ops->round_rate ||
+		    !rate_ops->set_rate) {
 			clk = ERR_PTR(-EINVAL);
 			goto err;
 		}
 
-		composite->div_hw = div_hw;
-		composite->div_ops = div_ops;
+		composite->rate_hw = rate_hw;
+		composite->rate_ops = rate_ops;
 		clk_composite_ops->recalc_rate = clk_composite_recalc_rate;
 		clk_composite_ops->round_rate = clk_composite_round_rate;
 		clk_composite_ops->set_rate = clk_composite_set_rate;
@@ -187,8 +187,8 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 	if (composite->mux_hw)
 		composite->mux_hw->clk = clk;
 
-	if (composite->div_hw)
-		composite->div_hw->clk = clk;
+	if (composite->rate_hw)
+		composite->rate_hw->clk = clk;
 
 	if (composite->gate_hw)
 		composite->gate_hw->clk = clk;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 9fdfae7..766711a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -352,11 +352,11 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
  * struct clk_composite - aggregate clock of mux, divider and gate clocks
  *
  * @hw:		handle between common and hardware-specific interfaces
- * @mux_hw:	handle between composite and hardware-specifix mux clock
- * @div_hw:	handle between composite and hardware-specifix divider clock
- * @gate_hw:	handle between composite and hardware-specifix gate clock
+ * @mux_hw:	handle between composite and hardware-specific mux clock
+ * @rate_hw:	handle between composite and hardware-specific rate clock
+ * @gate_hw:	handle between composite and hardware-specific gate clock
  * @mux_ops:	clock ops for mux
- * @div_ops:	clock ops for divider
+ * @rate_ops:	clock ops for rate
  * @gate_ops:	clock ops for gate
  */
 struct clk_composite {
@@ -364,18 +364,18 @@ struct clk_composite {
 	struct clk_ops	ops;
 
 	struct clk_hw	*mux_hw;
-	struct clk_hw	*div_hw;
+	struct clk_hw	*rate_hw;
 	struct clk_hw	*gate_hw;
 
 	const struct clk_ops	*mux_ops;
-	const struct clk_ops	*div_ops;
+	const struct clk_ops	*rate_ops;
 	const struct clk_ops	*gate_ops;
 };
 
 struct clk *clk_register_composite(struct device *dev, const char *name,
 		const char **parent_names, int num_parents,
 		struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
-		struct clk_hw *div_hw, const struct clk_ops *div_ops,
+		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
 		unsigned long flags);
 
-- 
1.7.10.4
