From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Feb 2015 14:32:07 -0800
Subject: [PATCH] clk: qcom: Properly change rates for ahbix clock
Message-ID: <1424903527-5636-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ahbix clock can never be turned off. To switch the rates we
need to switch the mux off the M/N counter to an always on source
(XO), reprogram the M/N counter to get the rate we want and
finally switch back to the M/N counter. Add a new ops structure
for this type of clock so that we can set the rate properly.

Fixes: c99e515a92e9 "clk: qcom: Add IPQ806X LPASS clock controller (LCC) driver"
Cc: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.c     | 30 ++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-rcg.h     |  1 +
 drivers/clk/qcom/lcc-ipq806x.c |  5 +----
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index 0039bd7d3965..49a1b58d4f8c 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -495,6 +495,27 @@ static int clk_rcg_bypass_set_rate(struct clk_hw *hw, unsigned long rate,
 	return __clk_rcg_set_rate(rcg, rcg->freq_tbl);
 }
 
+static int clk_rcg_lcc_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_rcg *rcg = to_clk_rcg(hw);
+	const struct freq_tbl *f;
+	int ret;
+	u32 gfm = BIT(10);
+
+	f = qcom_find_freq(rcg->freq_tbl, rate);
+	if (!f)
+		return -EINVAL;
+
+	/* Switch to XO to avoid glitches */
+	regmap_update_bits(rcg->clkr.regmap, rcg->ns_reg, gfm, 0);
+	ret = __clk_rcg_set_rate(rcg, f);
+	/* Switch back to M/N */
+	regmap_update_bits(rcg->clkr.regmap, rcg->ns_reg, gfm, gfm);
+
+	return ret;
+}
+
 static int __clk_dyn_rcg_set_rate(struct clk_hw *hw, unsigned long rate)
 {
 	struct clk_dyn_rcg *rcg = to_clk_dyn_rcg(hw);
@@ -543,6 +564,15 @@ const struct clk_ops clk_rcg_bypass_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_rcg_bypass_ops);
 
+const struct clk_ops clk_rcg_lcc_ops = {
+	.get_parent = clk_rcg_get_parent,
+	.set_parent = clk_rcg_set_parent,
+	.recalc_rate = clk_rcg_recalc_rate,
+	.determine_rate = clk_rcg_determine_rate,
+	.set_rate = clk_rcg_lcc_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_rcg_lcc_ops);
+
 const struct clk_ops clk_dyn_rcg_ops = {
 	.enable = clk_enable_regmap,
 	.is_enabled = clk_is_enabled_regmap,
diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 687e41f91d7c..d09d06ba278e 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -96,6 +96,7 @@ struct clk_rcg {
 
 extern const struct clk_ops clk_rcg_ops;
 extern const struct clk_ops clk_rcg_bypass_ops;
+extern const struct clk_ops clk_rcg_lcc_ops;
 
 #define to_clk_rcg(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg, clkr)
 
diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index c9ff27b4648b..fb276522173a 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -385,14 +385,11 @@ static struct clk_rcg ahbix_clk = {
 	},
 	.freq_tbl = clk_tbl_ahbix,
 	.clkr = {
-		.enable_reg = 0x38,
-		.enable_mask = BIT(10), /* toggle the gfmux to select mn/pxo */
 		.hw.init = &(struct clk_init_data){
 			.name = "ahbix",
 			.parent_names = lcc_pxo_pll4,
 			.num_parents = 2,
-			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
+			.ops = &clk_rcg_lcc_ops,
 		},
 	},
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
