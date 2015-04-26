From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:08 +0800
Subject: [PATCH 07/11] ARM: imx6: do not use cpu_is_xxx() in clock driver
In-Reply-To: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1430058672-9267-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're about to move clock drivers out of arch/arm/mach-imx,
cpu_is_xxx() shouldn't be used any more.  Let's avoid the call by
looking at the device tree machine compatible string to determine
which SoC the clock driver is running on.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 5e88038ad51c..d0135c62d21a 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -121,6 +121,16 @@ static unsigned int share_count_ssi2;
 static unsigned int share_count_ssi3;
 static unsigned int share_count_mipi_core_cfg;
 
+static inline int clk_on_imx6q(void)
+{
+	return of_machine_is_compatible("fsl,imx6q");
+}
+
+static inline int clk_on_imx6dl(void)
+{
+	return of_machine_is_compatible("fsl,imx6dl");
+}
+
 static void __init imx6q_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -141,7 +151,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	WARN_ON(!base);
 
 	/* Audio/video PLL post dividers do not work on i.MX6q revision 1.0 */
-	if (cpu_is_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0) {
+	if (clk_on_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0) {
 		post_div_table[1].div = 1;
 		post_div_table[2].div = 1;
 		video_div_table[1].div = 1;
@@ -248,7 +258,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_TWD]       = imx_clk_fixed_factor("twd",       "arm",            1, 2);
 	clk[IMX6QDL_CLK_GPT_3M]    = imx_clk_fixed_factor("gpt_3m",    "osc",            1, 8);
 	clk[IMX6QDL_CLK_VIDEO_27M] = imx_clk_fixed_factor("video_27m", "pll3_pfd1_540m", 1, 20);
-	if (cpu_is_imx6dl()) {
+	if (clk_on_imx6dl()) {
 		clk[IMX6QDL_CLK_GPU2D_AXI] = imx_clk_fixed_factor("gpu2d_axi", "mmdc_ch0_axi_podf", 1, 1);
 		clk[IMX6QDL_CLK_GPU3D_AXI] = imx_clk_fixed_factor("gpu3d_axi", "mmdc_ch0_axi_podf", 1, 1);
 	}
@@ -273,7 +283,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_ESAI_SEL]         = imx_clk_mux("esai_sel",         base + 0x20, 19, 2, audio_sels,        ARRAY_SIZE(audio_sels));
 	clk[IMX6QDL_CLK_ASRC_SEL]         = imx_clk_mux("asrc_sel",         base + 0x30, 7,  2, audio_sels,        ARRAY_SIZE(audio_sels));
 	clk[IMX6QDL_CLK_SPDIF_SEL]        = imx_clk_mux("spdif_sel",        base + 0x30, 20, 2, audio_sels,        ARRAY_SIZE(audio_sels));
-	if (cpu_is_imx6q()) {
+	if (clk_on_imx6q()) {
 		clk[IMX6QDL_CLK_GPU2D_AXI]        = imx_clk_mux("gpu2d_axi",        base + 0x18, 0,  1, gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
 		clk[IMX6QDL_CLK_GPU3D_AXI]        = imx_clk_mux("gpu3d_axi",        base + 0x18, 1,  1, gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
 	}
@@ -380,7 +390,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_ECSPI2]       = imx_clk_gate2("ecspi2",        "ecspi_root",        base + 0x6c, 2);
 	clk[IMX6QDL_CLK_ECSPI3]       = imx_clk_gate2("ecspi3",        "ecspi_root",        base + 0x6c, 4);
 	clk[IMX6QDL_CLK_ECSPI4]       = imx_clk_gate2("ecspi4",        "ecspi_root",        base + 0x6c, 6);
-	if (cpu_is_imx6dl())
+	if (clk_on_imx6dl())
 		clk[IMX6DL_CLK_I2C4]  = imx_clk_gate2("i2c4",          "ipg_per",           base + 0x6c, 8);
 	else
 		clk[IMX6Q_CLK_ECSPI5] = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
@@ -390,7 +400,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem", "ahb",             base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_GPT_IPG]      = imx_clk_gate2("gpt_ipg",       "ipg",               base + 0x6c, 20);
 	clk[IMX6QDL_CLK_GPT_IPG_PER]  = imx_clk_gate2("gpt_ipg_per",   "ipg_per",           base + 0x6c, 22);
-	if (cpu_is_imx6dl())
+	if (clk_on_imx6dl())
 		/*
 		 * The multiplexer and divider of imx6q clock gpu3d_shader get
 		 * redefined/reused as gpu2d_core_sel and gpu2d_core_podf on imx6dl.
@@ -418,7 +428,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_HSI_TX]       = imx_clk_gate2_shared("hsi_tx", "hsi_tx_podf",       base + 0x74, 16, &share_count_mipi_core_cfg);
 	clk[IMX6QDL_CLK_MIPI_CORE_CFG] = imx_clk_gate2_shared("mipi_core_cfg", "video_27m", base + 0x74, 16, &share_count_mipi_core_cfg);
 	clk[IMX6QDL_CLK_MIPI_IPG]     = imx_clk_gate2_shared("mipi_ipg", "ipg",             base + 0x74, 16, &share_count_mipi_core_cfg);
-	if (cpu_is_imx6dl())
+	if (clk_on_imx6dl())
 		/*
 		 * The multiplexer and divider of the imx6q clock gpu2d get
 		 * redefined/reused as mlb_sys_sel and mlb_sys_clk_podf on imx6dl.
@@ -468,7 +478,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	 * The gpt_3m clock is not available on i.MX6Q TO1.0.  Let's point it
 	 * to clock gpt_ipg_per to ease the gpt driver code.
 	 */
-	if (cpu_is_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0)
+	if (clk_on_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0)
 		clk[IMX6QDL_CLK_GPT_3M] = clk[IMX6QDL_CLK_GPT_IPG_PER];
 
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
@@ -480,7 +490,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk_register_clkdev(clk[IMX6QDL_CLK_ENET_REF], "enet_ref", NULL);
 
 	if ((imx_get_soc_revision() != IMX_CHIP_REVISION_1_0) ||
-	    cpu_is_imx6dl()) {
+	    clk_on_imx6dl()) {
 		clk_set_parent(clk[IMX6QDL_CLK_LDB_DI0_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
 		clk_set_parent(clk[IMX6QDL_CLK_LDB_DI1_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
 	}
-- 
1.9.1
