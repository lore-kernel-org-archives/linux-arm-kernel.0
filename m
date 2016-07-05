From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed,  6 Jul 2016 01:59:21 +0530
Subject: [PATCH v3 2/2] clk: samsung: exynos7: Add clocks for atlas block
In-Reply-To: <1467750561-13957-1-git-send-email-a.kesavan@samsung.com>
References: <1467750561-13957-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1467750561-13957-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CMU_ATLAS generates all the necessary clocks for the Cortex-A57
block. Enable clock support for this block, which includes:
	- addition of mux/divider/gate/pll clocks
	- addition of CPU clocks configuration data
	- instantiation of the atlas CPU clock

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../devicetree/bindings/clock/exynos7-clock.txt    |   6 +
 drivers/clk/samsung/clk-exynos7.c                  | 183 +++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h            |  21 ++-
 3 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
index 6bf1e74..b94c0bc 100644
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
+	- sclk_bus0_pll_atlas
+
 Input clocks for ccore clock controller:
 	- fin_pll
 	- dout_aclk_ccore_133
diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index 5931a41..63948c2 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -10,8 +10,10 @@
 
 #include <linux/clk-provider.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 #include <dt-bindings/clock/exynos7-clk.h>
 
 /* Register Offset definitions for CMU_TOPC (0x10570000) */
