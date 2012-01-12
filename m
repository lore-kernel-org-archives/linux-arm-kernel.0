From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 12 Jan 2012 16:10:15 +0100
Subject: [PATCH 1/5] S3C2443/S3C2416: remove XXX_setup_clocks methods
In-Reply-To: <201201121609.24110.heiko@sntech.de>
References: <201201121609.24110.heiko@sntech.de>
Message-ID: <201201121610.15670.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c2443_common_setup_clocks is always called through
s3c2443_common_init_clocks, so there is no need to call it separately.
On the S3C2443 it was also called twice.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/clock.c              |    6 ------
 arch/arm/mach-s3c2443/clock.c              |    7 -------
 arch/arm/plat-samsung/include/plat/clock.h |    1 -
 3 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 59f54d1..e01490d 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -132,12 +132,6 @@ static struct clk hsmmc0_clk = {
 	.ctrlbit	= S3C2416_HCLKCON_HSMMC0,
 };
 
-void __init_or_cpufreq s3c2416_setup_clocks(void)
-{
-	s3c2443_common_setup_clocks(s3c2416_get_pll);
-}
-
-
 static struct clksrc_clk *clksrcs[] __initdata = {
 	&hsspi_eplldiv,
 	&hsspi_mux,
diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index 6dde269..efb3ac3 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -179,11 +179,6 @@ static struct clk *clks[] __initdata = {
 	&clk_hsmmc,
 };
 
-void __init_or_cpufreq s3c2443_setup_clocks(void)
-{
-	s3c2443_common_setup_clocks(s3c2443_get_mpll);
-}
-
 void __init s3c2443_init_clocks(int xtal)
 {
 	unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
@@ -196,8 +191,6 @@ void __init s3c2443_init_clocks(int xtal)
 				   armdiv, ARRAY_SIZE(armdiv),
 				   S3C2443_CLKDIV0_ARMDIV_MASK);
 
-	s3c2443_setup_clocks();
-
 	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 73c66d4..58b42f6 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -114,7 +114,6 @@ extern void s3c24xx_setup_clocks(unsigned long fclk,
 extern void s3c2410_setup_clocks(void);
 extern void s3c2412_setup_clocks(void);
 extern void s3c244x_setup_clocks(void);
-extern void s3c2443_setup_clocks(void);
 
 /* S3C64XX specific functions and clocks */
 
-- 
1.7.5.4
