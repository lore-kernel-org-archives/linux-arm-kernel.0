From: ta.omasab@gmail.com (Thomas Abraham)
Date: Thu,  9 Jan 2014 21:29:22 +0530
Subject: [PATCH 3/6] clk: samsung: register cpu clock provider for exynos4210
 SoC
In-Reply-To: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1389283165-17708-4-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new clock provider for ARM clock domain. This clock provider
is composed of multiple components which include mux_core, div_core,
div_core2, div_corem0, div_corem1, div_periph, div_atb, div_pclk_dbg,
div_copy and div_hpm. This composition of mutiple components into
a single clock provider helps with faster completion of CPU clock
speed switching during DVFS operations.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c |   96 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 95 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index d967571..4bf2f93 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -108,8 +108,11 @@
 #define APLL_CON0		0x14100
 #define E4210_MPLL_CON0		0x14108
 #define SRC_CPU			0x14200
+#define STAT_CPU		0x14400
 #define DIV_CPU0		0x14500
 #define DIV_CPU1		0x14504
+#define DIV_STAT_CPU0		0x14600
+#define DIV_STAT_CPU1		0x14604
 #define GATE_SCLK_CPU		0x14800
 #define GATE_IP_CPU		0x14900
 #define E4X12_DIV_ISP0		0x18300
@@ -289,7 +292,7 @@ static unsigned long exynos4_clk_regs[] __initdata = {
 };
 
 /* list of all parent clock list */
-PNAME(mout_apll_p)	= { "fin_pll", "fout_apll", };
+PNAME(mout_apll_p)	= { "fin_pll", "fout_apll1", };
 PNAME(mout_mpll_p)	= { "fin_pll", "fout_mpll", };
 PNAME(mout_epll_p)	= { "fin_pll", "fout_epll", };
 PNAME(mout_vpllsrc_p)	= { "fin_pll", "sclk_hdmi24m", };
@@ -306,6 +309,7 @@ PNAME(mout_onenand_p)  = {"aclk133", "aclk160", };
 PNAME(mout_onenand1_p) = {"mout_onenand", "sclk_vpll", };
 
 /* Exynos 4210-specific parent groups */
+PNAME(armclk_p) = { "fout_apll", };
 PNAME(sclk_vpll_p4210)	= { "mout_vpllsrc", "fout_vpll", };
 PNAME(mout_core_p4210)	= { "mout_apll", "sclk_mpll", };
 PNAME(sclk_ampll_p4210)	= { "sclk_mpll", "sclk_apll", };
@@ -1089,6 +1093,92 @@ static struct samsung_pll_clock exynos4x12_plls[nr_plls] __initdata = {
 			VPLL_LOCK, VPLL_CON0, NULL),
 };
 
