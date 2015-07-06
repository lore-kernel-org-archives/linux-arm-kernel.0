From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  6 Jul 2015 16:24:12 +0530
Subject: [PATCH 05/18] ARM/gemini/time: Migrate to new 'set-state' interface
In-Reply-To: <cover.1436178990.git.viresh.kumar@linaro.org>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
Message-ID: <43f4546a1b6bc8f0d50e3f22fb3cee071c51e157.1436178990.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate gemini driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-gemini/time.c | 69 ++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-gemini/time.c b/arch/arm/mach-gemini/time.c
index 0a63c4d25b64..b57d367d21f1 100644
--- a/arch/arm/mach-gemini/time.c
+++ b/arch/arm/mach-gemini/time.c
@@ -59,49 +59,48 @@ static int gemini_timer_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-static void gemini_timer_set_mode(enum clock_event_mode mode,
-				  struct clock_event_device *evt)
+static int gemini_timer_shutdown(struct clock_event_device *evt)
+{
+	u32 cr;
+
+	/*
+	 * Disable also for oneshot: the set_next() call will arm the timer
+	 * instead.
+	 */
+	cr = readl(TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+	cr &= ~TIMER_2_CR_ENABLE;
+	cr &= ~TIMER_2_CR_INT;
+	writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+	return 0;
+}
+
+static int gemini_timer_set_periodic(struct clock_event_device *evt)
 {
 	u32 period = DIV_ROUND_CLOSEST(tick_rate, HZ);
 	u32 cr;
 
-	switch (mode) {
-        case CLOCK_EVT_MODE_PERIODIC:
-		/* Start the timer */
-		writel(period,
-		       TIMER_COUNT(IO_ADDRESS(GEMINI_TIMER2_BASE)));
-		writel(period,
-		       TIMER_LOAD(IO_ADDRESS(GEMINI_TIMER2_BASE)));
-		cr = readl(TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
-		cr |= TIMER_2_CR_ENABLE;
-		cr |= TIMER_2_CR_INT;
-		writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_UNUSED:
-        case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		/*
-		 * Disable also for oneshot: the set_next() call will
-		 * arm the timer instead.
-		 */
-		cr = readl(TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
-		cr &= ~TIMER_2_CR_ENABLE;
-		cr &= ~TIMER_2_CR_INT;
-		writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
-		break;
-	default:
-                break;
-	}
+	/* Start the timer */
+	writel(period, TIMER_COUNT(IO_ADDRESS(GEMINI_TIMER2_BASE)));
+	writel(period, TIMER_LOAD(IO_ADDRESS(GEMINI_TIMER2_BASE)));
+	cr = readl(TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+	cr |= TIMER_2_CR_ENABLE;
+	cr |= TIMER_2_CR_INT;
+	writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+	return 0;
 }
 
 /* Use TIMER2 as clock event */
 static struct clock_event_device gemini_clockevent = {
-	.name		= "TIMER2",
-	.rating		= 300, /* Reasonably fast and accurate clock event */
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_next_event	= gemini_timer_set_next_event,
-	.set_mode	= gemini_timer_set_mode,
+	.name			= "TIMER2",
+	/* Reasonably fast and accurate clock event */
+	.rating			= 300,
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event		= gemini_timer_set_next_event,
+	.set_state_shutdown	= gemini_timer_shutdown,
+	.set_state_periodic	= gemini_timer_set_periodic,
+	.set_state_oneshot	= gemini_timer_shutdown,
+	.tick_resume		= gemini_timer_shutdown,
 };
 
 /*
-- 
2.4.0
