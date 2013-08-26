From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 26 Aug 2013 19:08:59 +0200
Subject: [PATCH v2 04/16] clk: samsung: exynos4: Use separate aliases for
 cpufreq related clocks
In-Reply-To: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
References: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377536951-9307-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos cpufreq driver is the only remaining piece of code that needs
static clkdev aliases for operation, because it can not do device tree
based clock lookups yet.

This patch moves clock alias definitions for those clocks to separate
arrays that can be used with samsung_clk_register_alias() helper.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index f53658b..7de0769 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -392,9 +392,8 @@ static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 	MUX(none, "mout_g2d", mout_g2d_p, E4210_SRC_IMAGE, 8, 1),
 	MUX(none, "mout_fimd1", group1_p4210, E4210_SRC_LCD1, 0, 4),
 	MUX(none, "mout_mipi1", group1_p4210, E4210_SRC_LCD1, 12, 4),
-	MUX_A(sclk_mpll, "sclk_mpll", mout_mpll_p, SRC_CPU, 8, 1, "mout_mpll"),
-	MUX_A(mout_core, "mout_core", mout_core_p4210,
-			SRC_CPU, 16, 1, "moutcore"),
+	MUX(sclk_mpll, "sclk_mpll", mout_mpll_p, SRC_CPU, 8, 1),
+	MUX(mout_core, "mout_core", mout_core_p4210, SRC_CPU, 16, 1),
 	MUX_A(sclk_vpll, "sclk_vpll", sclk_vpll_p4210,
 			SRC_TOP0, 8, 1, "sclk_vpll"),
 	MUX(mout_fimc0, "mout_fimc0", group1_p4210, SRC_CAM, 0, 4),
@@ -431,8 +430,8 @@ static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 
 /* list of mux clocks supported in exynos4x12 soc */
 static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
-	MUX_A(mout_mpll_user_c, "mout_mpll_user_c", mout_mpll_user_p4x12,
-			SRC_CPU, 24, 1, "mout_mpll"),
+	MUX(mout_mpll_user_c, "mout_mpll_user_c", mout_mpll_user_p4x12,
+			SRC_CPU, 24, 1),
 	MUX(none, "mout_aclk266_gps", aclk_p4412, SRC_TOP1, 4, 1),
 	MUX(none, "mout_aclk400_mcuisp", aclk_p4412, SRC_TOP1, 8, 1),
 	MUX(mout_mpll_user_t, "mout_mpll_user_t", mout_mpll_user_p4x12,
@@ -456,8 +455,7 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 			SRC_DMC, 12, 1, "sclk_mpll"),
 	MUX_A(sclk_vpll, "sclk_vpll", mout_vpll_p,
 			SRC_TOP0, 8, 1, "sclk_vpll"),
-	MUX_A(mout_core, "mout_core", mout_core_p4x12,
-			SRC_CPU, 16, 1, "moutcore"),
+	MUX(mout_core, "mout_core", mout_core_p4x12, SRC_CPU, 16, 1),
 	MUX(mout_fimc0, "mout_fimc0", group1_p4x12, SRC_CAM, 0, 4),
 	MUX(mout_fimc1, "mout_fimc1", group1_p4x12, SRC_CAM, 4, 4),
 	MUX(mout_fimc2, "mout_fimc2", group1_p4x12, SRC_CAM, 8, 4),
@@ -545,7 +543,7 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
 	DIV(none, "div_spi_pre2", "div_spi2", DIV_PERIL2, 8, 8),
 	DIV(none, "div_audio1", "mout_audio1", DIV_PERIL4, 0, 4),
 	DIV(none, "div_audio2", "mout_audio2", DIV_PERIL4, 16, 4),
-	DIV_A(arm_clk, "arm_clk", "div_core2", DIV_CPU0, 28, 3, "armclk"),
+	DIV(arm_clk, "arm_clk", "div_core2", DIV_CPU0, 28, 3),
 	DIV_A(sclk_apll, "sclk_apll", "mout_apll",
 			DIV_CPU0, 24, 3, "sclk_apll"),
 	DIV_F(none, "div_mipi_pre0", "div_mipi0", DIV_LCD0, 20, 4,
@@ -930,6 +928,20 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 	GATE(tmu_apbif, "tmu_apbif", "aclk100", E4X12_GATE_IP_PERIR, 17, 0, 0),
 };
 
+static struct samsung_clock_alias exynos4_aliases[] __initdata = {
+	ALIAS(mout_core, NULL, "moutcore"),
+	ALIAS(arm_clk, NULL, "armclk"),
+	ALIAS(sclk_apll, NULL, "mout_apll"),
+};
+
+static struct samsung_clock_alias exynos4210_aliases[] __initdata = {
+	ALIAS(sclk_mpll, NULL, "mout_mpll"),
+};
+
+static struct samsung_clock_alias exynos4x12_aliases[] __initdata = {
+	ALIAS(mout_mpll_user_c, NULL, "mout_mpll"),
+};
+
 /*
  * The parent of the fin_pll clock is selected by the XOM[0] bit. This bit
  * resides in chipid register space, outside of the clock controller memory
@@ -1065,6 +1077,8 @@ static void __init exynos4_clk_init(struct device_node *np,
 			ARRAY_SIZE(exynos4210_div_clks));
 		samsung_clk_register_gate(exynos4210_gate_clks,
 			ARRAY_SIZE(exynos4210_gate_clks));
+		samsung_clk_register_alias(exynos4210_aliases,
+			ARRAY_SIZE(exynos4210_aliases));
 	} else {
 		samsung_clk_register_mux(exynos4x12_mux_clks,
 			ARRAY_SIZE(exynos4x12_mux_clks));
@@ -1072,8 +1086,13 @@ static void __init exynos4_clk_init(struct device_node *np,
 			ARRAY_SIZE(exynos4x12_div_clks));
 		samsung_clk_register_gate(exynos4x12_gate_clks,
 			ARRAY_SIZE(exynos4x12_gate_clks));
+		samsung_clk_register_alias(exynos4x12_aliases,
+			ARRAY_SIZE(exynos4x12_aliases));
 	}
 
+	samsung_clk_register_alias(exynos4_aliases,
+			ARRAY_SIZE(exynos4_aliases));
+
 	pr_info("%s clocks: sclk_apll = %ld, sclk_mpll = %ld\n"
 		"\tsclk_epll = %ld, sclk_vpll = %ld, arm_clk = %ld\n",
 		exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
-- 
1.8.3.2
