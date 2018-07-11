From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 11 Jul 2018 12:24:22 +0100
Subject: [PATCH 1/3] clocksource: drivers: set clockevent device cpumask to
 cpu_possible_mask
Message-ID: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, quite a few clockevent devices have cpumask set to
cpu_all_mask which should be fine. However, cpu_possible_mask is more
accurate and if there are any other clockevent devices in the system
which have cpumask set to cpu_possible_mask, then having cpu_all_mask
may result in issues (mostly boot hang with forever loops in
clockevents_notify_released).

So, lets replace all the clockevent device cpu_all_mask to
cpu_possible_mask in order to prevent above mentioned possible issue.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clocksource/tegra20_timer.c   | 2 +-
 drivers/clocksource/timer-atcpit100.c | 2 +-
 drivers/clocksource/timer-keystone.c  | 2 +-
 drivers/clocksource/zevio-timer.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index c337a8100a7b..dabf0a103567 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -230,7 +230,7 @@ static int __init tegra20_init_timer(struct device_node *np)
 		return ret;
 	}

-	tegra_clockevent.cpumask = cpu_all_mask;
+	tegra_clockevent.cpumask = cpu_possible_mask;
 	tegra_clockevent.irq = tegra_timer_irq.irq;
 	clockevents_config_and_register(&tegra_clockevent, 1000000,
 					0x1, 0x1fffffff);
diff --git a/drivers/clocksource/timer-atcpit100.c b/drivers/clocksource/timer-atcpit100.c
index 5e23d7b4a722..b4bd2f5b801d 100644
--- a/drivers/clocksource/timer-atcpit100.c
+++ b/drivers/clocksource/timer-atcpit100.c
@@ -185,7 +185,7 @@ static struct timer_of to = {
 		.set_state_oneshot = atcpit100_clkevt_set_oneshot,
 		.tick_resume = atcpit100_clkevt_shutdown,
 		.set_next_event = atcpit100_clkevt_next_event,
-		.cpumask = cpu_all_mask,
+		.cpumask = cpu_possible_mask,
 	},

 	.of_irq = {
diff --git a/drivers/clocksource/timer-keystone.c b/drivers/clocksource/timer-keystone.c
index 0eee03250cfc..f5b2eda30bf3 100644
--- a/drivers/clocksource/timer-keystone.c
+++ b/drivers/clocksource/timer-keystone.c
@@ -211,7 +211,7 @@ static int __init keystone_timer_init(struct device_node *np)
 	event_dev->set_state_shutdown = keystone_shutdown;
 	event_dev->set_state_periodic = keystone_set_periodic;
 	event_dev->set_state_oneshot = keystone_shutdown;
-	event_dev->cpumask = cpu_all_mask;
+	event_dev->cpumask = cpu_possible_mask;
 	event_dev->owner = THIS_MODULE;
 	event_dev->name = TIMER_NAME;
 	event_dev->irq = irq;
diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/zevio-timer.c
index a6a0338eea77..f74689334f7c 100644
--- a/drivers/clocksource/zevio-timer.c
+++ b/drivers/clocksource/zevio-timer.c
@@ -162,7 +162,7 @@ static int __init zevio_timer_add(struct device_node *node)
 		timer->clkevt.set_state_oneshot = zevio_timer_set_oneshot;
 		timer->clkevt.tick_resume	= zevio_timer_set_oneshot;
 		timer->clkevt.rating		= 200;
-		timer->clkevt.cpumask		= cpu_all_mask;
+		timer->clkevt.cpumask		= cpu_possible_mask;
 		timer->clkevt.features		= CLOCK_EVT_FEAT_ONESHOT;
 		timer->clkevt.irq		= irqnr;

--
2.7.4
