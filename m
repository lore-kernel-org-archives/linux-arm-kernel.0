From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 12 Jan 2012 16:10:45 +0100
Subject: [PATCH 2/5] S3C2443/S3C2416: add get_rate for clk_h
In-Reply-To: <201201121609.24110.heiko@sntech.de>
References: <201201121609.24110.heiko@sntech.de>
Message-ID: <201201121610.45402.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the rate of clk_h is calculated once and set through the
s3c24xx_setup_clocks call. As the clk_h is a child of the prediv
we can evaluate its divider and calculate the rate in get_rate.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-s3c24xx/s3c2443-clock.c |   31 ++++++++++++++++++++++---------
 1 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index 95e6819..8b9ee8b 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -160,6 +160,25 @@ static struct clk clk_prediv = {
 	},
 };
 
+/* hclk divider
+ *
+ * divides the prediv and provides the hclk.
+ */
+
+static unsigned long s3c2443_hclkdiv_getrate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned long clkdiv0 = __raw_readl(S3C2443_CLKDIV0);
+
+	clkdiv0 &= S3C2443_CLKDIV0_HCLKDIV_MASK;
+
+	return rate / (clkdiv0 + 1);
+}
+
+static struct clk_ops clk_h_ops = {
+	.get_rate	= s3c2443_hclkdiv_getrate,
+};
+
 /* armdiv
  *
  * this clock is sourced from msysclk and can have a number of
@@ -516,13 +535,6 @@ static struct clk hsmmc1_clk = {
 	.ctrlbit	= S3C2443_HCLKCON_HSMMC,
 };
 
-static inline unsigned long s3c2443_get_hdiv(unsigned long clkcon0)
-{
-	clkcon0 &= S3C2443_CLKDIV0_HCLKDIV_MASK;
-
-	return clkcon0 + 1;
-}
-
 /* EPLLCON compatible enough to get on/off information */
 
 void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll)
@@ -546,8 +558,7 @@ void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll)
 	clk_msysclk.clk.rate = pll;
 
 	fclk = clk_get_rate(&clk_armdiv);
-	hclk = s3c2443_prediv_getrate(&clk_prediv);
-	hclk /= s3c2443_get_hdiv(clkdiv0);
+	hclk = clk_get_rate(&clk_h);
 	pclk = hclk / ((clkdiv0 & S3C2443_CLKDIV0_HALF_PCLK) ? 2 : 1);
 
 	s3c24xx_setup_clocks(fclk, hclk, pclk);
@@ -613,6 +624,8 @@ void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
 
 	/* s3c2443 parents h and p clocks from prediv */
 	clk_h.parent = &clk_prediv;
+	clk_h.ops = &clk_h_ops;
+
 	clk_p.parent = &clk_prediv;
 
 	clk_usb_bus.parent = &clk_usb_bus_host.clk;
-- 
1.7.5.4
