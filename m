From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 22 Jan 2014 12:35:44 +0100
Subject: [PATCH] ARM: imx: enable delaytimer on the imx timer
Message-ID: <1390390544-10319-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx can support timer-based delays, so implement this.
Skips past jiffy calibration.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Tested on imx51.

 arch/arm/mach-imx/time.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index cd46529..19c5cf9 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -25,6 +25,7 @@
 #include <linux/irq.h>
 #include <linux/clockchips.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/sched_clock.h>
 
@@ -116,11 +117,22 @@ static u32 notrace mxc_read_sched_clock(void)
 	return sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
 }
 
+static struct delay_timer imx_delay_timer;
+
+static unsigned long imx_read_current_timer(void)
+{
+	return __raw_readl(sched_clock_reg);
+}
+
 static int __init mxc_clocksource_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
 	void __iomem *reg = timer_base + (timer_is_v2() ? V2_TCN : MX1_2_TCN);
 
+	imx_delay_timer.read_current_timer = &imx_read_current_timer;
+	imx_delay_timer.freq = c;
+	register_current_timer_delay(&imx_delay_timer);
+
 	sched_clock_reg = reg;
 
 	setup_sched_clock(mxc_read_sched_clock, 32, c);
-- 
1.8.5.2
