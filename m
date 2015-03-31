From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 31 Mar 2015 12:12:26 +0200
Subject: [PATCH 5/5] clocksource/drivers/sun5i: Add clock notifiers
In-Reply-To: <1427796746-373-1-git-send-email-daniel.lezcano@linaro.org>
References: <551A72B6.7030106@linaro.org>
 <1427796746-373-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1427796746-373-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The parent clock of the sun5i timer is the AHB clock, which rate might change
because of other devices requirements.

This is for example the case on the Allwinner A31, where the DMA controller
needs a minimum rate higher than the default, that is enforced after the timer
driver has probed.

Add clock notifiers to make sure we reflect the clock rate changes in the timer
rates.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun5i.c | 68 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 5a4f820..18616e6 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -40,9 +40,13 @@
 struct sun5i_timer {
 	void __iomem		*base;
 	struct clk		*clk;
+	struct notifier_block	clk_rate_cb;
 	u32			ticks_per_jiffy;
 };
 
+#define to_sun5i_timer(x) \
+	container_of(x, struct sun5i_timer, clk_rate_cb)
+
 struct sun5i_timer_clksrc {
 	struct sun5i_timer	timer;
 	struct clocksource	clksrc;
@@ -151,6 +155,30 @@ static cycle_t sun5i_clksrc_read(struct clocksource *clksrc)
 	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
 }
 
+static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
+				unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct sun5i_timer *timer = to_sun5i_timer(nb);
+	struct sun5i_timer_clksrc *cs = container_of(timer,
+						     struct sun5i_timer_clksrc, timer);
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		clocksource_unregister(&cs->clksrc);
+		break;
+
+	case POST_RATE_CHANGE:
+		clocksource_register_hz(&cs->clksrc, ndata->new_rate);
+		break;
+
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 static int __init sun5i_setup_clocksource(struct device_node *node,
 					  void __iomem *base,
 					  struct clk *clk, int irq)
@@ -173,6 +201,14 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 
 	cs->timer.base = base;
 	cs->timer.clk = clk;
+	cs->timer.clk_rate_cb.notifier_call = sun5i_rate_cb_clksrc;
+	cs->timer.clk_rate_cb.next = NULL;
+
+	ret = clk_notifier_register(clk, &cs->timer.clk_rate_cb);
+	if (ret) {
+		pr_err("Unable to register clock notifier.\n");
+		goto err_disable_clk;
+	}
 
 	writel(~0, base + TIMER_INTVAL_LO_REG(1));
 	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
@@ -187,11 +223,13 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 	ret = clocksource_register_hz(&cs->clksrc, rate);
 	if (ret) {
 		pr_err("Couldn't register clock source.\n");
-		goto err_disable_clk;
+		goto err_remove_notifier;
 	}
 
 	return 0;
 
+err_remove_notifier:
+	clk_notifier_unregister(clk, &cs->timer.clk_rate_cb);
 err_disable_clk:
 	clk_disable_unprepare(clk);
 err_free:
@@ -199,6 +237,22 @@ err_free:
 	return ret;
 }
 
+static int sun5i_rate_cb_clkevt(struct notifier_block *nb,
+				unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct sun5i_timer *timer = to_sun5i_timer(nb);
+	struct sun5i_timer_clkevt *ce = container_of(timer,
+						     struct sun5i_timer_clkevt, timer);
+
+	if (event == POST_RATE_CHANGE) {
+		clockevents_update_freq(&ce->clkevt, ndata->new_rate);
+		ce->timer.ticks_per_jiffy = DIV_ROUND_UP(ndata->new_rate, HZ);
+	}
+
+	return NOTIFY_DONE;
+}
+
 static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem *base,
 					 struct clk *clk, int irq)
 {
@@ -222,6 +276,14 @@ static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem
 	ce->timer.base = base;
 	ce->timer.ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
 	ce->timer.clk = clk;
+	ce->timer.clk_rate_cb.notifier_call = sun5i_rate_cb_clkevt;
+	ce->timer.clk_rate_cb.next = NULL;
+
+	ret = clk_notifier_register(clk, &ce->timer.clk_rate_cb);
+	if (ret) {
+		pr_err("Unable to register clock notifier.\n");
+		goto err_disable_clk;
+	}
 
 	ce->clkevt.name = node->name;
 	ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
@@ -242,11 +304,13 @@ static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem
 			  "sun5i_timer0", ce);
 	if (ret) {
 		pr_err("Unable to register interrupt\n");
-		goto err_disable_clk;
+		goto err_remove_notifier;
 	}
 
 	return 0;
 
+err_remove_notifier:
+	clk_notifier_unregister(clk, &ce->timer.clk_rate_cb);
 err_disable_clk:
 	clk_disable_unprepare(clk);
 err_free:
-- 
1.9.1
