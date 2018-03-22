From: abel.vesa@nxp.com (Abel Vesa)
Date: Thu, 22 Mar 2018 11:55:27 +0200
Subject: [PATCH 2/4] arm: imx: Correct dram pll type
In-Reply-To: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <1521712529-632-3-git-send-email-abel.vesa@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anson Huang <anson.huang@nxp.com>

DRAM PLL is a audio/video type PLL, need to correct it to get correct ops of
PLL.

There is a test_div placed before DRAM PLL's gate, so add this test div clk.

Signed-off-by: Anson Huang <anson.huang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 97 ++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 80dc211..d786f98 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -51,20 +51,20 @@ static const char *arm_a7_sel[] = { "osc", "pll_arm_main_clk",
 
 static const char *arm_m4_sel[] = { "osc", "pll_sys_main_240m_clk",
 	"pll_enet_250m_clk", "pll_sys_pfd2_270m_clk",
-	"pll_dram_533m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_dram_533m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"pll_usb_main_clk", };
 
 static const char *axi_sel[] = { "osc", "pll_sys_pfd1_332m_clk",
 	"pll_dram_533m_clk", "pll_enet_250m_clk", "pll_sys_pfd5_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_sys_pfd7_clk", };
+	"pll_audio_post_div", "pll_video_post_div", "pll_sys_pfd7_clk", };
 
 static const char *disp_axi_sel[] = { "osc", "pll_sys_pfd1_332m_clk",
 	"pll_dram_533m_clk", "pll_enet_250m_clk", "pll_sys_pfd6_clk",
-	"pll_sys_pfd7_clk", "pll_audio_post_div", "pll_video_main_clk", };
+	"pll_sys_pfd7_clk", "pll_audio_post_div", "pll_video_post_div", };
 
 static const char *enet_axi_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 	"pll_dram_533m_clk", "pll_enet_250m_clk",
-	"pll_sys_main_240m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_sys_main_240m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"pll_sys_pfd4_clk", };
 
 static const char *nand_usdhc_bus_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
@@ -75,7 +75,7 @@ static const char *nand_usdhc_bus_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 static const char *ahb_channel_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 	"pll_dram_533m_clk", "pll_sys_pfd0_392m_clk",
 	"pll_enet_125m_clk", "pll_usb_main_clk", "pll_audio_post_div",
-	"pll_video_main_clk", };
+	"pll_video_post_div", };
 
 static const char *dram_phym_sel[] = { "pll_dram_main_clk",
 	"dram_phym_alt_clk", };
@@ -86,7 +86,7 @@ static const char *dram_sel[] = { "pll_dram_main_clk",
 static const char *dram_phym_alt_sel[] = { "osc", "pll_dram_533m_clk",
 	"pll_sys_main_clk", "pll_enet_500m_clk",
 	"pll_usb_main_clk", "pll_sys_pfd7_clk", "pll_audio_post_div",
-	"pll_video_main_clk", };
+	"pll_video_post_div", };
 
 static const char *dram_alt_sel[] = { "osc", "pll_dram_533m_clk",
 	"pll_sys_main_clk", "pll_enet_500m_clk",
@@ -108,62 +108,62 @@ static const char *pcie_phy_sel[] = { "osc", "pll_enet_100m_clk",
 
 static const char *epdc_pixel_sel[] = { "osc", "pll_sys_pfd1_332m_clk",
 	"pll_dram_533m_clk", "pll_sys_main_clk", "pll_sys_pfd5_clk",
-	"pll_sys_pfd6_clk", "pll_sys_pfd7_clk", "pll_video_main_clk", };
+	"pll_sys_pfd6_clk", "pll_sys_pfd7_clk", "pll_video_post_div", };
 
 static const char *lcdif_pixel_sel[] = { "osc", "pll_sys_pfd5_clk",
 	"pll_dram_533m_clk", "ext_clk_3", "pll_sys_pfd4_clk",
-	"pll_sys_pfd2_270m_clk", "pll_video_main_clk",
+	"pll_sys_pfd2_270m_clk", "pll_video_post_div",
 	"pll_usb_main_clk", };
 
 static const char *mipi_dsi_sel[] = { "osc", "pll_sys_pfd5_clk",
 	"pll_sys_pfd3_clk", "pll_sys_main_clk", "pll_sys_pfd0_196m_clk",
-	"pll_dram_533m_clk", "pll_video_main_clk", "pll_audio_post_div", };
+	"pll_dram_533m_clk", "pll_video_post_div", "pll_audio_post_div", };
 
 static const char *mipi_csi_sel[] = { "osc", "pll_sys_pfd4_clk",
 	"pll_sys_pfd3_clk", "pll_sys_main_clk", "pll_sys_pfd0_196m_clk",
-	"pll_dram_533m_clk", "pll_video_main_clk", "pll_audio_post_div", };
+	"pll_dram_533m_clk", "pll_video_post_div", "pll_audio_post_div", };
 
 static const char *mipi_dphy_sel[] = { "osc", "pll_sys_main_120m_clk",
 	"pll_dram_533m_clk", "pll_sys_pfd5_clk", "ref_1m_clk", "ext_clk_2",
-	"pll_video_main_clk", "ext_clk_3", };
+	"pll_video_post_div", "ext_clk_3", };
 
 static const char *sai1_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
