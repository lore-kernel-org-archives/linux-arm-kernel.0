From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 09 Jan 2012 10:53:38 +0900
Subject: [PATCH v2] ARM: Exynos4: use s5p-timer for Universal_c210 board
Message-ID: <20120109015338.GA25429@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Commit 069d4e743 removed support for local timers and forced to use MCT as
event source. However MCT is not operating properly on early revision (EVT0)
of Exynos4 SoCs. All UniversalC210 boards are based on Exynos4 EVT0, so that
commit broke support for it. This patch provides a workaround that enables
UniversalC210 boards to boot again. s5p-timer is used as an event source.

and commit 2f0778afac79bd8d226225556858a636931eeabc <ARM: 7205/2: sched_clock: allow sched_clock to be selected@runtime> can be make a boot both sched_clock support or not.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e1efbca..b813a40 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -207,6 +207,9 @@ config MACH_ARMLEX4210
 config MACH_UNIVERSAL_C210
 	bool "Mobile UNIVERSAL_C210 Board"
 	select CPU_EXYNOS4210
+	select S5P_HRT
+	select CLKSRC_MMIO
+	select HAVE_SCHED_CLOCK
 	select S5P_GPIO_INT
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 52aea97..639b403 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -36,6 +36,7 @@
 #include <plat/mfc.h>
 #include <plat/sdhci.h>
 #include <plat/pd.h>
+#include <plat/s5p-time.h>
 #include <plat/regs-fb-v4.h>
 #include <plat/fimc-core.h>
 #include <plat/camport.h>
@@ -997,6 +998,7 @@ static void __init universal_map_io(void)
 	exynos_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 void s5p_tv_setup(void)
@@ -1062,7 +1064,7 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.map_io		= universal_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= universal_machine_init,
-	.timer		= &exynos4_timer,
+	.timer		= &s5p_timer,
 	.reserve        = &universal_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
