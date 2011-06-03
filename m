From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:15:58 +0100
Subject: [PATCH v6 14/14] ARM: exynos4: switch MCT to the full local timer
	infrastructure
In-Reply-To: <1307110558-29710-1-git-send-email-marc.zyngier@arm.com>
References: <1307110558-29710-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307110558-29710-15-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Despite MCT not using PPIs, there is now no reason for not
using the local timer infrastructure.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/mct.c |   68 ++++++++++++++++++------------------------
 1 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-exynos4/mct.c b/arch/arm/mach-exynos4/mct.c
index 14ac10b..1a30278 100644
--- a/arch/arm/mach-exynos4/mct.c
+++ b/arch/arm/mach-exynos4/mct.c
@@ -22,6 +22,7 @@
 
 #include <mach/map.h>
 #include <mach/regs-mct.h>
+#include <asm/localtimer.h>
 #include <asm/mach/time.h>
 
 static unsigned long clk_cnt_per_tick;
@@ -30,9 +31,10 @@ static unsigned long clk_rate;
 struct mct_clock_event_device {
 	struct clock_event_device *evt;
 	void __iomem *base;
+	bool booted;
 };
 
-struct mct_clock_event_device mct_tick[2];
+static struct mct_clock_event_device mct_tick[2];
 
 static void exynos4_mct_write(unsigned int value, void *addr)
 {
@@ -307,17 +309,20 @@ static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
 		exynos4_mct_tick_start(clk_cnt_per_tick, mevt);
 		break;
 
-	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_UNUSED:
+		disable_irq(evt->irq);
+		/* fall through */
+	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
 	}
 }
 
-static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
+int local_timer_ack(void)
 {
-	struct mct_clock_event_device *mevt = dev_id;
+	unsigned int cpu = smp_processor_id();
+	struct mct_clock_event_device *mevt = &mct_tick[cpu];
 	struct clock_event_device *evt = mevt->evt;
 
 	/*
@@ -330,27 +335,14 @@ static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
 
 	/* Clear the MCT tick interrupt */
 	exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
+	
+	return 1;
 }
 
-static struct irqaction mct_tick0_event_irq = {
-	.name		= "mct_tick0_irq",
-	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
-	.handler	= exynos4_mct_tick_isr,
-};
-
-static struct irqaction mct_tick1_event_irq = {
-	.name		= "mct_tick1_irq",
-	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
-	.handler	= exynos4_mct_tick_isr,
-};
-
-static void exynos4_mct_tick_init(struct clock_event_device *evt)
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	unsigned int cpu = smp_processor_id();
+	int err = 0;
 
 	mct_tick[cpu].evt = evt;
 
@@ -378,27 +370,25 @@ static void exynos4_mct_tick_init(struct clock_event_device *evt)
 
 	exynos4_mct_write(0x1, mct_tick[cpu].base + MCT_L_TCNTB_OFFSET);
 
-	if (cpu == 0) {
-		mct_tick0_event_irq.dev_id = &mct_tick[cpu];
-		setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
-	} else {
-		mct_tick1_event_irq.dev_id = &mct_tick[cpu];
-		irq_set_affinity(IRQ_MCT1, cpumask_of(1));
-		setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
-	}
-}
+	if (cpu == 0)
+		evt->irq = IRQ_MCT_L0;
+	else
+		evt->irq = IRQ_MCT_L1;
 
-/* Setup the local clock events for a CPU */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	exynos4_mct_tick_init(evt);
-}
+	if (!mct_tick[cpu].booted) {
+		irq_set_affinity(evt->irq, cpumask_of(cpu));
+		err = request_irq(evt->irq, percpu_timer_handler,
+				  IRQF_TIMER | IRQF_NOBALANCING,
+				  evt->name, evt);
 
-int local_timer_ack(void)
-{
-	return 0;
-}
+		if (err)
+			pr_err("MCT: request_irq failed for %s\n", evt->name);
+		mct_tick[cpu].booted = true;
+	} else
+		enable_irq(evt->irq);
 
+	return err;
+}
 #endif /* CONFIG_LOCAL_TIMERS */
 
 static void __init exynos4_timer_resources(void)
-- 
1.7.0.4