-	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_main_clk",
+	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_post_div",
 	"pll_sys_pfd4_clk", "pll_enet_125m_clk", "ext_clk_2", };
 
 static const char *sai2_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
-	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_main_clk",
+	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_post_div",
 	"pll_sys_pfd4_clk", "pll_enet_125m_clk", "ext_clk_2", };
 
 static const char *sai3_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
-	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_main_clk",
+	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_post_div",
 	"pll_sys_pfd4_clk", "pll_enet_125m_clk", "ext_clk_3", };
 
 static const char *spdif_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
-	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_main_clk",
+	"pll_audio_post_div", "pll_dram_533m_clk", "pll_video_post_div",
 	"pll_sys_pfd4_clk", "pll_enet_125m_clk", "ext_3_clk", };
 
 static const char *enet1_ref_sel[] = { "osc", "pll_enet_125m_clk",
 	"pll_enet_50m_clk", "pll_enet_25m_clk",
-	"pll_sys_main_120m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_sys_main_120m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"ext_clk_4", };
 
 static const char *enet1_time_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_audio_post_div", "ext_clk_1", "ext_clk_2", "ext_clk_3",
-	"ext_clk_4", "pll_video_main_clk", };
+	"ext_clk_4", "pll_video_post_div", };
 
 static const char *enet2_ref_sel[] = { "osc", "pll_enet_125m_clk",
 	"pll_enet_50m_clk", "pll_enet_25m_clk",
-	"pll_sys_main_120m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_sys_main_120m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"ext_clk_4", };
 
 static const char *enet2_time_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_audio_post_div", "ext_clk_1", "ext_clk_2", "ext_clk_3",
-	"ext_clk_4", "pll_video_main_clk", };
+	"ext_clk_4", "pll_video_post_div", };
 
 static const char *enet_phy_ref_sel[] = { "osc", "pll_enet_25m_clk",
 	"pll_enet_50m_clk", "pll_enet_125m_clk",
-	"pll_dram_533m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_dram_533m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"pll_sys_pfd3_clk", };
 
 static const char *eim_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
@@ -174,7 +174,7 @@ static const char *eim_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 static const char *nand_sel[] = { "osc", "pll_sys_main_clk",
 	"pll_dram_533m_clk", "pll_sys_pfd0_392m_clk", "pll_sys_pfd3_clk",
 	"pll_enet_500m_clk", "pll_enet_250m_clk",
-	"pll_video_main_clk", };
+	"pll_video_post_div", };
 
 static const char *qspi_sel[] = { "osc", "pll_sys_pfd4_clk",
 	"pll_dram_533m_clk", "pll_enet_500m_clk", "pll_sys_pfd3_clk",
@@ -204,22 +204,22 @@ static const char *can2_sel[] = { "osc", "pll_sys_main_120m_clk",
 
 static const char *i2c1_sel[] = { "osc", "pll_sys_main_120m_clk",
 	"pll_enet_50m_clk", "pll_dram_533m_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_usb_main_clk",
+	"pll_audio_post_div", "pll_video_post_div", "pll_usb_main_clk",
 	"pll_sys_pfd2_135m_clk", };
 
 static const char *i2c2_sel[] = { "osc", "pll_sys_main_120m_clk",
 	"pll_enet_50m_clk", "pll_dram_533m_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_usb_main_clk",
+	"pll_audio_post_div", "pll_video_post_div", "pll_usb_main_clk",
 	"pll_sys_pfd2_135m_clk", };
 
 static const char *i2c3_sel[] = { "osc", "pll_sys_main_120m_clk",
 	"pll_enet_50m_clk", "pll_dram_533m_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_usb_main_clk",
+	"pll_audio_post_div", "pll_video_post_div", "pll_usb_main_clk",
 	"pll_sys_pfd2_135m_clk", };
 
 static const char *i2c4_sel[] = { "osc", "pll_sys_main_120m_clk",
 	"pll_enet_50m_clk", "pll_dram_533m_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_usb_main_clk",
+	"pll_audio_post_div", "pll_video_post_div", "pll_usb_main_clk",
 	"pll_sys_pfd2_135m_clk", };
 
 static const char *uart1_sel[] = { "osc", "pll_sys_main_240m_clk",
@@ -279,27 +279,27 @@ static const char *ecspi4_sel[] = { "osc", "pll_sys_main_240m_clk",
 
 static const char *pwm1_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_1", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_1", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *pwm2_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_1", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_1", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *pwm3_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_2", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_2", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *pwm4_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_2", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_2", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *flextimer1_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_3", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_3", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *flextimer2_sel[] = { "osc", "pll_enet_100m_clk",
 	"pll_sys_main_120m_clk", "pll_enet_40m_clk", "pll_audio_post_div",
-	"ext_clk_3", "ref_1m_clk", "pll_video_main_clk", };
+	"ext_clk_3", "ref_1m_clk", "pll_video_post_div", };
 
 static const char *sim1_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 	"pll_sys_main_120m_clk", "pll_dram_533m_clk",
@@ -308,23 +308,23 @@ static const char *sim1_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 
 static const char *sim2_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 	"pll_sys_main_120m_clk", "pll_dram_533m_clk",
-	"pll_usb_main_clk", "pll_video_main_clk", "pll_enet_125m_clk",
+	"pll_usb_main_clk", "pll_video_post_div", "pll_enet_125m_clk",
 	"pll_sys_pfd7_clk", };
 
 static const char *gpt1_sel[] = { "osc", "pll_enet_100m_clk",
-	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_main_clk",
+	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_post_div",
 	"ref_1m_clk", "pll_audio_post_div", "ext_clk_1", };
 
 static const char *gpt2_sel[] = { "osc", "pll_enet_100m_clk",
-	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_main_clk",
+	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_post_div",
 	"ref_1m_clk", "pll_audio_post_div", "ext_clk_2", };
 
 static const char *gpt3_sel[] = { "osc", "pll_enet_100m_clk",
-	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_main_clk",
+	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_post_div",
 	"ref_1m_clk", "pll_audio_post_div", "ext_clk_3", };
 
 static const char *gpt4_sel[] = { "osc", "pll_enet_100m_clk",
-	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_main_clk",
+	"pll_sys_pfd0_392m_clk", "pll_enet_40m_clk", "pll_video_post_div",
 	"ref_1m_clk", "pll_audio_post_div", "ext_clk_4", };
 
 static const char *trace_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
@@ -339,12 +339,12 @@ static const char *wdog_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 
 static const char *csi_mclk_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 	"pll_sys_main_120m_clk", "pll_dram_533m_clk",
-	"pll_enet_125m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_enet_125m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"pll_usb_main_clk", };
 
 static const char *audio_mclk_sel[] = { "osc", "pll_sys_pfd2_135m_clk",
 	"pll_sys_main_120m_clk", "pll_dram_533m_clk",
-	"pll_enet_125m_clk", "pll_audio_post_div", "pll_video_main_clk",
+	"pll_enet_125m_clk", "pll_audio_post_div", "pll_video_post_div",
 	"pll_usb_main_clk", };
 
 static const char *wrclk_sel[] = { "osc", "pll_enet_40m_clk",
@@ -358,13 +358,13 @@ static const char *clko1_sel[] = { "osc", "pll_sys_main_clk",
 
 static const char *clko2_sel[] = { "osc", "pll_sys_main_240m_clk",
 	"pll_sys_pfd0_392m_clk", "pll_sys_pfd1_166m_clk", "pll_sys_pfd4_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "ckil", };
+	"pll_audio_post_div", "pll_video_post_div", "ckil", };
 
 static const char *lvds1_sel[] = { "pll_arm_main_clk",
 	"pll_sys_main_clk", "pll_sys_pfd0_392m_clk", "pll_sys_pfd1_332m_clk",
 	"pll_sys_pfd2_270m_clk", "pll_sys_pfd3_clk", "pll_sys_pfd4_clk",
 	"pll_sys_pfd5_clk", "pll_sys_pfd6_clk", "pll_sys_pfd7_clk",
-	"pll_audio_post_div", "pll_video_main_clk", "pll_enet_500m_clk",
+	"pll_audio_post_div", "pll_video_post_div", "pll_enet_500m_clk",
 	"pll_enet_250m_clk", "pll_enet_125m_clk", "pll_enet_100m_clk",
 	"pll_enet_50m_clk", "pll_enet_40m_clk", "pll_enet_25m_clk",
 	"pll_dram_main_clk", };
@@ -441,15 +441,22 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
 
 	clks[IMX7D_PLL_ARM_MAIN_CLK] = imx_clk_gate("pll_arm_main_clk", "pll_arm_main_bypass", base + 0x60, 13);
-	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_main_bypass", base + 0x70, 13);
+	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_test_div", base + 0x70, 13);
 	clks[IMX7D_PLL_SYS_MAIN_CLK] = imx_clk_gate("pll_sys_main_clk", "pll_sys_main_bypass", base + 0xb0, 13);
-	clks[IMX7D_PLL_AUDIO_MAIN_CLK] = imx_clk_gate("pll_audio_main_clk", "pll_audio_main_bypass", base + 0xf0, 13);
-	clks[IMX7D_PLL_VIDEO_MAIN_CLK] = imx_clk_gate("pll_video_main_clk", "pll_video_main_bypass", base + 0x130, 13);
+	clks[IMX7D_PLL_AUDIO_MAIN_CLK] = imx_clk_gate("pll_audio_main_clk", "pll_audio_test_div", base + 0xf0, 13);
+	clks[IMX7D_PLL_VIDEO_MAIN_CLK] = imx_clk_gate("pll_video_main_clk", "pll_video_test_div", base + 0x130, 13);
 
-	clks[IMX7D_PLL_AUDIO_TEST_DIV]  = clk_register_divider_table(NULL, "pll_audio_test_div", "pll_audio_main_clk",
+	clks[IMX7D_PLL_DRAM_TEST_DIV]  = clk_register_divider_table(NULL, "pll_dram_test_div", "pll_dram_main_bypass",
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x70, 21, 2, 0, test_div_table, &imx_ccm_lock);
+	clks[IMX7D_PLL_AUDIO_TEST_DIV]  = clk_register_divider_table(NULL, "pll_audio_test_div", "pll_audio_main_bypass",
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0xf0, 19, 2, 0, test_div_table, &imx_ccm_lock);
-	clks[IMX7D_PLL_AUDIO_POST_DIV] = clk_register_divider_table(NULL, "pll_audio_post_div", "pll_audio_test_div",
+	clks[IMX7D_PLL_AUDIO_POST_DIV] = clk_register_divider_table(NULL, "pll_audio_post_div", "pll_audio_main_clk",
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0xf0, 22, 2, 0, post_div_table, &imx_ccm_lock);
+	clks[IMX7D_PLL_VIDEO_TEST_DIV]  = clk_register_divider_table(NULL, "pll_video_test_div", "pll_video_main_bypass",
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x130, 19, 2, 0, test_div_table, &imx_ccm_lock);
+	clks[IMX7D_PLL_VIDEO_POST_DIV] = clk_register_divider_table(NULL, "pll_video_post_div", "pll_video_main_clk",
+				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x130, 22, 2, 0, post_div_table, &imx_ccm_lock);
+
 
 	clks[IMX7D_PLL_SYS_PFD0_392M_CLK] = imx_clk_pfd("pll_sys_pfd0_392m_clk", "pll_sys_main_clk", base + 0xc0, 0);
 	clks[IMX7D_PLL_SYS_PFD1_332M_CLK] = imx_clk_pfd("pll_sys_pfd1_332m_clk", "pll_sys_main_clk", base + 0xc0, 1);
-- 
2.7.4
