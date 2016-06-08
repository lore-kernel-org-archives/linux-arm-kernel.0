From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 8 Jun 2016 22:33:40 +0800
Subject: [PATCH 11/11] clk: imx7d: fix pll clock parents
In-Reply-To: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
References: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1465396420-27064-11-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pllx_bypass_src mux shouldn't be the parent of pllx clock
since it's only valid when when pllx BYPASS bit is set.
Thus it is actually one parent of pllx_bypass only.

Instead, pllx parent should be fixed to osc according to
reference manual.
Other plls have the same issue.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index dc8c3355a66d..738a5289b378 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -394,12 +394,12 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_PLL_AUDIO_MAIN_SRC] = imx_clk_mux("pll_audio_main_src", base + 0xf0, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
 	clks[IMX7D_PLL_VIDEO_MAIN_SRC] = imx_clk_mux("pll_video_main_src", base + 0x130, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
 
-	clks[IMX7D_PLL_ARM_MAIN]  = imx_clk_pllv3(IMX_PLLV3_SYS, "pll_arm_main", "pll_arm_main_src", base + 0x60, 0x7f);
-	clks[IMX7D_PLL_DRAM_MAIN] = imx_clk_pllv3(IMX_PLLV3_AV, "pll_dram_main", "pll_dram_main_src", base + 0x70, 0x7f);
-	clks[IMX7D_PLL_SYS_MAIN]  = imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll_sys_main", "pll_sys_main_src", base + 0xb0, 0x1);
-	clks[IMX7D_PLL_ENET_MAIN] = imx_clk_pllv3(IMX_PLLV3_ENET_IMX7, "pll_enet_main", "pll_enet_main_src", base + 0xe0, 0x0);
-	clks[IMX7D_PLL_AUDIO_MAIN] = imx_clk_pllv3(IMX_PLLV3_AV, "pll_audio_main", "pll_audio_main_src", base + 0xf0, 0x7f);
-	clks[IMX7D_PLL_VIDEO_MAIN] = imx_clk_pllv3(IMX_PLLV3_AV, "pll_video_main", "pll_video_main_src", base + 0x130, 0x7f);
+	clks[IMX7D_PLL_ARM_MAIN]  = imx_clk_pllv3(IMX_PLLV3_SYS, "pll_arm_main", "osc", base + 0x60, 0x7f);
+	clks[IMX7D_PLL_DRAM_MAIN] = imx_clk_pllv3(IMX_PLLV3_AV, "pll_dram_main", "osc", base + 0x70, 0x7f);
+	clks[IMX7D_PLL_SYS_MAIN]  = imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll_sys_main", "osc", base + 0xb0, 0x1);
+	clks[IMX7D_PLL_ENET_MAIN] = imx_clk_pllv3(IMX_PLLV3_ENET_IMX7, "pll_enet_main", "osc", base + 0xe0, 0x0);
+	clks[IMX7D_PLL_AUDIO_MAIN] = imx_clk_pllv3(IMX_PLLV3_AV, "pll_audio_main", "osc", base + 0xf0, 0x7f);
+	clks[IMX7D_PLL_VIDEO_MAIN] = imx_clk_pllv3(IMX_PLLV3_AV, "pll_video_main", "osc", base + 0x130, 0x7f);
 
 	clks[IMX7D_PLL_ARM_MAIN_BYPASS]  = imx_clk_mux_flags("pll_arm_main_bypass", base + 0x60, 16, 1, pll_arm_bypass_sel, ARRAY_SIZE(pll_arm_bypass_sel), CLK_SET_RATE_PARENT);
 	clks[IMX7D_PLL_DRAM_MAIN_BYPASS] = imx_clk_mux_flags("pll_dram_main_bypass", base + 0x70, 16, 1, pll_dram_bypass_sel, ARRAY_SIZE(pll_dram_bypass_sel), CLK_SET_RATE_PARENT);
-- 
1.9.1
