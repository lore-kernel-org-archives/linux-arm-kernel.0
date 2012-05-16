From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 May 2012 12:50:18 +0200
Subject: [PATCH 1/4] ARM i.MX5: fix gpt peripheral clock path
In-Reply-To: <1337165421-17118-1-git-send-email-s.hauer@pengutronix.de>
References: <1337165421-17118-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1337165421-17118-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- The gpt peripheral clk parent is per_root, not ipg
- The register for selectin per_lp_apm and per_root is
  MXC_CCM_CBCMR, not MXC_CCM_CBCDR

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index b8a382d..1e7828d 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -94,12 +94,12 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 				periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
 	clk[main_bus] = imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 1,
 				main_bus_sel, ARRAY_SIZE(main_bus_sel));
-	clk[per_lp_apm] = imx_clk_mux("per_lp_apm", MXC_CCM_CBCDR, 1, 1,
+	clk[per_lp_apm] = imx_clk_mux("per_lp_apm", MXC_CCM_CBCMR, 1, 1,
 				per_lp_apm_sel, ARRAY_SIZE(per_lp_apm_sel));
 	clk[per_pred1] = imx_clk_divider("per_pred1", "per_lp_apm", MXC_CCM_CBCDR, 6, 2);
 	clk[per_pred2] = imx_clk_divider("per_pred2", "per_pred1", MXC_CCM_CBCDR, 3, 3);
 	clk[per_podf] = imx_clk_divider("per_podf", "per_pred2", MXC_CCM_CBCDR, 0, 3);
-	clk[per_root] = imx_clk_mux("per_root", MXC_CCM_CBCDR, 1, 0,
+	clk[per_root] = imx_clk_mux("per_root", MXC_CCM_CBCMR, 0, 1,
 				per_root_sel, ARRAY_SIZE(per_root_sel));
 	clk[ahb] = imx_clk_divider("ahb", "main_bus", MXC_CCM_CBCDR, 10, 3);
 	clk[ahb_max] = imx_clk_gate2("ahb_max", "ahb", MXC_CCM_CCGR0, 28);
@@ -162,7 +162,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[pwm1_hf_gate] = imx_clk_gate2("pwm1_hf_gate", "ipg", MXC_CCM_CCGR2, 12);
 	clk[pwm2_ipg_gate] = imx_clk_gate2("pwm2_ipg_gate", "ipg", MXC_CCM_CCGR2, 14);
 	clk[pwm2_hf_gate] = imx_clk_gate2("pwm2_hf_gate", "ipg", MXC_CCM_CCGR2, 16);
-	clk[gpt_gate] = imx_clk_gate2("gpt_gate", "ipg", MXC_CCM_CCGR2, 18);
+	clk[gpt_gate] = imx_clk_gate2("gpt_gate", "per_root", MXC_CCM_CCGR2, 18);
 	clk[fec_gate] = imx_clk_gate2("fec_gate", "ipg", MXC_CCM_CCGR2, 24);
 	clk[usboh3_gate] = imx_clk_gate2("usboh3_gate", "ipg", MXC_CCM_CCGR2, 26);
 	clk[usboh3_per_gate] = imx_clk_gate2("usboh3_per_gate", "usboh3_podf", MXC_CCM_CCGR2, 28);
-- 
1.7.10
