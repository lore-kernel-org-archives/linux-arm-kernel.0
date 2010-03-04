From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Realview/Versatile: don't use magic numbers for
	timer frequency
References: <git-1267729916-abadbdc1887fc6c586b05d17c2b22f00bade49c9@rmk-PC>
Message-ID: <git-1267729916-6ca45be431733d3c1460cbc8245eb2efe0150fdd@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-versatile/timer-sp.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-versatile/timer-sp.c b/arch/arm/plat-versatile/timer-sp.c
index d1dbef5..fb0d1c2 100644
--- a/arch/arm/plat-versatile/timer-sp.c
+++ b/arch/arm/plat-versatile/timer-sp.c
@@ -26,15 +26,13 @@
 
 #include <asm/hardware/arm_timer.h>
 
-#include <mach/platform.h>
-
 #include <plat/timer-sp.h>
 
 /*
- * How long is the timer interval?
+ * These timers are currently always setup to be clocked at 1MHz.
  */
-#define TIMER_RELOAD	(TICKS_PER_uSEC * mSEC_10)
-
+#define TIMER_FREQ_KHZ	(1000)
+#define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
 
 static void __iomem *clksrc_base;
 
@@ -65,7 +63,7 @@ void __init sp804_clocksource_init(void __iomem *base)
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 		clksrc_base + TIMER_CTRL);
 
-	cs->mult = clocksource_khz2mult(1000, cs->shift);
+	cs->mult = clocksource_khz2mult(TIMER_FREQ_KHZ, cs->shift);
 	clocksource_register(cs);
 }
 
@@ -149,7 +147,7 @@ void __init sp804_clockevents_init(void __iomem *base, unsigned int timer_irq)
 	clkevt_base = base;
 
 	evt->irq = timer_irq;
-	evt->mult = div_sc(1000000, NSEC_PER_SEC, evt->shift);
+	evt->mult = div_sc(TIMER_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
 	evt->max_delta_ns = clockevent_delta2ns(0xffffffff, evt);
 	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
 
