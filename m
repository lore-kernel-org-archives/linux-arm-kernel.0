From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Nov 2011 17:30:48 +0000
Subject: [PATCH 1/2] ARM: EXYNOS4: convert MCT to percpu interrupt API
In-Reply-To: <1320255049-12447-1-git-send-email-marc.zyngier@arm.com>
References: <1320255049-12447-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1320255049-12447-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MCT recently gained per cpu interrupts, and missed the fact that
ARM has moved to a genirq based implementation.

This patch converts the driver to the new API.

Boot tested on Origen.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/mct.c |   40 +++++++++++++++++++++++++++-------------
 1 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-exynos4/mct.c b/arch/arm/mach-exynos4/mct.c
index f191608..97343df 100644
--- a/arch/arm/mach-exynos4/mct.c
+++ b/arch/arm/mach-exynos4/mct.c
@@ -44,7 +44,7 @@ struct mct_clock_event_device {
 	char name[10];
 };
 
-struct mct_clock_event_device mct_tick[NR_CPUS];
+static DEFINE_PER_CPU(struct mct_clock_event_device, percpu_mct_tick);
 
 static void exynos4_mct_write(unsigned int value, void *addr)
 {
@@ -302,7 +302,7 @@ static void exynos4_mct_tick_start(unsigned long cycles,
 static int exynos4_tick_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
-	struct mct_clock_event_device *mevt = &mct_tick[smp_processor_id()];
+	struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
 
 	exynos4_mct_tick_start(cycles, mevt);
 
@@ -312,7 +312,7 @@ static int exynos4_tick_set_next_event(unsigned long cycles,
 static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
 					 struct clock_event_device *evt)
 {
-	struct mct_clock_event_device *mevt = &mct_tick[smp_processor_id()];
+	struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
 
 	exynos4_mct_tick_stop(mevt);
 
@@ -376,14 +376,16 @@ static struct irqaction mct_tick1_event_irq = {
 
 static void exynos4_mct_tick_init(struct clock_event_device *evt)
 {
+	struct mct_clock_event_device *mevt;
 	unsigned int cpu = smp_processor_id();
 
-	mct_tick[cpu].evt = evt;
+	mevt = this_cpu_ptr(&percpu_mct_tick);
+	mevt->evt = evt;
 
-	mct_tick[cpu].base = EXYNOS4_MCT_L_BASE(cpu);
-	sprintf(mct_tick[cpu].name, "mct_tick%d", cpu);
+	mevt->base = EXYNOS4_MCT_L_BASE(cpu);
+	sprintf(mevt->name, "mct_tick%d", cpu);
 
-	evt->name = mct_tick[cpu].name;
+	evt->name = mevt->name;
 	evt->cpumask = cpumask_of(cpu);
 	evt->set_next_event = exynos4_tick_set_next_event;
 	evt->set_mode = exynos4_tick_set_mode;
@@ -398,21 +400,21 @@ static void exynos4_mct_tick_init(struct clock_event_device *evt)
 
 	clockevents_register_device(evt);
 
-	exynos4_mct_write(0x1, mct_tick[cpu].base + MCT_L_TCNTB_OFFSET);
+	exynos4_mct_write(0x1, mevt->base + MCT_L_TCNTB_OFFSET);
 
 	if (mct_int_type == MCT_INT_SPI) {
 		if (cpu == 0) {
-			mct_tick0_event_irq.dev_id = &mct_tick[cpu];
+			mct_tick0_event_irq.dev_id = mevt;
 			evt->irq = IRQ_MCT_L0;
 			setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
 		} else {
-			mct_tick1_event_irq.dev_id = &mct_tick[cpu];
+			mct_tick1_event_irq.dev_id = mevt;
 			evt->irq = IRQ_MCT_L1;
 			setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
 			irq_set_affinity(IRQ_MCT_L1, cpumask_of(1));
 		}
 	} else {
-		gic_enable_ppi(IRQ_MCT_LOCALTIMER);
+		enable_percpu_irq(IRQ_MCT_LOCALTIMER, 0);
 	}
 }
 
@@ -427,9 +429,11 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 void local_timer_stop(struct clock_event_device *evt)
 {
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
-	disable_irq(evt->irq);
+	if (mct_int_type == MCT_INT_SPI)
+		disable_irq(evt->irq);
+	else
+		disable_percpu_irq(IRQ_MCT_LOCALTIMER);
 }
-
 #endif /* CONFIG_LOCAL_TIMERS */
 
 static void __init exynos4_timer_resources(void)
@@ -438,6 +442,16 @@ static void __init exynos4_timer_resources(void)
 	mct_clk = clk_get(NULL, "xtal");
 
 	clk_rate = clk_get_rate(mct_clk);
+
+	if (mct_int_type == MCT_INT_PPI) {
+		int err;
+
+		err = request_percpu_irq(IRQ_MCT_LOCALTIMER,
+					 exynos4_mct_tick_isr, "MCT",
+					 &percpu_mct_tick);
+		WARN(err, "MCT: can't request IRQ %d (%d)\n",
+		     IRQ_MCT_LOCALTIMER, err);
+	}
 }
 
 static void __init exynos4_timer_init(void)
-- 
1.7.0.4
