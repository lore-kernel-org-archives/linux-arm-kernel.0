From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:27 +0530
Subject: [PATCH 13/41] clocksource: mtk: Migrate to new 'set-state' interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <ebdaf615b9ec5a4ddafe2f2524feb2127e987b56.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate mtk driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/mtk_timer.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
index 68ab42356d0e..50f0641c65b6 100644
--- a/drivers/clocksource/mtk_timer.c
+++ b/drivers/clocksource/mtk_timer.c
@@ -102,27 +102,20 @@ static void mtk_clkevt_time_start(struct mtk_clock_event_device *evt,
 	       evt->gpt_base + TIMER_CTRL_REG(timer));
 }
 
-static void mtk_clkevt_mode(enum clock_event_mode mode,
-				struct clock_event_device *clk)
+static int mtk_clkevt_shutdown(struct clock_event_device *clk)
+{
+	mtk_clkevt_time_stop(to_mtk_clk(clk), GPT_CLK_EVT);
+	return 0;
+}
+
+static int mtk_clkevt_set_periodic(struct clock_event_device *clk)
 {
 	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
 
 	mtk_clkevt_time_stop(evt, GPT_CLK_EVT);
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		mtk_clkevt_time_setup(evt, evt->ticks_per_jiffy, GPT_CLK_EVT);
-		mtk_clkevt_time_start(evt, true, GPT_CLK_EVT);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* Timer is enabled in set_next_event */
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		/* No more interrupts will occur as source is disabled */
-		break;
-	}
+	mtk_clkevt_time_setup(evt, evt->ticks_per_jiffy, GPT_CLK_EVT);
+	mtk_clkevt_time_start(evt, true, GPT_CLK_EVT);
+	return 0;
 }
 
 static int mtk_clkevt_next_event(unsigned long event,
@@ -196,7 +189,10 @@ static void __init mtk_timer_init(struct device_node *node)
 	evt->dev.name = "mtk_tick";
 	evt->dev.rating = 300;
 	evt->dev.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->dev.set_mode = mtk_clkevt_mode;
+	evt->dev.set_state_shutdown = mtk_clkevt_shutdown;
+	evt->dev.set_state_periodic = mtk_clkevt_set_periodic;
+	evt->dev.set_state_oneshot = mtk_clkevt_shutdown;
+	evt->dev.tick_resume = mtk_clkevt_shutdown;
 	evt->dev.set_next_event = mtk_clkevt_next_event;
 	evt->dev.cpumask = cpu_possible_mask;
 
-- 
2.4.0
