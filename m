From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 19 Mar 2013 17:57:01 +0100
Subject: [PATCH] ARM: i.MX53 Add the cko1, cko2 clock outputs.
Message-ID: <20130319165701.27591.1287.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two clocks connect to external pins and can be muxed to
various internal clocks.
They are typically used either for debugging or to provide
clocks to external chips (eg audio codecs).

Currently only the selectable clocks that already exist in the clock tree
have been added.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 .../devicetree/bindings/clock/imx5-clock.txt       |    6 ++++
 arch/arm/mach-imx/clk-imx51-imx53.c                |   34 ++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
index 2a0c904..959d495 100644
--- a/Documentation/devicetree/bindings/clock/imx5-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
@@ -172,6 +172,12 @@ clocks and IDs.
 	can1_serial_gate	157
 	can1_ipg_gate		158
 	owire_gate		159
+	cko1_sel		160
+	cko1_podf		161
+	cko1			162
+	cko2_sel		163
+	cko2_podf		164
+	cko2			165
 
 Examples (for mx53):
 
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 0f39f8c..872a7bc 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -49,6 +49,28 @@ static const char *tve_sel[] = { "tve_pred", "tve_ext_sel", };
 static const char *ipu_sel[] = { "axi_a", "axi_b", "emi_slow_gate", "ahb", };
 static const char *vpu_sel[] = { "axi_a", "axi_b", "emi_slow_gate", "ahb", };
 static const char *mx53_can_sel[] = { "ipg", "ckih1", "ckih2", "lp_apm", };
+static const char *mx53_cko1_sel[] = {
+	"cpu_podf", "pll1_sw", "pll2_sw", "pll3_sw",
+	"emi_slow_podf", "pll4_sw", "nfc_podf", "dummy",
+	"di_pred", "dummy", "dummy", "ahb",
+	"ipg", "per_root", "ckil", "dummy",};
+static const char *mx53_cko2_sel[] = {
+	"dummy"/* dptc_core */, "dummy"/* dptc_perich */,
+	"dummy", "esdhc_a_podf",
+	"usboh3_podf", "dummy"/* wrck_clk_root */,
+	"ecspi_podf", "dummy"/* pll1_ref_clk */,
+	"esdhc_b_podf", "dummy"/* ddr_clk_root */,
+	"dummy"/* arm_axi_clk_root */, "dummy"/* usb_phy_out */,
+	"vpu_sel", "ipu_sel",
+	"osc", "ckih1",
+	"dummy", "esdhc_c_sel",
+	"ssi1_root_podf", "ssi2_root_podf",
+	"dummy", "dummy",
+	"dummy"/* lpsr_clk_root */, "dummy"/* pgc_clk_root */,
+	"dummy"/* tve_out */, "usb_phy_sel",
+	"tve_sel", "lp_apm",
+	"uart_root", "dummy"/* spdif0_clk_root */,
+	"dummy", "dummy", };
 
 enum imx5_clks {
 	dummy, ckil, osc, ckih1, ckih2, ahb, ipg, axi_a, axi_b, uart_pred,
@@ -84,6 +106,8 @@ enum imx5_clks {
 	epit1_ipg_gate, epit1_hf_gate, epit2_ipg_gate, epit2_hf_gate,
 	can_sel, can1_serial_gate, can1_ipg_gate,
 	owire_gate,
+	cko1_sel, cko1_podf, cko1,
+	cko2_sel, cko2_podf, cko2,
 	clk_max
 };
 
@@ -456,6 +480,16 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk[can2_ipg_gate] = imx_clk_gate2("can2_ipg_gate", "ipg", MXC_CCM_CCGR4, 6);
 	clk[i2c3_gate] = imx_clk_gate2("i2c3_gate", "per_root", MXC_CCM_CCGR1, 22);
 
+	clk[cko1_sel] = imx_clk_mux("cko1_sel", MXC_CCM_CCOSR, 0, 4,
+				mx53_cko1_sel, ARRAY_SIZE(mx53_cko1_sel));
+	clk[cko1_podf] = imx_clk_divider("cko1_podf", "cko1_sel", MXC_CCM_CCOSR, 4, 3);
+	clk[cko1] = imx_clk_gate2("cko1", "cko1_podf", MXC_CCM_CCOSR, 7);
+
+	clk[cko2_sel] = imx_clk_mux("cko2_sel", MXC_CCM_CCOSR, 16, 5,
+				mx53_cko2_sel, ARRAY_SIZE(mx53_cko2_sel));
+	clk[cko2_podf] = imx_clk_divider("cko2_podf", "cko2_sel", MXC_CCM_CCOSR, 21, 3);
+	clk[cko2] = imx_clk_gate2("cko2", "cko2_podf", MXC_CCM_CCOSR, 24);
+
 	for (i = 0; i < ARRAY_SIZE(clk); i++)
 		if (IS_ERR(clk[i]))
 			pr_err("i.MX53 clk %d: register failed with %ld\n",
