From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue,  4 Dec 2012 11:10:44 +0100
Subject: [PATCH 1/2] clocksource: nomadik-mtu: support timer-based delay
In-Reply-To: <1354615845-2758-1-git-send-email-fabio.baltieri@linaro.org>
References: <1354615845-2758-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1354615845-2758-2-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to use Nomadik MTU for timer-based delay.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/clocksource/nomadik-mtu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index 8914c3c..5f3c8db 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -15,6 +15,7 @@
 #include <linux/clocksource.h>
 #include <linux/clk.h>
 #include <linux/jiffies.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/platform_data/clocksource-nomadik-mtu.h>
 #include <asm/mach/time.h>
@@ -64,6 +65,7 @@ static void __iomem *mtu_base;
 static bool clkevt_periodic;
 static u32 clk_prescale;
 static u32 nmdk_cycle;		/* write-once */
+static struct delay_timer mtu_delay_timer;
 
 #ifdef CONFIG_NOMADIK_MTU_SCHED_CLOCK
 /*
@@ -80,6 +82,11 @@ static u32 notrace nomadik_read_sched_clock(void)
 }
 #endif
 
+static unsigned long nmdk_timer_read_current_timer(void)
+{
+	return ~readl_relaxed(mtu_base + MTU_VAL(0));
+}
+
 /* Clockevent device: use one-shot mode */
 static int nmdk_clkevt_next(unsigned long evt, struct clock_event_device *ev)
 {
@@ -227,4 +234,8 @@ void __init nmdk_timer_init(void __iomem *base, int irq)
 	setup_irq(irq, &nmdk_timer_irq);
 	nmdk_clkevt.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&nmdk_clkevt, rate, 2, 0xffffffffU);
+
+	mtu_delay_timer.read_current_timer = &nmdk_timer_read_current_timer;
+	mtu_delay_timer.freq = rate;
+	register_current_timer_delay(&mtu_delay_timer);
 }
-- 
1.7.12.1
