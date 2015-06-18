From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:25 +0530
Subject: [PATCH 11/41] clocksource: mips-gic: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <d3dcd15d3935e2a13761352f3561f8bb190f619d.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate mips-gic driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in the ->set_mode() callback. So, this patch
doesn't provide any set-state callbacks.

Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/mips-gic-timer.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index b81ed1a5342d..c3810b61c815 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -33,12 +33,6 @@ static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
 	return res;
 }
 
-static void gic_set_clock_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
-{
-	/* Nothing to do ...  */
-}
-
 static irqreturn_t gic_compare_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *cd = dev_id;
@@ -67,7 +61,6 @@ static void gic_clockevent_cpu_init(struct clock_event_device *cd)
 	cd->irq			= gic_timer_irq;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= gic_next_event;
-	cd->set_mode		= gic_set_clock_mode;
 
 	clockevents_config_and_register(cd, gic_frequency, 0x300, 0x7fffffff);
 
-- 
2.4.0
