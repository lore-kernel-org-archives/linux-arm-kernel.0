From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri,  6 Feb 2015 19:27:44 +0530
Subject: [PATCH v2 1/3] clk: samsung: exynos7: add clocks for CPU block
In-Reply-To: <1423231066-7341-1-git-send-email-a.kesavan@samsung.com>
References: <1423231066-7341-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1423231066-7341-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock support for the Atlas CPU block in Exynos7.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../devicetree/bindings/clock/exynos7-clock.txt    |    6 +
 drivers/clk/samsung/clk-exynos7.c                  |  121 ++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h            |   20 +++-
 3 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
index 6bf1e74..bcf274b5 100644
--- a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
@@ -28,6 +28,7 @@ Required Properties for Clock Controller:
 	- "samsung,exynos7-clock-topc"
 	- "samsung,exynos7-clock-top0"
 	- "samsung,exynos7-clock-top1"
+	- "samsung,exynos7-clock-atlas"
 	- "samsung,exynos7-clock-ccore"
 	- "samsung,exynos7-clock-peric0"
 	- "samsung,exynos7-clock-peric1"
@@ -64,6 +65,11 @@ Input clocks for top1 clock controller:
 	- dout_sclk_cc_pll
 	- dout_sclk_mfc_pll
 
+Input clocks for atlas clock controller:
+	- fin_pll
+	- fout_atlas_pll
+	- mout_sclk_bus0_pll_atlas
+
 Input clocks for ccore clock controller:
 	- fin_pll
 	- dout_aclk_ccore_133
diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index b61724b..cec026c 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -36,6 +36,34 @@
 #define DIV_TOPC3		0x060C
 #define ENABLE_ACLK_TOPC1	0x0804
 
