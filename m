From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:28 -0500
Subject: [PATCH 13/18] ARM: imx: Removed the unused functions and variables
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-14-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed the following unused functions which were related to SoC.
gpt_irq_disable(void)
gpt_irq_enable(void)
gpt_irq_acknowledge(void)

The following two global variables were removed:
irqaction mxc_timer_irq
clock_event_device clockevent_mxc

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 48 ------------------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 4a6c625..9a89bcf 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -150,40 +150,6 @@ static void gpt_irq_acknowledge_v2_v3(struct imx_timer *tm)
 	__raw_writel(V2_TSTAT_OF1, tm->timer_base + V2_TSTAT);
 }
 
-static inline void gpt_irq_disable(void)
-{
-	unsigned int tmp;
-
-	if (timer_is_v2())
-		__raw_writel(0, timer_base + V2_IR);
-	else {
-		tmp = __raw_readl(timer_base + MXC_TCTL);
-		__raw_writel(tmp & ~MX1_2_TCTL_IRQEN, timer_base + MXC_TCTL);
-	}
-}
-
-static inline void gpt_irq_enable(void)
-{
-	if (timer_is_v2())
-		__raw_writel(1<<0, timer_base + V2_IR);
-	else {
-		__raw_writel(__raw_readl(timer_base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
-			timer_base + MXC_TCTL);
-	}
-}
-
-static void gpt_irq_acknowledge(void)
-{
-	if (timer_is_v1()) {
-		if (cpu_is_mx1())
-			__raw_writel(0, timer_base + MX1_2_TSTAT);
-		else
-			__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
-				timer_base + MX1_2_TSTAT);
-	} else if (timer_is_v2())
-		__raw_writel(V2_TSTAT_OF1, timer_base + V2_TSTAT);
-}
-
 static void __iomem *sched_clock_reg;
 
 static u64 notrace mxc_read_sched_clock(void)
@@ -333,20 +299,6 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction mxc_timer_irq = {
-	.name		= "i.MX Timer Tick",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= mxc_timer_interrupt,
-};
-
-static struct clock_event_device clockevent_mxc = {
-	.name		= "mxc_timer1",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= mxc_set_mode,
-	.set_next_event	= mx1_2_set_next_event,
-	.rating		= 200,
-};
-
 static int __init mxc_clockevent_init(struct clk *timer_clk,
 		struct imx_timer *tm)
 {
-- 
1.9.1
