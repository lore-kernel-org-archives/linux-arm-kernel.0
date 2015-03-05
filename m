From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Mar 2015 11:20:56 +0100
Subject: [PATCH v3 5/5] clocksource: sun5i: Add clock notifiers
In-Reply-To: <1425550856-12928-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1425550856-12928-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1425550856-12928-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The parent clock of the sun5i timer is the AHB clock, which rate might change
because of other devices requirements.

This is for example the case on the Allwinner A31, where the DMA controller
needs a minimum rate higher than the default, that is enforced after the timer
driver has probed.

Add clock notifiers to make sure we reflect the clock rate changes in the timer
rates.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/timer-sun5i.c | 68 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 377e50450781..ba405c5fa2b1 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -41,9 +41,13 @@
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
@@ -152,6 +156,30 @@ static cycle_t sun5i_clksrc_read(struct clocksource *clksrc)
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
@@ -174,6 +202,14 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 
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
@@ -188,11 +224,13 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
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
@@ -200,6 +238,22 @@ err_free:
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
@@ -223,6 +277,14 @@ static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem
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
@@ -240,7 +302,7 @@ static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem
 			  "sun5i_timer0", ce);
 	if (ret) {
 		pr_err("Unable to register interrupt\n");
-		goto err_disable_clk;
+		goto err_remove_notifier;
 	}
 
 	clockevents_config_and_register(&ce->clkevt, rate,
@@ -248,6 +310,8 @@ static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem
 
 	return 0;
 
+err_remove_notifier:
+	clk_notifier_unregister(clk, &ce->timer.clk_rate_cb);
 err_disable_clk:
 	clk_disable_unprepare(clk);
 err_free:
-- 
2.3.0
