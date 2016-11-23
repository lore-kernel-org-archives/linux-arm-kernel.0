From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 23 Nov 2016 20:29:35 +0300
Subject: [PATCH 7/9] clocksource/drivers/rockchip_timer: implement clocksource
 timer
In-Reply-To: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
References: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1479922177-20136-7-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch implement stable clocksource for rk3188. It register
one of the timers as clocksource and sched_clock. Also it override
arm_global_timer clocksource using rating property (350).

arm_global_timer enabled on rk3188 provide unstable clocksource.
It's rate depend on ARM CPU rate. As result the command 'sleep 60'
could run either ~60s (with CPU freq 312 MHZ) or ~45s (with CPU
freq 1.6GHz).

In order to use the patch you have to setup the timer using
'rockchip,clocksource' device tree property. timer6 was used as
clocksource in kernel 3.0 from rockchip SDK.

    cpufreq-set -f 1.6GHZ
    date; sleep 60; date

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/clocksource/rockchip_timer.c |   79 +++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index 61787c5..77bea97 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -11,6 +11,7 @@
 #include <linux/clockchips.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/sched_clock.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -42,7 +43,13 @@ struct rk_clock_event_device {
 	struct rk_timer timer;
 };
 
+struct rk_clocksource {
+	struct clocksource cs;
+	struct rk_timer timer;
+};
+
 static struct rk_clock_event_device bc_timer;
+static struct rk_clocksource cs_timer;
 
 static inline struct rk_clock_event_device*
 rk_clock_event_device(struct clock_event_device *ce)
@@ -139,14 +146,35 @@ static irqreturn_t rk_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static cycle_t rk_timer_clocksource_read(struct clocksource *cs)
+{
+	struct rk_clocksource *_cs = container_of(cs, struct rk_clocksource, cs);
+	return ~rk_timer_counter_read(&_cs->timer);
+}
+
+static u64 notrace rk_timer_sched_clock_read(void)
+{
+	struct rk_clocksource *_cs = &cs_timer;
+	return ~rk_timer_counter_read(&_cs->timer);
+}
+
 static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
 {
-	struct clock_event_device *ce = &bc_timer.ce;
-	struct rk_timer *timer = &bc_timer.timer;
+	struct clock_event_device *ce = NULL;
+	struct clocksource *cs = NULL;
+	struct rk_timer *timer = NULL;
 	struct clk *timer_clk;
 	struct clk *pclk;
 	int ret = -EINVAL, irq;
 
+	if (of_property_read_bool(np, "rockchip,clocksource")) {
+		cs = &cs_timer.cs;
+		timer = &cs_timer.timer;
+	} else {
+		ce = &bc_timer.ce;
+		timer = &bc_timer.timer;
+	}
+
 	timer->base = of_iomap(np, 0);
 	if (!timer->base) {
 		pr_err("Failed to get base address for '%s'\n", TIMER_NAME);
@@ -189,26 +217,45 @@ static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
 		goto out_irq;
 	}
 
-	ce->name = TIMER_NAME;
-	ce->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-		       CLOCK_EVT_FEAT_DYNIRQ;
-	ce->set_next_event = rk_timer_set_next_event;
-	ce->set_state_shutdown = rk_timer_shutdown;
-	ce->set_state_periodic = rk_timer_set_periodic;
-	ce->irq = irq;
-	ce->cpumask = cpu_possible_mask;
-	ce->rating = 250;
+	if (ce) {
+		ce->name = TIMER_NAME;
+		ce->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+			       CLOCK_EVT_FEAT_DYNIRQ;
+		ce->set_next_event = rk_timer_set_next_event;
+		ce->set_state_shutdown = rk_timer_shutdown;
+		ce->set_state_periodic = rk_timer_set_periodic;
+		ce->irq = irq;
+		ce->cpumask = cpu_possible_mask;
+		ce->rating = 250;
+	}
+
+	if (cs) {
+		cs->name = TIMER_NAME;
+		cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
+		cs->mask = CLOCKSOURCE_MASK(64);
+		cs->read = rk_timer_clocksource_read;
+		cs->rating = 350;
+	}
 
 	rk_timer_interrupt_clear(timer);
 	rk_timer_disable(timer);
 
-	ret = request_irq(irq, rk_timer_interrupt, IRQF_TIMER, TIMER_NAME, ce);
-	if (ret) {
-		pr_err("Failed to initialize '%s': %d\n", TIMER_NAME, ret);
-		goto out_irq;
+	if (ce) {
+		ret = request_irq(irq, rk_timer_interrupt, IRQF_TIMER, TIMER_NAME, ce);
+		if (ret) {
+			pr_err("Failed to initialize '%s': %d\n", TIMER_NAME, ret);
+			goto out_irq;
+		}
+
+		clockevents_config_and_register(ce, timer->freq, 1, UINT_MAX);
 	}
 
-	clockevents_config_and_register(ce, timer->freq, 1, UINT_MAX);
+	if (cs) {
+		rk_timer_update_counter(U64_MAX, timer);
+		rk_timer_enable(timer, 0);
+		clocksource_register_hz(cs, timer->freq);
+		sched_clock_register(rk_timer_sched_clock_read, 64, timer->freq);
+	}
 
 	return 0;
 
-- 
1.7.9.5
