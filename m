From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 Aug 2016 14:26:59 +0800
Subject: [PATCH v3] clocksource: sun4i: Clear interrupts after stopping timer
 in probe function
Message-ID: <20160825062659.17433-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
Changes since v2:

  - Add static helper function to clear interrupts as suggested by Daniel.

Changes since v1:

  - Add stable kernel to Cc.
---
 drivers/clocksource/sun4i_timer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 97669ee4df2a..c83452cacb41 100644
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
2.9.3
