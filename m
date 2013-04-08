From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 16:46:21 +0200
Subject: [PATCH 3/5] ARM i.MX53: make tve_ext_sel propagate rate change to PLL
In-Reply-To: <1365432383-7787-1-git-send-email-p.zabel@pengutronix.de>
References: <1365432383-7787-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1365432383-7787-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed so the Television Encoder driver can set the rate
on tve_clk and have it propagated up to pll4_sw.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 890012e..9226940 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -469,8 +469,8 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 				mx53_ipu_di0_sel, ARRAY_SIZE(mx53_ipu_di0_sel));
 	clk[ipu_di1_sel] = imx_clk_mux("ipu_di1_sel", MXC_CCM_CSCMR2, 29, 3,
 				mx53_ipu_di1_sel, ARRAY_SIZE(mx53_ipu_di1_sel));
-	clk[tve_ext_sel] = imx_clk_mux("tve_ext_sel", MXC_CCM_CSCMR1, 6, 1,
-				mx53_tve_ext_sel, ARRAY_SIZE(mx53_tve_ext_sel));
+	clk[tve_ext_sel] = imx_clk_mux_flags("tve_ext_sel", MXC_CCM_CSCMR1, 6, 1,
+				mx53_tve_ext_sel, ARRAY_SIZE(mx53_tve_ext_sel), CLK_SET_RATE_PARENT);
 	clk[tve_gate] = imx_clk_gate2("tve_gate", "tve_pred", MXC_CCM_CCGR2, 30);
 	clk[tve_pred] = imx_clk_divider("tve_pred", "tve_ext_sel", MXC_CCM_CDCDR, 28, 3);
 	clk[esdhc1_per_gate] = imx_clk_gate2("esdhc1_per_gate", "esdhc_a_podf", MXC_CCM_CCGR3, 2);
-- 
1.8.2.rc2
