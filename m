From: robherring2@gmail.com (Rob Herring)
Date: Wed, 20 Mar 2013 17:54:02 -0500
Subject: [PATCH 02/11] ARM: remove extra timer-sp control register clearing
In-Reply-To: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
References: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
Message-ID: <1363820051-24428-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The timer-sp initialization code clears the control register before
initializing the timers, so every platform doing this is redundant.

For unused timers, we should not care what state they are in.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-integrator/integrator_ap.c |    4 ----
 arch/arm/mach-integrator/integrator_cp.c |    7 -------
 arch/arm/mach-realview/core.c            |    9 ---------
 arch/arm/mach-versatile/core.c           |    9 ---------
 arch/arm/mach-vexpress/v2m.c             |    3 ---
 5 files changed, 32 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index ea96144..4cb322d 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -643,10 +643,6 @@ static void __init ap_timer_init(void)
 	clk_prepare_enable(clk);
 	rate = clk_get_rate(clk);
 
-	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
-
 	integrator_clocksource_init(rate, (void __iomem *)TIMER2_VA_BASE);
 	integrator_clockevent_init(rate, (void __iomem *)TIMER1_VA_BASE,
 				IRQ_TIMERINT1);
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 2b0db82..c68e7d8 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -33,7 +33,6 @@
 #include <mach/platform.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
 #include <mach/cm.h>
@@ -267,7 +266,6 @@ static void __init cp_of_timer_init(void)
 	base = of_iomap(node, 0);
 	if (WARN_ON(!base))
 		return;
-	writel(0, base + TIMER_CTRL);
 	sp804_clocksource_init(base, node->name);
 
 	err = of_property_read_string(of_aliases,
@@ -279,7 +277,6 @@ static void __init cp_of_timer_init(void)
 	if (WARN_ON(!base))
 		return;
 	irq = irq_of_parse_and_map(node, 0);
-	writel(0, base + TIMER_CTRL);
 	sp804_clockevents_init(base, irq, node->name);
 }
 
@@ -510,10 +507,6 @@ static void __init intcp_init_irq(void)
 
 static void __init cp_timer_init(void)
 {
-	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
-
 	sp804_clocksource_init(TIMER2_VA_BASE, "timer2");
 	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1, "timer1");
 }
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 1d5ee5c..8ce6366 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -35,7 +35,6 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
 #include <asm/mach/arch.h>
@@ -355,14 +354,6 @@ void __init realview_timer_init(unsigned int timer_irq)
 	       (REALVIEW_TIMCLK << REALVIEW_TIMER4_EnSel) | val,
 	       __io_address(REALVIEW_SCTL_BASE));
 
-	/*
-	 * Initialise to a known state (all timers off)
-	 */
-	writel(0, timer0_va_base + TIMER_CTRL);
-	writel(0, timer1_va_base + TIMER_CTRL);
-	writel(0, timer2_va_base + TIMER_CTRL);
-	writel(0, timer3_va_base + TIMER_CTRL);
-
 	sp804_clocksource_init(timer3_va_base, "timer3");
 	sp804_clockevents_init(timer0_va_base, timer_irq, "timer0");
 }
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 25160ae..286303a 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -40,7 +40,6 @@
 #include <linux/bitops.h>
 
 #include <asm/irq.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 #include <asm/mach-types.h>
 
@@ -799,14 +798,6 @@ void __init versatile_timer_init(void)
 	       (VERSATILE_TIMCLK << VERSATILE_TIMER4_EnSel) | val,
 	       __io_address(VERSATILE_SCTL_BASE));
 
-	/*
-	 * Initialise to a known state (all timers off)
-	 */
-	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
-
 	sp804_clocksource_init(TIMER3_VA_BASE, "timer3");
 	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1, "timer0");
 }
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 6215717..9fbfbe4 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -61,9 +61,6 @@ static void __init v2m_sp804_init(void __iomem *base, unsigned int irq)
 	if (WARN_ON(!base || irq == NO_IRQ))
 		return;
 
-	writel(0, base + TIMER_1_BASE + TIMER_CTRL);
-	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
-
 	sp804_clocksource_init(base + TIMER_2_BASE, "v2m-timer1");
 	sp804_clockevents_init(base + TIMER_1_BASE, irq, "v2m-timer0");
 }
-- 
1.7.10.4
