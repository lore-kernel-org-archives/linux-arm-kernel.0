From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:19 +0530
Subject: [PATCH 05/41] clocksource: dw_apb: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <8fc35aa8bdb893ee9e92e3f3c7af2671b8ed8319.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate dw_apb driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Jamie Iles <jamie@jamieiles.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/dw_apb_timer.c | 143 +++++++++++++++++++++----------------
 1 file changed, 81 insertions(+), 62 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index 35a88097af3c..97ba7cbc2cbd 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -110,71 +110,87 @@ static void apbt_enable_int(struct dw_apb_timer *timer)
 	apbt_writel(timer, ctrl, APBTMR_N_CONTROL);
 }
 
-static void apbt_set_mode(enum clock_event_mode mode,
-			  struct clock_event_device *evt)
+static int apbt_shutdown(struct clock_event_device *evt)
 {
+	struct dw_apb_clock_event_device *dw_ced = ced_to_dw_apb_ced(evt);
 	unsigned long ctrl;
-	unsigned long period;
+
+	pr_debug("%s CPU %d state=shutdown\n", __func__,
+		 cpumask_first(evt->cpumask));
+
+	ctrl = apbt_readl(&dw_ced->timer, APBTMR_N_CONTROL);
+	ctrl &= ~APBTMR_CONTROL_ENABLE;
+	apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
+	return 0;
+}
+
+static int apbt_set_oneshot(struct clock_event_device *evt)
+{
 	struct dw_apb_clock_event_device *dw_ced = ced_to_dw_apb_ced(evt);
+	unsigned long ctrl;
 
-	pr_debug("%s CPU %d mode=%d\n", __func__,
-		 cpumask_first(evt->cpumask),
-		 mode);
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		period = DIV_ROUND_UP(dw_ced->timer.freq, HZ);
-		ctrl = apbt_readl(&dw_ced->timer, APBTMR_N_CONTROL);
-		ctrl |= APBTMR_CONTROL_MODE_PERIODIC;
-		apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
-		/*
-		 * DW APB p. 46, have to disable timer before load counter,
-		 * may cause sync problem.
-		 */
-		ctrl &= ~APBTMR_CONTROL_ENABLE;
-		apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
-		udelay(1);
-		pr_debug("Setting clock period %lu for HZ %d\n", period, HZ);
-		apbt_writel(&dw_ced->timer, period, APBTMR_N_LOAD_COUNT);
-		ctrl |= APBTMR_CONTROL_ENABLE;
-		apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		ctrl = apbt_readl(&dw_ced->timer, APBTMR_N_CONTROL);
-		/*
-		 * set free running mode, this mode will let timer reload max
-		 * timeout which will give time (3min on 25MHz clock) to rearm
-		 * the next event, therefore emulate the one-shot mode.
-		 */
-		ctrl &= ~APBTMR_CONTROL_ENABLE;
-		ctrl &= ~APBTMR_CONTROL_MODE_PERIODIC;
-
-		apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
-		/* write again to set free running mode */
-		apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
-
-		/*
-		 * DW APB p. 46, load counter with all 1s before starting free
-		 * running mode.
-		 */
-		apbt_writel(&dw_ced->timer, ~0, APBTMR_N_LOAD_COUNT);
-		ctrl &= ~APBTMR_CONTROL_INT;
-		ctrl |= APBTMR_CONTROL_ENABLE;
-		apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		ctrl = apbt_readl(&dw_ced->timer, APBTMR_N_CONTROL);
-		ctrl &= ~APBTMR_CONTROL_ENABLE;
-		apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
-		break;
-
-	case CLOCK_EVT_MODE_RESUME:
-		apbt_enable_int(&dw_ced->timer);
-		break;
-	}
+	pr_debug("%s CPU %d state=oneshot\n", __func__,
+		 cpumask_first(evt->cpumask));
+
+	ctrl = apbt_readl(&dw_ced->timer, APBTMR_N_CONTROL);
+	/*
+	 * set free running mode, this mode will let timer reload max
+	 * timeout which will give time (3min on 25MHz clock) to rearm
+	 * the next event, therefore emulate the one-shot mode.
+	 */
+	ctrl &= ~APBTMR_CONTROL_ENABLE;
+	ctrl &= ~APBTMR_CONTROL_MODE_PERIODIC;
+
+	apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
+	/* write again to set free running mode */
+	apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
+
+	/*
+	 * DW APB p. 46, load counter with all 1s before starting free
+	 * running mode.
+	 */
+	apbt_writel(&dw_ced->timer, ~0, APBTMR_N_LOAD_COUNT);
+	ctrl &= ~APBTMR_CONTROL_INT;
+	ctrl |= APBTMR_CONTROL_ENABLE;
+	apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
+	return 0;
+}
+
+static int apbt_set_periodic(struct clock_event_device *evt)
+{
+	struct dw_apb_clock_event_device *dw_ced = ced_to_dw_apb_ced(evt);
+	unsigned long period = DIV_ROUND_UP(dw_ced->timer.freq, HZ);
+	unsigned long ctrl;
+
+	pr_debug("%s CPU %d state=periodic\n", __func__,
+		 cpumask_first(evt->cpumask));
+
+	ctrl = apbt_readl(&dw_ced->timer, APBTMR_N_CONTROL);
+	ctrl |= APBTMR_CONTROL_MODE_PERIODIC;
+	apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
+	/*
+	 * DW APB p. 46, have to disable timer before load counter,
+	 * may cause sync problem.
+	 */
+	ctrl &= ~APBTMR_CONTROL_ENABLE;
+	apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
+	udelay(1);
+	pr_debug("Setting clock period %lu for HZ %d\n", period, HZ);
+	apbt_writel(&dw_ced->timer, period, APBTMR_N_LOAD_COUNT);
+	ctrl |= APBTMR_CONTROL_ENABLE;
+	apbt_writel(&dw_ced->timer, ctrl, APBTMR_N_CONTROL);
+	return 0;
+}
+
+static int apbt_resume(struct clock_event_device *evt)
+{
+	struct dw_apb_clock_event_device *dw_ced = ced_to_dw_apb_ced(evt);
+
+	pr_debug("%s CPU %d state=resume\n", __func__,
+		 cpumask_first(evt->cpumask));
+
+	apbt_enable_int(&dw_ced->timer);
+	return 0;
 }
 
 static int apbt_next_event(unsigned long delta,
@@ -233,7 +249,10 @@ dw_apb_clockevent_init(int cpu, const char *name, unsigned rating,
 	dw_ced->ced.min_delta_ns = clockevent_delta2ns(5000, &dw_ced->ced);
 	dw_ced->ced.cpumask = cpumask_of(cpu);
 	dw_ced->ced.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	dw_ced->ced.set_mode = apbt_set_mode;
+	dw_ced->ced.set_state_shutdown = apbt_shutdown;
+	dw_ced->ced.set_state_periodic = apbt_set_periodic;
+	dw_ced->ced.set_state_oneshot = apbt_set_oneshot;
+	dw_ced->ced.tick_resume = apbt_resume;
 	dw_ced->ced.set_next_event = apbt_next_event;
 	dw_ced->ced.irq = dw_ced->timer.irq;
 	dw_ced->ced.rating = rating;
-- 
2.4.0
