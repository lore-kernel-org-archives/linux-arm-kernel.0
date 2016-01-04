From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon,  4 Jan 2016 11:01:53 +0000
Subject: [PATCH v2] clk:gcc-msm8916: add missing mss_q6_bimc_axi clock
Message-ID: <1451905313-6461-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock is required for loading the qdsp firmware.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	fixed parent name as spotted by Georgi

 drivers/clk/qcom/gcc-msm8916.c               | 18 ++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8916.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.c
index e643944..89fe930 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -2590,6 +2590,23 @@ static struct clk_branch gcc_mss_cfg_ahb_clk = {
 	},
 };
 
+static struct clk_branch gcc_mss_q6_bimc_axi_clk = {
+	.halt_reg = 0x49004,
+	.clkr = {
+		.enable_reg = 0x49004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_q6_bimc_axi_clk",
+			.parent_names = (const char *[]){
+				"bimc_ddr_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_oxili_ahb_clk = {
 	.halt_reg = 0x59028,
 	.clkr = {
@@ -3228,6 +3245,7 @@ static struct clk_regmap *gcc_msm8916_clocks[] = {
 	[GCC_ULTAUDIO_LPAIF_SEC_I2S_CLK] = &gcc_ultaudio_lpaif_sec_i2s_clk.clkr,
 	[GCC_ULTAUDIO_LPAIF_AUX_I2S_CLK] = &gcc_ultaudio_lpaif_aux_i2s_clk.clkr,
 	[GCC_CODEC_DIGCODEC_CLK] = &gcc_codec_digcodec_clk.clkr,
+	[GCC_MSS_Q6_BIMC_AXI_CLK] = &gcc_mss_q6_bimc_axi_clk.clkr,
 };
 
 static struct gdsc *gcc_msm8916_gdscs[] = {
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8916.h b/include/dt-bindings/clock/qcom,gcc-msm8916.h
index 257e2fb..28a27a4 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8916.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8916.h
@@ -174,6 +174,7 @@
 #define GCC_ULTAUDIO_LPAIF_SEC_I2S_CLK		157
 #define GCC_ULTAUDIO_LPAIF_AUX_I2S_CLK		158
 #define GCC_CODEC_DIGCODEC_CLK			159
+#define GCC_MSS_Q6_BIMC_AXI_CLK			160
 
 /* Indexes for GDSCs */
 #define BIMC_GDSC				0
-- 
1.9.1
