From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 13 May 2014 20:04:21 +0400
Subject: [PATCH v2 1/3] ARM: i.MX1 clk: Add missing clocks
Message-ID: <1399997062-4270-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing clocks for mpll_gate, spll_gate, uart3_gate,
ssi2_gate and brom_gate. As an additional this fixes incorrect bit
position for dma_gate clock.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx1.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 15f9d22..602b30a 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -40,12 +40,14 @@
 #define SCM_GCCR	IO_ADDR_SCM(0xc)
 
 static const char *prem_sel_clks[] = { "clk32_premult", "clk16m", };
-static const char *clko_sel_clks[] = { "per1", "hclk", "clk48m", "clk16m", "prem",
-				"fclk", };
+static const char *clko_sel_clks[] = { "per1", "hclk", "clk48m", "clk16m",
+				       "prem", "fclk", };
+
 enum imx1_clks {
-	dummy, clk32, clk16m_ext, clk16m, clk32_premult, prem, mpll, spll, mcu,
-	fclk, hclk, clk48m, per1, per2, per3, clko, dma_gate, csi_gate,
-	mma_gate, usbd_gate, clk_max
+	dummy, clk32, clk16m_ext, clk16m, clk32_premult, prem, mpll, mpll_gate,
+	spll, spll_gate, mcu, fclk, hclk, clk48m, per1, per2, per3, clko,
+	uart3_gate, ssi2_gate, brom_gate, dma_gate, csi_gate, mma_gate,
+	usbd_gate, clk_max
 };
 
 static struct clk *clk[clk_max];
@@ -62,17 +64,22 @@ int __init mx1_clocks_init(unsigned long fref)
 	clk[prem] = imx_clk_mux("prem", CCM_CSCR, 16, 1, prem_sel_clks,
 			ARRAY_SIZE(prem_sel_clks));
 	clk[mpll] = imx_clk_pllv1("mpll", "clk32_premult", CCM_MPCTL0);
+	clk[mpll_gate] = imx_clk_gate("mpll_gate", "mpll", CCM_CSCR, 0);
 	clk[spll] = imx_clk_pllv1("spll", "prem", CCM_SPCTL0);
+	clk[spll_gate] = imx_clk_gate("spll_gate", "spll", CCM_CSCR, 1);
 	clk[mcu] = imx_clk_divider("mcu", "clk32_premult", CCM_CSCR, 15, 1);
-	clk[fclk] = imx_clk_divider("fclk", "mpll", CCM_CSCR, 15, 1);
-	clk[hclk] = imx_clk_divider("hclk", "spll", CCM_CSCR, 10, 4);
-	clk[clk48m] = imx_clk_divider("clk48m", "spll", CCM_CSCR, 26, 3);
-	clk[per1] = imx_clk_divider("per1", "spll", CCM_PCDR, 0, 4);
-	clk[per2] = imx_clk_divider("per2", "spll", CCM_PCDR, 4, 4);
-	clk[per3] = imx_clk_divider("per3", "spll", CCM_PCDR, 16, 7);
+	clk[fclk] = imx_clk_divider("fclk", "mpll_gate", CCM_CSCR, 15, 1);
+	clk[hclk] = imx_clk_divider("hclk", "spll_gate", CCM_CSCR, 10, 4);
+	clk[clk48m] = imx_clk_divider("clk48m", "spll_gate", CCM_CSCR, 26, 3);
+	clk[per1] = imx_clk_divider("per1", "spll_gate", CCM_PCDR, 0, 4);
+	clk[per2] = imx_clk_divider("per2", "spll_gate", CCM_PCDR, 4, 4);
+	clk[per3] = imx_clk_divider("per3", "spll_gate", CCM_PCDR, 16, 7);
 	clk[clko] = imx_clk_mux("clko", CCM_CSCR, 29, 3, clko_sel_clks,
 			ARRAY_SIZE(clko_sel_clks));
-	clk[dma_gate] = imx_clk_gate("dma_gate", "hclk", SCM_GCCR, 4);
+	clk[uart3_gate] = imx_clk_gate("uart3_gate", "hclk", SCM_GCCR, 6);
+	clk[ssi2_gate] = imx_clk_gate("ssi2_gate", "hclk", SCM_GCCR, 5);
+	clk[brom_gate] = imx_clk_gate("brom_gate", "hclk", SCM_GCCR, 4);
+	clk[dma_gate] = imx_clk_gate("dma_gate", "hclk", SCM_GCCR, 3);
 	clk[csi_gate] = imx_clk_gate("csi_gate", "hclk", SCM_GCCR, 2);
 	clk[mma_gate] = imx_clk_gate("mma_gate", "hclk", SCM_GCCR, 1);
 	clk[usbd_gate] = imx_clk_gate("usbd_gate", "clk48m", SCM_GCCR, 0);
@@ -94,7 +101,7 @@ int __init mx1_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[per1], "per", "imx1-uart.1");
 	clk_register_clkdev(clk[hclk], "ipg", "imx1-uart.1");
 	clk_register_clkdev(clk[per1], "per", "imx1-uart.2");
-	clk_register_clkdev(clk[hclk], "ipg", "imx1-uart.2");
+	clk_register_clkdev(clk[uart3_gate], "ipg", "imx1-uart.2");
 	clk_register_clkdev(clk[hclk], NULL, "imx1-i2c.0");
 	clk_register_clkdev(clk[per2], "per", "imx1-cspi.0");
 	clk_register_clkdev(clk[dummy], "ipg", "imx1-cspi.0");
-- 
1.8.3.2
