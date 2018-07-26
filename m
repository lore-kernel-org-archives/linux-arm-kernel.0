From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Jul 2018 12:15:28 +0200
Subject: [PATCH 5/7] clocksource/drivers/timer-mediatek: Convert the driver to
 timer-of
In-Reply-To: <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
References: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
 <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1532600131-28168-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stanley Chu <stanley.chu@mediatek.com>

Convert the driver to use the timer_of helpers.
This allows to remove custom proprietary structure,
factors out and simplifies the code.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-mediatek.c | 205 ++++++++++++++---------------------
 1 file changed, 80 insertions(+), 125 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index e3657d2..e57c4d7 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -18,16 +18,13 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
-#include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/clocksource.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/irqreturn.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
+#include "timer-of.h"
 
 #define TIMER_CLK_EVT           (1)
 #define TIMER_CLK_SRC           (2)
@@ -59,12 +56,6 @@
 #define GPT_CNT_REG(val)        (0x08 + (0x10 * (val)))
 #define GPT_CMP_REG(val)        (0x0C + (0x10 * (val)))
 
-struct mtk_clock_event_device {
-	void __iomem *gpt_base;
-	u32 ticks_per_jiffy;
-	struct clock_event_device dev;
-};
-
 static void __iomem *gpt_sched_reg __read_mostly;
 
 static u64 notrace mtk_gpt_read_sched_clock(void)
@@ -72,36 +63,30 @@ static u64 notrace mtk_gpt_read_sched_clock(void)
 	return readl_relaxed(gpt_sched_reg);
 }
 
-static inline struct mtk_clock_event_device *to_mtk_clk(
-				struct clock_event_device *c)
-{
-	return container_of(c, struct mtk_clock_event_device, dev);
-}
-
-static void mtk_gpt_clkevt_time_stop(struct mtk_clock_event_device *evt, u8 timer)
+static void mtk_gpt_clkevt_time_stop(struct timer_of *to, u8 timer)
 {
 	u32 val;
 
-	val = readl(evt->gpt_base + GPT_CTRL_REG(timer));
-	writel(val & ~GPT_CTRL_ENABLE, evt->gpt_base +
-			GPT_CTRL_REG(timer));
+	val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
+	writel(val & ~GPT_CTRL_ENABLE, timer_of_base(to) +
+	       GPT_CTRL_REG(timer));
 }
 
-static void mtk_gpt_clkevt_time_setup(struct mtk_clock_event_device *evt,
-				unsigned long delay, u8 timer)
+static void mtk_gpt_clkevt_time_setup(struct timer_of *to,
+				      unsigned long delay, u8 timer)
 {
-	writel(delay, evt->gpt_base + GPT_CMP_REG(timer));
+	writel(delay, timer_of_base(to) + GPT_CMP_REG(timer));
 }
 
