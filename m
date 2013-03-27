From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 Mar 2013 10:51:33 +0100
Subject: [PATCH] ARM i.MX53: Add GPU clocks to clock tree
Message-ID: <1364377893-26839-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing GPU2D and GPU3D mux and gate clocks,
and the graphics arbiter gate clock.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 Documentation/devicetree/bindings/clock/imx5-clock.txt | 5 +++++
 arch/arm/mach-imx/clk-imx51-imx53.c                    | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
index 2a0c904..342ad0f 100644
--- a/Documentation/devicetree/bindings/clock/imx5-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
@@ -172,6 +172,11 @@ clocks and IDs.
 	can1_serial_gate	157
 	can1_ipg_gate		158
 	owire_gate		159
+	gpu3d_s			160
+	gpu2d_s			161
+	gpu3d_gate		162
+	gpu2d_gate		163
+	garb_gate		164
 
 Examples (for mx53):
 
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 0f39f8c..fdd8657 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -47,6 +47,8 @@ static const char *mx51_tve_ext_sel[] = { "osc", "ckih1", };
 static const char *mx53_tve_ext_sel[] = { "pll4_sw", "ckih1", };
 static const char *tve_sel[] = { "tve_pred", "tve_ext_sel", };
 static const char *ipu_sel[] = { "axi_a", "axi_b", "emi_slow_gate", "ahb", };
+static const char *gpu3d_sel[] = { "axi_a", "axi_b", "emi_slow_gate", "ahb" };
+static const char *gpu2d_sel[] = { "axi_a", "axi_b", "emi_slow_gate", "ahb" };
 static const char *vpu_sel[] = { "axi_a", "axi_b", "emi_slow_gate", "ahb", };
 static const char *mx53_can_sel[] = { "ipg", "ckih1", "ckih2", "lp_apm", };
 
@@ -83,7 +85,7 @@ enum imx5_clks {
 	ssi2_root_gate, ssi3_root_gate, ssi_ext1_gate, ssi_ext2_gate,
 	epit1_ipg_gate, epit1_hf_gate, epit2_ipg_gate, epit2_hf_gate,
 	can_sel, can1_serial_gate, can1_ipg_gate,
-	owire_gate,
+	owire_gate, gpu3d_s, gpu2d_s, gpu3d_gate, gpu2d_gate, garb_gate,
 	clk_max
 };
 
@@ -200,6 +202,11 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[nfc_gate] = imx_clk_gate2("nfc_gate", "nfc_podf", MXC_CCM_CCGR5, 20);
 	clk[ipu_di0_gate] = imx_clk_gate2("ipu_di0_gate", "ipu_di0_sel", MXC_CCM_CCGR6, 10);
 	clk[ipu_di1_gate] = imx_clk_gate2("ipu_di1_gate", "ipu_di1_sel", MXC_CCM_CCGR6, 12);
+	clk[gpu3d_s] = imx_clk_mux("gpu3d_sel", MXC_CCM_CBCMR, 4, 2, gpu3d_sel, ARRAY_SIZE(gpu3d_sel));
+	clk[gpu2d_s] = imx_clk_mux("gpu2d_sel", MXC_CCM_CBCMR, 16, 2, gpu2d_sel, ARRAY_SIZE(gpu2d_sel));
+	clk[gpu3d_gate] = imx_clk_gate2("gpu3d_gate", "gpu3d_sel", MXC_CCM_CCGR5, 2);
+	clk[garb_gate] = imx_clk_gate2("garb_gate", "axi_a", MXC_CCM_CCGR5, 4);
+	clk[gpu2d_gate] = imx_clk_gate2("gpu2d_gate", "gpu2d_sel", MXC_CCM_CCGR6, 14);
 	clk[vpu_s] = imx_clk_mux("vpu_sel", MXC_CCM_CBCMR, 14, 2, vpu_sel, ARRAY_SIZE(vpu_sel));
 	clk[vpu_gate] = imx_clk_gate2("vpu_gate", "vpu_sel", MXC_CCM_CCGR5, 6);
 	clk[vpu_reference_gate] = imx_clk_gate2("vpu_reference_gate", "osc", MXC_CCM_CCGR5, 8);
-- 
1.8.2.rc2
