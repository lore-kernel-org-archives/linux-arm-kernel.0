From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 28 Sep 2011 12:23:32 +0200
Subject: [PATCH 8/8] S3C2443: use clk_get_rate to init fclk in
	common_setup_clocks
In-Reply-To: <201109281217.33813.heiko@sntech.de>
References: <201109281217.33813.heiko@sntech.de>
Message-ID: <201109281223.33213.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously the fclk rate was calculated by dividing the pll through
the divider value of the armdiv. With a real armdiv clk in place it's
possible to simply read its value, which does essentially the same.

This change makes the whole fdiv_fn function pointers supplied to
s3c2443_common_init_clocks and s3c2443_common_setup_clocks
obsolete, so remove it too.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/clock.c                |   11 ++---------
 arch/arm/mach-s3c2443/clock.c                |   11 ++---------
 arch/arm/plat-s3c24xx/include/plat/s3c2443.h |    5 ++---
 arch/arm/plat-s3c24xx/s3c2443-clock.c        |    8 +++-----
 4 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 7aa0cfa..afbbe8b 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -133,16 +133,9 @@ static struct clk hsmmc0_clk = {
 	.ctrlbit	= S3C2416_HCLKCON_HSMMC0,
 };
 
-static inline unsigned int s3c2416_fclk_div(unsigned long clkcon0)
-{
-	clkcon0 &= S3C2416_CLKDIV0_ARMDIV_MASK;
-
-	return armdiv[clkcon0 >> S3C2443_CLKDIV0_ARMDIV_SHIFT];
-}
-
 void __init_or_cpufreq s3c2416_setup_clocks(void)
 {
-	s3c2443_common_setup_clocks(s3c2416_get_pll, s3c2416_fclk_div);
+	s3c2443_common_setup_clocks(s3c2416_get_pll);
 }
 
 
@@ -166,7 +159,7 @@ void __init s3c2416_init_clocks(int xtal)
 
 	clk_epll.parent = &clk_epllref.clk;
 
-	s3c2443_common_init_clocks(xtal, s3c2416_get_pll, s3c2416_fclk_div,
+	s3c2443_common_init_clocks(xtal, s3c2416_get_pll,
 				   armdiv, ARRAY_SIZE(armdiv),
 				   S3C2416_CLKDIV0_ARMDIV_MASK);
 
diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index 6fda4bf..b93cb96 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -76,13 +76,6 @@ static unsigned int armdiv[16] = {
 	[S3C2443_CLKDIV0_ARMDIV_16 >> S3C2443_CLKDIV0_ARMDIV_SHIFT]	= 16,
 };
 
-static inline unsigned int s3c2443_fclk_div(unsigned long clkcon0)
-{
-	clkcon0 &= S3C2443_CLKDIV0_ARMDIV_MASK;
-
-	return armdiv[clkcon0 >> S3C2443_CLKDIV0_ARMDIV_SHIFT];
-}
-
 /* hsspi
  *
  * high-speed spi clock, sourced from esysclk
@@ -191,7 +184,7 @@ static struct clk *clks[] __initdata = {
 
 void __init_or_cpufreq s3c2443_setup_clocks(void)
 {
-	s3c2443_common_setup_clocks(s3c2443_get_mpll, s3c2443_fclk_div);
+	s3c2443_common_setup_clocks(s3c2443_get_mpll);
 }
 
 void __init s3c2443_init_clocks(int xtal)
@@ -202,7 +195,7 @@ void __init s3c2443_init_clocks(int xtal)
 	clk_epll.rate = s3c2443_get_epll(epllcon, xtal);
 	clk_epll.parent = &clk_epllref.clk;
 
-	s3c2443_common_init_clocks(xtal, s3c2443_get_mpll, s3c2443_fclk_div,
+	s3c2443_common_init_clocks(xtal, s3c2443_get_mpll,
 				   armdiv, ARRAY_SIZE(armdiv),
 				   S3C2443_CLKDIV0_ARMDIV_MASK);
 
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2443.h b/arch/arm/plat-s3c24xx/include/plat/s3c2443.h
index 7b824cb..5496316 100644
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2443.h
+++ b/arch/arm/plat-s3c24xx/include/plat/s3c2443.h
@@ -37,10 +37,9 @@ extern  int s3c2443_baseclk_add(void);
 struct clk;	/* some files don't need clk.h otherwise */
 
 typedef unsigned int (*pll_fn)(unsigned int reg, unsigned int base);
-typedef unsigned int (*fdiv_fn)(unsigned long clkcon0);
 
-extern void s3c2443_common_setup_clocks(pll_fn get_mpll, fdiv_fn fdiv);
-extern void s3c2443_common_init_clocks(int xtal, pll_fn get_mpll, fdiv_fn fdiv,
+extern void s3c2443_common_setup_clocks(pll_fn get_mpll);
+extern void s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
 				       unsigned int *divs, int nr_divs,
 				       int divmask);
 
diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index 40a8720..d3ebbee 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -520,8 +520,7 @@ static inline unsigned long s3c2443_get_hdiv(unsigned long clkcon0)
 
 /* EPLLCON compatible enough to get on/off information */
 
-void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll,
-						   fdiv_fn get_fdiv)
+void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll)
 {
 	unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
 	unsigned long mpllcon = __raw_readl(S3C2443_MPLLCON);
@@ -541,7 +540,7 @@ void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll,
 	pll = get_mpll(mpllcon, xtal);
 	clk_msysclk.clk.rate = pll;
 
-	fclk = pll / get_fdiv(clkdiv0);
+	fclk = clk_get_rate(&clk_armdiv);
 	hclk = s3c2443_prediv_getrate(&clk_prediv);
 	hclk /= s3c2443_get_hdiv(clkdiv0);
 	pclk = hclk / ((clkdiv0 & S3C2443_CLKDIV0_HALF_PCLK) ? 2 : 1);
@@ -590,7 +589,6 @@ static struct clksrc_clk *clksrcs[] __initdata = {
 };
 
 void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
-				       fdiv_fn get_fdiv,
 				       unsigned int *divs, int nr_divs,
 				       int divmask)
 {
@@ -620,5 +618,5 @@ void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
-	s3c2443_common_setup_clocks(get_mpll, get_fdiv);
+	s3c2443_common_setup_clocks(get_mpll);
 }
-- 
1.7.5.4
