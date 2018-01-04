From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu,  4 Jan 2018 13:10:10 +0200
Subject: [PATCH v2 06/11] clk: qcom: cpu-8996: Add support to switch to
 alternate PLL
In-Reply-To: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
References: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <1515064215-22202-7-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Each of the CPU clusters on msm8996 and powered via a primary
PLL and a secondary PLL. The primary PLL is what drivers the
CPU clk, except for times when we are reprogramming the PLL
itself, when we temporarily switch to an alternate PLL.
Use clock rate change notifiers to support this.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/clk/qcom/clk-cpu-8996.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index bc60111..9bb25be 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -119,10 +119,14 @@ struct clk_cpu_8996_mux {
 	u32	reg;
 	u32	shift;
 	u32	width;
+	struct notifier_block nb;
 	struct clk_hw	*pll;
 	struct clk_regmap clkr;
 };
 
+#define to_clk_cpu_8996_mux_nb(_nb) \
+	container_of(_nb, struct clk_cpu_8996_mux, nb)
+
 static inline
 struct clk_cpu_8996_mux *to_clk_cpu_8996_mux_hw(struct clk_hw *hw)
 {
@@ -173,6 +177,27 @@ static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
+int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
+			void *data)
+{
+	int ret;
+	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_nb(nb);
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
+		break;
+	case POST_RATE_CHANGE:
+		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, PLL_INDEX);
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	return notifier_from_errno(ret);
+};
+
 const struct clk_ops clk_cpu_8996_mux_ops = {
 	.set_parent = clk_cpu_8996_mux_set_parent,
 	.get_parent = clk_cpu_8996_mux_get_parent,
@@ -216,6 +241,7 @@ static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
 	.shift = 0,
 	.width = 2,
 	.pll = &pwrcl_pll.clkr.hw,
+	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "pwrcl_pmux",
 		.parent_names = (const char *[]){
@@ -235,6 +261,7 @@ static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
 	.shift = 0,
 	.width = 2,
 	.pll = &perfcl_pll.clkr.hw,
+	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "perfcl_pmux",
 		.parent_names = (const char *[]){
@@ -310,6 +337,14 @@ struct clk_hw_clks {
 	clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
 	clk_alpha_pll_configure(&pwrcl_alt_pll, regmap, &altpll_config);
 
+	ret = clk_notifier_register(pwrcl_pmux.clkr.hw.clk, &pwrcl_pmux.nb);
+	if (ret)
+		return ret;
+
+	ret = clk_notifier_register(perfcl_pmux.clkr.hw.clk, &perfcl_pmux.nb);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
-- 
1.9.1
