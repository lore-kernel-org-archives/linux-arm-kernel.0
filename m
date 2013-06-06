From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu,  6 Jun 2013 16:31:25 +0530
Subject: [PATCH 11/13] clocksource: exynos_mct: extend local timer support for
 four cores
In-Reply-To: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1370516488-25860-11-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the local timer interrupt support for handling four local timers.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 drivers/clocksource/exynos_mct.c |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 662fcc0..6af17d4 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -412,6 +412,18 @@ static struct irqaction mct_tick1_event_irq = {
 	.handler	= exynos4_mct_tick_isr,
 };
 
+static struct irqaction mct_tick2_event_irq = {
+	.name		= "mct_tick2_irq",
+	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
+	.handler	= exynos4_mct_tick_isr,
+};
+
+static struct irqaction mct_tick3_event_irq = {
+	.name		= "mct_tick3_irq",
+	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
+	.handler	= exynos4_mct_tick_isr,
+};
+
 static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
 {
 	struct mct_clock_event_device *mevt;
@@ -439,11 +451,21 @@ static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
 			mct_tick0_event_irq.dev_id = mevt;
 			evt->irq = mct_irqs[MCT_L0_IRQ];
 			setup_irq(evt->irq, &mct_tick0_event_irq);
-		} else {
+		} else if (cpu == 1) {
 			mct_tick1_event_irq.dev_id = mevt;
 			evt->irq = mct_irqs[MCT_L1_IRQ];
 			setup_irq(evt->irq, &mct_tick1_event_irq);
 			irq_set_affinity(evt->irq, cpumask_of(1));
+		} else if (cpu == 2) {
+			mct_tick2_event_irq.dev_id = mevt;
+			evt->irq = mct_irqs[MCT_L2_IRQ];
+			setup_irq(evt->irq, &mct_tick2_event_irq);
+			irq_set_affinity(evt->irq, cpumask_of(2));
+		} else if (cpu == 3) {
+			mct_tick3_event_irq.dev_id = mevt;
+			evt->irq = mct_irqs[MCT_L3_IRQ];
+			setup_irq(evt->irq, &mct_tick3_event_irq);
+			irq_set_affinity(evt->irq, cpumask_of(3));
 		}
 	} else {
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
@@ -456,11 +478,16 @@ static void exynos4_local_timer_stop(struct clock_event_device *evt)
 {
 	unsigned int cpu = smp_processor_id();
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
-	if (mct_int_type == MCT_INT_SPI)
+	if (mct_int_type == MCT_INT_SPI) {
 		if (cpu == 0)
 			remove_irq(evt->irq, &mct_tick0_event_irq);
-		else
+		else if (cpu == 1)
 			remove_irq(evt->irq, &mct_tick1_event_irq);
+		else if (cpu == 2)
+			remove_irq(evt->irq, &mct_tick2_event_irq);
+		else if (cpu == 3)
+			remove_irq(evt->irq, &mct_tick3_event_irq);
+	}
 	else
 		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
 }
-- 
1.7.9.5
