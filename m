From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:50 +0530
Subject: [PATCH 36/41] clocksource: stm32: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <7fc5a0bfae6062b7fbea71a9a469e6574a1c3cf6.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate stm32 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/timer-stm32.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index a97e8b50701c..f3dcb76799b4 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -40,24 +40,25 @@ struct stm32_clock_event_ddata {
 	void __iomem *base;
 };
 
-static void stm32_clock_event_set_mode(enum clock_event_mode mode,
-				       struct clock_event_device *evtdev)
+static int stm32_clock_event_shutdown(struct clock_event_device *evtdev)
 {
 	struct stm32_clock_event_ddata *data =
 		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
 	void *base = data->base;
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		writel_relaxed(data->periodic_top, base + TIM_ARR);
-		writel_relaxed(TIM_CR1_ARPE | TIM_CR1_CEN, base + TIM_CR1);
-		break;
+	writel_relaxed(0, base + TIM_CR1);
+	return 0;
+}
 
-	case CLOCK_EVT_MODE_ONESHOT:
-	default:
-		writel_relaxed(0, base + TIM_CR1);
-		break;
-	}
+static int stm32_clock_event_set_periodic(struct clock_event_device *evtdev)
+{
+	struct stm32_clock_event_ddata *data =
+		container_of(evtdev, struct stm32_clock_event_ddata, evtdev);
+	void *base = data->base;
+
+	writel_relaxed(data->periodic_top, base + TIM_ARR);
+	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_CEN, base + TIM_CR1);
+	return 0;
 }
 
 static int stm32_clock_event_set_next_event(unsigned long evt,
@@ -88,7 +89,10 @@ static struct stm32_clock_event_ddata clock_event_ddata = {
 	.evtdev = {
 		.name = "stm32 clockevent",
 		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-		.set_mode = stm32_clock_event_set_mode,
+		.set_state_shutdown = stm32_clock_event_shutdown,
+		.set_state_periodic = stm32_clock_event_set_periodic,
+		.set_state_oneshot = stm32_clock_event_shutdown,
+		.tick_resume = stm32_clock_event_shutdown,
 		.set_next_event = stm32_clock_event_set_next_event,
 		.rating = 200,
 	},
-- 
2.4.0
