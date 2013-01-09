From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 09 Jan 2013 12:33:42 +0530
Subject: [PATCH] ARM: EXYNOS5: Add g3d clock hierarchy
Message-ID: <1357715022-5728-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add G3D clock support for Exynos5.
To setup an initial frequency of 533MHz for the G3D block we need
to have the parent source clock of MOUTACLK_400_G3D as sclk_gpll
and the divisor register as 0.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos5.c           |  150 ++++++++++++++++++++++--
 arch/arm/mach-exynos/include/mach/regs-clock.h |    4 +
 arch/arm/plat-samsung/include/plat/s5p-clock.h |    1 +
 3 files changed, 146 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 0208c3a..9b2bbf0 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -173,6 +173,11 @@ static int exynos5_clk_ip_mfc_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(EXYNOS5_CLKGATE_IP_MFC, clk, enable);
 }
 
+static int exynos5_clk_ip_g3d_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(EXYNOS5_CLKGATE_IP_G3D, clk, enable);
+}
+
 static int exynos5_clk_ip_peric_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(EXYNOS5_CLKGATE_IP_PERIC, clk, enable);
@@ -205,6 +210,23 @@ static int exynos5_clk_hdmiphy_ctrl(struct clk *clk, int enable)
 
 /* Core list of CMU_CPU side */
 
