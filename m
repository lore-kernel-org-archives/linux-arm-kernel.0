From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Jul 2016 11:01:59 +0800
Subject: [PATCH] clocksource: sun4i: Clear interrupts after stopping timer in
 probe function
Message-ID: <1469502119-2344-1-git-send-email-wens@csie.org>
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

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

I've run into this many times while working on U-boot. Finally
made time to figure it out.

---
 drivers/clocksource/sun4i_timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 6f3719d73390..d5725c82401d 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -193,6 +193,9 @@ static void __init sun4i_timer_init(struct device_node *node)
 	/* Make sure timer is stopped before playing with interrupts */
 	sun4i_clkevt_time_stop(0);
 
+	/* clear timer0 interrupt */
+	writel(0x1, timer_base + TIMER_IRQ_ST_REG);
+
 	sun4i_clockevent.cpumask = cpu_possible_mask;
 	sun4i_clockevent.irq = irq;
 
-- 
2.8.1
