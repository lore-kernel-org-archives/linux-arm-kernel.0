From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Tue, 12 Jul 2016 11:20:58 +0000
Subject: [PATCH -next] clocksource: cadence_ttc: Fix error handling in
 ttc_setup_clockevent()
Message-ID: <1468322458-32531-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

resources alloc in this function should be release in the error
handling, otherwise it will cause resource leak.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/clocksource/cadence_ttc_timer.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index fbfbdec..020b85c 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -418,10 +418,8 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	ttcce->ttc.clk = clk;
 
 	err = clk_prepare_enable(ttcce->ttc.clk);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
+	if (err)
+		goto err_clk;
 
 	ttcce->ttc.clk_rate_change_nb.notifier_call =
 		ttc_rate_change_clockevent_cb;
@@ -431,7 +429,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 				    &ttcce->ttc.clk_rate_change_nb);
 	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
-		return err;
+		goto err_reg;
 	}
 
 	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
@@ -460,15 +458,21 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 
 	err = request_irq(irq, ttc_clock_event_interrupt,
 			  IRQF_TIMER, ttcce->ce.name, ttcce);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
+	if (err)
+		goto err_irq;
 
 	clockevents_config_and_register(&ttcce->ce,
 			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
 
 	return 0;
+err_irq:
+	clk_notifier_unregister(ttcce->ttc.clk,
+				&ttcce->ttc.clk_rate_change_nb);
+err_reg:
+	clk_disable_unprepare(ttcce->ttc.clk);
+err_clk:
+	kfree(ttcce);
+	return err;
 }
 
 /**
