From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:22 +0530
Subject: [PATCH 08/41] clocksource: i8253: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <d30aeb9bfee60f4121a4b6c73f7d09915a9503b2.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate i8253 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/x86/kernel/i8253.c     |  2 +-
 drivers/clocksource/i8253.c | 77 ++++++++++++++++++++++-----------------------
 2 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index f2b96de3c7c1..efb82f07b29c 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -34,7 +34,7 @@ static int __init init_pit_clocksource(void)
 	  * - when local APIC timer is active (PIT is switched off)
 	  */
 	if (num_possible_cpus() > 1 || is_hpet_enabled() ||
-	    i8253_clockevent.mode != CLOCK_EVT_MODE_PERIODIC)
+	    !clockevent_state_periodic(&i8253_clockevent))
 		return 0;
 
 	return clocksource_i8253_init();
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 14ee3efcc404..0efd36e483ab 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -100,44 +100,40 @@ int __init clocksource_i8253_init(void)
 #endif
 
 #ifdef CONFIG_CLKEVT_I8253
-/*
- * Initialize the PIT timer.
- *
- * This is also called after resume to bring the PIT into operation again.
- */
-static void init_pit_timer(enum clock_event_mode mode,
-			   struct clock_event_device *evt)
+static int pit_shutdown(struct clock_event_device *evt)
 {
+	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
+		return 0;
+
 	raw_spin_lock(&i8253_lock);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		/* binary, mode 2, LSB/MSB, ch 0 */
-		outb_p(0x34, PIT_MODE);
-		outb_p(PIT_LATCH & 0xff , PIT_CH0);	/* LSB */
-		outb_p(PIT_LATCH >> 8 , PIT_CH0);		/* MSB */
-		break;
-
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-		if (evt->mode == CLOCK_EVT_MODE_PERIODIC ||
-		    evt->mode == CLOCK_EVT_MODE_ONESHOT) {
-			outb_p(0x30, PIT_MODE);
-			outb_p(0, PIT_CH0);
-			outb_p(0, PIT_CH0);
-		}
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* One shot setup */
-		outb_p(0x38, PIT_MODE);
-		break;
-
-	case CLOCK_EVT_MODE_RESUME:
-		/* Nothing to do here */
-		break;
-	}
+	outb_p(0x30, PIT_MODE);
+	outb_p(0, PIT_CH0);
+	outb_p(0, PIT_CH0);
+
+	raw_spin_unlock(&i8253_lock);
+	return 0;
+}
+
+static int pit_set_oneshot(struct clock_event_device *evt)
+{
+	raw_spin_lock(&i8253_lock);
+	outb_p(0x38, PIT_MODE);
+	raw_spin_unlock(&i8253_lock);
+	return 0;
+}
+
+static int pit_set_periodic(struct clock_event_device *evt)
+{
+	raw_spin_lock(&i8253_lock);
+
+	/* binary, mode 2, LSB/MSB, ch 0 */
+	outb_p(0x34, PIT_MODE);
+	outb_p(PIT_LATCH & 0xff, PIT_CH0);	/* LSB */
+	outb_p(PIT_LATCH >> 8, PIT_CH0);	/* MSB */
+
 	raw_spin_unlock(&i8253_lock);
+	return 0;
 }
 
 /*
@@ -160,10 +156,11 @@ static int pit_next_event(unsigned long delta, struct clock_event_device *evt)
  * it can be solely used for the global tick.
  */
 struct clock_event_device i8253_clockevent = {
-	.name		= "pit",
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
-	.set_mode	= init_pit_timer,
-	.set_next_event = pit_next_event,
+	.name			= "pit",
+	.features		= CLOCK_EVT_FEAT_PERIODIC,
+	.set_state_shutdown	= pit_shutdown,
+	.set_state_periodic	= pit_set_periodic,
+	.set_next_event		= pit_next_event,
 };
 
 /*
@@ -172,8 +169,10 @@ struct clock_event_device i8253_clockevent = {
  */
 void __init clockevent_i8253_init(bool oneshot)
 {
-	if (oneshot)
+	if (oneshot) {
 		i8253_clockevent.features |= CLOCK_EVT_FEAT_ONESHOT;
+		i8253_clockevent.set_state_oneshot = pit_set_oneshot;
+	}
 	/*
 	 * Start pit with the boot cpu mask. x86 might make it global
 	 * when it is used as broadcast device later.
-- 
2.4.0
