From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 11:19:29 +0100
Subject: [PATCH 10/20] clocksource: sun4i: Switch to sched_clock_register()
In-Reply-To: <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
References: <52C1479E.80808@linaro.org>
 <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388398779-11222-10-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface. While we're here, mark the sched_clock function as
notrace to prevent ftrace recursion crashes.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sun4i_timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index d7a1a1a..1911874 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -138,7 +138,7 @@ static struct irqaction sun4i_timer_irq = {
 	.dev_id = &sun4i_clockevent,
 };
 
-static u32 sun4i_timer_sched_read(void)
+static u64 notrace sun4i_timer_sched_read(void)
 {
 	return ~readl(timer_base + TIMER_CNTVAL_REG(1));
 }
@@ -170,7 +170,7 @@ static void __init sun4i_timer_init(struct device_node *node)
 	       TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
 	       timer_base + TIMER_CTL_REG(1));
 
-	setup_sched_clock(sun4i_timer_sched_read, 32, rate);
+	sched_clock_register(sun4i_timer_sched_read, 32, rate);
 	clocksource_mmio_init(timer_base + TIMER_CNTVAL_REG(1), node->name,
 			      rate, 350, 32, clocksource_mmio_readl_down);
 
-- 
1.7.9.5