+static const struct samsung_pll_rate_table pll1450x_24mhz_tbl[] = {
+	/* rate, m, p, s */
+	PLL_35XX_RATE(2496000000, 208, 2, 0),
+	PLL_35XX_RATE(2400000000, 200, 2, 0),
+	PLL_35XX_RATE(2304000000, 192, 2, 0),
+	PLL_35XX_RATE(2200000000, 275, 3, 0),
+	PLL_35XX_RATE(2100000000, 175, 2, 0),
+	PLL_35XX_RATE(2000000000, 250, 3, 0),
+	PLL_35XX_RATE(1896000000, 158, 2, 0),
+	PLL_35XX_RATE(1800000000, 150, 2, 0),
+	PLL_35XX_RATE(1704000000, 142, 2, 0),
+	PLL_35XX_RATE(1600000000, 200, 3, 0),
+	PLL_35XX_RATE(1500000000, 250, 2, 1),
+	PLL_35XX_RATE(1400000000, 350, 3, 1),
+	PLL_35XX_RATE(1300000000, 325, 3, 1),
+	PLL_35XX_RATE(1200000000, 200, 2, 1),
+	PLL_35XX_RATE(1100000000, 275, 3, 1),
+	PLL_35XX_RATE(1000000000, 250, 3, 1),
+	PLL_35XX_RATE(900000000, 150, 2, 1),
+	PLL_35XX_RATE(800000000, 200, 3, 1),
+	PLL_35XX_RATE(700000000, 350, 3, 2),
+	PLL_35XX_RATE(600000000, 200, 2, 2),
+	PLL_35XX_RATE(500000000, 250, 3, 2),
+	PLL_35XX_RATE(400000000, 200, 3, 2),
+	PLL_35XX_RATE(300000000, 200, 2, 3),
+	PLL_35XX_RATE(200000000, 200, 3, 3),
+};
+
 static struct samsung_fixed_factor_clock topc_fixed_factor_clks[] __initdata = {
 	FFACTOR(0, "ffac_topc_bus0_pll_div2", "mout_bus0_pll_ctrl", 1, 2, 0),
 	FFACTOR(0, "ffac_topc_bus0_pll_div4",
@@ -57,6 +85,8 @@ PNAME(mout_bus1_pll_ctrl_p)	= { "fin_pll", "fout_bus1_pll" };
 PNAME(mout_cc_pll_ctrl_p)	= { "fin_pll", "fout_cc_pll" };
 PNAME(mout_mfc_pll_ctrl_p)	= { "fin_pll", "fout_mfc_pll" };
 
+PNAME(mout_topc_group1)	= { "mout_bus0_pll_ctrl", "ffac_topc_bus0_pll_div2",
+	 "mout_bus1_pll_ctrl", "mout_cc_pll_ctrl" };
 PNAME(mout_topc_group2) = { "mout_sclk_bus0_pll_cmuc",
 	"mout_sclk_bus1_pll_cmuc", "mout_sclk_cc_pll_cmuc",
 	"mout_sclk_mfc_pll_cmuc" };
@@ -111,6 +141,8 @@ static struct samsung_mux_clock topc_mux_clks[] __initdata = {
 
 	MUX(0, "mout_sclk_bus0_pll_out", mout_sclk_bus0_pll_out_p,
 		MUX_SEL_TOPC1, 16, 1),
+	MUX(MOUT_SCLK_BUS0_PLL_ATLAS, "mout_sclk_bus0_pll_atlas",
+		mout_topc_group1, MUX_SEL_TOPC1, 4, 2),
 	MUX(0, "mout_aud_pll_ctrl", mout_aud_pll_ctrl_p, MUX_SEL_TOPC1, 0, 1),
 
 	MUX(0, "mout_aclk_ccore_133", mout_topc_group2,	MUX_SEL_TOPC2, 4, 2),
@@ -504,6 +536,95 @@ static void __init exynos7_clk_top1_init(struct device_node *np)
 CLK_OF_DECLARE(exynos7_clk_top1, "samsung,exynos7-clock-top1",
 	exynos7_clk_top1_init);
 
+/* Register Offset definitions for CMU_ATLAS (0x11800000) */
+#define	ATLAS_PLL_LOCK			0x0000
+#define	ATLAS_PLL_CON0			0x0100
+#define	MUX_SEL_ATLAS0			0x0200
+#define	MUX_SEL_ATLAS1			0x0204
+#define	MUX_SEL_ATLAS2			0x0208
+#define	DIV_ATLAS0			0x0600
+#define	DIV_ATLAS1			0x0604
+#define	ENABLE_SCLK_ATLAS		0x0A00
+
+/* List of parent clocks for Muxes in CMU_ATLAS */
+PNAME(mout_atlas_pll_ctrl_p) = { "fin_pll", "fout_atlas_pll" };
+PNAME(mout_bus_pll_atlas_p) = { "fin_pll", "mout_sclk_bus0_pll_atlas" };
+PNAME(mout_atlas_p) = { "mout_atlas_pll_ctrl", "mout_bus_pll_atlas" };
+
+static unsigned long atlas_clk_regs[] __initdata = {
+	ATLAS_PLL_LOCK,
+	ATLAS_PLL_CON0,
+	MUX_SEL_ATLAS0,
+	MUX_SEL_ATLAS1,
+	MUX_SEL_ATLAS2,
+	DIV_ATLAS0,
+	DIV_ATLAS1,
+	ENABLE_SCLK_ATLAS,
+};
+
+static struct samsung_mux_clock atlas_mux_clks[] __initdata = {
+	MUX_F(MOUT_ATLAS_PLL_CTRL, "mout_atlas_pll_ctrl", mout_atlas_pll_ctrl_p,
+		MUX_SEL_ATLAS0, 0, 1, CLK_SET_RATE_PARENT, 0),
+	MUX_F(MOUT_BUS_PLL_ATLAS, "mout_bus_pll_atlas", mout_bus_pll_atlas_p,
+		MUX_SEL_ATLAS1, 0, 1, CLK_SET_RATE_PARENT, 0),
+	MUX_F(MOUT_ATLAS, "mout_atlas", mout_atlas_p,
+		MUX_SEL_ATLAS2, 0, 1, CLK_SET_RATE_PARENT, 0),
+};
+
+static struct samsung_div_clock atlas_div_clks[] __initdata = {
+	DIV(DOUT_PCLK_DBG_CLK_ATLAS, "dout_pclk_dbg_clk_atlas", "dout_atlas2",
+		DIV_ATLAS0, 26, 6),
+	DIV(DOUT_ATCLK_ATLAS, "dout_atclk_atlas", "dout_atlas2",
+		DIV_ATLAS0, 20, 6),
+	DIV(DOUT_PCLK_ATLAS, "dout_pclk_atlas", "dout_atlas2",
+		DIV_ATLAS0, 12, 6),
+	DIV(DOUT_ACLK_ATLAS, "dout_aclk_atlas", "dout_atlas2",
+		DIV_ATLAS0, 8, 3),
+	DIV(DOUT_ATLAS2, "dout_atlas2", "dout_atlas1",
+		DIV_ATLAS0, 4, 3),
+	DIV(DOUT_ATLAS1, "dout_atlas1", "mout_atlas",
+		DIV_ATLAS0, 0, 3),
+
+	DIV(DOUT_CNTCLK_ATLAS, "dout_cntclk_atlas", "dout_atlas2",
+		DIV_ATLAS1, 8, 4),
+	DIV(DOUT_SCLK_HPM_ATLAS, "dout_sclk_hpm_atlas", "mout_atlas",
+		DIV_ATLAS1, 4, 3),
+	DIV(DOUT_ATLAS_PLL, "dout_atlas_pll", "mout_atlas",
+		DIV_ATLAS1, 0, 3),
+};
+
+static struct samsung_gate_clock atlas_gate_clks[] __initdata = {
+	GATE(CLK_ATLAS, "atlas", "dout_atlas2",
+		ENABLE_SCLK_ATLAS, 0, 0, 0),
+};
+
+static struct samsung_pll_clock atlas_pll_clks[] __initdata = {
+	PLL(pll_1450x, FOUT_ATLAS_PLL, "fout_atlas_pll", "fin_pll",
+		ATLAS_PLL_LOCK, ATLAS_PLL_CON0,
+		pll1450x_24mhz_tbl),
+};
+
+static struct samsung_cmu_info atlas_cmu_info __initdata = {
+	.pll_clks		= atlas_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(atlas_pll_clks),
+	.mux_clks		= atlas_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(atlas_mux_clks),
+	.div_clks		= atlas_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(atlas_div_clks),
+	.gate_clks		= atlas_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(atlas_gate_clks),
+	.nr_clk_ids		= ATLAS_NR_CLK,
+	.clk_regs		= atlas_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(atlas_clk_regs),
+};
+
+static void __init exynos7_clk_atlas_init(struct device_node *np)
+{
+	samsung_cmu_register_one(np, &atlas_cmu_info);
+}
+
+CLK_OF_DECLARE(exynos7_clk_atlas, "samsung,exynos7-clock-atlas",
+		exynos7_clk_atlas_init);
 /* Register Offset definitions for CMU_CCORE (0x105B0000) */
 #define MUX_SEL_CCORE			0x0200
 #define DIV_CCORE			0x0600
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index 6fad139..6b9465c 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -21,7 +21,8 @@
 #define ACLK_MSCL_532			8
 #define DOUT_SCLK_AUD_PLL		9
 #define FOUT_AUD_PLL			10
-#define TOPC_NR_CLK			11
+#define MOUT_SCLK_BUS0_PLL_ATLAS	11
+#define TOPC_NR_CLK			12
 
 /* TOP0 */
 #define DOUT_ACLK_PERIC1		1
@@ -51,6 +52,23 @@
 #define CLK_SCLK_MMC0			8
 #define TOP1_NR_CLK			9
 
+/* ATLAS */
+#define FOUT_ATLAS_PLL			1
+#define MOUT_ATLAS_PLL_CTRL		2
+#define MOUT_BUS_PLL_ATLAS		3
+#define MOUT_ATLAS			4
+#define DOUT_PCLK_DBG_CLK_ATLAS		5
+#define DOUT_ATCLK_ATLAS		6
+#define DOUT_PCLK_ATLAS			7
+#define DOUT_ACLK_ATLAS			8
+#define DOUT_ATLAS2			9
+#define DOUT_ATLAS1			10
+#define DOUT_CNTCLK_ATLAS		11
+#define CLK_ATLAS			12
+#define DOUT_SCLK_HPM_ATLAS		13
+#define DOUT_ATLAS_PLL			14
+#define ATLAS_NR_CLK			15
+
 /* CCORE */
 #define PCLK_RTC			1
 #define CCORE_NR_CLK			2
-- 
1.7.9.5
