From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 12 Oct 2017 15:29:35 +0200
Subject: [PATCH] clk: imx: clk-imx6ul: allow lcdif_pre_sel to change parent
 rate
Message-ID: <20171012132935.3508-1-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allowing the lcdif_pre_sel to propagate rate changes to its parent PLL
allows more fine grained control over the LCDIF pixel clock rate.

For example, the Innovision AT043TN24 LCD panel described in the
imx6ul-14x14-evk device tree requires a 9 MHz pixel clock.
Before this patch, the lcdif_pre_sel clock rate is fixed, and just
setting the lcdif_pred and lcdif_podf dividers only allows to get as
close as about 8.44 MHz:

    pll3                                  1            1   480000000 0 0
       pll3_bypass                        1            1   480000000 0 0
	  pll3_usb_otg                    1            1   480000000 0 0
	     pll3_pfd1_540m               1            1   540000000 0 0
		lcdif_pre_sel             1            1   540000000 0 0
		   lcdif_pred             1            1    67500000 0 0
		      lcdif_podf           1            1     8437500 0 0
			 lcdif_pix           1            1     8437500 0 0

Once lcdif_pre_sel is allowed to propagate rate requests to its parent,
the actual pixel clock matches the requested value:

    pll3                                  1            1   480000000 0 0
       pll3_bypass                        1            1   480000000 0 0
	  pll3_usb_otg                    1            1   480000000 0 0
	     pll3_pfd1_540m               1            1   288000000 0 0
		lcdif_pre_sel             1            1   288000000 0 0
		   lcdif_pred             1            1    36000000 0 0
		      lcdif_podf           1            1     9000000 0 0
                         lcdif_pix           1            1     9000000 0 0

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/clk/imx/clk-imx6ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 5e8c18afce9ad..85c1181644697 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -267,7 +267,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 		clks[IMX6ULL_CLK_EPDC_SEL]	  = imx_clk_mux("epdc_sel",	base + 0x34, 9, 3, epdc_sels, ARRAY_SIZE(epdc_sels));
 	}
 	clks[IMX6UL_CLK_ECSPI_SEL]	  = imx_clk_mux("ecspi_sel",	base + 0x38, 18, 1, ecspi_sels, ARRAY_SIZE(ecspi_sels));
-	clks[IMX6UL_CLK_LCDIF_PRE_SEL]	  = imx_clk_mux("lcdif_pre_sel", base + 0x38, 15, 3, lcdif_pre_sels, ARRAY_SIZE(lcdif_pre_sels));
+	clks[IMX6UL_CLK_LCDIF_PRE_SEL]	  = imx_clk_mux_flags("lcdif_pre_sel", base + 0x38, 15, 3, lcdif_pre_sels, ARRAY_SIZE(lcdif_pre_sels), CLK_SET_RATE_PARENT);
 	clks[IMX6UL_CLK_LCDIF_SEL]	  = imx_clk_mux("lcdif_sel",	base + 0x38, 9, 3, lcdif_sels, ARRAY_SIZE(lcdif_sels));
 
 	clks[IMX6UL_CLK_LDB_DI0_DIV_SEL]  = imx_clk_mux("ldb_di0", base + 0x20, 10, 1, ldb_di0_div_sels, ARRAY_SIZE(ldb_di0_div_sels));
-- 
2.11.0
