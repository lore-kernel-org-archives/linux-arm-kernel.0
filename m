From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 10 Aug 2015 11:52:08 +0200
Subject: [PATCH 51/74] clockevents/drivers/exynos_mct: Migrate to new
 'set-state' interface
In-Reply-To: <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1439200352-26767-51-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

Migrate exynos_mct driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 85 +++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 4d2330a..029f96a 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -257,15 +257,14 @@ static void exynos4_mct_comp0_stop(void)
 	exynos4_mct_write(0, EXYNOS4_MCT_G_INT_ENB);
 }
 
-static void exynos4_mct_comp0_start(enum clock_event_mode mode,
-				    unsigned long cycles)
+static void exynos4_mct_comp0_start(bool periodic, unsigned long cycles)
 {
 	unsigned int tcon;
 	cycle_t comp_cycle;
 
 	tcon = readl_relaxed(reg_base + EXYNOS4_MCT_G_TCON);
 
-	if (mode == CLOCK_EVT_MODE_PERIODIC) {
+	if (periodic) {
 		tcon |= MCT_G_TCON_COMP0_AUTO_INC;
 		exynos4_mct_write(cycles, EXYNOS4_MCT_G_COMP0_ADD_INCR);
 	}
@@ -283,38 +282,38 @@ static void exynos4_mct_comp0_start(enum clock_event_mode mode,
 static int exynos4_comp_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
-	exynos4_mct_comp0_start(evt->mode, cycles);
+	exynos4_mct_comp0_start(false, cycles);
 
 	return 0;
 }
 
-static void exynos4_comp_set_mode(enum clock_event_mode mode,
-				  struct clock_event_device *evt)
+static int mct_set_state_shutdown(struct clock_event_device *evt)
 {
-	unsigned long cycles_per_jiffy;
 	exynos4_mct_comp0_stop();
+	return 0;
+}
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		cycles_per_jiffy =
-			(((unsigned long long) NSEC_PER_SEC / HZ * evt->mult) >> evt->shift);
-		exynos4_mct_comp0_start(mode, cycles_per_jiffy);
-		break;
+static int mct_set_state_periodic(struct clock_event_device *evt)
+{
+	unsigned long cycles_per_jiffy;
 
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+	cycles_per_jiffy = (((unsigned long long)NSEC_PER_SEC / HZ * evt->mult)
+			    >> evt->shift);
+	exynos4_mct_comp0_stop();
+	exynos4_mct_comp0_start(true, cycles_per_jiffy);
+	return 0;
 }
 
 static struct clock_event_device mct_comp_device = {
-	.name		= "mct-comp",
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 250,
-	.set_next_event	= exynos4_comp_set_next_event,
-	.set_mode	= exynos4_comp_set_mode,
+	.name			= "mct-comp",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 250,
+	.set_next_event		= exynos4_comp_set_next_event,
+	.set_state_periodic	= mct_set_state_periodic,
+	.set_state_shutdown	= mct_set_state_shutdown,
+	.set_state_oneshot	= mct_set_state_shutdown,
+	.tick_resume		= mct_set_state_shutdown,
 };
 
 static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
@@ -390,39 +389,32 @@ static int exynos4_tick_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
-					 struct clock_event_device *evt)
+static int set_state_shutdown(struct clock_event_device *evt)
+{
+	exynos4_mct_tick_stop(this_cpu_ptr(&percpu_mct_tick));
+	return 0;
+}
+
+static int set_state_periodic(struct clock_event_device *evt)
 {
 	struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
 	unsigned long cycles_per_jiffy;
 
+	cycles_per_jiffy = (((unsigned long long)NSEC_PER_SEC / HZ * evt->mult)
+			    >> evt->shift);
 	exynos4_mct_tick_stop(mevt);
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		cycles_per_jiffy =
-			(((unsigned long long) NSEC_PER_SEC / HZ * evt->mult) >> evt->shift);
-		exynos4_mct_tick_start(cycles_per_jiffy, mevt);
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+	exynos4_mct_tick_start(cycles_per_jiffy, mevt);
+	return 0;
 }
 
 static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
 {
-	struct clock_event_device *evt = &mevt->evt;
-
 	/*
 	 * This is for supporting oneshot mode.
 	 * Mct would generate interrupt periodically
 	 * without explicit stopping.
 	 */
-	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
+	if (!clockevent_state_periodic(&mevt->evt))
 		exynos4_mct_tick_stop(mevt);
 
 	/* Clear the MCT tick interrupt */
@@ -453,7 +445,10 @@ static int exynos4_local_timer_setup(struct mct_clock_event_device *mevt)
 	evt->name = mevt->name;
 	evt->cpumask = cpumask_of(cpu);
 	evt->set_next_event = exynos4_tick_set_next_event;
-	evt->set_mode = exynos4_tick_set_mode;
+	evt->set_state_periodic = set_state_periodic;
+	evt->set_state_shutdown = set_state_shutdown;
+	evt->set_state_oneshot = set_state_shutdown;
+	evt->tick_resume = set_state_shutdown;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	evt->rating = 450;
 
@@ -479,7 +474,7 @@ static void exynos4_local_timer_stop(struct mct_clock_event_device *mevt)
 {
 	struct clock_event_device *evt = &mevt->evt;
 
-	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
+	evt->set_state_shutdown(evt);
 	if (mct_int_type == MCT_INT_SPI) {
 		if (evt->irq != -1)
 			disable_irq_nosync(evt->irq);
-- 
1.9.1
