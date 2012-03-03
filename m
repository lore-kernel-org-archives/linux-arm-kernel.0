From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 3 Mar 2012 22:16:47 +0100
Subject: [PATCH 3/4] ARM: S3C24XX: add get_rate for clk_p on S3C2416/2443
In-Reply-To: <201203032214.36820.heiko@sntech.de>
References: <201203032214.36820.heiko@sntech.de>
Message-ID: <201203032216.48126.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the rate of clk_p is calculated once and set through the
s3c24xx_setup_clocks call. As the clk_p is a child of clk_h we can
evaluate its divider and calculate the rate in get_rate.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common-s3c2443.c |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common-s3c2443.c b/arch/arm/mach-s3c24xx/common-s3c2443.c
index 39f9613..6f3bcad 100644
--- a/arch/arm/mach-s3c24xx/common-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/common-s3c2443.c
@@ -187,6 +187,25 @@ static struct clk_ops clk_h_ops = {
 	.get_rate	= s3c2443_hclkdiv_getrate,
 };
 
+/* pclk divider
+ *
+ * divides the hclk and provides the pclk.
+ */
+
+static unsigned long s3c2443_pclkdiv_getrate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned long clkdiv0 = __raw_readl(S3C2443_CLKDIV0);
+
+	clkdiv0 = ((clkdiv0 & S3C2443_CLKDIV0_HALF_PCLK) ? 1 : 0);
+
+	return rate / (clkdiv0 + 1);
+}
+
+static struct clk_ops clk_p_ops = {
+	.get_rate	= s3c2443_pclkdiv_getrate,
+};
+
 /* armdiv
  *
  * this clock is sourced from msysclk and can have a number of
@@ -549,7 +568,6 @@ void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll)
 {
 	unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
 	unsigned long mpllcon = __raw_readl(S3C2443_MPLLCON);
-	unsigned long clkdiv0 = __raw_readl(S3C2443_CLKDIV0);
 	struct clk *xtal_clk;
 	unsigned long xtal;
 	unsigned long pll;
@@ -567,7 +585,7 @@ void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll)
 
 	fclk = clk_get_rate(&clk_armdiv);
 	hclk = clk_get_rate(&clk_h);
-	pclk = hclk / ((clkdiv0 & S3C2443_CLKDIV0_HALF_PCLK) ? 2 : 1);
+	pclk = clk_get_rate(&clk_p);
 
 	s3c24xx_setup_clocks(fclk, hclk, pclk);
 
@@ -630,11 +648,13 @@ void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
 	nr_armdiv = nr_divs;
 	armdivmask = divmask;
 
-	/* s3c2443 parents h and p clocks from prediv */
+	/* s3c2443 parents h clock from prediv */
 	clk_h.parent = &clk_prediv;
 	clk_h.ops = &clk_h_ops;
 
-	clk_p.parent = &clk_prediv;
+	/* and p clock from h clock */
+	clk_p.parent = &clk_h;
+	clk_p.ops = &clk_p_ops;
 
 	clk_usb_bus.parent = &clk_usb_bus_host.clk;
 	clk_epll.parent = &clk_epllref.clk;
-- 
1.7.2.3
