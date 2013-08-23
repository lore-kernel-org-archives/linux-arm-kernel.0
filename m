From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 07:24:04 -0300
Subject: [PATCH v3 2/3] clocksource: orion: Use atomic access for shared
 registers
In-Reply-To: <1377253445-2842-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377253445-2842-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377253445-2842-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the driver-specific thread-safe shared register API
by the recently introduced atomic_io_clear_set().

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-orion.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index ecbeb68..da9379e 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -35,20 +35,6 @@
 #define ORION_ONESHOT_MAX	0xfffffffe
 
 static void __iomem *timer_base;
-static DEFINE_SPINLOCK(timer_ctrl_lock);
-
-/*
- * Thread-safe access to TIMER_CTRL register
- * (shared with watchdog timer)
- */
-void orion_timer_ctrl_clrset(u32 clr, u32 set)
-{
-	spin_lock(&timer_ctrl_lock);
-	writel((readl(timer_base + TIMER_CTRL) & ~clr) | set,
-		timer_base + TIMER_CTRL);
-	spin_unlock(&timer_ctrl_lock);
-}
-EXPORT_SYMBOL(orion_timer_ctrl_clrset);
 
 /*
  * Free-running clocksource handling.
@@ -68,7 +54,8 @@ static int orion_clkevt_next_event(unsigned long delta,
 {
 	/* setup and enable one-shot timer */
 	writel(delta, timer_base + TIMER1_VAL);
-	orion_timer_ctrl_clrset(TIMER1_RELOAD_EN, TIMER1_EN);
+	atomic_io_modify(timer_base + TIMER_CTRL,
+		TIMER1_RELOAD_EN | TIMER1_EN, TIMER1_EN);
 
 	return 0;
 }
@@ -80,10 +67,13 @@ static void orion_clkevt_mode(enum clock_event_mode mode,
 		/* setup and enable periodic timer at 1/HZ intervals */
 		writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD);
 		writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL);
-		orion_timer_ctrl_clrset(0, TIMER1_RELOAD_EN | TIMER1_EN);
+		atomic_io_modify(timer_base + TIMER_CTRL,
+			TIMER1_RELOAD_EN | TIMER1_EN,
+			TIMER1_RELOAD_EN | TIMER1_EN);
 	} else {
 		/* disable timer */
-		orion_timer_ctrl_clrset(TIMER1_RELOAD_EN | TIMER1_EN, 0);
+		atomic_io_modify(timer_base + TIMER_CTRL,
+			TIMER1_RELOAD_EN | TIMER1_EN, 0);
 	}
 }
 
@@ -131,7 +121,9 @@ static void __init orion_timer_init(struct device_node *np)
 	/* setup timer0 as free-running clocksource */
 	writel(~0, timer_base + TIMER0_VAL);
 	writel(~0, timer_base + TIMER0_RELOAD);
-	orion_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | TIMER0_EN);
+	oatomic_io_modify(timer_base + TIMER_CTRL,
+		TIMER0_RELOAD_EN | TIMER0_EN,
+		TIMER0_RELOAD_EN | TIMER0_EN);
 	clocksource_mmio_init(timer_base + TIMER0_VAL, "orion_clocksource",
 			      clk_get_rate(clk), 300, 32,
 			      clocksource_mmio_readl_down);
-- 
1.8.1.5
