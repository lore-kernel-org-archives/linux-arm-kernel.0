From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 22 Mar 2017 18:48:32 +0300
Subject: [PATCH v7 5/7] clocksource/drivers/rockchip_timer: implement
 clocksource timer
In-Reply-To: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
References: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1490197714-25415-6-git-send-email-al.kochet@gmail.com>
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
will be initialized as clockevent, as expected. But new warnings like
'Failed to initialize /timer at ....' will appear with old device tree
files. To resolve them 'clockevent' attribute should be added to the
timer.

rk3288 (and probably anything newer) is irrelevant to this patch,
as it has the arch timer interface. This patch may be useful
for Cortex-A9/A5 based parts.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 arch/arm/mach-rockchip/rockchip.c    |    2 +
 drivers/clocksource/Kconfig          |    2 +
 drivers/clocksource/rockchip_timer.c |  215 ++++++++++++++++++++++++----------
 3 files changed, 156 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index a7ab9ec..5184f7d 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -21,6 +21,7 @@
 #include <linux/irqchip.h>
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <asm/mach/arch.h>
@@ -67,6 +68,7 @@ static void __init rockchip_timer_init(void)
 	}
 
 	of_clk_init(NULL);
+	clockevent_probe();
 	clocksource_probe();
 }
 
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 21f84ea..5e0df76 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -71,6 +71,8 @@ config ROCKCHIP_TIMER
 	bool "Rockchip timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
 	select CLKSRC_OF
+	select CLKEVT_OF
+	select CLKSRC_MMIO
 	help
 	  Enables the support for the rockchip timer driver.
 
diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index 23e267a..0ac71bb 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -11,6 +11,8 @@
 #include <linux/clockchips.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -19,6 +21,8 @@
 
 #define TIMER_LOAD_COUNT0	0x00
 #define TIMER_LOAD_COUNT1	0x04
+#define TIMER_CURRENT_VALUE0	0x08
+#define TIMER_CURRENT_VALUE1	0x0C
 #define TIMER_CONTROL_REG3288	0x10
 #define TIMER_CONTROL_REG3399	0x1c
 #define TIMER_INT_STATUS	0x18
@@ -29,103 +33,118 @@
 #define TIMER_MODE_USER_DEFINED_COUNT		(1 << 1)
 #define TIMER_INT_UNMASK			(1 << 2)
 
-struct bc_timer {
-	struct clock_event_device ce;
+struct rk_timer {
 	void __iomem *base;
 	void __iomem *ctrl;
+	struct clk *clk;
+	struct clk *pclk;
 	u32 freq;
+	int irq;
 };
 
-static struct bc_timer bc_timer;
+struct rk_clkevt {
+	struct clock_event_device ce;
+	struct rk_timer timer;
+};
 
-static inline struct bc_timer *rk_timer(struct clock_event_device *ce)
-{
-	return container_of(ce, struct bc_timer, ce);
-}
+/* global instance for rk_timer_sched_read() */
+static struct rk_timer *rk_clksrc;
 
-static inline void __iomem *rk_base(struct clock_event_device *ce)
+static inline struct rk_timer *rk_timer(struct clock_event_device *ce)
 {
-	return rk_timer(ce)->base;
+	return &container_of(ce, struct rk_clkevt, ce)->timer;
 }
 
-static inline void __iomem *rk_ctrl(struct clock_event_device *ce)
+static inline void rk_timer_disable(struct rk_timer *timer)
 {
-	return rk_timer(ce)->ctrl;
+	writel_relaxed(TIMER_DISABLE, timer->ctrl);
 }
 
-static inline void rk_timer_disable(struct clock_event_device *ce)
+static inline void rk_timer_enable(struct rk_timer *timer, u32 flags)
 {
-	writel_relaxed(TIMER_DISABLE, rk_ctrl(ce));
-}
-
-static inline void rk_timer_enable(struct clock_event_device *ce, u32 flags)
-{
-	writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
-		       rk_ctrl(ce));
+	writel_relaxed(TIMER_ENABLE | flags, timer->ctrl);
 }
 
 static void rk_timer_update_counter(unsigned long cycles,
-				    struct clock_event_device *ce)
+				    struct rk_timer *timer)
 {
-	writel_relaxed(cycles, rk_base(ce) + TIMER_LOAD_COUNT0);
-	writel_relaxed(0, rk_base(ce) + TIMER_LOAD_COUNT1);
+	writel_relaxed(cycles, timer->base + TIMER_LOAD_COUNT0);
+	writel_relaxed(0, timer->base + TIMER_LOAD_COUNT1);
 }
 
