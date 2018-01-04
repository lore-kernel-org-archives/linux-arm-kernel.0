From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu,  4 Jan 2018 13:10:06 +0200
Subject: [PATCH v2 02/11] clk: qcom: Fix .set_rate to handle alpha PLLs w/wo
 dynamic update
In-Reply-To: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
References: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <1515064215-22202-3-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Taniya Das <tdas@codeaurora.org>

From: Taniya Das <tdas@codeaurora.org>

Alpha PLLs which do not support dynamic update feature
need to be explicitly disabled before a rate change.
The ones which do support dynamic update do so within a
single vco range, so add a min/max freq check for such
PLLs so they fall in the vco range.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 72 ++++++++++++++++++++++++++++++++++------
 drivers/clk/qcom/clk-alpha-pll.h |  5 +++
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 47a1da3..ffdb160 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -376,19 +376,47 @@ static unsigned long alpha_pll_calc_rate(u64 prate, u32 l, u32 a)
 	return alpha_pll_calc_rate(prate, l, a);
 }
 
-static int clk_alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
-				  unsigned long prate)
+static int alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long prate,
+			      int (*enable)(struct clk_hw *hw),
+			      void (*disable)(struct clk_hw *hw))
 {
+	bool need_reenabling = false;
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	const struct pll_vco *vco;
 	u32 l, off = pll->offset;
 	u64 a;
 
 	rate = alpha_pll_round_rate(rate, prate, &l, &a);
-	vco = alpha_pll_find_vco(pll, rate);
-	if (!vco) {
-		pr_err("alpha pll not in a valid vco range\n");
-		return -EINVAL;
+
+	if (pll->flags & SUPPORTS_DYNAMIC_UPDATE) {
+		/*
+		 * PLLs which support dynamic updates support one single
+		 * vco range, between min_rate and max_rate supported
+		 */
+		if (rate < pll->min_rate || rate > pll->max_rate) {
+			pr_err("alpha pll rate outside supported min/max range\n");
+			return -EINVAL;
+		}
+	} else {
+		/*
+		 * All alpha PLLs which do not support dynamic update,
+		 * should be disabled before a vco update.
+		 */
+		if (clk_hw_is_enabled(hw)) {
+			disable(hw);
+			need_reenabling = true;
+		}
+
+		vco = alpha_pll_find_vco(pll, rate);
+		if (!vco) {
+			pr_err("alpha pll not in a valid vco range\n");
+			return -EINVAL;
+		}
+
+		regmap_update_bits(pll->clkr.regmap, off + PLL_USER_CTL,
+				   PLL_VCO_MASK << PLL_VCO_SHIFT,
+				   vco->val << PLL_VCO_SHIFT);
 	}
 
 	regmap_write(pll->clkr.regmap, off + PLL_L_VAL, l);
@@ -401,16 +429,29 @@ static int clk_alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 		regmap_write(pll->clkr.regmap, off + PLL_ALPHA_VAL_U, a >> 32);
 	}
 
-	regmap_update_bits(pll->clkr.regmap, off + PLL_USER_CTL,
-			   PLL_VCO_MASK << PLL_VCO_SHIFT,
-			   vco->val << PLL_VCO_SHIFT);
-
 	regmap_update_bits(pll->clkr.regmap, off + PLL_USER_CTL, PLL_ALPHA_EN,
 			   PLL_ALPHA_EN);
 
+	if (need_reenabling)
+		enable(hw);
+
 	return 0;
 }
 
+static int clk_alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long prate)
+{
+	return alpha_pll_set_rate(hw, rate, prate, clk_alpha_pll_enable,
+				  clk_alpha_pll_disable);
+}
+
+static int clk_alpha_pll_hwfsm_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long prate)
+{
+	return alpha_pll_set_rate(hw, rate, prate, clk_alpha_pll_hwfsm_enable,
+				  clk_alpha_pll_hwfsm_disable);
+}
+
 static long clk_alpha_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 				     unsigned long *prate)
 {
@@ -420,6 +461,15 @@ static long clk_alpha_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long min_freq, max_freq;
 
 	rate = alpha_pll_round_rate(rate, *prate, &l, &a);
+
+	if (pll->flags & SUPPORTS_DYNAMIC_UPDATE) {
+		if (rate < pll->min_rate)
+			rate = pll->min_rate;
+		else if (rate > pll->max_rate)
+			rate = pll->max_rate;
+		return rate;
+	}
+
 	if (alpha_pll_find_vco(pll, rate))
 		return rate;
 
@@ -445,7 +495,7 @@ static long clk_alpha_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	.is_enabled = clk_alpha_pll_hwfsm_is_enabled,
 	.recalc_rate = clk_alpha_pll_recalc_rate,
 	.round_rate = clk_alpha_pll_round_rate,
-	.set_rate = clk_alpha_pll_set_rate,
+	.set_rate = clk_alpha_pll_hwfsm_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_hwfsm_ops);
 
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index d6e1ee2..7aaa11c 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -27,6 +27,8 @@ struct pll_vco {
  * struct clk_alpha_pll - phase locked loop (PLL)
  * @offset: base address of registers
  * @vco_table: array of VCO settings
+ * @min_rate: Minimim rate for PLLs with single VCO range
+ * @max_rate: Maximun rate for PLLs with single VCO range
  * @clkr: regmap clock handle
  */
 struct clk_alpha_pll {
@@ -37,8 +39,11 @@ struct clk_alpha_pll {
 #define SUPPORTS_OFFLINE_REQ	BIT(0)
 #define SUPPORTS_16BIT_ALPHA	BIT(1)
 #define SUPPORTS_FSM_MODE	BIT(2)
+#define SUPPORTS_DYNAMIC_UPDATE	BIT(3)
 	u8 flags;
 
+	unsigned long min_rate;
+	unsigned long max_rate;
 	struct clk_regmap clkr;
 };
 
-- 
1.9.1
