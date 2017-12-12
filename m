From: ilialin@codeaurora.org (Ilia Lin)
Date: Tue, 12 Dec 2017 14:31:33 +0200
Subject: [PATCH 06/10] clk: qcom: cpu-8996: Add support to switch below 600Mhz
In-Reply-To: <1513081897-31612-1-git-send-email-ilialin@codeaurora.org>
References: <1513081897-31612-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <1513081897-31612-7-git-send-email-ilialin@codeaurora.org>
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
 drivers/clk/qcom/clk-cpu-8996.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index 9bb25be..79db4e8 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -28,6 +28,7 @@
 #define PLL_INDEX		1
 #define ACD_INDEX		2
 #define ALT_INDEX		3
+#define DIV_2_THRESHOLD		600000000
 
 /* PLLs */
 
@@ -121,6 +122,7 @@ struct clk_cpu_8996_mux {
 	u32	width;
 	struct notifier_block nb;
 	struct clk_hw	*pll;
+	struct clk_hw	*pll_div_2;
 	struct clk_regmap clkr;
 };
 
@@ -171,6 +173,13 @@ static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
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
 
@@ -182,13 +191,19 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
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
@@ -241,6 +256,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 	.shift = 0,
 	.width = 2,
 	.pll = &pwrcl_pll.clkr.hw,
+	.pll_div_2 = &pwrcl_smux.clkr.hw,
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "pwrcl_pmux",
@@ -261,6 +277,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 	.shift = 0,
 	.width = 2,
 	.pll = &perfcl_pll.clkr.hw,
+	.pll_div_2 = &perfcl_smux.clkr.hw,
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "perfcl_pmux",
-- 
1.9.1