-static void rk_timer_interrupt_clear(struct clock_event_device *ce)
+static void rk_timer_interrupt_clear(struct rk_timer *timer)
 {
-	writel_relaxed(1, rk_base(ce) + TIMER_INT_STATUS);
+	writel_relaxed(1, timer->base + TIMER_INT_STATUS);
 }
 
 static inline int rk_timer_set_next_event(unsigned long cycles,
 					  struct clock_event_device *ce)
 {
-	rk_timer_disable(ce);
-	rk_timer_update_counter(cycles, ce);
-	rk_timer_enable(ce, TIMER_MODE_USER_DEFINED_COUNT);
+	struct rk_timer *timer = rk_timer(ce);
+
+	rk_timer_disable(timer);
+	rk_timer_update_counter(cycles, timer);
+	rk_timer_enable(timer, TIMER_MODE_USER_DEFINED_COUNT |
+			       TIMER_INT_UNMASK);
 	return 0;
 }
 
 static int rk_timer_shutdown(struct clock_event_device *ce)
 {
-	rk_timer_disable(ce);
+	struct rk_timer *timer = rk_timer(ce);
+
+	rk_timer_disable(timer);
 	return 0;
 }
 
 static int rk_timer_set_periodic(struct clock_event_device *ce)
 {
-	rk_timer_disable(ce);
-	rk_timer_update_counter(rk_timer(ce)->freq / HZ - 1, ce);
-	rk_timer_enable(ce, TIMER_MODE_FREE_RUNNING);
+	struct rk_timer *timer = rk_timer(ce);
+
+	rk_timer_disable(timer);
+	rk_timer_update_counter(timer->freq / HZ - 1, timer);
+	rk_timer_enable(timer, TIMER_MODE_FREE_RUNNING | TIMER_INT_UNMASK);
 	return 0;
 }
 
 static irqreturn_t rk_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *ce = dev_id;
+	struct rk_timer *timer = rk_timer(ce);
 
-	rk_timer_interrupt_clear(ce);
+	rk_timer_interrupt_clear(timer);
 
 	if (clockevent_state_oneshot(ce))
-		rk_timer_disable(ce);
+		rk_timer_disable(timer);
 
 	ce->event_handler(ce);
 
 	return IRQ_HANDLED;
 }
 
-static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
+static u64 notrace rk_timer_sched_read(void)
+{
+	return ~readl_relaxed(rk_clksrc->base + TIMER_CURRENT_VALUE0);
+}
+
+static int __init
+rk_timer_probe(struct rk_timer *timer, struct device_node *np)
 {
-	struct clock_event_device *ce = &bc_timer.ce;
 	struct clk *timer_clk;
 	struct clk *pclk;
 	int ret = -EINVAL, irq;
+	u32 ctrl_reg = TIMER_CONTROL_REG3288;
 
-	bc_timer.base = of_iomap(np, 0);
-	if (!bc_timer.base) {
+	timer->base = of_iomap(np, 0);
+	if (!timer->base) {
 		pr_err("Failed to get base address for '%s'\n", TIMER_NAME);
 		return -ENXIO;
 	}
-	bc_timer.ctrl = bc_timer.base + ctrl_reg;
+
+	if (of_device_is_compatible(np, "rockchip,rk3399-timer"))
+		ctrl_reg = TIMER_CONTROL_REG3399;
+
+	timer->ctrl = timer->base + ctrl_reg;
 
 	pclk = of_clk_get_by_name(np, "pclk");
 	if (IS_ERR(pclk)) {
@@ -139,6 +158,7 @@ static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
 		pr_err("Failed to enable pclk for '%s'\n", TIMER_NAME);
 		goto out_unmap;
 	}
+	timer->pclk = pclk;
 
 	timer_clk = of_clk_get_by_name(np, "timer");
 	if (IS_ERR(timer_clk)) {
@@ -152,8 +172,9 @@ static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
 		pr_err("Failed to enable timer clock\n");
 		goto out_timer_clk;
 	}
+	timer->clk = timer_clk;
 
-	bc_timer.freq = clk_get_rate(timer_clk);
+	timer->freq = clk_get_rate(timer_clk);
 
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
@@ -161,51 +182,119 @@ static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
 		pr_err("Failed to map interrupts for '%s'\n", TIMER_NAME);
 		goto out_irq;
 	}
+	timer->irq = irq;
 
+	rk_timer_interrupt_clear(timer);
+	rk_timer_disable(timer);
+	return 0;
+
+out_irq:
+	clk_disable_unprepare(timer_clk);
+out_timer_clk:
+	clk_disable_unprepare(pclk);
+out_unmap:
+	iounmap(timer->base);
+
+	return ret;
+}
+
+static void __init rk_timer_cleanup(struct rk_timer *timer)
+{
+	clk_disable_unprepare(timer->clk);
+	clk_disable_unprepare(timer->pclk);
+	iounmap(timer->base);
+}
+
+static int __init rk_clkevt_init(struct device_node *np)
+{
+	struct rk_clkevt *clkevt;
+	struct clock_event_device *ce;
+	int ret = -EINVAL;
+
+	clkevt = kzalloc(sizeof(struct rk_clkevt), GFP_KERNEL);
+	if (!clkevt)
+		return -ENOMEM;
+
+	ret = rk_timer_probe(&clkevt->timer, np);
+	if (ret)
+		goto out_probe;
+
+	ce = &clkevt->ce;
 	ce->name = TIMER_NAME;
 	ce->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 		       CLOCK_EVT_FEAT_DYNIRQ;
 	ce->set_next_event = rk_timer_set_next_event;
 	ce->set_state_shutdown = rk_timer_shutdown;
 	ce->set_state_periodic = rk_timer_set_periodic;
-	ce->irq = irq;
+	ce->irq = clkevt->timer.irq;
 	ce->cpumask = cpu_possible_mask;
 	ce->rating = 250;
 
-	rk_timer_interrupt_clear(ce);
-	rk_timer_disable(ce);
-
-	ret = request_irq(irq, rk_timer_interrupt, IRQF_TIMER, TIMER_NAME, ce);
+	ret = request_irq(clkevt->timer.irq, rk_timer_interrupt, IRQF_TIMER,
+			  TIMER_NAME, ce);
 	if (ret) {
-		pr_err("Failed to initialize '%s': %d\n", TIMER_NAME, ret);
+		pr_err("Failed to initialize '%s': %d\n",
+			TIMER_NAME, ret);
 		goto out_irq;
 	}
 
-	clockevents_config_and_register(ce, bc_timer.freq, 1, UINT_MAX);
-
+	clockevents_config_and_register(&clkevt->ce,
+					clkevt->timer.freq, 1, UINT_MAX);
 	return 0;
 
 out_irq:
-	clk_disable_unprepare(timer_clk);
-out_timer_clk:
-	clk_disable_unprepare(pclk);
-out_unmap:
-	iounmap(bc_timer.base);
-
+	rk_timer_cleanup(&clkevt->timer);
+out_probe:
+	kfree(clkevt);
 	return ret;
 }
 
