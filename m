From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Sep 2011 16:25:00 +0900
Subject: [PATCH 2/2] ARM: EXYNOS4: Add support MCT PPI for EXYNOS4212
Message-ID: <009001cc7e78$e628f180$b27ad480$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch implements clock event timer using MCT PPI
and make EXYNOS4212 use MCT PPI instead of MCT SPI.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/entry-macro.S |    6 ++
 arch/arm/mach-exynos4/include/mach/irqs.h        |    2 +
 arch/arm/mach-exynos4/mct.c                      |   55 ++++++++++++++++++----
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
index d7a1e28..c09ab4c 100644
--- a/arch/arm/mach-exynos4/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -80,4 +80,10 @@
 		/* As above, this assumes that irqstat and base are preserved.. */
 
 		.macro test_for_ltirq, irqnr, irqstat, base, tmp
+		bic	\irqnr, \irqstat, #0x1c00
+		mov	\tmp, #0
+		cmp	\irqnr, #28
+		moveq	\tmp, #1
+		streq	\irqstat, [\base, #GIC_CPU_EOI]
+		cmp	\tmp, #0
 		.endm
diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index 62093b9..dfd4b7e 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -19,6 +19,8 @@
 
 #define IRQ_PPI(x)		S5P_IRQ(x+16)
 
+#define IRQ_MCT_LOCALTIMER	IRQ_PPI(12)
+
 /* SPI: Shared Peripheral Interrupt */
 
 #define IRQ_SPI(x)		S5P_IRQ(x+32)
diff --git a/arch/arm/mach-exynos4/mct.c b/arch/arm/mach-exynos4/mct.c
index ddd8686..f43f3fa 100644
--- a/arch/arm/mach-exynos4/mct.c
+++ b/arch/arm/mach-exynos4/mct.c
@@ -20,12 +20,23 @@
 #include <linux/delay.h>
 #include <linux/percpu.h>
 
+#include <asm/hardware/gic.h>
+
+#include <plat/cpu.h>
+
 #include <mach/map.h>
+#include <mach/irqs.h>
 #include <mach/regs-mct.h>
 #include <asm/mach/time.h>
 
+enum {
+	MCT_INT_SPI,
+	MCT_INT_PPI
+};
+
 static unsigned long clk_cnt_per_tick;
 static unsigned long clk_rate;
+static unsigned int mct_int_type;
 
 struct mct_clock_event_device {
 	struct clock_event_device *evt;
@@ -321,9 +332,8 @@ static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
 	}
 }
 
-static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
+static inline int exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
 {
-	struct mct_clock_event_device *mevt = dev_id;
 	struct clock_event_device *evt = mevt->evt;
 
 	/*
@@ -335,7 +345,20 @@ static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
 		exynos4_mct_tick_stop(mevt);
 
 	/* Clear the MCT tick interrupt */
-	exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
+	if (__raw_readl(mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1) {
+		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
+{
+	struct mct_clock_event_device *mevt = dev_id;
+	struct clock_event_device *evt = mevt->evt;
+
+	exynos4_mct_tick_clear(mevt);
 
 	evt->event_handler(evt);
 
@@ -384,13 +407,17 @@ static void exynos4_mct_tick_init(struct clock_event_device *evt)
 
 	exynos4_mct_write(0x1, mct_tick[cpu].base + MCT_L_TCNTB_OFFSET);
 
-	if (cpu == 0) {
-		mct_tick0_event_irq.dev_id = &mct_tick[cpu];
-		setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
+	if (mct_int_type == MCT_INT_SPI) {
+		if (cpu == 0) {
+			mct_tick0_event_irq.dev_id = &mct_tick[cpu];
+			setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
+		} else {
+			mct_tick1_event_irq.dev_id = &mct_tick[cpu];
+			setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
+			irq_set_affinity(IRQ_MCT_L1, cpumask_of(1));
+		}
 	} else {
-		mct_tick1_event_irq.dev_id = &mct_tick[cpu];
-		setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
-		irq_set_affinity(IRQ_MCT_L1, cpumask_of(1));
+		gic_enable_ppi(IRQ_MCT_LOCALTIMER);
 	}
 }
 
@@ -404,7 +431,10 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 
 int local_timer_ack(void)
 {
-	return 0;
+	unsigned int cpu = smp_processor_id();
+	struct mct_clock_event_device *mevt = &mct_tick[cpu];
+
+	return exynos4_mct_tick_clear(mevt);
 }
 
 #endif /* CONFIG_LOCAL_TIMERS */
@@ -419,6 +449,11 @@ static void __init exynos4_timer_resources(void)
 
 static void __init exynos4_timer_init(void)
 {
+	if (soc_is_exynos4210())
+		mct_int_type = MCT_INT_SPI;
+	else
+		mct_int_type = MCT_INT_PPI;
+
 	exynos4_timer_resources();
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
-- 
1.7.1
