From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 12 Mar 2018 16:59:25 +0200
Subject: [PATCH] clk: imx6ull: Add epdc_podf instead of sim_podf
Message-ID: <64c4bc079a59002931a92e00b38b455d957ce169.1520866479.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is one of the differences between 6ul and 6ull: imx6ull has no sim
but has epdc and this clock is redefined on the same bit.

This can be verified in the Reference Manuals.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/clk/imx/clk-imx6ul.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 85c1181..114ecbb 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -308,7 +308,10 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_SAI2_PODF]	= imx_clk_divider("sai2_podf",	   "sai2_pred",		base + 0x2c, 0,  6);
 	clks[IMX6UL_CLK_SPDIF_PRED]	= imx_clk_divider("spdif_pred",	   "spdif_sel",		base + 0x30, 25, 3);
 	clks[IMX6UL_CLK_SPDIF_PODF]	= imx_clk_divider("spdif_podf",	   "spdif_pred",	base + 0x30, 22, 3);
-	clks[IMX6UL_CLK_SIM_PODF]	= imx_clk_divider("sim_podf",	   "sim_pre_sel",	base + 0x34, 12, 3);
+	if (clk_on_imx6ul())
+		clks[IMX6UL_CLK_SIM_PODF]	= imx_clk_divider("sim_podf",	   "sim_pre_sel",	base + 0x34, 12, 3);
+	else if (clk_on_imx6ull())
+		clks[IMX6ULL_CLK_EPDC_PODF]	= imx_clk_divider("epdc_podf",	   "epdc_pre_sel",	base + 0x34, 12, 3);
 	clks[IMX6UL_CLK_ECSPI_PODF]	= imx_clk_divider("ecspi_podf",	   "ecspi_sel",		base + 0x38, 19, 6);
 	clks[IMX6UL_CLK_LCDIF_PRED]	= imx_clk_divider("lcdif_pred",	   "lcdif_pre_sel",	base + 0x38, 12, 3);
 	clks[IMX6UL_CLK_CSI_PODF]       = imx_clk_divider("csi_podf",      "csi_sel",           base + 0x3c, 11, 3);
-- 
2.7.4
