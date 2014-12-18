From: agross@codeaurora.org (Andy Gross)
Date: Thu, 18 Dec 2014 14:59:55 -0600
Subject: [PATCH 4/4] pinctrl: qcom: msm8960: Add multi copy support
In-Reply-To: <1418936395-14623-1-git-send-email-agross@codeaurora.org>
References: <1418936395-14623-1-git-send-email-agross@codeaurora.org>
Message-ID: <1418936395-14623-5-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds multiple copy support for functions that can be mapped to more
than one pin and that also require an additional mux configuration setting to
work properly.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../bindings/pinctrl/qcom,msm8960-pinctrl.txt      |   19 ++++++------
 drivers/pinctrl/qcom/pinctrl-msm8960.c             |   32 +++++++++++++++-----
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt
index eb8d8aa..c73ed5c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt
@@ -103,15 +103,16 @@ to specify in a pin configuration subnode:
 		    gsbi12, hdmi_cec, hdmi_ddc_clock, hdmi_ddc_data,
 		    hdmi_hot_plug_detect, hsic, mdp_vsync, mi2s, mic_i2s,
 		    pmb_clk, pmb_ext_ctrl, ps_hold, rpm_wdog, sdc2, sdc4, sdc5,
-		    slimbus1, slimbus2, spkr_i2s, ssbi1, ssbi2, ssbi_ext_gps,
-		    ssbi_pmic2, ssbi_qpa1, ssbi_ts, tsif1, tsif2, ts_eoc,
-		    usb_fs1, usb_fs1_oe, usb_fs1_oe_n, usb_fs2, usb_fs2_oe,
-		    usb_fs2_oe_n, vfe_camif_timer1_a, vfe_camif_timer1_b,
-		    vfe_camif_timer2, vfe_camif_timer3_a, vfe_camif_timer3_b,
-		    vfe_camif_timer4_a, vfe_camif_timer4_b, vfe_camif_timer4_c,
-		    vfe_camif_timer5_a, vfe_camif_timer5_b, vfe_camif_timer6_a,
-		    vfe_camif_timer6_b, vfe_camif_timer6_c, vfe_camif_timer7_a,
-		    vfe_camif_timer7_b, vfe_camif_timer7_c, wlan
+		    slimbus1_a, slimbus1_b, slimbus2, spkr_i2s, ssbi1, ssbi2,
+		    ssbi_ext_gps, ssbi_pmic2, ssbi_qpa1, ssbi_ts, tsif1, tsif2,
+		    ts_eoc, usb_fs1, usb_fs1_oe, usb_fs1_oe_n, usb_fs2,
+		    usb_fs2_oe, usb_fs2_oe_n, vfe_camif_timer1_a,
+		    vfe_camif_timer1_b, vfe_camif_timer2, vfe_camif_timer3_a,
+		    vfe_camif_timer3_b, vfe_camif_timer4_a, vfe_camif_timer4_b,
+		    vfe_camif_timer4_c, vfe_camif_timer5_a, vfe_camif_timer5_b,
+		    vfe_camif_timer6_a, vfe_camif_timer6_b, vfe_camif_timer6_c,
+		    vfe_camif_timer7_a, vfe_camif_timer7_b, vfe_camif_timer7_c,
+		    wlan
 
 - bias-disable:
 	Usage: optional
diff --git a/drivers/pinctrl/qcom/pinctrl-msm8960.c b/drivers/pinctrl/qcom/pinctrl-msm8960.c
index ed23e36..39e76b9 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8960.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8960.c
@@ -349,6 +349,16 @@ static const unsigned int sdc3_data_pins[] = { 157 };
 		.ngroups = ARRAY_SIZE(fname##_groups),	\
 	}
 
+#define FUNCTION_MULTI_COPY(fname, reg, value)		\
+	[MSM_MUX_##fname] = {				\
+		.name = #fname,				\
+		.groups = fname##_groups,		\
+		.ngroups = ARRAY_SIZE(fname##_groups),	\
+		.requires_copy_select = 1,		\
+		.copy_select_reg = reg,			\
+		.copy_select_value = value,		\
+	}
+
 #define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11) \
 	{						\
 		.name = "gpio" #id,			\
@@ -487,7 +497,8 @@ enum msm8960_functions {
 	MSM_MUX_sdc2,
 	MSM_MUX_sdc4,
 	MSM_MUX_sdc5,
-	MSM_MUX_slimbus1,
+	MSM_MUX_slimbus1_a,
+	MSM_MUX_slimbus1_b,
 	MSM_MUX_slimbus2,
 	MSM_MUX_spkr_i2s,
 	MSM_MUX_ssbi1,
@@ -824,8 +835,12 @@ static const char * const sdc5_groups[] = {
 	"gpio77", "gpio78", "gpio79", "gpio80", "gpio81", "gpio82"
 };
 
-static const char * const slimbus1_groups[] = {
-	"gpio50", "gpio51", "gpio60", "gpio61"
+static const char * const slimbus1_a_groups[] = {
+	"gpio60", "gpio61"
+};
+
+static const char * const slimbus1_b_groups[] = {
+	"gpio50", "gpio51",
 };
 
 static const char * const slimbus2_groups[] = {
@@ -1034,7 +1049,8 @@ static const struct msm_function msm8960_functions[] = {
 	FUNCTION(sdc2),
 	FUNCTION(sdc4),
 	FUNCTION(sdc5),
-	FUNCTION(slimbus1),
+	FUNCTION_MULTI_COPY(slimbus1_a, 0x2074, 0),
+	FUNCTION_MULTI_COPY(slimbus1_b, 0x2074, 1),
 	FUNCTION(slimbus2),
 	FUNCTION(spkr_i2s),
 	FUNCTION(ssbi1),
@@ -1122,8 +1138,8 @@ static const struct msm_pingroup msm8960_groups[] = {
 	PINGROUP(47, mi2s, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(48, mi2s, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(49, mi2s, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(50, mi2s, slimbus1, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(51, mi2s, slimbus1, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(50, mi2s, slimbus1_b, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(51, mi2s, slimbus1_b, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(52, mi2s, gp_clk_2a, gsbi2_spi_cs1_n, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(53, mi2s, gp_pdm_2b, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(54, codec_mic_i2s, gp_clk_0b, NA, NA, NA, NA, NA, NA, NA, NA, NA),
@@ -1132,8 +1148,8 @@ static const struct msm_pingroup msm8960_groups[] = {
 	PINGROUP(57, codec_mic_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(58, codec_mic_i2s, gp_pdm_0a, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(59, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(60, slimbus1, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(61, slimbus1, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(60, slimbus1_a, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(61, slimbus1_a, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(62, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(63, audio_pcm, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(64, audio_pcm, gp_pdm_1b, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-- 
Qualcomm Innovation Center, Inc
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
