From: agross@codeaurora.org (Andy Gross)
Date: Sun, 14 Sep 2014 23:12:12 -0500
Subject: [PATCH] clk: qcom: Add IPQ8064 PLL required for USB
Message-ID: <1410754332-26699-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PLL0 that is required for the USB clocks to work properly.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/clk/qcom/gcc-ipq806x.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 4032e51..21f9187 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -32,6 +32,33 @@
 #include "clk-branch.h"
 #include "reset.h"
 
+static struct clk_pll pll0 = {
+	.l_reg = 0x30c4,
+	.m_reg = 0x30c8,
+	.n_reg = 0x30cc,
+	.config_reg = 0x30d4,
+	.mode_reg = 0x30c0,
+	.status_reg = 0x30d8,
+	.status_bit = 16,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pll0",
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.ops = &clk_pll_ops,
+	},
+};
+
+static struct clk_regmap pll0_vote = {
+	.enable_reg = 0x34c0,
+	.enable_mask = BIT(0),
+	.hw.init = &(struct clk_init_data){
+		.name = "pll0_vote",
+		.parent_names = (const char *[]){ "pll0" },
+		.num_parents = 1,
+		.ops = &clk_pll_vote_ops,
+	},
+};
+
 static struct clk_pll pll3 = {
 	.l_reg = 0x3164,
 	.m_reg = 0x3168,
@@ -155,6 +182,7 @@ static const char *gcc_pxo_pll8_pll0_map[] = {
 	"pxo",
 	"pll8_vote",
 	"pll0",
+	"pll0_vote",
 };
 
 static struct freq_tbl clk_tbl_gsbi_uart[] = {
@@ -2133,6 +2161,8 @@ static struct clk_branch usb_fs1_h_clk = {
 };
 
 static struct clk_regmap *gcc_ipq806x_clks[] = {
+	[PLL0] = &pll0.clkr,
+	[PLL0_VOTE] = &pll0_vote,
 	[PLL3] = &pll3.clkr,
 	[PLL8] = &pll8.clkr,
 	[PLL8_VOTE] = &pll8_vote,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
