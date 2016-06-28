From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:31:00 +0200
Subject: [PATCH 41/92] clocksource/drivers/sun4i: Convert init function to
 return error
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-41-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init functions do not return any error. They behave as the following:

  - panic, thus leading to a kernel crash while another timer may work and
       make the system boot up correctly

  or

  - print an error and let the caller unaware if the state of the system

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sun4i_timer.c | 45 ++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 6f3719d..4453730 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -146,7 +146,7 @@ static u64 notrace sun4i_timer_sched_read(void)
 	return ~readl(timer_base + TIMER_CNTVAL_REG(1));
 }
 
-static void __init sun4i_timer_init(struct device_node *node)
+static int __init sun4i_timer_init(struct device_node *node)
 {
 	unsigned long rate = 0;
 	struct clk *clk;
@@ -154,17 +154,28 @@ static void __init sun4i_timer_init(struct device_node *node)
 	u32 val;
 
 	timer_base = of_iomap(node, 0);
-	if (!timer_base)
-		panic("Can't map registers");
+	if (!timer_base) {
+		pr_crit("Can't map registers");
+		return -ENXIO;
+	}
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (irq <= 0)
-		panic("Can't parse IRQ");
+	if (irq <= 0) {
+		pr_crit("Can't parse IRQ");
+		return -EINVAL;
+	}
 
 	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk))
-		panic("Can't get timer clock");
-	clk_prepare_enable(clk);
+	if (IS_ERR(clk)) {
+		pr_crit("Can't get timer clock");
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("Failed to prepare clock");
+		return ret;
+	}
 
 	rate = clk_get_rate(clk);
 
@@ -182,8 +193,12 @@ static void __init sun4i_timer_init(struct device_node *node)
 	    of_machine_is_compatible("allwinner,sun5i-a10s"))
 		sched_clock_register(sun4i_timer_sched_read, 32, rate);
 
-	clocksource_mmio_init(timer_base + TIMER_CNTVAL_REG(1), node->name,
-			      rate, 350, 32, clocksource_mmio_readl_down);
+	ret = clocksource_mmio_init(timer_base + TIMER_CNTVAL_REG(1), node->name,
+				    rate, 350, 32, clocksource_mmio_readl_down);
+	if (ret) {
+		pr_err("Failed to register clocksource");
+		return ret;
+	}
 
 	ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
 
@@ -200,12 +215,16 @@ static void __init sun4i_timer_init(struct device_node *node)
 					TIMER_SYNC_TICKS, 0xffffffff);
 
 	ret = setup_irq(irq, &sun4i_timer_irq);
-	if (ret)
-		pr_warn("failed to setup irq %d\n", irq);
+	if (ret) {
+		pr_err("failed to setup irq %d\n", irq);
+		return ret;
+	}
 
 	/* Enable timer0 interrupt */
 	val = readl(timer_base + TIMER_IRQ_EN_REG);
 	writel(val | TIMER_IRQ_EN(0), timer_base + TIMER_IRQ_EN_REG);
+
+	return ret;
 }
-CLOCKSOURCE_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
+CLOCKSOURCE_OF_DECLARE_RET(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
-- 
1.9.1
