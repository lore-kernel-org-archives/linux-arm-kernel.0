From: b20788@freescale.com (Anson Huang)
Date: Thu, 11 Sep 2014 11:29:40 +0800
Subject: [PATCH V3 1/3] ARM: imx: add gpt_3m clk for i.mx6qdl
In-Reply-To: <1410406182-21113-1-git-send-email-b20788@freescale.com>
References: <1410406182-21113-1-git-send-email-b20788@freescale.com>
Message-ID: <1410406182-21113-2-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpt_3m clock for i.mx6qdl, as gpt can source clock
from OSC, some i.MX6 series SOCs has fixed divider of
8 for gpt clock, so here add a fix clk of gpt_3m.

i.MX6Q TO1.0 has no gpt_3m option, so force it to be
from ipg_per.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
change log from v2 -> v3:
	re-initialize gpt_3m to ipg_per on i.MX6Q TO1.0

 arch/arm/mach-imx/clk-imx6q.c             |    4 ++++
 include/dt-bindings/clock/imx6qdl-clock.h |    3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 2edcebf..32ac04d 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -194,6 +194,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_PLL3_80M]  = imx_clk_fixed_factor("pll3_80m",  "pll3_usb_otg",   1, 6);
 	clk[IMX6QDL_CLK_PLL3_60M]  = imx_clk_fixed_factor("pll3_60m",  "pll3_usb_otg",   1, 8);
 	clk[IMX6QDL_CLK_TWD]       = imx_clk_fixed_factor("twd",       "arm",            1, 2);
+	clk[IMX6QDL_CLK_GPT_3M]    = imx_clk_fixed_factor("gpt_3m",    "osc",            1, 8);
 	if (cpu_is_imx6dl()) {
 		clk[IMX6QDL_CLK_GPU2D_AXI] = imx_clk_fixed_factor("gpu2d_axi", "mmdc_ch0_axi_podf", 1, 1);
 		clk[IMX6QDL_CLK_GPU3D_AXI] = imx_clk_fixed_factor("gpu3d_axi", "mmdc_ch0_axi_podf", 1, 1);
@@ -405,6 +406,9 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_CKO1]         = imx_clk_gate("cko1",           "cko1_podf",         base + 0x60, 7);
 	clk[IMX6QDL_CLK_CKO2]         = imx_clk_gate("cko2",           "cko2_podf",         base + 0x60, 24);
 
+	if (cpu_is_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0)
+		clk[IMX6QDL_CLK_GPT_3M] = clk[IMX6QDL_CLK_GPT_IPG_PER];
+
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
 
 	clk_data.clks = clk;
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 323e865..9bc2e07 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -220,6 +220,7 @@
 #define IMX6QDL_CLK_LVDS2_GATE			207
 #define IMX6QDL_CLK_ESAI_IPG			208
 #define IMX6QDL_CLK_ESAI_MEM			209
-#define IMX6QDL_CLK_END				210
+#define IMX6QDL_CLK_GPT_3M			210
+#define IMX6QDL_CLK_END				211
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
1.7.9.5
