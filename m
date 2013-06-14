From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 21:32:45 +0200
Subject: [PATCH 09/28] ARM: EXYNOS: common: Remove legacy timer initialization
 code
In-Reply-To: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371238384-1504-10-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes legacy timer initialization code that was used to
set up system timers when booting with ATAGS, which is not supported
on Exynos any more.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 9626ce4..b1d0afa 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -299,13 +299,6 @@ static struct map_desc exynos5440_iodesc0[] __initdata = {
 	},
 };
 
-static struct samsung_pwm_variant exynos4_pwm_variant = {
-	.bits		= 32,
-	.div_base	= 0,
-	.has_tint_cstat	= true,
-	.tclk_mask	= 0,
-};
-
 void exynos4_restart(char mode, const char *cmd)
 {
 	__raw_writel(0x1, S5P_SWRESET);
@@ -451,38 +444,10 @@ static void __init exynos5440_map_io(void)
 	iotable_init(exynos5440_iodesc0, ARRAY_SIZE(exynos5440_iodesc0));
 }
 
-void __init exynos_set_timer_source(u8 channels)
-{
-	exynos4_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
-	exynos4_pwm_variant.output_mask &= ~channels;
-}
-
 void __init exynos_init_time(void)
 {
-	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
-		EXYNOS4_IRQ_TIMER0_VIC, EXYNOS4_IRQ_TIMER1_VIC,
-		EXYNOS4_IRQ_TIMER2_VIC, EXYNOS4_IRQ_TIMER3_VIC,
-		EXYNOS4_IRQ_TIMER4_VIC,
-	};
-
-	if (of_have_populated_dt()) {
-		of_clk_init(NULL);
-		clocksource_of_init();
-	} else {
-		/* todo: remove after migrating legacy E4 platforms to dt */
-#ifdef CONFIG_ARCH_EXYNOS4
-		exynos4_clk_init(NULL, !soc_is_exynos4210(), S5P_VA_CMU, readl(S5P_VA_CHIPID + 8) & 1);
-		exynos4_clk_register_fixed_ext(xxti_f, xusbxti_f);
-#endif
-#ifdef CONFIG_CLKSRC_SAMSUNG_PWM
-		if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_0)
-			samsung_pwm_clocksource_init(S3C_VA_TIMER,
-					timer_irqs, &exynos4_pwm_variant);
-		else
-#endif
-			mct_init(S5P_VA_SYSTIMER, EXYNOS4_IRQ_MCT_G0,
-					EXYNOS4_IRQ_MCT_L0, EXYNOS4_IRQ_MCT_L1);
-	}
+	of_clk_init(NULL);
+	clocksource_of_init();
 }
 
 void __init exynos4_init_irq(void)
-- 
1.8.2.1
