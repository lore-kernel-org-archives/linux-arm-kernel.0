From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 24 Jan 2017 15:16:43 +0300
Subject: [PATCH v5 8/8] clocksource/drivers/rockchip_timer: implement
 clocksource timer
In-Reply-To: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
References: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1485260203-14216-9-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock supplying the arm-global-timer on the rk3188 is coming from the
the cpu clock itself and thus changes its rate everytime cpufreq adjusts
the cpu frequency making this timer unsuitable as a stable clocksource
and sched clock.

The rk3188, rk3288 and following socs share a separate timer block already
handled by the rockchip-timer driver. Therefore adapt this driver to also
be able to act as clocksource and sched clock on rk3188.

In order to test clocksource you can run following commands and check
how much time it take in real. On rk3188 it take about ~45 seconds.

    cpufreq-set -f 1.6GHZ
    date; sleep 60; date

In order to use the patch you need to declare two timers in the dts
file. The first timer will be initialized as clockevent provider
and the second one as clocksource. The clockevent must be from
alive subsystem as it used as backup for the local timers at sleep
time.

The patch does not break compatibility with older device tree files.
The older device tree files contain only one timer. The timer
will be initialized as clockevent, as expected.

rk3288 (and probably anything newer) is irrelevant to this patch,
as it has the arch timer interface. This patch may be usefull
for Cortex-A9/A5 based parts.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Reviwed-by: Heiko St?bner <heiko@sntech.de>
---
 drivers/clocksource/rockchip_timer.c |  137 +++++++++++++++++++++++++++++-----
 1 file changed, 117 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index 61c3bb1..3ff533c 100644
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
@@ -19,6 +20,8 @@
 
 #define TIMER_LOAD_COUNT0	0x00
 #define TIMER_LOAD_COUNT1	0x04
+#define TIMER_CURRENT_VALUE0	0x08
+#define TIMER_CURRENT_VALUE1	0x0C
 #define TIMER_CONTROL_REG3288	0x10
 #define TIMER_CONTROL_REG3399	0x1c
 #define TIMER_INT_STATUS	0x18
@@ -40,7 +43,19 @@ struct rk_clock_event_device {
 	struct rk_timer timer;
 };
 
+struct rk_clocksource {
+	struct clocksource cs;
+	struct rk_timer timer;
+};
+
+enum {
+	ROCKCHIP_CLKSRC_CLOCKEVENT = 0,
+	ROCKCHIP_CLKSRC_CLOCKSOURCE = 1,
+};
+
 static struct rk_clock_event_device bc_timer;
+static struct rk_clocksource cs_timer;
+static int rk_next_clksrc = ROCKCHIP_CLKSRC_CLOCKEVENT;
 
 static inline struct rk_clock_event_device*
 rk_clock_event_device(struct clock_event_device *ce)
@@ -63,11 +78,37 @@ static inline void rk_timer_enable(struct rk_timer *timer, u32 flags)
 	writel_relaxed(TIMER_ENABLE | flags, timer->ctrl);
 }
 
-static void rk_timer_update_counter(unsigned long cycles,
-				    struct rk_timer *timer)
+static void rk_timer_update_counter(u64 cycles, struct rk_timer *timer)
+{
+	u32 lower = cycles & 0xFFFFFFFF;
+	u32 upper = (cycles >> 32) & 0xFFFFFFFF;
+
+	writel_relaxed(lower, timer->base + TIMER_LOAD_COUNT0);
+	writel_relaxed(upper, timer->base + TIMER_LOAD_COUNT1);
+}
+
+static u64 notrace _rk_timer_counter_read(struct rk_timer *timer)
 {
-	writel_relaxed(cycles, timer->base + TIMER_LOAD_COUNT0);
-	writel_relaxed(0, timer->base + TIMER_LOAD_COUNT1);
+	u64 counter;
+	u32 lower;
+	u32 upper, old_upper;
+
+	upper = readl_relaxed(timer->base + TIMER_CURRENT_VALUE1);
+	do {
+		old_upper = upper;
+		lower = readl_relaxed(timer->base + TIMER_CURRENT_VALUE0);
+		upper = readl_relaxed(timer->base + TIMER_CURRENT_VALUE1);
+	} while (upper != old_upper);
+
+	counter = upper;
+	counter <<= 32;
+	counter |= lower;
+	return counter;
+}
+
+static u64 rk_timer_counter_read(struct rk_timer *timer)
+{
+	return _rk_timer_counter_read(timer);
 }
 
 static void rk_timer_interrupt_clear(struct rk_timer *timer)
@@ -120,13 +161,46 @@ static irqreturn_t rk_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static u64 rk_timer_clocksource_read(struct clocksource *cs)
+{
+	struct rk_clocksource *_cs =
+		container_of(cs, struct rk_clocksource, cs);
+
+	return ~rk_timer_counter_read(&_cs->timer);
+}
+
+static u64 notrace rk_timer_sched_clock_read(void)
+{
+	struct rk_clocksource *_cs = &cs_timer;
+
+	return ~_rk_timer_counter_read(&_cs->timer);
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
+	int clksrc;
+
+	clksrc = rk_next_clksrc;
+	rk_next_clksrc++;
+
+	switch (clksrc) {
+	case ROCKCHIP_CLKSRC_CLOCKEVENT:
+		ce = &bc_timer.ce;
+		timer = &bc_timer.timer;
+		break;
+	case ROCKCHIP_CLKSRC_CLOCKSOURCE:
+		cs = &cs_timer.cs;
+		timer = &cs_timer.timer;
+		break;
+	default:
+		return -ENODEV;
+	}
 
 	timer->base = of_iomap(np, 0);
 	if (!timer->base) {
@@ -170,26 +244,49 @@ static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
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
+		ce->features = CLOCK_EVT_FEAT_PERIODIC |
+			       CLOCK_EVT_FEAT_ONESHOT |
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
+		cs->rating = 250;
+	}
 
 	rk_timer_interrupt_clear(timer);
 	rk_timer_disable(timer);
 
-	ret = request_irq(irq, rk_timer_interrupt, IRQF_TIMER, TIMER_NAME, ce);
-	if (ret) {
-		pr_err("Failed to initialize '%s': %d\n", TIMER_NAME, ret);
-		goto out_irq;
+	if (ce) {
+		ret = request_irq(irq, rk_timer_interrupt, IRQF_TIMER,
+				  TIMER_NAME, ce);
+		if (ret) {
+			pr_err("Failed to initialize '%s': %d\n",
+				TIMER_NAME, ret);
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
+		sched_clock_register(rk_timer_sched_clock_read, 64,
+				     timer->freq);
+	}
 
 	return 0;
 
-- 
1.7.9.5
