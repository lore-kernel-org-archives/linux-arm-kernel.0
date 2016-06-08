From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 8 Jun 2016 22:33:36 +0800
Subject: [PATCH 07/11] clk: imx6ul: fix pll clock parents
In-Reply-To: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
References: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1465396420-27064-7-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pllx_bypass_src mux shouldn't be the parent of pllx clock
since it's only valid when when pllx BYPASS bit is set.
Thus it is actually one parent of pllx_bypass only.

Instead, pllx parent should be fixed to osc according to
reference manual.
Other plls have the same issue.

e.g. before fix, the pll tree is:
osc                                      6            6    24000000          0 0
   pll1_bypass_src                       0            0    24000000          0 0
      pll1                               0            0   792000000          0 0
         pll1_bypass                     0            0   792000000          0 0
            pll1_sys                     0            0   792000000          0 0

After the fix, it's:
osc                                      6            6    24000000          0 0
   pll1                                  0            0   792000000          0 0
      pll1_bypass                        0            0   792000000          0 0
         pll1_sys                        0            0   792000000          0 0

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-imx6ul.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 67ae3465dd37..bdf4cf807b78 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -130,13 +130,13 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_PLL6_BYPASS_SRC] = imx_clk_mux("pll6_bypass_src", base + 0xe0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
 	clks[IMX6UL_PLL7_BYPASS_SRC] = imx_clk_mux("pll7_bypass_src", base + 0x20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
 
-	clks[IMX6UL_CLK_PLL1] = imx_clk_pllv3(IMX_PLLV3_SYS,	 "pll1", "pll1_bypass_src", base + 0x00, 0x7f);
-	clks[IMX6UL_CLK_PLL2] = imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2", "pll2_bypass_src", base + 0x30, 0x1);
-	clks[IMX6UL_CLK_PLL3] = imx_clk_pllv3(IMX_PLLV3_USB,	 "pll3", "pll3_bypass_src", base + 0x10, 0x3);
-	clks[IMX6UL_CLK_PLL4] = imx_clk_pllv3(IMX_PLLV3_AV,	 "pll4", "pll4_bypass_src", base + 0x70, 0x7f);
-	clks[IMX6UL_CLK_PLL5] = imx_clk_pllv3(IMX_PLLV3_AV,	 "pll5", "pll5_bypass_src", base + 0xa0, 0x7f);
-	clks[IMX6UL_CLK_PLL6] = imx_clk_pllv3(IMX_PLLV3_ENET,	 "pll6", "pll6_bypass_src", base + 0xe0, 0x3);
-	clks[IMX6UL_CLK_PLL7] = imx_clk_pllv3(IMX_PLLV3_USB,	 "pll7", "pll7_bypass_src", base + 0x20, 0x3);
+	clks[IMX6UL_CLK_PLL1] = imx_clk_pllv3(IMX_PLLV3_SYS,	 "pll1", "osc", base + 0x00, 0x7f);
+	clks[IMX6UL_CLK_PLL2] = imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc", base + 0x30, 0x1);
+	clks[IMX6UL_CLK_PLL3] = imx_clk_pllv3(IMX_PLLV3_USB,	 "pll3", "osc", base + 0x10, 0x3);
+	clks[IMX6UL_CLK_PLL4] = imx_clk_pllv3(IMX_PLLV3_AV,	 "pll4", "osc", base + 0x70, 0x7f);
+	clks[IMX6UL_CLK_PLL5] = imx_clk_pllv3(IMX_PLLV3_AV,	 "pll5", "osc", base + 0xa0, 0x7f);
+	clks[IMX6UL_CLK_PLL6] = imx_clk_pllv3(IMX_PLLV3_ENET,	 "pll6", "osc", base + 0xe0, 0x3);
+	clks[IMX6UL_CLK_PLL7] = imx_clk_pllv3(IMX_PLLV3_USB,	 "pll7", "osc", base + 0x20, 0x3);
 
 	clks[IMX6UL_PLL1_BYPASS] = imx_clk_mux_flags("pll1_bypass", base + 0x00, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PARENT);
 	clks[IMX6UL_PLL2_BYPASS] = imx_clk_mux_flags("pll2_bypass", base + 0x30, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PARENT);
-- 
1.9.1
