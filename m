From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:18 +0530
Subject: [PATCH 04/41] clocksource: dummy_timer: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <c502146bb8cf6dc9c14c9f1aa116523e6e7d7e5d.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate dummy_timer driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

We weren't doing anything in the ->set_mode() callback. So, this patch
doesn't provide any set-state callbacks.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Viresh Kumae <viresh.kumar@linaro.org>
---
 drivers/clocksource/dummy_timer.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/clocksource/dummy_timer.c b/drivers/clocksource/dummy_timer.c
index 31990600fcff..776b6c86dcd5 100644
--- a/drivers/clocksource/dummy_timer.c
+++ b/drivers/clocksource/dummy_timer.c
@@ -16,15 +16,6 @@
 
 static DEFINE_PER_CPU(struct clock_event_device, dummy_timer_evt);
 
-static void dummy_timer_set_mode(enum clock_event_mode mode,
-			   struct clock_event_device *evt)
-{
-	/*
-	 * Core clockevents code will call this when exchanging timer devices.
-	 * We don't need to do anything here.
-	 */
-}
-
 static void dummy_timer_setup(void)
 {
 	int cpu = smp_processor_id();
@@ -35,7 +26,6 @@ static void dummy_timer_setup(void)
 			  CLOCK_EVT_FEAT_ONESHOT |
 			  CLOCK_EVT_FEAT_DUMMY;
 	evt->rating	= 100;
-	evt->set_mode	= dummy_timer_set_mode;
 	evt->cpumask	= cpumask_of(cpu);
 
 	clockevents_register_device(evt);
-- 
2.4.0
