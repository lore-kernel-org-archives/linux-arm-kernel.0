From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Apr 2011 20:08:19 +0100
Subject: [RFC PATCH 10/12] ARM: gic: remove previous local timer interrupt
	handling
In-Reply-To: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1303326501-15664-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all users of local timers are using CONFIG_ARM_GIC_VPPI,
the now unused local timer infrastructure can be safely removed.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/common/gic.c                           |   10 ----------
 arch/arm/include/asm/entry-macro-multi.S        |    7 -------
 arch/arm/include/asm/hardware/entry-macro-gic.S |   13 -------------
 arch/arm/include/asm/hardware/gic.h             |    1 -
 arch/arm/include/asm/localtimer.h               |    5 -----
 arch/arm/kernel/smp.c                           |   13 -------------
 arch/arm/kernel/smp_twd.c                       |    5 -----
 7 files changed, 0 insertions(+), 54 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 60f8915..9236ce6 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -500,16 +500,6 @@ void __cpuinit gic_secondary_init(unsigned int gic_nr)
 	gic_cpu_init(&gic_data[gic_nr]);
 }
 
-void __cpuinit gic_enable_ppi(unsigned int irq)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	irq_set_status_flags(irq, IRQ_NOPROBE);
-	gic_unmask_irq(irq_get_irq_data(irq));
-	local_irq_restore(flags);
-}
-
 #ifdef CONFIG_SMP
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
diff --git a/arch/arm/include/asm/entry-macro-multi.S b/arch/arm/include/asm/entry-macro-multi.S
index c599795..4ef27af 100644
--- a/arch/arm/include/asm/entry-macro-multi.S
+++ b/arch/arm/include/asm/entry-macro-multi.S
@@ -23,13 +23,6 @@
 	movne	r1, sp
 	adrne	lr, BSYM(1b)
 	bne	do_IPI
-
-#if defined(CONFIG_LOCAL_TIMERS) && !defined(CONFIG_ARM_GIC_VPPI)
-	test_for_ltirq r0, r6, r5, lr
-	movne	r0, sp
-	adrne	lr, BSYM(1b)
-	bne	do_local_timer
-#endif
 #endif
 9997:
 	.endm
diff --git a/arch/arm/include/asm/hardware/entry-macro-gic.S b/arch/arm/include/asm/hardware/entry-macro-gic.S
index 14a3363..db83287 100644
--- a/arch/arm/include/asm/hardware/entry-macro-gic.S
+++ b/arch/arm/include/asm/hardware/entry-macro-gic.S
@@ -65,16 +65,3 @@
 	strcc	\irqstat, [\base, #GIC_CPU_EOI]
 	cmpcs	\irqnr, \irqnr
 	.endm
-
-#ifndef CONFIG_ARM_GIC_VPPI
-/* As above, this assumes that irqstat and base are preserved.. */
-
-	.macro test_for_ltirq, irqnr, irqstat, base, tmp
-	bic	\irqnr, \irqstat, #0x1c00
-	mov 	\tmp, #0
-	cmp	\irqnr, #29
-	moveq	\tmp, #1
-	streq	\irqstat, [\base, #GIC_CPU_EOI]
-	cmp	\tmp, #0
-	.endm
-#endif
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 9dbffed..069d4c0 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -42,7 +42,6 @@ void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
 void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
-void gic_enable_ppi(unsigned int);
 #ifdef CONFIG_ARM_GIC_VPPI
 unsigned int gic_ppi_to_vppi(unsigned int irq);
 #else
diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index bef44b3..5c8acb4 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -20,11 +20,6 @@ struct clock_event_device;
 void percpu_timer_setup(void);
 
 /*
- * Called from assembly, this is the local timer IRQ handler
- */
-asmlinkage void do_local_timer(struct pt_regs *);
-
-/*
  * Per-cpu timer IRQ handler
  */
 irqreturn_t percpu_timer_handler(int irq, void *dev_id);
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 64b9d81..798a357 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -439,19 +439,6 @@ static void ipi_timer(void)
 }
 
 #ifdef CONFIG_LOCAL_TIMERS
-asmlinkage void __exception_irq_entry do_local_timer(struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-	int cpu = smp_processor_id();
-
-	if (local_timer_ack()) {
-		__inc_irq_stat(cpu, local_timer_irqs);
-		ipi_timer();
-	}
-
-	set_irq_regs(old_regs);
-}
-
 irqreturn_t percpu_timer_handler(int irq, void *dev_id)
 {
 	if (local_timer_ack()) {
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index bbb0f4d..082753c 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -140,7 +140,6 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
 	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
 
-#ifdef CONFIG_ARM_GIC_VPPI
 	err = request_irq(clk->irq, percpu_timer_handler,
 			  IRQF_PERCPU | IRQF_NOBALANCING | IRQF_TIMER,
 			  clk->name, clk);
@@ -149,10 +148,6 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 		       clk->name, clk->irq, smp_processor_id(), err);
 		return;
 	}
-#else
-	/* Make sure our local interrupt controller has this enabled */
-	gic_enable_ppi(clk->irq);
-#endif
 
 	clockevents_register_device(clk);
 }
-- 
1.7.0.4
