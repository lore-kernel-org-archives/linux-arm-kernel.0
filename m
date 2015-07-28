From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 28 Jul 2015 21:33:11 +0800
Subject: [PATCH 4/4] clk: imx7d: only enable minimum required clocks
In-Reply-To: <1438090391-30329-1-git-send-email-aisheng.dong@freescale.com>
References: <1438090391-30329-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1438090391-30329-5-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Formerly clk core does not support imx7d clock type well that all
its clock operations requires the parent clock on.
Therefore we enabled all clocks by default in clock driver
initialization for other module clocks operate well.

After patch 'clk: imx7d: using api with flag CLK_OPS_PARENT_ON',
clk core can handle such clock type well, so we don't have to enable
them all by default anymore. Instead, we only enable a minimum required
set of clocks.

BTW, clk_set_parent of plls clocks are also moved behind clks_init_on
that every clock operation should happen after the minimum clocks are
already enabled.

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/clk/imx/clk-imx7d.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 8b0b023..dc54622 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -361,6 +361,14 @@ static const char *pll_enet_bypass_sel[] = { "pll_enet_main", "pll_enet_main_src
 static const char *pll_audio_bypass_sel[] = { "pll_audio_main", "pll_audio_main_src", };
 static const char *pll_video_bypass_sel[] = { "pll_video_main", "pll_video_main_src", };
 
+static int const clks_init_on[] __initconst = {
+	IMX7D_ARM_A7_ROOT_CLK, IMX7D_MAIN_AXI_ROOT_CLK,
+	IMX7D_PLL_SYS_MAIN_480M_CLK, IMX7D_NAND_USDHC_BUS_ROOT_CLK,
+	IMX7D_DRAM_PHYM_ROOT_CLK, IMX7D_DRAM_ROOT_CLK,
+	IMX7D_DRAM_PHYM_ALT_ROOT_CLK, IMX7D_DRAM_ALT_ROOT_CLK,
+	IMX7D_AHB_CHANNEL_ROOT_CLK,
+};
+
 static struct clk_onecell_data clk_data;
 
 static void __init imx7d_clocks_init(struct device_node *ccm_node)
@@ -830,14 +838,8 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clk_data.clk_num = ARRAY_SIZE(clks);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
-	/* TO BE FIXED LATER
-	 * Enable all clock to bring up imx7, otherwise system will be halt and block
-	 * the other part upstream Because imx7d clock design changed, clock framework
-	 * need do a little modify.
-	 * Dong Aisheng is working on this. After that, this part need be changed.
-	 */
-	for (i = 0; i < IMX7D_CLK_END; i++)
-		clk_prepare_enable(clks[i]);
+	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
+		clk_prepare_enable(clks[clks_init_on[i]]);
 
 	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter freq */
 	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
-- 
1.9.1
