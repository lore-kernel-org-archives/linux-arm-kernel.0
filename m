From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu,  4 Jan 2018 13:10:11 +0200
Subject: [PATCH v2 07/11] clk: qcom: cpu-8996: Add support to switch below
 600Mhz
In-Reply-To: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
References: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <1515064215-22202-8-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@codeaurora.org>

The CPU clock controllers primary PLL operates on a single VCO range,
between 600Mhz and 3Ghz. However the CPUs do support OPPs with
frequencies between 300Mhz and 600Mhz. In order to support running the
CPUs at those frequencies we end up having to lock the PLL at twice the
rate and drive the CPU clk via the PLL/2 output and SMUX.

So for frequencies above 600Mhz we follow the following path
 Primary PLL --> PLL_EARLY --> PMUX(1) --> CPU clk
and for frequencies between 300Mhz and 600Mhz we follow
 Primary PLL --> PLL/2 --> SMUX(1) --> PMUX(0) --> CPU clk

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/clk/qcom/clk-cpu-8996.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index 9bb25be..81cf466 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -28,15 +28,17 @@
 #define PLL_INDEX		1
 #define ACD_INDEX		2
 #define ALT_INDEX		3
+#define DIV_2_THRESHOLD		600000000
 
 /* PLLs */
 
 static const struct alpha_pll_config hfpll_config = {
 	.l = 60,
-	.config_ctl_val = 0x200d4828,
+	.config_ctl_val = 0x200D4AA8,
 	.config_ctl_hi_val = 0x006,
 	.pre_div_mask = BIT(12),
 	.post_div_mask = 0x3 << 8,
+	.post_div_val = 0x1 << 8,
 	.main_output_mask = BIT(0),
 	.early_output_mask = BIT(3),
 };
@@ -82,7 +84,7 @@
 	.vco_mask = 0x3 << 20,
 	.config_ctl_val = 0x4001051b,
 	.post_div_mask = 0x3 << 8,
-	.post_div_val = 0x1,
+	.post_div_val = 0x1 << 8,
 	.main_output_mask = BIT(0),
 	.early_output_mask = BIT(3),
 };
@@ -121,6 +123,7 @@ struct clk_cpu_8996_mux {
 	u32	width;
 	struct notifier_block nb;
 	struct clk_hw	*pll;
+	struct clk_hw	*pll_div_2;
 	struct clk_regmap clkr;
 };
 
@@ -171,6 +174,13 @@ static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
 	if (!cpuclk->pll)
 		return -EINVAL;
 
+	if (cpuclk->pll_div_2 && req->rate < DIV_2_THRESHOLD) {
+		if (req->rate < (DIV_2_THRESHOLD / 2))
+			return -EINVAL;
+
+		parent = cpuclk->pll_div_2;
+	}
+
 	req->best_parent_rate = clk_hw_round_rate(parent, req->rate);
 	req->best_parent_hw = parent;
 
@@ -182,13 +192,19 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 {
 	int ret;
 	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_nb(nb);
+	struct clk_notifier_data *cnd = data;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
 		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
 		break;
 	case POST_RATE_CHANGE:
-		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, PLL_INDEX);
+		if (cnd->new_rate < DIV_2_THRESHOLD)
+			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
+							  DIV_2_INDEX);
+		else
+			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
+							  PLL_INDEX);
 		break;
 	default:
 		ret = 0;
@@ -241,6 +257,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 	.shift = 0,
 	.width = 2,
 	.pll = &pwrcl_pll.clkr.hw,
+	.pll_div_2 = &pwrcl_smux.clkr.hw,
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "pwrcl_pmux",
@@ -261,6 +278,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 	.shift = 0,
 	.width = 2,
 	.pll = &perfcl_pll.clkr.hw,
+	.pll_div_2 = &perfcl_smux.clkr.hw,
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "perfcl_pmux",
-- 
1.9.1
