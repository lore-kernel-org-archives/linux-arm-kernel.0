From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 10 Jul 2013 00:59:32 +0200
Subject: [PATCH v2 4/6] ARM: S3C24XX: enable legacy clock code only when
 SAMSUNG_CLOCK selected
In-Reply-To: <201307100057.06061.heiko@sntech.de>
References: <201307100057.06061.heiko@sntech.de>
Message-ID: <201307100059.32401.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables a smooth transition, as not all S3C24XX SoCs need to be
converted at the same time and can instead simply exchange their
select SAMSUNG_CLOCK with a select COMMON_CLK after the conversion.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common-s3c2443.c |    2 ++
 arch/arm/mach-s3c24xx/common.c         |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/common-s3c2443.c b/arch/arm/mach-s3c24xx/common-s3c2443.c
index f6b9f2e..b5bbeb7 100644
--- a/arch/arm/mach-s3c24xx/common-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/common-s3c2443.c
@@ -28,6 +28,7 @@
 #include <plat/cpu-freq.h>
 
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 static int s3c2443_gate(void __iomem *reg, struct clk *clk, int enable)
 {
 	u32 ctrlbit = clk->ctrlbit;
@@ -673,3 +674,4 @@ void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
 
 	s3c2443_common_setup_clocks(get_mpll);
 }
+#endif
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 457261c..0fe0254 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -317,6 +317,7 @@ struct s3c24xx_uart_resources s3c2410_uart_resources[] __initdata = {
 
 /* initialise all the clocks */
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 void __init_or_cpufreq s3c24xx_setup_clocks(unsigned long fclk,
 					   unsigned long hclk,
 					   unsigned long pclk)
@@ -329,3 +330,4 @@ void __init_or_cpufreq s3c24xx_setup_clocks(unsigned long fclk,
 	clk_p.rate = pclk;
 	clk_f.rate = fclk;
 }
+#endif
-- 
1.7.10.4
