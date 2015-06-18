From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:24 +0530
Subject: [PATCH 10/41] clocksource: metag_generic: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <9da54df749f74e796694880feeb60e450811727a.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate metag_generic driver to the new 'set-state' interface provided
by clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in the ->set_mode() callback. Even the WARN()
for periodic or unused modes isn't required anymore as the core is
taking care of that now. So, this patch doesn't provide any set-state
callbacks.

Cc: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/metag_generic.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/clocksource/metag_generic.c b/drivers/clocksource/metag_generic.c
index b7384b853e5a..bcd5c0d602a0 100644
--- a/drivers/clocksource/metag_generic.c
+++ b/drivers/clocksource/metag_generic.c
@@ -56,25 +56,6 @@ static int metag_timer_set_next_event(unsigned long delta,
 	return 0;
 }
 
-static void metag_timer_set_mode(enum clock_event_mode mode,
-				 struct clock_event_device *evt)
-{
-	switch (mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		/* We should disable the IRQ here */
-		break;
-
-	case CLOCK_EVT_MODE_PERIODIC:
-	case CLOCK_EVT_MODE_UNUSED:
-		WARN_ON(1);
-		break;
-	};
-}
-
 static cycle_t metag_clocksource_read(struct clocksource *cs)
 {
 	return __core_reg_get(TXTIMER);
@@ -129,7 +110,6 @@ static void arch_timer_setup(unsigned int cpu)
 	clk->rating = 200,
 	clk->shift = 12,
 	clk->irq = tbisig_map(TBID_SIGNUM_TRT),
-	clk->set_mode = metag_timer_set_mode,
 	clk->set_next_event = metag_timer_set_next_event,
 
 	clk->mult = div_sc(hwtimer_freq, NSEC_PER_SEC, clk->shift);
-- 
2.4.0
