From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Apr 2011 20:08:11 +0100
Subject: [RFC PATCH 02/12] ARM: smp_twd: add support for remapped PPI
	interrupts
In-Reply-To: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1303326501-15664-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_ARM_GIC_VPPI is enabled, let smp_twd request interrupts
the normal way (ie using request_irq()).

This involves letting PPIs go via the same code path as SPIs and
having normal interrupt handler for the local timer code.

The previous ad-hoc code is still supported when CONFIG_ARM_GIC_VPPI
is not defined.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/entry-macro-multi.S        |    2 +-
 arch/arm/include/asm/hardware/entry-macro-gic.S |   19 ++++++++++++-------
 arch/arm/include/asm/localtimer.h               |    6 ++++++
 arch/arm/kernel/smp.c                           |   10 ++++++++++
 arch/arm/kernel/smp_twd.c                       |   16 +++++++++++++++-
 5 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/entry-macro-multi.S b/arch/arm/include/asm/entry-macro-multi.S
index ec0bbf7..c599795 100644
--- a/arch/arm/include/asm/entry-macro-multi.S
+++ b/arch/arm/include/asm/entry-macro-multi.S
@@ -24,7 +24,7 @@
 	adrne	lr, BSYM(1b)
 	bne	do_IPI
 
-#ifdef CONFIG_LOCAL_TIMERS
+#if defined(CONFIG_LOCAL_TIMERS) && !defined(CONFIG_ARM_GIC_VPPI)
 	test_for_ltirq r0, r6, r5, lr
 	movne	r0, sp
 	adrne	lr, BSYM(1b)
diff --git a/arch/arm/include/asm/hardware/entry-macro-gic.S b/arch/arm/include/asm/hardware/entry-macro-gic.S
index c115b82..14a3363 100644
--- a/arch/arm/include/asm/hardware/entry-macro-gic.S
+++ b/arch/arm/include/asm/hardware/entry-macro-gic.S
@@ -17,23 +17,26 @@
 	.endm
 #endif
 
+#ifdef CONFIG_ARM_GIC_VPPI
+#define DO_IRQ_BASE	16
+#else
+#define DO_IRQ_BASE	30
+#endif
+
 /*
  * The interrupt numbering scheme is defined in the
  * interrupt controller spec.  To wit:
  *
  * Interrupts 0-15 are IPI
- * 16-28 are reserved
- * 29-31 are local.  We allow 30 to be used for the watchdog.
+ * 16-31 are local.  We allow 30 to be used for the watchdog.
  * 32-1020 are global
  * 1021-1022 are reserved
  * 1023 is "spurious" (no interrupt)
  *
- * For now, we ignore all local interrupts so only return an interrupt if it's
- * between 30 and 1020.  The test_for_ipi routine below will pick up on IPIs.
- *
  * A simple read from the controller will tell us the number of the highest
  * priority enabled interrupt.  We then just need to check whether it is in the
- * valid range for an IRQ (30-1020 inclusive).
+ * valid range for an IRQ (30-1020 inclusive). If CONFIG_ARM_GIC_VPPI is
+ * enabled, local interrupts are handled the same way as global ones.
  */
 
 	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
@@ -43,7 +46,7 @@
 
 	ldr	\tmp, =1021
 	bic     \irqnr, \irqstat, #0x1c00
-	cmp     \irqnr, #29
+	cmp     \irqnr, #(DO_IRQ_BASE - 1)
 	cmpcc	\irqnr, \irqnr
 	cmpne	\irqnr, \tmp
 	cmpcs	\irqnr, \irqnr
@@ -63,6 +66,7 @@
 	cmpcs	\irqnr, \irqnr
 	.endm
 
+#ifndef CONFIG_ARM_GIC_VPPI
 /* As above, this assumes that irqstat and base are preserved.. */
 
 	.macro test_for_ltirq, irqnr, irqstat, base, tmp
@@ -73,3 +77,4 @@
 	streq	\irqstat, [\base, #GIC_CPU_EOI]
 	cmp	\tmp, #0
 	.endm
+#endif
diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 080d74f..bef44b3 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -10,6 +10,8 @@
 #ifndef __ASM_ARM_LOCALTIMER_H
 #define __ASM_ARM_LOCALTIMER_H
 
+#include <linux/interrupt.h>
+
 struct clock_event_device;
 
 /*
@@ -22,6 +24,10 @@ void percpu_timer_setup(void);
  */
 asmlinkage void do_local_timer(struct pt_regs *);
 
+/*
+ * Per-cpu timer IRQ handler
+ */
+irqreturn_t percpu_timer_handler(int irq, void *dev_id);
 
 #ifdef CONFIG_LOCAL_TIMERS
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8fe05ad..64b9d81 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -452,6 +452,16 @@ asmlinkage void __exception_irq_entry do_local_timer(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+irqreturn_t percpu_timer_handler(int irq, void *dev_id)
+{
+	if (local_timer_ack()) {
+		ipi_timer();
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
 void show_local_irqs(struct seq_file *p, int prec)
 {
 	unsigned int cpu;
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 60636f4..bbb0f4d 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -15,10 +15,11 @@
 #include <linux/smp.h>
 #include <linux/jiffies.h>
 #include <linux/clockchips.h>
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 
 #include <asm/smp_twd.h>
+#include <asm/localtimer.h>
 #include <asm/hardware/gic.h>
 
 /* set up by the platform code */
@@ -124,6 +125,8 @@ static void __cpuinit twd_calibrate_rate(void)
  */
 void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
+	int err;
+
 	twd_calibrate_rate();
 
 	clk->name = "local_timer";
@@ -137,8 +140,19 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
 	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
 
+#ifdef CONFIG_ARM_GIC_VPPI
+	err = request_irq(clk->irq, percpu_timer_handler,
+			  IRQF_PERCPU | IRQF_NOBALANCING | IRQF_TIMER,
+			  clk->name, clk);
+	if (err) {
+		pr_err("%s: can't register interrupt %d on cpu %d (%d)\n",
+		       clk->name, clk->irq, smp_processor_id(), err);
+		return;
+	}
+#else
 	/* Make sure our local interrupt controller has this enabled */
 	gic_enable_ppi(clk->irq);
+#endif
 
 	clockevents_register_device(clk);
 }
-- 
1.7.0.4
