From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Apr 2013 16:03:20 +0200
Subject: [PATCH 2/7] clocksource: exynos_mct: remove platform header dependency
In-Reply-To: <1365775405-115297-1-git-send-email-arnd@arndb.de>
References: <1365775405-115297-1-git-send-email-arnd@arndb.de>
Message-ID: <1365775405-115297-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the non-DT case, the mct_init() function requires access
to a couple of platform specific constants, but cannot include
the header files in case we are building for multiplatform.

This changes the interface to the platform so we pass all
the necessary data as arguments to mct_init.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
---
 arch/arm/mach-exynos/common.c    |  2 +-
 arch/arm/mach-exynos/common.h    |  2 +-
 drivers/clocksource/exynos_mct.c | 21 ++++++---------------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 42f399a..59cb8fe 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -413,7 +413,7 @@ void __init exynos_init_time(void)
 		exynos4_clk_init(NULL, !soc_is_exynos4210(), S5P_VA_CMU, readl(S5P_VA_CHIPID + 8) & 1);
 		exynos4_clk_register_fixed_ext(xxti_f, xusbxti_f);
 #endif
-		mct_init();
+		mct_init(S5P_VA_SYSTIMER, EXYNOS4_IRQ_MCT_G0, EXYNOS4_IRQ_MCT_L0, EXYNOS4_IRQ_MCT_L1);
 	}
 }
 
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 4ed8eef..9717d0f 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -14,7 +14,7 @@
 
 #include <linux/of.h>
 
-extern void mct_init(void);
+void mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1);
 void exynos_init_time(void);
 extern unsigned long xxti_f, xusbxti_f;
 
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 509a601..2292452 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -26,11 +26,6 @@
 
 #include <asm/arch_timer.h>
 #include <asm/localtimer.h>
-
-#include <plat/cpu.h>
-
-#include <mach/map.h>
-#include <mach/irqs.h>
 #include <asm/mach/time.h>
 
 #define EXYNOS4_MCTREG(x)		(x)
@@ -511,18 +506,14 @@ static void __init exynos4_timer_resources(struct device_node *np, void __iomem
 #endif /* CONFIG_LOCAL_TIMERS */
 }
 
-void __init mct_init(void)
+void __init mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1)
 {
-	if (soc_is_exynos4210()) {
-		mct_irqs[MCT_G0_IRQ] = EXYNOS4_IRQ_MCT_G0;
-		mct_irqs[MCT_L0_IRQ] = EXYNOS4_IRQ_MCT_L0;
-		mct_irqs[MCT_L1_IRQ] = EXYNOS4_IRQ_MCT_L1;
-		mct_int_type = MCT_INT_SPI;
-	} else {
-		panic("unable to determine mct controller type\n");
-	}
+	mct_irqs[MCT_G0_IRQ] = irq_g0;
+	mct_irqs[MCT_L0_IRQ] = irq_l0;
+	mct_irqs[MCT_L1_IRQ] = irq_l1;
+	mct_int_type = MCT_INT_SPI;
 
-	exynos4_timer_resources(NULL, S5P_VA_SYSTIMER);
+	exynos4_timer_resources(NULL, base);
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
 }
-- 
1.8.1.2
