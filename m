From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:39 +0530
Subject: [PATCH 25/41] clocksource: tegra20: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <1888421925acbfbcc453488d254faa154cd0fc2b.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate tegra20 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Thierry Reding <treding@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/tegra20_timer.c | 40 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index 5a112d72fc2d..e6083d3d762b 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -72,33 +72,31 @@ static int tegra_timer_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-static void tegra_timer_set_mode(enum clock_event_mode mode,
-				    struct clock_event_device *evt)
+static int tegra_timer_shutdown(struct clock_event_device *evt)
 {
-	u32 reg;
-
 	timer_writel(0, TIMER3_BASE + TIMER_PTV);
+	return 0;
+}
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		reg = 0xC0000000 | ((1000000/HZ)-1);
-		timer_writel(reg, TIMER3_BASE + TIMER_PTV);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+static int tegra_timer_set_periodic(struct clock_event_device *evt)
+{
+	u32 reg = 0xC0000000 | ((1000000 / HZ) - 1);
+
+	timer_writel(0, TIMER3_BASE + TIMER_PTV);
+	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
+	return 0;
 }
 
 static struct clock_event_device tegra_clockevent = {
-	.name		= "timer0",
-	.rating		= 300,
-	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-	.set_next_event	= tegra_timer_set_next_event,
-	.set_mode	= tegra_timer_set_mode,
+	.name			= "timer0",
+	.rating			= 300,
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PERIODIC,
+	.set_next_event		= tegra_timer_set_next_event,
+	.set_state_shutdown	= tegra_timer_shutdown,
+	.set_state_periodic	= tegra_timer_set_periodic,
+	.set_state_oneshot	= tegra_timer_shutdown,
+	.tick_resume		= tegra_timer_shutdown,
 };
 
 static u64 notrace tegra_read_sched_clock(void)
-- 
2.4.0
