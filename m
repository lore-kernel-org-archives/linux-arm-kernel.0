From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 26 Aug 2016 16:20:45 +0200
Subject: [PATCH 3/3] clocksource/drivers/sun4i: Clear interrupts after
 stopping timer in probe function
In-Reply-To: <1472221245-14265-1-git-send-email-daniel.lezcano@linaro.org>
References: <57C05026.7010905@linaro.org>
 <1472221245-14265-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1472221245-14265-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>

The bootloader (U-boot) sometimes uses this timer for various delays.
It uses it as a ongoing counter, and does comparisons on the current
counter value. The timer counter is never stopped.

In some cases when the user interacts with the bootloader, or lets
it idle for some time before loading Linux, the timer may expire,
and an interrupt will be pending. This results in an unexpected
interrupt when the timer interrupt is enabled by the kernel, at
which point the event_handler isn't set yet. This results in a NULL
pointer dereference exception, panic, and no way to reboot.

Clear any pending interrupts after we stop the timer in the probe
function to avoid this.

Cc: stable at vger.kernel.org
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/sun4i_timer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 97669ee..c83452c 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -123,12 +123,16 @@ static struct clock_event_device sun4i_clockevent = {
 	.set_next_event = sun4i_clkevt_next_event,
 };
 
+static void sun4i_timer_clear_interrupt(void)
+{
+	writel(TIMER_IRQ_EN(0), timer_base + TIMER_IRQ_ST_REG);
+}
 
 static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
 
-	writel(0x1, timer_base + TIMER_IRQ_ST_REG);
+	sun4i_timer_clear_interrupt();
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
@@ -208,6 +212,9 @@ static int __init sun4i_timer_init(struct device_node *node)
 	/* Make sure timer is stopped before playing with interrupts */
 	sun4i_clkevt_time_stop(0);
 
+	/* clear timer0 interrupt */
+	sun4i_timer_clear_interrupt();
+
 	sun4i_clockevent.cpumask = cpu_possible_mask;
 	sun4i_clockevent.irq = irq;
 
-- 
1.9.1
