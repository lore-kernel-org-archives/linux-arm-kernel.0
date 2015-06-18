From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:52 +0530
Subject: [PATCH 38/41] clocksource: u300: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <0b64aa9802f9657aae1618e073ac4c0b9de4cfd0.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate u300 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/timer-u300.c | 155 +++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 78 deletions(-)

diff --git a/drivers/clocksource/timer-u300.c b/drivers/clocksource/timer-u300.c
index 5dcf756970e7..1744b243898a 100644
--- a/drivers/clocksource/timer-u300.c
+++ b/drivers/clocksource/timer-u300.c
@@ -187,85 +187,82 @@ struct u300_clockevent_data {
 	unsigned ticks_per_jiffy;
 };
 
+static int u300_shutdown(struct clock_event_device *evt)
+{
+	/* Disable interrupts on GP1 */
+	writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
+	       u300_timer_base + U300_TIMER_APP_GPT1IE);
+	/* Disable GP1 */
+	writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
+	       u300_timer_base + U300_TIMER_APP_DGPT1);
+	return 0;
+}
+
 /*
- * The u300_set_mode() function is always called first, if we
- * have oneshot timer active, the oneshot scheduling function
+ * If we have oneshot timer active, the oneshot scheduling function
  * u300_set_next_event() is called immediately after.
  */