-static void mtk_gpt_clkevt_time_start(struct mtk_clock_event_device *evt,
-		bool periodic, u8 timer)
+static void mtk_gpt_clkevt_time_start(struct timer_of *to,
+				      bool periodic, u8 timer)
 {
 	u32 val;
 
 	/* Acknowledge interrupt */
-	writel(GPT_IRQ_ACK(timer), evt->gpt_base + GPT_IRQ_ACK_REG);
+	writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
 
-	val = readl(evt->gpt_base + GPT_CTRL_REG(timer));
+	val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
 
 	/* Clear 2 bit timer operation mode field */
 	val &= ~GPT_CTRL_OP(0x3);
@@ -112,160 +97,130 @@ static void mtk_gpt_clkevt_time_start(struct mtk_clock_event_device *evt,
 		val |= GPT_CTRL_OP(GPT_CTRL_OP_ONESHOT);
 
 	writel(val | GPT_CTRL_ENABLE | GPT_CTRL_CLEAR,
-	       evt->gpt_base + GPT_CTRL_REG(timer));
+	       timer_of_base(to) + GPT_CTRL_REG(timer));
 }
 
 static int mtk_gpt_clkevt_shutdown(struct clock_event_device *clk)
 {
-	mtk_gpt_clkevt_time_stop(to_mtk_clk(clk), TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(to_timer_of(clk), TIMER_CLK_EVT);
+
 	return 0;
 }
 
 static int mtk_gpt_clkevt_set_periodic(struct clock_event_device *clk)
 {
-	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
+	struct timer_of *to = to_timer_of(clk);
+
+	mtk_gpt_clkevt_time_stop(to, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_setup(to, to->of_clk.period, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_start(to, true, TIMER_CLK_EVT);
 
-	mtk_gpt_clkevt_time_stop(evt, TIMER_CLK_EVT);
-	mtk_gpt_clkevt_time_setup(evt, evt->ticks_per_jiffy, TIMER_CLK_EVT);
-	mtk_gpt_clkevt_time_start(evt, true, TIMER_CLK_EVT);
 	return 0;
 }
 
 static int mtk_gpt_clkevt_next_event(unsigned long event,
-				   struct clock_event_device *clk)
+				     struct clock_event_device *clk)
 {
-	struct mtk_clock_event_device *evt = to_mtk_clk(clk);
+	struct timer_of *to = to_timer_of(clk);
 
-	mtk_gpt_clkevt_time_stop(evt, TIMER_CLK_EVT);
-	mtk_gpt_clkevt_time_setup(evt, event, TIMER_CLK_EVT);
-	mtk_gpt_clkevt_time_start(evt, false, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_stop(to, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_setup(to, event, TIMER_CLK_EVT);
+	mtk_gpt_clkevt_time_start(to, false, TIMER_CLK_EVT);
 
 	return 0;
 }
 
 static irqreturn_t mtk_gpt_interrupt(int irq, void *dev_id)
 {
-	struct mtk_clock_event_device *evt = dev_id;
+	struct clock_event_device *clkevt = (struct clock_event_device *)dev_id;
+	struct timer_of *to = to_timer_of(clkevt);
 
 	/* Acknowledge timer0 irq */
-	writel(GPT_IRQ_ACK(TIMER_CLK_EVT), evt->gpt_base + GPT_IRQ_ACK_REG);
-	evt->dev.event_handler(&evt->dev);
+	writel(GPT_IRQ_ACK(TIMER_CLK_EVT), timer_of_base(to) + GPT_IRQ_ACK_REG);
+	clkevt->event_handler(clkevt);
 
 	return IRQ_HANDLED;
 }
 
 static void
-__init mtk_gpt_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
+__init mtk_gpt_setup(struct timer_of *to, u8 timer, u8 option)
 {
 	writel(GPT_CTRL_CLEAR | GPT_CTRL_DISABLE,
-		evt->gpt_base + GPT_CTRL_REG(timer));
+	       timer_of_base(to) + GPT_CTRL_REG(timer));
 
 	writel(GPT_CLK_SRC(GPT_CLK_SRC_SYS13M) | GPT_CLK_DIV1,
-			evt->gpt_base + GPT_CLK_REG(timer));
+	       timer_of_base(to) + GPT_CLK_REG(timer));
 
-	writel(0x0, evt->gpt_base + GPT_CMP_REG(timer));
+	writel(0x0, timer_of_base(to) + GPT_CMP_REG(timer));
 
 	writel(GPT_CTRL_OP(option) | GPT_CTRL_ENABLE,
-			evt->gpt_base + GPT_CTRL_REG(timer));
+	       timer_of_base(to) + GPT_CTRL_REG(timer));
 }
 
-static void mtk_gpt_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
+static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
 {
 	u32 val;
 
 	/* Disable all interrupts */
-	writel(0x0, evt->gpt_base + GPT_IRQ_EN_REG);
+	writel(0x0, timer_of_base(to) + GPT_IRQ_EN_REG);
 
 	/* Acknowledge all spurious pending interrupts */
-	writel(0x3f, evt->gpt_base + GPT_IRQ_ACK_REG);
+	writel(0x3f, timer_of_base(to) + GPT_IRQ_ACK_REG);
 
-	val = readl(evt->gpt_base + GPT_IRQ_EN_REG);
+	val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
 	writel(val | GPT_IRQ_ENABLE(timer),
-			evt->gpt_base + GPT_IRQ_EN_REG);
+	       timer_of_base(to) + GPT_IRQ_EN_REG);
 }
 
