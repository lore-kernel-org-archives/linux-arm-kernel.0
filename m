From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 22 Sep 2011 15:46:17 +0200
Subject: [PATCH 1/7] ARM: plat-nomadik: MTU sched_clock as an option
Message-ID: <1316699177-21259-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mattias Wallin <mattias.wallin@stericsson.com>

This patch makes it possible to configure away the sched_clock
part of the MTU timer.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
Signed-off-by: Jonas Aberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/Kconfig |    8 +++++++-
 arch/arm/plat-nomadik/timer.c |    8 ++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-nomadik/Kconfig b/arch/arm/plat-nomadik/Kconfig
index ce65901..bca4914 100644
--- a/arch/arm/plat-nomadik/Kconfig
+++ b/arch/arm/plat-nomadik/Kconfig
@@ -15,10 +15,16 @@ if PLAT_NOMADIK
 
 config HAS_MTU
 	bool
-	select HAVE_SCHED_CLOCK
 	help
 	  Support for Multi Timer Unit. MTU provides access
 	  to multiple interrupt generating programmable
 	  32-bit free running decrementing counters.
 
+config NOMADIK_MTU_SCHED_CLOCK
+	bool
+	depends on HAS_MTU
+	select HAVE_SCHED_CLOCK
+	help
+	  Use the Multi Timer Unit as the sched_clock.
+
 endif
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index ef74e15..bd638c5 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -24,7 +24,7 @@
 #include <plat/mtu.h>
 
 void __iomem *mtu_base; /* Assigned by machine code */
-
+#ifdef CONFIG_NOMADIK_MTU_SCHED_CLOCK
 /*
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
@@ -48,7 +48,7 @@ static void notrace nomadik_update_sched_clock(void)
 	u32 cyc = -readl(mtu_base + MTU_VAL(0));
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
-
+#endif
 /* Clockevent device: use one-shot mode */
 static void nmdk_clkevt_mode(enum clock_event_mode mode,
 			     struct clock_event_device *dev)
@@ -153,9 +153,9 @@ void __init nmdk_timer_init(void)
 			rate, 200, 32, clocksource_mmio_readl_down))
 		pr_err("timer: failed to initialize clock source %s\n",
 		       "mtu_0");
-
+#ifdef CONFIG_NOMADIK_MTU_SCHED_CLOCK
 	init_sched_clock(&cd, nomadik_update_sched_clock, 32, rate);
-
+#endif
 	/* Timer 1 is used for events */
 
 	clockevents_calc_mult_shift(&nmdk_clkevt, rate, MTU_MIN_RANGE);
-- 
1.7.3.2