+/* GPLL clock output */
+static struct clk clk_fout_gpll = {
+	.name		= "fout_gpll",
+	.id		= -1,
+};
+
+/* Possible clock sources for GPLL Mux */
+static struct clk *clk_src_gpll_list[] = {
+	[0] = &clk_fin_gpll,
+	[1] = &clk_fout_gpll,
+};
+
+static struct clksrc_sources clk_src_gpll = {
+	.sources	= clk_src_gpll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_gpll_list),
+};
+
 static struct clksrc_clk exynos5_clk_mout_apll = {
 	.clk	= {
 		.name		= "mout_apll",
@@ -484,12 +506,40 @@ static struct clksrc_sources exynos5_clkset_aclk = {
 	.nr_sources	= ARRAY_SIZE(exynos5_clkset_aclk_top_list),
 };
 
-static struct clksrc_clk exynos5_clk_aclk_400 = {
+static struct clksrc_clk exynos5_clk_mout_gpll = {
 	.clk	= {
-		.name		= "aclk_400",
+		.name		= "mout_gpll",
+	},
+	.sources = &clk_src_gpll,
+	.reg_src = { .reg = EXYNOS5_CLKSRC_TOP2, .shift = 28, .size = 1 },
+};
+
+/* For ACLK_400_G3D_MID */
+static struct clksrc_clk exynos5_clk_aclk_400_g3d_mid = {
+	.clk	= {
+		.name		= "aclk_400_g3d_mid",
 	},
 	.sources = &exynos5_clkset_aclk,
 	.reg_src = { .reg = EXYNOS5_CLKSRC_TOP0, .shift = 20, .size = 1 },
+};
+
+/* For ACLK_400_G3D */
+struct clk *exynos5_clkset_aclk_g3d_list[] = {
+	[0] = &exynos5_clk_aclk_400_g3d_mid.clk,
+	[1] = &exynos5_clk_mout_gpll.clk,
+};
+
+struct clksrc_sources exynos5_clkset_aclk_g3d = {
+	.sources	= exynos5_clkset_aclk_g3d_list,
+	.nr_sources	= ARRAY_SIZE(exynos5_clkset_aclk_g3d_list),
+};
+
+static struct clksrc_clk exynos5_clk_aclk_400_g3d = {
+	.clk	= {
+		.name		= "aclk_400_g3d",
+	},
+	.sources = &exynos5_clkset_aclk_g3d,
+	.reg_src = { .reg = EXYNOS5_CLKSRC_TOP1, .shift = 28, .size = 1 },
 	.reg_div = { .reg = EXYNOS5_CLKDIV_TOP0, .shift = 24, .size = 3 },
 };
 
@@ -952,6 +1002,10 @@ static struct clk exynos5_init_clocks_off[] = {
 		.enable		= &exynos5_clk_ip_acp_ctrl,
 		.ops		= &exynos5_gate_clk_ops,
 		.ctrlbit	= (1 << 7)
+	}, {
+		.name		= "g3d",
+		.enable		= exynos5_clk_ip_g3d_ctrl,
+		.ctrlbit	= ((1 << 1) | (1 << 0)),
 	}
 };
 
@@ -1342,6 +1396,7 @@ static struct clksrc_clk *exynos5_sysclks[] = {
 	&exynos5_clk_mout_cpll,
 	&exynos5_clk_mout_epll,
 	&exynos5_clk_mout_mpll,
+	&exynos5_clk_mout_gpll,
 	&exynos5_clk_mout_mpll_fout,
 	&exynos5_clk_mout_mpll_user,
 	&exynos5_clk_vpllsrc,
@@ -1350,7 +1405,8 @@ static struct clksrc_clk *exynos5_sysclks[] = {
 	&exynos5_clk_dout_armclk,
 	&exynos5_clk_dout_arm2clk,
 	&exynos5_clk_cdrex,
-	&exynos5_clk_aclk_400,
+	&exynos5_clk_aclk_400_g3d,
+	&exynos5_clk_aclk_400_g3d_mid,
 	&exynos5_clk_aclk_333,
 	&exynos5_clk_aclk_266,
 	&exynos5_clk_aclk_200,
@@ -1413,6 +1469,76 @@ static struct clk_lookup exynos5_clk_lookup[] = {
 	CLKDEV_INIT("exynos5-fb.1", "lcd", &exynos5_clk_fimd1),
 };
 
+static u32 exynos5_gpll_div[][6] = {
+	/* rate, P, M, S, AFC_DNB, AFC */
+	{1400000000,  3, 175, 0, 0, 0},
+	{ 800000000,  3, 100, 0, 0, 0},
+	{ 667000000,  7, 389, 1, 0, 0},
+	{ 600000000,  4, 200, 1, 0, 0},
+	{ 533000000, 12, 533, 1, 0, 0},
+	{ 450000000, 12, 450, 1, 0, 0},
+	{ 400000000,  3, 100, 1, 0, 0},
+	{ 333000000,  4, 222, 2, 0, 0},
+	{ 200000000,  3, 100, 2, 0, 0},
+};
+
+static unsigned long exynos5_gpll_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+
+static int exynos5_gpll_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int gpll_con0;
+	unsigned int locktime;
+	unsigned int tmp;
+	unsigned int i;
+
+	/* Return if no rate changed */
+	if (clk->rate == rate)
+		return 0;
+
+	gpll_con0 = __raw_readl(EXYNOS5_GPLL_CON0);
+	gpll_con0 &= ~(PLL35XX_MDIV_MASK << PLL35XX_MDIV_SHIFT	 |
+			 PLL35XX_PDIV_MASK << PLL35XX_PDIV_SHIFT |
+			 PLL35XX_SDIV_MASK << PLL35XX_SDIV_SHIFT);
+
+	for (i = 0; i < ARRAY_SIZE(exynos5_gpll_div); i++) {
+		if (exynos5_gpll_div[i][0] == rate) {
+			gpll_con0 |=
+				exynos5_gpll_div[i][1] << PLL35XX_PDIV_SHIFT;
+			gpll_con0 |=
+				exynos5_gpll_div[i][2] << PLL35XX_MDIV_SHIFT;
+			gpll_con0 |=
+				exynos5_gpll_div[i][3] << PLL35XX_SDIV_SHIFT;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(exynos5_gpll_div)) {
+		pr_err("%s: Invalid GPLL clock frequency\n", __func__);
+		return -EINVAL;
+	}
+
+	locktime = 270 * exynos5_gpll_div[i][1] + 1;
+	__raw_writel(locktime, EXYNOS5_GPLL_LOCK);
+
+	__raw_writel(gpll_con0, EXYNOS5_GPLL_CON0);
+
+	do {
+		tmp = __raw_readl(EXYNOS5_GPLL_CON0);
+	} while (!(tmp & (0x1 << EXYNOS5_GPLLCON0_LOCKED_SHIFT)));
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+static struct clk_ops exynos5_gpll_ops = {
+	.get_rate = exynos5_gpll_get_rate,
+	.set_rate = exynos5_gpll_set_rate,
+};
+
 static unsigned long exynos5_epll_get_rate(struct clk *clk)
 {
 	return clk->rate;
@@ -1425,6 +1551,7 @@ static struct clk *exynos5_clks[] __initdata = {
 	&clk_fout_bpll_div2,
 	&clk_fout_cpll,
 	&clk_fout_mpll_div2,
+	&clk_fout_gpll,
 	&exynos5_clk_armclk,
 };
 
@@ -1551,11 +1678,12 @@ void __init_or_cpufreq exynos5_setup_clocks(void)
 	unsigned long mpll;
 	unsigned long epll;
 	unsigned long vpll;
+	unsigned long gpll;
 	unsigned long vpllsrc;
 	unsigned long xtal;
 	unsigned long armclk;
 	unsigned long mout_cdrex;
-	unsigned long aclk_400;
+	unsigned long aclk_400_g3d;
 	unsigned long aclk_333;
 	unsigned long aclk_266;
 	unsigned long aclk_200;
@@ -1587,6 +1715,8 @@ void __init_or_cpufreq exynos5_setup_clocks(void)
 	vpll = s5p_get_pll36xx(vpllsrc, __raw_readl(EXYNOS5_VPLL_CON0),
 			__raw_readl(EXYNOS5_VPLL_CON1));
 
+	gpll = s5p_get_pll35xx(xtal, __raw_readl(EXYNOS5_GPLL_CON0));
+
 	clk_fout_apll.ops = &exynos5_fout_apll_ops;
 	clk_fout_bpll.rate = bpll;
 	clk_fout_bpll_div2.rate = bpll >> 1;
@@ -1595,30 +1725,32 @@ void __init_or_cpufreq exynos5_setup_clocks(void)
 	clk_fout_mpll_div2.rate = mpll >> 1;
 	clk_fout_epll.rate = epll;
 	clk_fout_vpll.rate = vpll;
+	clk_fout_gpll.rate = gpll;
 
 	printk(KERN_INFO "EXYNOS5: PLL settings, A=%ld, B=%ld, C=%ld\n"
-			"M=%ld, E=%ld V=%ld",
-			apll, bpll, cpll, mpll, epll, vpll);
+			"M=%ld, E=%ld V=%ld G=%ld",
+			apll, bpll, cpll, mpll, epll, vpll, gpll);
 
 	armclk = clk_get_rate(&exynos5_clk_armclk);
 	mout_cdrex = clk_get_rate(&exynos5_clk_cdrex.clk);
 
-	aclk_400 = clk_get_rate(&exynos5_clk_aclk_400.clk);
+	aclk_400_g3d = clk_get_rate(&exynos5_clk_aclk_400_g3d.clk);
 	aclk_333 = clk_get_rate(&exynos5_clk_aclk_333.clk);
 	aclk_266 = clk_get_rate(&exynos5_clk_aclk_266.clk);
 	aclk_200 = clk_get_rate(&exynos5_clk_aclk_200.clk);
 	aclk_166 = clk_get_rate(&exynos5_clk_aclk_166.clk);
 	aclk_66 = clk_get_rate(&exynos5_clk_aclk_66.clk);
 
-	printk(KERN_INFO "EXYNOS5: ARMCLK=%ld, CDREX=%ld, ACLK400=%ld\n"
+	printk(KERN_INFO "EXYNOS5: ARMCLK=%ld, CDREX=%ld, ACLK400G3D=%ld\n"
 			"ACLK333=%ld, ACLK266=%ld, ACLK200=%ld\n"
 			"ACLK166=%ld, ACLK66=%ld\n",
-			armclk, mout_cdrex, aclk_400,
+			armclk, mout_cdrex, aclk_400_g3d,
 			aclk_333, aclk_266, aclk_200,
 			aclk_166, aclk_66);
 
 
 	clk_fout_epll.ops = &exynos5_epll_ops;
+	clk_fout_gpll.ops = &exynos5_gpll_ops;
 
 	if (clk_set_parent(&exynos5_clk_mout_epll.clk, &clk_fout_epll))
 		printk(KERN_ERR "Unable to set parent %s of clock %s.\n",
diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h b/arch/arm/mach-exynos/include/mach/regs-clock.h
index d36ad76..60ebf87 100644
--- a/arch/arm/mach-exynos/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
@@ -283,6 +283,8 @@
 #define EXYNOS5_VPLL_CON0			EXYNOS_CLKREG(0x10140)
 #define EXYNOS5_VPLL_CON1			EXYNOS_CLKREG(0x10144)
 #define EXYNOS5_VPLL_CON2			EXYNOS_CLKREG(0x10148)
+#define EXYNOS5_GPLL_CON0			EXYNOS_CLKREG(0x10150)
+#define EXYNOS5_GPLL_CON1			EXYNOS_CLKREG(0x10154)
 #define EXYNOS5_CPLL_CON0			EXYNOS_CLKREG(0x10120)
 
 #define EXYNOS5_CLKSRC_TOP0			EXYNOS_CLKREG(0x10210)
@@ -344,8 +346,10 @@
 #define EXYNOS5_PLL_DIV2_SEL			EXYNOS_CLKREG(0x20A24)
 
 #define EXYNOS5_EPLL_LOCK			EXYNOS_CLKREG(0x10030)
+#define EXYNOS5_GPLL_LOCK			EXYNOS_CLKREG(0x10050)
 
 #define EXYNOS5_EPLLCON0_LOCKED_SHIFT		(29)
+#define EXYNOS5_GPLLCON0_LOCKED_SHIFT		(29)
 
 #define PWR_CTRL1_CORE2_DOWN_RATIO		(7 << 28)
 #define PWR_CTRL1_CORE1_DOWN_RATIO		(7 << 16)
diff --git a/arch/arm/plat-samsung/include/plat/s5p-clock.h b/arch/arm/plat-samsung/include/plat/s5p-clock.h
index 8364b4b..aa8dcdd 100644
--- a/arch/arm/plat-samsung/include/plat/s5p-clock.h
+++ b/arch/arm/plat-samsung/include/plat/s5p-clock.h
@@ -19,6 +19,7 @@
 
 #define clk_fin_apll clk_ext_xtal_mux
 #define clk_fin_bpll clk_ext_xtal_mux
+#define clk_fin_gpll clk_ext_xtal_mux
 #define clk_fin_cpll clk_ext_xtal_mux
 #define clk_fin_mpll clk_ext_xtal_mux
 #define clk_fin_epll clk_ext_xtal_mux
-- 
1.7.9.5