-static int __init rk3288_timer_init(struct device_node *np)
+static int __init rk_clksrc_init(struct device_node *np)
 {
-	return rk_timer_init(np, TIMER_CONTROL_REG3288);
-}
+	struct rk_timer *clksrc;
+	int ret = -EINVAL;
+
+	/*
+	 * Old DT-files has timer entries without 'clocksource' property
+	 * and that timer assumed to be a clockevent, so skip them.
+	 */
+	if (!of_property_read_bool(np, "clocksource"))
+		return -EINVAL;
+
+	clksrc = kzalloc(sizeof(struct rk_timer), GFP_KERNEL);
+	if (!clksrc)
+		return -ENOMEM;
+
+	ret = rk_timer_probe(clksrc, np);
+	if (ret)
+		goto out_probe;
+
+	rk_timer_update_counter(UINT_MAX, clksrc);
+	rk_timer_enable(clksrc, 0);
+
+	ret = clocksource_mmio_init(clksrc->base + TIMER_CURRENT_VALUE0,
+		TIMER_NAME, clksrc->freq, 250, 32,
+		clocksource_mmio_readl_down);
+	if (ret) {
+		pr_err("Failed to register clocksource");
+		goto out_clocksource;
+	}
 
-static int __init rk3399_timer_init(struct device_node *np)
-{
-	return rk_timer_init(np, TIMER_CONTROL_REG3399);
+	if (!rk_clksrc) {
+		rk_clksrc = clksrc;
+		sched_clock_register(rk_timer_sched_read, 32, rk_clksrc->freq);
+	}
+	return 0;
+
+out_clocksource:
+	rk_timer_cleanup(clksrc);
+out_probe:
+	kfree(clksrc);
+	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE(rk3288_timer, "rockchip,rk3288-timer",
-		       rk3288_timer_init);
-CLOCKSOURCE_OF_DECLARE(rk3399_timer, "rockchip,rk3399-timer",
-		       rk3399_timer_init);
+CLOCKEVENT_OF_DECLARE(rk3288_clkevt, "rockchip,rk3288-timer", rk_clkevt_init);
+CLOCKEVENT_OF_DECLARE(rk3399_clkevt, "rockchip,rk3399-timer", rk_clkevt_init);
+
+CLOCKSOURCE_OF_DECLARE(rk3288_clksrc, "rockchip,rk3288-timer", rk_clksrc_init);
+CLOCKSOURCE_OF_DECLARE(rk3399_clksrc, "rockchip,rk3399-timer", rk_clksrc_init);
-- 
1.7.9.5