-static void u300_set_mode(enum clock_event_mode mode,
-			  struct clock_event_device *evt)
+static int u300_set_oneshot(struct clock_event_device *evt)
+{
+	/* Just return; here? */
+	/*
+	 * The actual event will be programmed by the next event hook,
+	 * so we just set a dummy value somewhere at the end of the
+	 * universe here.
+	 */
+	/* Disable interrupts on GPT1 */
+	writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
+	       u300_timer_base + U300_TIMER_APP_GPT1IE);
+	/* Disable GP1 while we're reprogramming it. */
+	writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
+	       u300_timer_base + U300_TIMER_APP_DGPT1);
+	/*
+	 * Expire far in the future, u300_set_next_event() will be
+	 * called soon...
+	 */
+	writel(0xFFFFFFFF, u300_timer_base + U300_TIMER_APP_GPT1TC);
+	/* We run one shot per tick here! */
+	writel(U300_TIMER_APP_SGPT1M_MODE_ONE_SHOT,
+	       u300_timer_base + U300_TIMER_APP_SGPT1M);
+	/* Enable interrupts for this timer */
+	writel(U300_TIMER_APP_GPT1IE_IRQ_ENABLE,
+	       u300_timer_base + U300_TIMER_APP_GPT1IE);
+	/* Enable timer */
+	writel(U300_TIMER_APP_EGPT1_TIMER_ENABLE,
+	       u300_timer_base + U300_TIMER_APP_EGPT1);
+	return 0;
+}
+
+static int u300_set_periodic(struct clock_event_device *evt)
 {
 	struct u300_clockevent_data *cevdata =
 		container_of(evt, struct u300_clockevent_data, cevd);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		/* Disable interrupts on GPT1 */
-		writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
-		       u300_timer_base + U300_TIMER_APP_GPT1IE);
-		/* Disable GP1 while we're reprogramming it. */
-		writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
-		       u300_timer_base + U300_TIMER_APP_DGPT1);
-		/*
-		 * Set the periodic mode to a certain number of ticks per
-		 * jiffy.
-		 */
-		writel(cevdata->ticks_per_jiffy,
-		       u300_timer_base + U300_TIMER_APP_GPT1TC);
-		/*
-		 * Set continuous mode, so the timer keeps triggering
-		 * interrupts.
-		 */
-		writel(U300_TIMER_APP_SGPT1M_MODE_CONTINUOUS,
-		       u300_timer_base + U300_TIMER_APP_SGPT1M);
-		/* Enable timer interrupts */
-		writel(U300_TIMER_APP_GPT1IE_IRQ_ENABLE,
-		       u300_timer_base + U300_TIMER_APP_GPT1IE);
-		/* Then enable the OS timer again */
-		writel(U300_TIMER_APP_EGPT1_TIMER_ENABLE,
-		       u300_timer_base + U300_TIMER_APP_EGPT1);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* Just break; here? */
-		/*
-		 * The actual event will be programmed by the next event hook,
-		 * so we just set a dummy value somewhere at the end of the
-		 * universe here.
-		 */
-		/* Disable interrupts on GPT1 */
-		writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
-		       u300_timer_base + U300_TIMER_APP_GPT1IE);
-		/* Disable GP1 while we're reprogramming it. */
-		writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
-		       u300_timer_base + U300_TIMER_APP_DGPT1);
-		/*
-		 * Expire far in the future, u300_set_next_event() will be
-		 * called soon...
-		 */
-		writel(0xFFFFFFFF, u300_timer_base + U300_TIMER_APP_GPT1TC);
-		/* We run one shot per tick here! */
-		writel(U300_TIMER_APP_SGPT1M_MODE_ONE_SHOT,
-		       u300_timer_base + U300_TIMER_APP_SGPT1M);
-		/* Enable interrupts for this timer */
-		writel(U300_TIMER_APP_GPT1IE_IRQ_ENABLE,
-		       u300_timer_base + U300_TIMER_APP_GPT1IE);
-		/* Enable timer */
-		writel(U300_TIMER_APP_EGPT1_TIMER_ENABLE,
-		       u300_timer_base + U300_TIMER_APP_EGPT1);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		/* Disable interrupts on GP1 */
-		writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
-		       u300_timer_base + U300_TIMER_APP_GPT1IE);
-		/* Disable GP1 */
-		writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
-		       u300_timer_base + U300_TIMER_APP_DGPT1);
-		break;
-	case CLOCK_EVT_MODE_RESUME:
-		/* Ignore this call */
-		break;
-	}
+	/* Disable interrupts on GPT1 */
+	writel(U300_TIMER_APP_GPT1IE_IRQ_DISABLE,
+	       u300_timer_base + U300_TIMER_APP_GPT1IE);
+	/* Disable GP1 while we're reprogramming it. */
+	writel(U300_TIMER_APP_DGPT1_TIMER_DISABLE,
+	       u300_timer_base + U300_TIMER_APP_DGPT1);
+	/*
+	 * Set the periodic mode to a certain number of ticks per
+	 * jiffy.
+	 */
+	writel(cevdata->ticks_per_jiffy,
+	       u300_timer_base + U300_TIMER_APP_GPT1TC);
+	/*
+	 * Set continuous mode, so the timer keeps triggering
+	 * interrupts.
+	 */
+	writel(U300_TIMER_APP_SGPT1M_MODE_CONTINUOUS,
+	       u300_timer_base + U300_TIMER_APP_SGPT1M);
+	/* Enable timer interrupts */
+	writel(U300_TIMER_APP_GPT1IE_IRQ_ENABLE,
+	       u300_timer_base + U300_TIMER_APP_GPT1IE);
+	/* Then enable the OS timer again */
+	writel(U300_TIMER_APP_EGPT1_TIMER_ENABLE,
+	       u300_timer_base + U300_TIMER_APP_EGPT1);
+	return 0;
 }
 
 /*
@@ -309,13 +306,15 @@ static int u300_set_next_event(unsigned long cycles,
 static struct u300_clockevent_data u300_clockevent_data = {
 	/* Use general purpose timer 1 as clock event */
 	.cevd = {
-		.name		= "GPT1",
+		.name			= "GPT1",
 		/* Reasonably fast and accurate clock event */
-		.rating		= 300,
-		.features	= CLOCK_EVT_FEAT_PERIODIC |
-			CLOCK_EVT_FEAT_ONESHOT,
-		.set_next_event	= u300_set_next_event,
-		.set_mode	= u300_set_mode,
+		.rating			= 300,
+		.features		= CLOCK_EVT_FEAT_PERIODIC |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		.set_next_event		= u300_set_next_event,
+		.set_state_shutdown	= u300_shutdown,
+		.set_state_periodic	= u300_set_periodic,
+		.set_state_oneshot	= u300_set_oneshot,
 	},
 };
 
-- 
2.4.0