+static struct timer_of to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+
+	.clkevt = {
+		.name = "mtk-clkevt",
+		.rating = 300,
+		.cpumask = cpu_possible_mask,
+	},
+
+	.of_irq = {
+		.flags = IRQF_TIMER | IRQF_IRQPOLL,
+	},
+};
+
 static int __init mtk_gpt_init(struct device_node *node)
 {
-	struct mtk_clock_event_device *evt;
-	struct resource res;
-	unsigned long rate = 0;
-	struct clk *clk;
-
-	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
-	if (!evt)
-		return -ENOMEM;
-
-	evt->dev.name = "mtk_tick";
-	evt->dev.rating = 300;
-	evt->dev.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->dev.set_state_shutdown = mtk_gpt_clkevt_shutdown;
-	evt->dev.set_state_periodic = mtk_gpt_clkevt_set_periodic;
-	evt->dev.set_state_oneshot = mtk_gpt_clkevt_shutdown;
-	evt->dev.tick_resume = mtk_gpt_clkevt_shutdown;
-	evt->dev.set_next_event = mtk_gpt_clkevt_next_event;
-	evt->dev.cpumask = cpu_possible_mask;
-
-	evt->gpt_base = of_io_request_and_map(node, 0, "mtk-timer-gpt");
-	if (IS_ERR(evt->gpt_base)) {
-		pr_err("Can't get resource\n");
-		goto err_kzalloc;
-	}
-
-	evt->dev.irq = irq_of_parse_and_map(node, 0);
-	if (evt->dev.irq <= 0) {
-		pr_err("Can't parse IRQ\n");
-		goto err_mem;
-	}
-
-	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk)) {
-		pr_err("Can't get timer clock\n");
-		goto err_irq;
-	}
-
-	if (clk_prepare_enable(clk)) {
-		pr_err("Can't prepare clock\n");
-		goto err_clk_put;
-	}
-	rate = clk_get_rate(clk);
-
-	if (request_irq(evt->dev.irq, mtk_gpt_interrupt,
-			IRQF_TIMER | IRQF_IRQPOLL, "mtk_timer", evt)) {
-		pr_err("failed to setup irq %d\n", evt->dev.irq);
-		goto err_clk_disable;
-	}
-
-	evt->ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
+	int ret;
+
+	to.clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	to.clkevt.set_state_shutdown = mtk_gpt_clkevt_shutdown;
+	to.clkevt.set_state_periodic = mtk_gpt_clkevt_set_periodic;
+	to.clkevt.set_state_oneshot = mtk_gpt_clkevt_shutdown;
+	to.clkevt.tick_resume = mtk_gpt_clkevt_shutdown;
+	to.clkevt.set_next_event = mtk_gpt_clkevt_next_event;
+	to.of_irq.handler = mtk_gpt_interrupt;
+
+	ret = timer_of_init(node, &to);
+	if (ret)
+		goto err;
 
 	/* Configure clock source */
-	mtk_gpt_setup(evt, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
-	clocksource_mmio_init(evt->gpt_base + GPT_CNT_REG(TIMER_CLK_SRC),
-			node->name, rate, 300, 32, clocksource_mmio_readl_up);
-	gpt_sched_reg = evt->gpt_base + GPT_CNT_REG(TIMER_CLK_SRC);
-	sched_clock_register(mtk_gpt_read_sched_clock, 32, rate);
+	mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
+	clocksource_mmio_init(timer_of_base(&to) + GPT_CNT_REG(TIMER_CLK_SRC),
+			      node->name, timer_of_rate(&to), 300, 32,
+			      clocksource_mmio_readl_up);
+	gpt_sched_reg = timer_of_base(&to) + GPT_CNT_REG(TIMER_CLK_SRC);
+	sched_clock_register(mtk_gpt_read_sched_clock, 32, timer_of_rate(&to));
 
 	/* Configure clock event */
-	mtk_gpt_setup(evt, TIMER_CLK_EVT, GPT_CTRL_OP_REPEAT);
-	clockevents_config_and_register(&evt->dev, rate, TIMER_SYNC_TICKS,
-					0xffffffff);
+	mtk_gpt_setup(&to, TIMER_CLK_EVT, GPT_CTRL_OP_REPEAT);
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
+					TIMER_SYNC_TICKS, 0xffffffff);
 
-	mtk_gpt_enable_irq(evt, TIMER_CLK_EVT);
+	mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
 
 	return 0;
 
-err_clk_disable:
-	clk_disable_unprepare(clk);
-err_clk_put:
-	clk_put(clk);
-err_irq:
-	irq_dispose_mapping(evt->dev.irq);
-err_mem:
-	iounmap(evt->gpt_base);
-	of_address_to_resource(node, 0, &res);
-	release_mem_region(res.start, resource_size(&res));
-err_kzalloc:
-	kfree(evt);
-
-	return -EINVAL;
+err:
+	timer_of_cleanup(&to);
+	return ret;
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
-- 
2.7.4