+#define EXYNOS4210_DIV_CPU0(apll, pclk_dbg, atb, periph, corem1, corem0) \
+		((apll << 24) | (pclk_dbg << 20) | (atb << 16) | \
+		(periph << 12) | (corem1 << 8) | (corem0 << 4))
+#define EXYNOS4210_DIV_CPU1(hpm, copy)	\
+		((hpm << 4) | (copy << 0))
+static const unsigned long exynos4210_armclk_data[][2] = {
+	{ EXYNOS4210_DIV_CPU0(7, 1, 4, 3, 7, 3), EXYNOS4210_DIV_CPU1(0, 5), },
+	{ EXYNOS4210_DIV_CPU0(7, 1, 4, 3, 7, 3), EXYNOS4210_DIV_CPU1(0, 4), },
+	{ EXYNOS4210_DIV_CPU0(7, 1, 3, 3, 7, 3), EXYNOS4210_DIV_CPU1(0, 3), },
+	{ EXYNOS4210_DIV_CPU0(7, 1, 3, 3, 7, 3), EXYNOS4210_DIV_CPU1(0, 3), },
+	{ EXYNOS4210_DIV_CPU0(7, 1, 3, 3, 7, 3), EXYNOS4210_DIV_CPU1(0, 3), },
+	{ EXYNOS4210_DIV_CPU0(0, 1, 3, 1, 3, 1), EXYNOS4210_DIV_CPU1(0, 3), },
+};
+
+static const unsigned long exynos4210_armclk_freqs[] = {
+	1200000 , 1000000, 800000, 500000, 400000, 200000,
+};
+
+static const struct samsung_core_clock_freq_table exyno4210_armclk_table = {
+	.freq		= exynos4210_armclk_freqs,
+	.freq_count	= ARRAY_SIZE(exynos4210_armclk_freqs),
+	.data		= (void *)exynos4210_armclk_data,
+};
+
+static int exynos4210_armclk_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long prate)
+{
+	struct samsung_core_clock *armclk;
+	const struct samsung_core_clock_freq_table *freq_tbl;
+	unsigned long *freq_data;
+	unsigned long mux_reg, idx;
+	void __iomem *base;
+
+	if (drate == prate)
+		return 0;
+
+	armclk = container_of(hw, struct samsung_core_clock, hw);
+	freq_tbl = armclk->freq_table;
+	freq_data = (unsigned long *)freq_tbl->data;
+	base = armclk->ctrl_base;
+
+	for (idx = 0; idx < freq_tbl->freq_count; idx++, freq_data += 2)
+		if ((freq_tbl->freq[idx] * 1000) == drate)
+			break;
+
+	if (!armclk->fout_pll)
+		armclk->fout_pll = __clk_lookup("fout_apll");
+
+	if (drate < prate) {
+		mux_reg = readl(base + SRC_CPU);
+		writel(mux_reg | (1 << 16), base + SRC_CPU);
+		while (((readl(base + STAT_CPU) >> 16) & 0x7) != 2)
+			;
+
+		clk_set_rate(armclk->fout_pll, drate);
+	}
+
+	writel(freq_data[0], base + DIV_CPU0);
+	while (readl(base + DIV_STAT_CPU0) != 0)
+		;
+	writel(freq_data[1], base + DIV_CPU1);
+	while (readl(base + DIV_STAT_CPU1) != 0)
+		;
+
+	if (drate > prate) {
+		mux_reg = readl(base + SRC_CPU);
+		writel(mux_reg | (1 << 16), base + SRC_CPU);
+		while (((readl(base + STAT_CPU) >> 16) & 0x7) != 2)
+			;
+
+		clk_set_rate(armclk->fout_pll, drate);
+	}
+
+	mux_reg = readl(base + SRC_CPU);
+	writel(mux_reg & ~(1 << 16), base + SRC_CPU);
+	while (((readl(base + STAT_CPU) >> 16) & 0x7) != 1)
+			;
+	return 0;
+}
+
+static const struct clk_ops exynos4210_armclk_clk_ops = {
+	.recalc_rate = samsung_core_clock_recalc_rate,
+	.round_rate = samsung_core_clk_round_rate,
+	.set_rate = exynos4210_armclk_set_rate,
+};
+
 /* register exynos4 clocks */
 static void __init exynos4_clk_init(struct device_node *np,
 				    enum exynos4_soc exynos4_soc,
@@ -1164,6 +1254,10 @@ static void __init exynos4_clk_init(struct device_node *np,
 			ARRAY_SIZE(exynos4210_gate_clks));
 		samsung_clk_register_alias(exynos4210_aliases,
 			ARRAY_SIZE(exynos4210_aliases));
+		samsung_coreclk_register("armclk", armclk_p,
+			ARRAY_SIZE(armclk_p), "fout_apll",
+			&exynos4210_armclk_clk_ops, arm_clk,
+			&exyno4210_armclk_table);
 	} else {
 		samsung_clk_register_mux(exynos4x12_mux_clks,
 			ARRAY_SIZE(exynos4x12_mux_clks));
-- 
1.6.6.rc2
