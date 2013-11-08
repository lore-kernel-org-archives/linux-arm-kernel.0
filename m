From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  8 Nov 2013 13:21:13 -0800
Subject: [PATCH 3/7] clocksource/cadence_ttc: Store timer frequency in driver
 data
In-Reply-To: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1383945677-29674-4-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not allowed to call clk_get_rate() from interrupt context. To
avoid such calls the timer input frequency is stored in the driver's
data struct which makes it accessible to the driver in any context.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clocksource/cadence_ttc_timer.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index b2bb3a4bc205..a92350b55d32 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -67,11 +67,13 @@
  * struct ttc_timer - This definition defines local timer structure
  *
  * @base_addr:	Base address of timer
+ * @freq:	Timer input clock frequency
  * @clk:	Associated clock source
  * @clk_rate_change_nb	Notifier block for clock rate changes
  */
 struct ttc_timer {
 	void __iomem *base_addr;
+	unsigned long freq;
 	struct clk *clk;
 	struct notifier_block clk_rate_change_nb;
 };
@@ -196,9 +198,8 @@ static void ttc_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		ttc_set_interval(timer,
-				DIV_ROUND_CLOSEST(clk_get_rate(ttce->ttc.clk),
-					PRESCALE * HZ));
+		ttc_set_interval(timer, DIV_ROUND_CLOSEST(ttce->ttc.freq,
+						PRESCALE * HZ));
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_UNUSED:
@@ -273,6 +274,8 @@ static void __init ttc_setup_clocksource(struct clk *clk, void __iomem *base)
 		return;
 	}
 
+	ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
+
 	ttccs->ttc.clk_rate_change_nb.notifier_call =
 		ttc_rate_change_clocksource_cb;
 	ttccs->ttc.clk_rate_change_nb.next = NULL;
@@ -298,16 +301,14 @@ static void __init ttc_setup_clocksource(struct clk *clk, void __iomem *base)
 	__raw_writel(CNT_CNTRL_RESET,
 		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
 
-	err = clocksource_register_hz(&ttccs->cs,
-			clk_get_rate(ttccs->ttc.clk) / PRESCALE);
+	err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
 	if (WARN_ON(err)) {
 		kfree(ttccs);
 		return;
 	}
 
 	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
-	setup_sched_clock(ttc_sched_clock_read, 16,
-			clk_get_rate(ttccs->ttc.clk) / PRESCALE);
+	setup_sched_clock(ttc_sched_clock_read, 16, ttccs->ttc.freq / PRESCALE);
 }
 
 static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
@@ -334,6 +335,9 @@ static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
 				ndata->new_rate / PRESCALE);
 		local_irq_restore(flags);
 
+		/* update cached frequency */
+		ttc->freq = ndata->new_rate;
+
 		/* fall through */
 	}
 	case PRE_RATE_CHANGE:
@@ -367,6 +371,7 @@ static void __init ttc_setup_clockevent(struct clk *clk,
 	if (clk_notifier_register(ttcce->ttc.clk,
 				&ttcce->ttc.clk_rate_change_nb))
 		pr_warn("Unable to register clock notifier.\n");
+	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
 
 	ttcce->ttc.base_addr = base;
 	ttcce->ce.name = "ttc_clockevent";
@@ -396,7 +401,7 @@ static void __init ttc_setup_clockevent(struct clk *clk,
 	}
 
 	clockevents_config_and_register(&ttcce->ce,
-			clk_get_rate(ttcce->ttc.clk) / PRESCALE, 1, 0xfffe);
+			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
 }
 
 /**
-- 
1.8.4.2
