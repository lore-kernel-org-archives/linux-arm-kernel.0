From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 18 May 2015 13:44:43 +0100
Subject: [PATCH v2 1/2] ARM: introduce sp804_timer_disable and remove
 arm_timer.h inclusion
In-Reply-To: <1431953084-15700-1-git-send-email-sudeep.holla@arm.com>
References: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
 <1431953084-15700-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1431953084-15700-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header asm/hardware/arm_timer.h is included in various machine
specific files to access TIMER_CTRL and initialise to a known state.

This patch introduces a new function sp804_timer_disable to disable
the SP804 timers and uses the same for initialising the timers to
known(off) state, thereby removing the dependency on the header
asm/hardware/arm_timer.h

This change is in prepartion to move sp804 timer support out of arch/arm
so that it can be used on ARM64 platforms.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/common/timer-sp.c               | 5 +++++
 arch/arm/include/asm/hardware/timer-sp.h | 1 +
 arch/arm/mach-integrator/integrator_ap.c | 1 -
 arch/arm/mach-realview/core.c            | 9 ++++-----
 arch/arm/mach-versatile/core.c           | 9 ++++-----
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 19211324772f..000aea3722bc 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -71,6 +71,11 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
 }

+void __init sp804_timer_disable(void __iomem *base)
+{
+	writel(0, base + TIMER_CTRL);
+}
+
 void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						     const char *name,
 						     struct clk *clk,
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/arch/arm/include/asm/hardware/timer-sp.h
index bb28af7c32de..05eaefa46742 100644
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ b/arch/arm/include/asm/hardware/timer-sp.h
@@ -4,6 +4,7 @@ void __sp804_clocksource_and_sched_clock_init(void __iomem *,
 					      const char *, struct clk *, int);
 void __sp804_clockevents_init(void __iomem *, unsigned int,
 			      struct clk *, const char *);
+void sp804_timer_disable(void __iomem *);

 static inline void sp804_clocksource_init(void __iomem *base, const char *name)
 {
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 30003ba447a5..5b0e363fe5ba 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -37,7 +37,6 @@
 #include <linux/stat.h>
 #include <linux/termios.h>

-#include <asm/hardware/arm_timer.h>
 #include <asm/setup.h>
 #include <asm/param.h>		/* HZ */
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index c309593abdb2..c611f489bdd2 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -38,7 +38,6 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>

 #include <asm/mach/arch.h>
@@ -381,10 +380,10 @@ void __init realview_timer_init(unsigned int timer_irq)
 	/*
 	 * Initialise to a known state (all timers off)
 	 */
-	writel(0, timer0_va_base + TIMER_CTRL);
-	writel(0, timer1_va_base + TIMER_CTRL);
-	writel(0, timer2_va_base + TIMER_CTRL);
-	writel(0, timer3_va_base + TIMER_CTRL);
+	sp804_timer_disable(timer0_va_base);
+	sp804_timer_disable(timer1_va_base);
+	sp804_timer_disable(timer2_va_base);
+	sp804_timer_disable(timer3_va_base);

 	sp804_clocksource_init(timer3_va_base, "timer3");
 	sp804_clockevents_init(timer0_va_base, timer_irq, "timer0");
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 6ea09fe53426..f98c1961be6a 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -42,7 +42,6 @@
 #include <linux/reboot.h>

 #include <asm/irq.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 #include <asm/mach-types.h>

@@ -798,10 +797,10 @@ void __init versatile_timer_init(void)
 	/*
 	 * Initialise to a known state (all timers off)
 	 */
-	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
+	sp804_timer_disable(TIMER0_VA_BASE);
+	sp804_timer_disable(TIMER1_VA_BASE);
+	sp804_timer_disable(TIMER2_VA_BASE);
+	sp804_timer_disable(TIMER3_VA_BASE);

 	sp804_clocksource_init(TIMER3_VA_BASE, "timer3");
 	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1, "timer0");
--
1.9.1
