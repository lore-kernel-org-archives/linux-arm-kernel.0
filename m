From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 30 Apr 2015 11:44:21 +0100
Subject: [PATCH 1/2] ARM: simplify timer initialisation and remove arm_timer.h
 inclusion
In-Reply-To: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
References: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1430390662-18246-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header asm/hardware/arm_timer.h is included in various machine
specific files to access TIMER_CTRL and initialise to a known state.
However that's not required as the clock{source,event} driver timer-sp
initialises all the timer being used.

This patch removes the redundant code in timer_init and also the
inclusion of asm/hardware/arm_timer.h header.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-integrator/integrator_ap.c |  1 -
 arch/arm/mach-realview/core.c            |  9 ---------
 arch/arm/mach-versatile/core.c           | 10 ----------
 3 files changed, 20 deletions(-)

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
index c309593abdb2..dd9c12d995db 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -38,7 +38,6 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>

 #include <asm/mach/arch.h>
@@ -378,14 +377,6 @@ void __init realview_timer_init(unsigned int timer_irq)
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
index 6ea09fe53426..a5a57e453698 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -42,7 +42,6 @@
 #include <linux/reboot.h>

 #include <asm/irq.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 #include <asm/mach-types.h>

@@ -794,15 +793,6 @@ void __init versatile_init(void)
  */
 void __init versatile_timer_init(void)
 {
-
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
--
1.9.1
