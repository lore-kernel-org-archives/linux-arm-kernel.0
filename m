From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu,  6 Aug 2015 14:41:13 +0530
Subject: [PATCH] ARM/EP93xx/timer: Migrate to new 'set-state' interface
Message-ID: <744dca162a7626694770a9f51457566a33c3e08f.1438852023.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate EP93xx driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Linus,

All other clockevent drivers are migrated to the new interface and yours
was left as it adapted generic clockevents framework just now.

Probably Olof can apply it directly to ARM SoC tree..

 arch/arm/mach-ep93xx/timer-ep93xx.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index ac48ac1fd16d..e5f791145bd0 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -86,19 +86,22 @@ static int ep93xx_clkevt_set_next_event(unsigned long next,
 }
 
 
-static void ep93xx_clkevt_set_mode(enum clock_event_mode mode,
-				   struct clock_event_device *evt)
+static int ep93xx_clkevt_shutdown(struct clock_event_device *evt)
 {
 	/* Disable timer */
 	writel(0, EP93XX_TIMER3_CONTROL);
+
+	return 0;
 }
 
 static struct clock_event_device ep93xx_clockevent = {
-	.name		= "timer1",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= ep93xx_clkevt_set_mode,
-	.set_next_event	= ep93xx_clkevt_set_next_event,
-	.rating		= 300,
+	.name			= "timer1",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= ep93xx_clkevt_shutdown,
+	.set_state_oneshot	= ep93xx_clkevt_shutdown,
+	.tick_resume		= ep93xx_clkevt_shutdown,
+	.set_next_event		= ep93xx_clkevt_set_next_event,
+	.rating			= 300,
 };
 
 static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
-- 
2.4.0
