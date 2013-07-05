From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  6 Jul 2013 00:18:39 +0200
Subject: [PATCHv4 04/10] clocksource: sun4i: Add clocksource and sched clock
 drivers
In-Reply-To: <1373062725-19625-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1373062725-19625-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1373062725-19625-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the second timer found on the Allwinner SoCs as a clock source and
sched clock, that were both not used yet on these platforms.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/sun4i_timer.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index f5e227b..b581c93 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -96,6 +97,11 @@ static struct irqaction sun4i_timer_irq = {
 	.dev_id = &sun4i_clockevent,
 };
 
+static u32 sun4i_timer_sched_read(void)
+{
+	return ~readl(timer_base + TIMER_CNTVAL_REG(1));
+}
+
 static void __init sun4i_timer_init(struct device_node *node)
 {
 	unsigned long rate = 0;
@@ -117,6 +123,15 @@ static void __init sun4i_timer_init(struct device_node *node)
 
 	rate = clk_get_rate(clk);
 
+	writel(~0, timer_base + TIMER_INTVAL_REG(1));
+	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD |
+	       TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
+	       timer_base + TIMER_CTL_REG(1));
+
+	setup_sched_clock(sun4i_timer_sched_read, 32, rate);
+	clocksource_mmio_init(timer_base + TIMER_CNTVAL_REG(1), node->name,
+			      rate, 300, 32, clocksource_mmio_readl_down);
+
 	writel(rate / (TIMER_SCAL * HZ),
 	       timer_base + TIMER_INTVAL_REG(0));
 
-- 
1.8.3.2
