From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Tue, 31 May 2011 10:30:23 +0200
Subject: [PATCH 1/3] plat-nomadik: MTU sched_clock as an option
Message-ID: <1306830623-9504-1-git-send-email-mattias.wallin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it possible to configure away the sched_clock
part of the MTU timer.

Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/Kconfig |    8 +++++++-
 arch/arm/plat-nomadik/timer.c |    4 ++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/Kconfig b/arch/arm/plat-nomadik/Kconfig
index 18296ee..d8101a4 100644
--- a/arch/arm/plat-nomadik/Kconfig
+++ b/arch/arm/plat-nomadik/Kconfig
@@ -15,12 +15,18 @@ if PLAT_NOMADIK
 
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
 config NOMADIK_GPIO
 	bool
 	help
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index ef74e15..b55c4ec 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -25,6 +25,7 @@
 
 void __iomem *mtu_base; /* Assigned by machine code */
 
+#ifdef CONFIG_NOMADIK_MTU_SCHED_CLOCK
 /*
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
@@ -48,6 +49,7 @@ static void notrace nomadik_update_sched_clock(void)
 	u32 cyc = -readl(mtu_base + MTU_VAL(0));
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
+#endif
 
 /* Clockevent device: use one-shot mode */
 static void nmdk_clkevt_mode(enum clock_event_mode mode,
@@ -154,7 +156,9 @@ void __init nmdk_timer_init(void)
 		pr_err("timer: failed to initialize clock source %s\n",
 		       "mtu_0");
 
+#ifdef CONFIG_NOMADIK_MTU_SCHED_CLOCK
 	init_sched_clock(&cd, nomadik_update_sched_clock, 32, rate);
+#endif
 
 	/* Timer 1 is used for events */
 
-- 
1.7.4.3
