From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 23 Apr 2013 17:46:32 +0200
Subject: [PATCH v3 11/13] ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
In-Reply-To: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
References: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
Message-ID: <1366731994-7478-12-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends exynos_init_time() function to handle Exynos4210 rev0
SoC, which differs in availability of system timers and needs different
clocksource initialization.

This makes it possible to use exynos_init_time() function as init_time
callback for all Exynos-based boards, including Universal_C210, which
originally had to use samsung_timer_init().

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/Kconfig               |  3 ++-
 arch/arm/mach-exynos/common.c              | 30 +++++++++++++++++++++++++++++-
 arch/arm/mach-exynos/common.h              |  2 ++
 arch/arm/mach-exynos/mach-universal_c210.c |  5 ++---
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index eefea36..f7af1e0 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -268,6 +268,7 @@ config MACH_ARMLEX4210
 config MACH_UNIVERSAL_C210
 	bool "Mobile UNIVERSAL_C210 Board"
 	select CLKSRC_MMIO
+	select CLKSRC_SAMSUNG_PWM
 	select CPU_EXYNOS4210
 	select EXYNOS4_SETUP_FIMC
 	select EXYNOS4_SETUP_FIMD0
@@ -299,7 +300,6 @@ config MACH_UNIVERSAL_C210
 	select S5P_DEV_TV
 	select S5P_GPIO_INT
 	select S5P_SETUP_MIPIPHY
-	select SAMSUNG_HRT
 	help
 	  Machine support for Samsung Mobile Universal S5PC210 Reference
 	  Board.
@@ -428,6 +428,7 @@ config MACH_EXYNOS4_DT
 	depends on ARCH_EXYNOS4
 	select ARM_AMBA
 	select CLKSRC_OF
+	select CLKSRC_SAMSUNG_PWM if CPU_EXYNOS4210
 	select CPU_EXYNOS4210
 	select KEYBOARD_SAMSUNG if INPUT_KEYBOARD
 	select PINCTRL
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 9574498..52c024f 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -10,12 +10,14 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/io.h>
 #include <linux/device.h>
 #include <linux/gpio.h>
+#include <clocksource/samsung_pwm.h>
 #include <linux/sched.h>
 #include <linux/serial_core.h>
 #include <linux/of.h>
@@ -445,8 +447,27 @@ static void __init exynos5440_map_io(void)
 	iotable_init(exynos5440_iodesc0, ARRAY_SIZE(exynos5440_iodesc0));
 }
 
+static struct samsung_pwm_variant exynos4_pwm_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= 0,
+};
+
+void __init exynos_set_timer_source(u8 channels)
+{
+	exynos4_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
+	exynos4_pwm_variant.output_mask &= ~channels;
+}
+
 void __init exynos_init_time(void)
 {
+	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
+		EXYNOS4_IRQ_TIMER0_VIC, EXYNOS4_IRQ_TIMER1_VIC,
+		EXYNOS4_IRQ_TIMER2_VIC, EXYNOS4_IRQ_TIMER3_VIC,
+		EXYNOS4_IRQ_TIMER4_VIC,
+	};
+
 	if (of_have_populated_dt()) {
 #ifdef CONFIG_OF
 		of_clk_init(NULL);
@@ -458,7 +479,14 @@ void __init exynos_init_time(void)
 		exynos4_clk_init(NULL, !soc_is_exynos4210(), S5P_VA_CMU, readl(S5P_VA_CHIPID + 8) & 1);
 		exynos4_clk_register_fixed_ext(xxti_f, xusbxti_f);
 #endif
-		mct_init(S5P_VA_SYSTIMER, EXYNOS4_IRQ_MCT_G0, EXYNOS4_IRQ_MCT_L0, EXYNOS4_IRQ_MCT_L1);
+#ifdef CONFIG_CLKSRC_SAMSUNG_PWM
+		if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_0)
+			samsung_pwm_clocksource_init(S3C_VA_TIMER,
+					timer_irqs, &exynos4_pwm_variant);
+		else
+#endif
+			mct_init(S5P_VA_SYSTIMER, EXYNOS4_IRQ_MCT_G0,
+					EXYNOS4_IRQ_MCT_L0, EXYNOS4_IRQ_MCT_L1);
 	}
 }
 
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 60dd35c..11fc1e2 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -32,6 +32,8 @@ void exynos4_clk_register_fixed_ext(unsigned long, unsigned long);
 
 void exynos_firmware_init(void);
 
+void exynos_set_timer_source(u8 channels);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS
 int exynos_pm_late_initcall(void);
 #else
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 020e1f4..6ca31c4 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -41,7 +41,6 @@
 #include <plat/mfc.h>
 #include <plat/sdhci.h>
 #include <plat/fimc-core.h>
-#include <plat/samsung-time.h>
 #include <plat/camport.h>
 
 #include <mach/map.h>
@@ -1117,7 +1116,7 @@ static void __init universal_map_io(void)
 {
 	exynos_init_io(NULL, 0);
 	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM2, SAMSUNG_PWM4);
+	exynos_set_timer_source(BIT(2) | BIT(4));
 	xxti_f = 0;
 	xusbxti_f = 24000000;
 }
@@ -1177,7 +1176,7 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.map_io		= universal_map_io,
 	.init_machine	= universal_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= samsung_timer_init,
+	.init_time	= exynos_init_time,
 	.reserve        = &universal_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
-- 
1.8.2.1
