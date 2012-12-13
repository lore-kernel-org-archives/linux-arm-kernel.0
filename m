From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 13 Dec 2012 19:11:23 +0900
Subject: [PATCH] ARM: EXYNOS: remove static mapping of PWM memory
Message-ID: <1355393483-15113-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos SoCs uses MCT(Multi-Core Timer) so it doesn't need to map PWM
memory area to virtual memory(S3C_VA_TIMER) statically for timer.

This patch also remove functions call dependent to S3C_VA_TIMER.
- s3c_pwmclk_init()
- s5p_init_irq()

They access PWM registers via S3C_VA_TIMER but exynos will not use them
any more. There is a exception case about the universal_c210 board. The
universal_c210 board can't use MCT because of low SoC version.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
This is based on for-next branch of git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

 arch/arm/mach-exynos/clock-exynos4.c       |    2 --
 arch/arm/mach-exynos/clock-exynos5.c       |    1 -
 arch/arm/mach-exynos/common.c              |   23 -----------------------
 arch/arm/mach-exynos/mach-universal_c210.c |   21 +++++++++++++++++++--
 4 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-exynos/clock-exynos4.c
index efead60..8e5a0aa 100644
--- a/arch/arm/mach-exynos/clock-exynos4.c
+++ b/arch/arm/mach-exynos/clock-exynos4.c
@@ -1597,6 +1597,4 @@ void __init exynos4_register_clocks(void)
 
 	register_syscore_ops(&exynos4_clock_syscore_ops);
 	s3c24xx_register_clock(&dummy_apb_pclk);
-
-	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 5c63bc7..cf96990 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -1754,5 +1754,4 @@ void __init exynos5_register_clocks(void)
 	clkdev_add_table(exynos5_clk_lookup, ARRAY_SIZE(exynos5_clk_lookup));
 
 	register_syscore_ops(&exynos5_clock_syscore_ops);
-	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 73b940f..79dcb4a 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -141,11 +141,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.length		= SZ_64K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S3C_VA_TIMER,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_TIMER),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_WATCHDOG),
 		.length		= SZ_4K,
@@ -243,11 +238,6 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 		.length		= SZ_64K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S3C_VA_TIMER,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_TIMER),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_WATCHDOG),
 		.length		= SZ_4K,
@@ -654,13 +644,6 @@ void __init exynos4_init_irq(void)
 
 	if (!of_have_populated_dt())
 		combiner_init(S5P_VA_COMBINER_BASE, NULL);
-
-	/*
-	 * The parameters of s5p_init_irq() are for VIC init.
-	 * Theses parameters should be NULL and 0 because EXYNOS4
-	 * uses GIC instead of VIC.
-	 */
-	s5p_init_irq(NULL, 0);
 }
 
 void __init exynos5_init_irq(void)
@@ -668,12 +651,6 @@ void __init exynos5_init_irq(void)
 #ifdef CONFIG_OF
 	of_irq_init(exynos_dt_irq_match);
 #endif
-	/*
-	 * The parameters of s5p_init_irq() are for VIC init.
-	 * Theses parameters should be NULL and 0 because EXYNOS4
-	 * uses GIC instead of VIC.
-	 */
-	s5p_init_irq(NULL, 0);
 
 	gic_arch_extn.irq_set_wake = s3c_irq_wake;
 }
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 9e3340f..6eee378 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -29,6 +29,7 @@
 #include <drm/exynos_drm.h>
 
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
@@ -1090,10 +1091,26 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s5p_device_fimc_md,
 };
 
+static struct map_desc universal_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S3C_VA_TIMER,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_TIMER),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void __init universal_init_irq(void)
+{
+	exynos4_init_irq();
+	s5p_init_irq(NULL, 0);
+}
+
 static void __init universal_map_io(void)
 {
-	exynos_init_io(NULL, 0);
+	exynos_init_io(universal_iodesc, ARRAY_SIZE(universal_iodesc));
 	s3c24xx_init_clocks(clk_xusbxti.rate);
+	s3c_pwmclk_init();
 	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
 	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
@@ -1149,7 +1166,7 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
 	.atag_offset	= 0x100,
 	.smp		= smp_ops(exynos_smp_ops),
-	.init_irq	= exynos4_init_irq,
+	.init_irq	= universal_init_irq,
 	.map_io		= universal_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= universal_machine_init,
-- 
1.7.9.5
