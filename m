From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  5 Jan 2018 18:09:56 +0100
Subject: [PATCH 2/5] clk: lpc32xx: read-only divider can propagate rate change
In-Reply-To: <20180105170959.17266-1-jbrunet@baylibre.com>
References: <20180105170959.17266-1-jbrunet@baylibre.com>
Message-ID: <20180105170959.17266-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a divider clock has CLK_DIVIDER_READ_ONLY set, it means that the
register shall be left un-touched, but it does not mean the clock
should stop rate propagation if CLK_SET_RATE_PARENT is set

This properly handled in qcom clk-regmap-divider but it was not in the
lpc32xx divider

Fixes: f7c82a60ba26 ("clk: lpc32xx: add common clock framework driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/nxp/clk-lpc32xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index f5d815f577e0..729333766f97 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -963,6 +963,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *prate)
 {
 	struct lpc32xx_clk_div *divider = to_lpc32xx_div(hw);
+	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
 	unsigned int bestdiv;
 
 	/* if read only, just return current value */
@@ -972,6 +973,15 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 		bestdiv &= div_mask(divider->width);
 		bestdiv = _get_div(divider->table, bestdiv, divider->flags,
 			divider->width);
+
+		/* Even a read-only clock can propagate a rate change */
+		if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
+			if (!hw_parent)
+				return -EINVAL;
+
+			*prate = clk_hw_round_rate(hw_parent, rate * bestdiv);
+		}
+
 		return DIV_ROUND_UP(*prate, bestdiv);
 	}
 
-- 
2.14.3
