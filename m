From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 3 Mar 2012 22:15:27 +0100
Subject: [PATCH 1/4] ARM: S3C24XX: remove XXX_setup_clocks method from S3C2443
In-Reply-To: <201203032214.36820.heiko@sntech.de>
References: <201203032214.36820.heiko@sntech.de>
Message-ID: <201203032215.27901.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c2443_common_setup_clocks is always called through
s3c2443_common_init_clocks, so there is no need to call it separately.
It was also called twice through this separate call.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/clock-s3c2443.c      |    7 -------
 arch/arm/plat-samsung/include/plat/clock.h |    1 -
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/clock-s3c2443.c b/arch/arm/mach-s3c24xx/clock-s3c2443.c
index 6dde269..efb3ac3 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2443.c
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
index 3b5a9dc..a62753d 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -118,7 +118,6 @@ extern void s3c24xx_setup_clocks(unsigned long fclk,
 extern void s3c2410_setup_clocks(void);
 extern void s3c2412_setup_clocks(void);
 extern void s3c244x_setup_clocks(void);
-extern void s3c2443_setup_clocks(void);
 
 /* S3C2410 specific clock functions */
 
-- 
1.7.2.3