@@ -36,6 +38,34 @@
 #define ENABLE_ACLK_TOPC1	0x0804
 #define ENABLE_SCLK_TOPC1	0x0A04
 
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
 static const struct samsung_fixed_factor_clock topc_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ffac_topc_bus0_pll_div2", "mout_topc_bus0_pll", 1, 2, 0),
 	FFACTOR(0, "ffac_topc_bus0_pll_div4",
@@ -52,6 +82,8 @@ PNAME(mout_topc_bus1_pll_ctrl_p)	= { "fin_pll", "fout_bus1_pll" };
 PNAME(mout_topc_cc_pll_ctrl_p)	= { "fin_pll", "fout_cc_pll" };
 PNAME(mout_topc_mfc_pll_ctrl_p)	= { "fin_pll", "fout_mfc_pll" };
 
+PNAME(mout_topc_group1)	= { "mout_topc_bus0_pll", "ffac_topc_bus0_pll_div2",
+	 "mout_topc_bus1_pll", "mout_topc_cc_pll" };
 PNAME(mout_topc_group2) = { "mout_topc_bus0_pll_half",
 	"mout_topc_bus1_pll_half", "mout_topc_cc_pll_half",
 	"mout_topc_mfc_pll_half" };
@@ -111,6 +143,8 @@ static const struct samsung_mux_clock topc_mux_clks[] __initconst = {
 		MUX_SEL_TOPC1, 0, 1),
 	MUX(0, "mout_topc_bus0_pll_out", mout_topc_bus0_pll_out_p,
 		MUX_SEL_TOPC1, 16, 1),
+	MUX(0, "mout_topc_bus0_pll_atlas", mout_topc_group1,
+		MUX_SEL_TOPC1, 4, 2),
 
 	MUX(0, "mout_aclk_ccore_133", mout_topc_group2,	MUX_SEL_TOPC2, 4, 2),
 
@@ -164,6 +198,9 @@ static const struct samsung_gate_clock topc_gate_clks[] __initconst = {
 		ENABLE_SCLK_TOPC1, 13, 0, 0),
 	GATE(SCLK_BUS1_PLL_A, "sclk_bus1_pll_a", "dout_sclk_bus1_pll",
 		ENABLE_SCLK_TOPC1, 12, 0, 0),
+	GATE(SCLK_BUS0_PLL_ATLAS, "sclk_bus0_pll_atlas",
+		"mout_topc_bus0_pll_atlas", ENABLE_SCLK_TOPC1, 7,
+		CLK_IGNORE_UNUSED, 0),
 	GATE(SCLK_BUS0_PLL_B, "sclk_bus0_pll_b", "dout_sclk_bus0_pll",
 		ENABLE_SCLK_TOPC1, 5, 0, 0),
 	GATE(SCLK_BUS0_PLL_A, "sclk_bus0_pll_a", "dout_sclk_bus0_pll",
@@ -580,6 +617,152 @@ static void __init exynos7_clk_top1_init(struct device_node *np)
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
+PNAME(mout_atlas_pll_p) = { "fin_pll", "fout_atlas_pll" };
+PNAME(mout_sclk_bus0_pll_atlas_user_p) = { "fin_pll", "sclk_bus0_pll_atlas" };
+PNAME(mout_atlas_p) = { "mout_atlas_pll", "mout_sclk_bus0_pll_atlas_user" };
+
+static const unsigned long atlas_clk_regs[] __initconst = {
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
+static const struct samsung_mux_clock atlas_mux_clks[] __initconst = {
+	/* MUX_SEL_ATLAS0 */
+	MUX_F(MOUT_ATLAS_PLL, "mout_atlas_pll", mout_atlas_pll_p,
+		MUX_SEL_ATLAS0, 0, 1, CLK_SET_RATE_PARENT |
+		CLK_RECALC_NEW_RATES, 0),
+
+	/* MUX_SEL_ATLAS1 */
+	MUX_F(MOUT_SCLK_BUS0_PLL_ATLAS_USER, "mout_sclk_bus0_pll_atlas_user",
+		mout_sclk_bus0_pll_atlas_user_p, MUX_SEL_ATLAS1,
+		0, 1, CLK_SET_RATE_PARENT, 0),
+
+	/* MUX_SEL_ATLAS2 */
+	MUX_F(MOUT_ATLAS, "mout_atlas", mout_atlas_p,
+		MUX_SEL_ATLAS2, 0, 1, CLK_SET_RATE_PARENT, 0),
+};
+
+static const struct samsung_div_clock atlas_div_clks[] __initconst = {
+	/* DIV_ATLAS0 */
+	DIV_F(DOUT_PCLK_DBG_CLK_ATLAS, "dout_pclk_dbg_clk_atlas", "dout_atlas2",
+		DIV_ATLAS0, 26, 6, CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(DOUT_ATCLK_ATLAS, "dout_atclk_atlas", "dout_atlas2",
+		DIV_ATLAS0, 20, 6, CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(DOUT_PCLK_ATLAS, "dout_pclk_atlas", "dout_atlas2",
+		DIV_ATLAS0, 12, 6, CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(DOUT_ACLK_ATLAS, "dout_aclk_atlas", "dout_atlas2",
+		DIV_ATLAS0, 8, 3, CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(DOUT_ATLAS2, "dout_atlas2", "dout_atlas1",
+		DIV_ATLAS0, 4, 3, CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(DOUT_ATLAS1, "dout_atlas1", "mout_atlas",
+		DIV_ATLAS0, 0, 3, CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+
+	/* DIV_ATLAS1 */
+	DIV_F(DOUT_CNTCLK_ATLAS, "dout_cntclk_atlas", "dout_atlas2",
+		DIV_ATLAS1, 8, 4, CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(DOUT_SCLK_HPM_ATLAS, "dout_sclk_hpm_atlas", "mout_atlas",
+		DIV_ATLAS1, 4, 3, CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(DOUT_ATLAS_PLL, "dout_atlas_pll", "mout_atlas",
+		DIV_ATLAS1, 0, 3, CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+};
+
+static const struct samsung_gate_clock atlas_gate_clks[] __initconst = {
+	GATE(CLK_ATLAS, "atlas", "dout_atlas2",
+		ENABLE_SCLK_ATLAS, 0, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_pll_clock atlas_pll_clks[] __initconst = {
+	PLL(pll_1450x, FOUT_ATLAS_PLL, "fout_atlas_pll", "fin_pll",
+		ATLAS_PLL_LOCK, ATLAS_PLL_CON0,
+		pll1450x_24mhz_tbl),
+};
+
+#define EXYNOS7_ATL_DIV0(aclk, pclk, atclk, pclk_dbg) \
+		((aclk << 8) | (pclk << 12) | (atclk << 20) | (pclk_dbg << 26))
+
+#define EXYNOS7_ATL_DIV1(pll, hpm, cntclk) \
+		((pll << 0) | (hpm << 4) | (cntclk << 8))
+
+static const struct exynos_cpuclk_cfg_data exynos7_atlclk_d[] __initconst = {
+	{ 2100000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 5, 6), },
+	{ 2000000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 5, 6), },
+	{ 1896000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1800000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1704000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1600000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1500000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1400000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1300000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 4, 6), },
+	{ 1200000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 3, 6), },
+	{ 1100000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 3, 6), },
+	{ 1000000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 3, 6), },
+	{  900000, EXYNOS7_ATL_DIV0(2, 6, 6, 6), EXYNOS7_ATL_DIV1(1, 3, 6), },
+	{  800000, EXYNOS7_ATL_DIV0(2, 5, 5, 5), EXYNOS7_ATL_DIV1(1, 3, 5), },
+	{  700000, EXYNOS7_ATL_DIV0(2, 5, 5, 5), EXYNOS7_ATL_DIV1(1, 3, 5), },
+	{  600000, EXYNOS7_ATL_DIV0(2, 4, 4, 4), EXYNOS7_ATL_DIV1(1, 3, 4), },
+	{  500000, EXYNOS7_ATL_DIV0(2, 3, 3, 3), EXYNOS7_ATL_DIV1(1, 2, 3), },
+	{  400000, EXYNOS7_ATL_DIV0(2, 3, 3, 3), EXYNOS7_ATL_DIV1(1, 2, 3), },
+	{  300000, EXYNOS7_ATL_DIV0(2, 3, 3, 3), EXYNOS7_ATL_DIV1(1, 2, 3), },
+	{  200000, EXYNOS7_ATL_DIV0(2, 3, 3, 3), EXYNOS7_ATL_DIV1(1, 1, 3), },
+	{  0 },
+};
+
+static void __init exynos7_clk_atlas_init(struct device_node *np)
+{
+	void __iomem *reg_base;
+	struct samsung_clk_provider *ctx;
+
+	reg_base = of_iomap(np, 0);
+	if (!reg_base) {
+		panic("%s: failed to map registers\n", __func__);
+		return;
+	}
+
+	ctx = samsung_clk_init(np, reg_base, ATLAS_NR_CLK);
+	if (!ctx) {
+		panic("%s: unable to allocate ctx\n", __func__);
+		return;
+	}
+
+	samsung_clk_register_pll(ctx, atlas_pll_clks,
+				 ARRAY_SIZE(atlas_pll_clks), reg_base);
+	samsung_clk_register_mux(ctx, atlas_mux_clks,
+				 ARRAY_SIZE(atlas_mux_clks));
+	samsung_clk_register_div(ctx, atlas_div_clks,
+				 ARRAY_SIZE(atlas_div_clks));
+	samsung_clk_register_gate(ctx, atlas_gate_clks,
+				  ARRAY_SIZE(atlas_gate_clks));
+
+	exynos_register_cpu_clock(ctx, CLK_ATLAS_CLK, "atlclk",
+		mout_atlas_p[0], mout_atlas_p[1], 0x200,
+		exynos7_atlclk_d, ARRAY_SIZE(exynos7_atlclk_d),
+		CLK_CPU_HAS_E5433_REGS_LAYOUT | CLK_CPU_HAS_MODIFIED_MUX_STAT);
+
+	samsung_clk_sleep_init(reg_base, atlas_clk_regs,
+			       ARRAY_SIZE(atlas_clk_regs));
+
+	samsung_clk_of_add_provider(np, ctx);
+}
+
+CLK_OF_DECLARE(exynos7_clk_atlas, "samsung,exynos7-clock-atlas",
+		exynos7_clk_atlas_init);
 /* Register Offset definitions for CMU_CCORE (0x105B0000) */
 #define MUX_SEL_CCORE			0x0200
 #define DIV_CCORE			0x0600
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index 10c5586..26df7d8 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -32,7 +32,8 @@
 #define SCLK_CC_PLL_A			19
 #define ACLK_CCORE_133			20
 #define ACLK_PERIS_66			21
-#define TOPC_NR_CLK			22
+#define SCLK_BUS0_PLL_ATLAS		22
+#define TOPC_NR_CLK			23
 
 /* TOP0 */
 #define DOUT_ACLK_PERIC1		1
@@ -73,6 +74,24 @@
 #define DOUT_SCLK_PHY_FSYS1_26M		17
 #define TOP1_NR_CLK			18
 
+/* ATLAS */
+#define FOUT_ATLAS_PLL			1
+#define MOUT_ATLAS_PLL			2
+#define MOUT_SCLK_BUS0_PLL_ATLAS_USER	3
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
+#define CLK_ATLAS_CLK			15
+#define ATLAS_NR_CLK			16
+
 /* CCORE */
 #define PCLK_RTC			1
 #define CCORE_NR_CLK			2
-- 
1.9.1
