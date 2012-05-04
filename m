From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri,  4 May 2012 20:30:21 +0800
Subject: [PATCH v2 4/9] ARM: mmp: support DT in timer
In-Reply-To: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1336134626-12262-5-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse timer from DTS file. Avoid to use hardcoding marco for register.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/time.c |   81 ++++++++++++++++++++++++++++++++++------------
 1 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 71fc4ee..936447c 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -25,6 +25,9 @@
 
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <asm/sched_clock.h>
 #include <mach/addr-map.h>
@@ -41,6 +44,8 @@
 #define MAX_DELTA		(0xfffffffe)
 #define MIN_DELTA		(16)
 
+static void __iomem *mmp_timer_base = TIMERS_VIRT_BASE;
+
 /*
  * FIXME: the timer needs some delay to stablize the counter capture
  */
@@ -48,12 +53,12 @@ static inline uint32_t timer_read(void)
 {
 	int delay = 100;
 
-	__raw_writel(1, TIMERS_VIRT_BASE + TMR_CVWR(1));
+	__raw_writel(1, mmp_timer_base + TMR_CVWR(1));
 
 	while (delay--)
 		cpu_relax();
 
-	return __raw_readl(TIMERS_VIRT_BASE + TMR_CVWR(1));
+	return __raw_readl(mmp_timer_base + TMR_CVWR(1));
 }
 
 static u32 notrace mmp_read_sched_clock(void)
@@ -68,12 +73,12 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	/*
 	 * Clear pending interrupt status.
 	 */
-	__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_ICR(0));
+	__raw_writel(0x01, mmp_timer_base + TMR_ICR(0));
 
 	/*
 	 * Disable timer 0.
 	 */
-	__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CER);
+	__raw_writel(0x02, mmp_timer_base + TMR_CER);
 
 	c->event_handler(c);
 
@@ -90,23 +95,23 @@ static int timer_set_next_event(unsigned long delta,
 	/*
 	 * Disable timer 0.
 	 */
-	__raw_writel(0x02, TIMERS_VIRT_BASE + TMR_CER);
+	__raw_writel(0x02, mmp_timer_base + TMR_CER);
 
 	/*
 	 * Clear and enable timer match 0 interrupt.
 	 */
-	__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_ICR(0));
-	__raw_writel(0x01, TIMERS_VIRT_BASE + TMR_IER(0));
+	__raw_writel(0x01, mmp_timer_base + TMR_ICR(0));
+	__raw_writel(0x01, mmp_timer_base + TMR_IER(0));
 
 	/*
 	 * Setup new clockevent timer value.
 	 */
-	__raw_writel(delta - 1, TIMERS_VIRT_BASE + TMR_TN_MM(0, 0));
+	__raw_writel(delta - 1, mmp_timer_base + TMR_TN_MM(0, 0));
 
 	/*
 	 * Enable timer 0.
 	 */
-	__raw_writel(0x03, TIMERS_VIRT_BASE + TMR_CER);
+	__raw_writel(0x03, mmp_timer_base + TMR_CER);
 
 	local_irq_restore(flags);
 
@@ -124,7 +129,7 @@ static void timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		/* disable the matching interrupt */
-		__raw_writel(0x00, TIMERS_VIRT_BASE + TMR_IER(0));
+		__raw_writel(0x00, mmp_timer_base + TMR_IER(0));
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -157,27 +162,27 @@ static struct clocksource cksrc = {
 
 static void __init timer_config(void)
 {
-	uint32_t ccr = __raw_readl(TIMERS_VIRT_BASE + TMR_CCR);
+	uint32_t ccr = __raw_readl(mmp_timer_base + TMR_CCR);
 
-	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_CER); /* disable */
+	__raw_writel(0x0, mmp_timer_base + TMR_CER); /* disable */
 
 	ccr &= (cpu_is_mmp2()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
 		(TMR_CCR_CS_0(3) | TMR_CCR_CS_1(3));
-	__raw_writel(ccr, TIMERS_VIRT_BASE + TMR_CCR);
+	__raw_writel(ccr, mmp_timer_base + TMR_CCR);
 
 	/* set timer 0 to periodic mode, and timer 1 to free-running mode */
-	__raw_writel(0x2, TIMERS_VIRT_BASE + TMR_CMR);
+	__raw_writel(0x2, mmp_timer_base + TMR_CMR);
 
-	__raw_writel(0x1, TIMERS_VIRT_BASE + TMR_PLCR(0)); /* periodic */
-	__raw_writel(0x7, TIMERS_VIRT_BASE + TMR_ICR(0));  /* clear status */
-	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_IER(0));
+	__raw_writel(0x1, mmp_timer_base + TMR_PLCR(0)); /* periodic */
+	__raw_writel(0x7, mmp_timer_base + TMR_ICR(0));  /* clear status */
+	__raw_writel(0x0, mmp_timer_base + TMR_IER(0));
 
-	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_PLCR(1)); /* free-running */
-	__raw_writel(0x7, TIMERS_VIRT_BASE + TMR_ICR(1));  /* clear status */
-	__raw_writel(0x0, TIMERS_VIRT_BASE + TMR_IER(1));
+	__raw_writel(0x0, mmp_timer_base + TMR_PLCR(1)); /* free-running */
+	__raw_writel(0x7, mmp_timer_base + TMR_ICR(1));  /* clear status */
+	__raw_writel(0x0, mmp_timer_base + TMR_IER(1));
 
 	/* enable timer 1 counter */
-	__raw_writel(0x2, TIMERS_VIRT_BASE + TMR_CER);
+	__raw_writel(0x2, mmp_timer_base + TMR_CER);
 }
 
 static struct irqaction timer_irq = {
@@ -203,3 +208,37 @@ void __init timer_init(int irq)
 	clocksource_register_hz(&cksrc, CLOCK_TICK_RATE);
 	clockevents_register_device(&ckevt);
 }
+
+#ifdef CONFIG_OF
+static struct of_device_id mmp_timer_dt_ids[] = {
+	{ .compatible = "mrvl,mmp-timer", },
+	{}
+};
+
+void __init mmp_dt_init_timer(void)
+{
+	struct device_node *np;
+	int irq, ret;
+
+	np = of_find_matching_node(NULL, mmp_timer_dt_ids);
+	if (!np) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		ret = -EINVAL;
+		goto out;
+	}
+	mmp_timer_base = of_iomap(np, 0);
+	if (!mmp_timer_base) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	timer_init(irq);
+	return;
+out:
+	pr_err("Failed to get timer from device tree with error:%d\n", ret);
+}
+#endif
-- 
1.7.5.4
