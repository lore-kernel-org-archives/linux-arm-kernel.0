From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 4 Aug 2015 16:16:54 +0800
Subject: [PATCH v6 5/9] clk: mediatek: Fix rate and dependency of MT8173 clocks
In-Reply-To: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1438676218-11310-6-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the dependency from clk_null, and give all root clocks a
typical rate, include clkph_mck_o, usb_syspll_125m and hdmitx_dig_cts.

dpi_ck was removed due to no clock reference to it.

Replace parent clock of infra_cpum with cpum_ck, which is an external
clock and can be defined in the device tree.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8173.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 361fe32..f37ace6 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -22,10 +22,9 @@
 
 static DEFINE_SPINLOCK(mt8173_clk_lock);
 
-static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
-	FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
-	FACTOR(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk_null", 1, 1),
-	FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null", 1, 1),
+static const struct mtk_fixed_clk fixed_clks[] __initconst = {
+	FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", 400 * MHZ),
+	FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),
 };
 
 static const struct mtk_fixed_factor top_divs[] __initconst = {
@@ -50,6 +49,7 @@ static const struct mtk_fixed_factor top_divs[] __initconst = {
 	FACTOR(CLK_TOP_CLKRTC_INT, "clkrtc_int", "clk26m", 1, 793),
 	FACTOR(CLK_TOP_FPC, "fpc_ck", "clk26m", 1, 1),
 
+	FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "tvdpll_445p5m", 1, 3),
 	FACTOR(CLK_TOP_HDMITXPLL_D2, "hdmitxpll_d2", "hdmitx_dig_cts", 1, 2),
 	FACTOR(CLK_TOP_HDMITXPLL_D3, "hdmitxpll_d3", "hdmitx_dig_cts", 1, 3),
 
@@ -608,7 +608,7 @@ static const struct mtk_gate infra_clks[] __initconst = {
 	GATE_ICG(CLK_INFRA_GCE, "infra_gce", "axi_sel", 6),
 	GATE_ICG(CLK_INFRA_L2C_SRAM, "infra_l2c_sram", "axi_sel", 7),
 	GATE_ICG(CLK_INFRA_M4U, "infra_m4u", "mem_sel", 8),
-	GATE_ICG(CLK_INFRA_CPUM, "infra_cpum", "clk_null", 15),
+	GATE_ICG(CLK_INFRA_CPUM, "infra_cpum", "cpum_ck", 15),
 	GATE_ICG(CLK_INFRA_KP, "infra_kp", "axi_sel", 16),
 	GATE_ICG(CLK_INFRA_CEC, "infra_cec", "clk26m", 18),
 	GATE_ICG(CLK_INFRA_PMICSPI, "infra_pmicspi", "pmicspi_sel", 22),
@@ -727,7 +727,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mt8173_top_clk_data = clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 
-	mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
+	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
 			&mt8173_clk_lock, clk_data);
-- 
1.8.1.1.dirty
