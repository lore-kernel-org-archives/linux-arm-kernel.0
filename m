From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:52 +0900
Subject: [PATCH 12/18] ARM: S5PV210: Add support for VPLL
Message-ID: <1274056732-14581-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch adds the following.

1. Adds 'clk_sclk_hdmi27m' clock to represent the HDMI 27MHz clock.
2. Adds 'clk_vpllsrc; clock of type clksrc_clk to represent the
   input clock for VPLL.
3. Adds 'clk_sclk_vpll' clock of type clksrc_clk to represent the
   output of the MUX_VPLL mux.
4. Add clk_sclk_hdmi27m, clk_vpllsrc and clk_sclk_vpll to the list
   of clocks to be registered.
5. Adds boot time print of 'clk_sclk_vpll' clock rate.
6. Adds 'clk_fout_vpll' clock to plat-s5p such that it is reusable
   on other s5p platforms.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c              |   63 +++++++++++++++++++++++++++-
 arch/arm/plat-s5p/clock.c                  |    8 ++++
 arch/arm/plat-s5p/include/plat/s5p-clock.h |    1 +
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 315955d..c86bff5 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -173,6 +173,57 @@ static int s5pv210_clk_ip3_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKGATE_IP3, clk, enable);
 }
 
+static int s5pv210_clk_mask0_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLK_SRC_MASK0, clk, enable);
+}
+
+static struct clk clk_sclk_hdmi27m = {
+	.name		= "sclk_hdmi27m",
+	.id		= -1,
+	.rate		= 27000000,
+};
+
+static struct clk *clkset_vpllsrc_list[] = {
+	[0] = &clk_fin_vpll,
+	[1] = &clk_sclk_hdmi27m,
+};
+
+static struct clksrc_sources clkset_vpllsrc = {
+	.sources	= clkset_vpllsrc_list,
+	.nr_sources	= ARRAY_SIZE(clkset_vpllsrc_list),
+};
+
+static struct clksrc_clk clk_vpllsrc = {
+	.clk	= {
+		.name		= "vpll_src",
+		.id		= -1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 7),
+	},
+	.sources	= &clkset_vpllsrc,
+	.reg_src	= { .reg = S5P_CLK_SRC1, .shift = 28, .size = 1 },
+};
+
+static struct clk *clkset_sclk_vpll_list[] = {
+	[0] = &clk_vpllsrc.clk,
+	[1] = &clk_fout_vpll,
+};
+
+static struct clksrc_sources clkset_sclk_vpll = {
+	.sources	= clkset_sclk_vpll_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_vpll_list),
+};
+
+static struct clksrc_clk clk_sclk_vpll = {
+	.clk	= {
+		.name		= "sclk_vpll",
+		.id		= -1,
+	},
+	.sources	= &clkset_sclk_vpll,
+	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 12, .size = 1 },
+};
+
 static unsigned long s5pv210_clk_imem_get_rate(struct clk *clk)
 {
 	return clk_get_rate(clk->parent) / 2;
@@ -402,12 +453,15 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_pclk_msys,
 	&clk_pclk_dsys,
 	&clk_pclk_psys,
+	&clk_vpllsrc,
+	&clk_sclk_vpll,
 };
 
 void __init_or_cpufreq s5pv210_setup_clocks(void)
 {
 	struct clk *xtal_clk;
 	unsigned long xtal;
+	unsigned long vpllsrc;
 	unsigned long armclk;
 	unsigned long hclk_msys;
 	unsigned long hclk_dsys;
@@ -418,6 +472,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	unsigned long apll;
 	unsigned long mpll;
 	unsigned long epll;
+	unsigned long vpll;
 	unsigned int ptr;
 	u32 clkdiv0, clkdiv1;
 
@@ -440,13 +495,16 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON), pll_4508);
 	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
 	epll = s5p_get_pll45xx(xtal, __raw_readl(S5P_EPLL_CON), pll_4500);
+	vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
+	vpll = s5p_get_pll45xx(vpllsrc, __raw_readl(S5P_VPLL_CON), pll_4502);
 
 	clk_fout_apll.rate = apll;
 	clk_fout_mpll.rate = mpll;
 	clk_fout_epll.rate = epll;
+	clk_fout_vpll.rate = vpll;
 
-	printk(KERN_INFO "S5PV210: PLL settings, A=%ld, M=%ld, E=%ld",
-			apll, mpll, epll);
+	printk(KERN_INFO "S5PV210: PLL settings, A=%ld, M=%ld, E=%ld V=%ld",
+			apll, mpll, epll, vpll);
 
 	armclk = clk_get_rate(&clk_armclk.clk);
 	hclk_msys = clk_get_rate(&clk_hclk_msys.clk);
@@ -470,6 +528,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 }
 
 static struct clk *clks[] __initdata = {
+	&clk_sclk_hdmi27m,
 };
 
 void __init s5pv210_register_clocks(void)
diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
index 3fef951..a8bfabf 100644
--- a/arch/arm/plat-s5p/clock.c
+++ b/arch/arm/plat-s5p/clock.c
@@ -74,6 +74,13 @@ struct clk clk_fout_epll = {
 	.ctrlbit	= (1 << 31),
 };
 
+/* VPLL clock output */
+struct clk clk_fout_vpll = {
+	.name		= "fout_vpll",
+	.id		= -1,
+	.ctrlbit	= (1 << 31),
+};
+
 /* ARM clock */
 struct clk clk_arm = {
 	.name		= "armclk",
@@ -138,6 +145,7 @@ static struct clk *s5p_clks[] __initdata = {
 	&clk_fout_apll,
 	&clk_fout_mpll,
 	&clk_fout_epll,
+	&clk_fout_vpll,
 	&clk_arm,
 	&clk_vpll,
 };
diff --git a/arch/arm/plat-s5p/include/plat/s5p-clock.h b/arch/arm/plat-s5p/include/plat/s5p-clock.h
index a476a9f..aa0447a 100644
--- a/arch/arm/plat-s5p/include/plat/s5p-clock.h
+++ b/arch/arm/plat-s5p/include/plat/s5p-clock.h
@@ -28,6 +28,7 @@ extern struct clk clk_48m;
 extern struct clk clk_fout_apll;
 extern struct clk clk_fout_mpll;
 extern struct clk clk_fout_epll;
+extern struct clk clk_fout_vpll;
 extern struct clk clk_arm;
 extern struct clk clk_vpll;
 
-- 
1.6.2.5
