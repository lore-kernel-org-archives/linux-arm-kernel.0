From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sat, 14 Sep 2013 21:37:59 -0300
Subject: [PATCH] clk: composite: .determine_rate support
Message-ID: <1379205479-26001-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds .determine_rate support to the composite clock. It will
use the .determine_rate callback from the rate component if available,
and fall back on the mux component otherwise. This allows composite
clocks to enjoy the benefits of automatic clock reparenting.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Hi Mike,

This is a prerequisite patch for the sunxi driver changes that I'll send 
shortly; I believe you already looked at this diff on IRC and agreed it 
was sensible, so I hope it can be merged early for the 3.13 cycle 
(unless someone else has any objections to the patch, that is).

Cheers,

Emilio

 drivers/clk/clk-composite.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index a33f46f..753d0b7 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -55,6 +55,30 @@ static unsigned long clk_composite_recalc_rate(struct clk_hw *hw,
 	return rate_ops->recalc_rate(rate_hw, parent_rate);
 }
 
+static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *best_parent_rate,
+					struct clk **best_parent_p)
+{
+	struct clk_composite *composite = to_clk_composite(hw);
+	const struct clk_ops *rate_ops = composite->rate_ops;
+	const struct clk_ops *mux_ops = composite->mux_ops;
+	struct clk_hw *rate_hw = composite->rate_hw;
+	struct clk_hw *mux_hw = composite->mux_hw;
+
+	if (rate_hw && rate_ops && rate_ops->determine_rate) {
+		rate_hw->clk = hw->clk;
+		return rate_ops->determine_rate(rate_hw, rate, best_parent_rate,
+						best_parent_p);
+	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
+		mux_hw->clk = hw->clk;
+		return mux_ops->determine_rate(rate_hw, rate, best_parent_rate,
+					       best_parent_p);
+	} else {
+		pr_err("clk: clk_composite_determine_rate function called, but no mux or rate callback set!\n");
+		return 0;
+	}
+}
+
 static long clk_composite_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *prate)
 {
@@ -147,6 +171,8 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		composite->mux_ops = mux_ops;
 		clk_composite_ops->get_parent = clk_composite_get_parent;
 		clk_composite_ops->set_parent = clk_composite_set_parent;
+		if (mux_ops->determine_rate)
+			clk_composite_ops->determine_rate = clk_composite_determine_rate;
 	}
 
 	if (rate_hw && rate_ops) {
@@ -170,6 +196,8 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		composite->rate_hw = rate_hw;
 		composite->rate_ops = rate_ops;
 		clk_composite_ops->recalc_rate = clk_composite_recalc_rate;
+		if (rate_ops->determine_rate)
+			clk_composite_ops->determine_rate = clk_composite_determine_rate;
 	}
 
 	if (gate_hw && gate_ops) {
-- 
1.8.4
