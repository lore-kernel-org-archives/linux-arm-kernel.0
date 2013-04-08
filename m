From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 16:46:23 +0200
Subject: [PATCH 5/5] ARM i.MX53: set CLK_SET_RATE_PARENT flag on the
 tve_ext_sel clock
In-Reply-To: <1365432383-7787-1-git-send-email-p.zabel@pengutronix.de>
References: <1365432383-7787-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1365432383-7787-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use imx_clk_mux_flags to set the appropriate flags for the TVE
selector clock. This is needed so tve_clk rate changes can propagate
up to pll4_sw.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 189d654..6fc486b 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -362,8 +362,8 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 				mx51_ipu_di0_sel, ARRAY_SIZE(mx51_ipu_di0_sel));
 	clk[ipu_di1_sel] = imx_clk_mux("ipu_di1_sel", MXC_CCM_CSCMR2, 29, 3,
 				mx51_ipu_di1_sel, ARRAY_SIZE(mx51_ipu_di1_sel));
-	clk[tve_ext_sel] = imx_clk_mux("tve_ext_sel", MXC_CCM_CSCMR1, 6, 1,
-				mx51_tve_ext_sel, ARRAY_SIZE(mx51_tve_ext_sel));
+	clk[tve_ext_sel] = imx_clk_mux_flags("tve_ext_sel", MXC_CCM_CSCMR1, 6, 1,
+				mx51_tve_ext_sel, ARRAY_SIZE(mx51_tve_ext_sel), CLK_SET_RATE_PARENT);
 	clk[tve_s] = imx_clk_mux("tve_sel", MXC_CCM_CSCMR1, 7, 1,
 				mx51_tve_sel, ARRAY_SIZE(mx51_tve_sel));
 	clk[tve_gate] = imx_clk_gate2("tve_gate", "tve_sel", MXC_CCM_CCGR2, 30);
-- 
1.8.2.rc2
