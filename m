From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  5 Jan 2018 18:09:59 +0100
Subject: [PATCH 5/5] clk: qcom: use divider_ro_round_rate helper
In-Reply-To: <20180105170959.17266-1-jbrunet@baylibre.com>
References: <20180105170959.17266-1-jbrunet@baylibre.com>
Message-ID: <20180105170959.17266-6-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is now an helper function to round the rate when the
divider is read-only. Let's use it

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/qcom/clk-regmap-divider.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/clk-regmap-divider.c b/drivers/clk/qcom/clk-regmap-divider.c
index 4e9b8c2c8980..114e36b97255 100644
--- a/drivers/clk/qcom/clk-regmap-divider.c
+++ b/drivers/clk/qcom/clk-regmap-divider.c
@@ -28,22 +28,15 @@ static long div_round_ro_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_regmap_div *divider = to_clk_regmap_div(hw);
 	struct clk_regmap *clkr = &divider->clkr;
-	u32 div;
+	u32 val;
 	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
 
-	regmap_read(clkr->regmap, divider->reg, &div);
-	div >>= divider->shift;
-	div &= BIT(divider->width) - 1;
-	div += 1;
-
-	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
-		if (!hw_parent)
-			return -EINVAL;
-
-		*prate = clk_hw_round_rate(hw_parent, rate * div);
-	}
+	regmap_read(clkr->regmap, divider->reg, &val);
+	val >>= divider->shift;
+	val &= BIT(divider->width) - 1;
 
-	return DIV_ROUND_UP_ULL((u64)*prate, div);
+	return divider_ro_round_rate(hw, rate, prate, NULL, divider->width,
+				     CLK_DIVIDER_ROUND_CLOSEST, val);
 }
 
 static long div_round_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.14.3
