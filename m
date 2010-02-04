From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 4 Feb 2010 11:11:58 -0800
Subject: [RFC PATCH 2/3] [ARM] Preliminary support for dynamic IRQ
Message-ID: <f17812d71002041111i1171b055t5d0d0bf585bfba5d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To solve the mess that a heavy usage of board IRQs on ARM and the
diversity, we might end up with a dynamic solution, where SPARSE_IRQ
looks so far fit at least.

commit 59e902671333e2b3c39cb39a47e2c6b673c9f406
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Wed Feb 3 18:16:43 2010 -0800

    [ARM] Preliminary support for dynamic IRQ

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c33ca8..c95484c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -920,6 +920,18 @@ config ARM_ERRATA_460075
 	  ACTLR register. Note that setting specific bits in the ACTLR register
 	  may not be available in non-secure mode.

+config SPARSE_IRQ
+	bool "Support sparse irq numbering"
+	depends on EXPERIMENTAL
+	help
+	  This enables support for sparse irqs. This is useful in general
+	  as most CPUs have a fairly sparse array of IRQ vectors, which
+	  the irq_desc then maps directly on to. Systems with a high
+	  number of off-chip IRQs will want to treat this as
+	  experimental until they have been independently verified.
+
+	  If you don't know what to do here, say N.
+
 endmenu

 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 328f14a..a1ea728 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -7,6 +7,8 @@
 #define irq_canonicalize(i)	(i)
 #endif

+#define NR_IRQS_LEGACY	16
+
 /*
  * Use this value to indicate lack of interrupt
  * capability
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index b7cb45b..e62f39b 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -54,6 +54,7 @@ unsigned long irq_err_count;
 int show_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, cpu;
+	struct irq_desc *desc;
 	struct irqaction * action;
 	unsigned long flags;

@@ -68,24 +69,25 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 	}

-	if (i < NR_IRQS) {
-		raw_spin_lock_irqsave(&irq_desc[i].lock, flags);
-		action = irq_desc[i].action;
+	if (i < nr_irqs) {
+		desc = irq_to_desc(i);
+		raw_spin_lock_irqsave(&desc->lock, flags);
+		action = desc->action;
 		if (!action)
 			goto unlock;

 		seq_printf(p, "%3d: ", i);
 		for_each_present_cpu(cpu)
 			seq_printf(p, "%10u ", kstat_irqs_cpu(i, cpu));
-		seq_printf(p, " %10s", irq_desc[i].chip->name ? : "-");
+		seq_printf(p, " %10s", desc->chip->name ? : "-");
 		seq_printf(p, "  %s", action->name);
 		for (action = action->next; action; action = action->next)
 			seq_printf(p, ", %s", action->name);

 		seq_putc(p, '\n');
 unlock:
-		raw_spin_unlock_irqrestore(&irq_desc[i].lock, flags);
-	} else if (i == NR_IRQS) {
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+	} else if (i == nr_irqs) {
 #ifdef CONFIG_FIQ
 		show_fiq_list(p, v);
 #endif
@@ -113,7 +115,7 @@ asmlinkage void __exception asm_do_IRQ(unsigned
int irq, struct pt_regs *regs)
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
 	 */
-	if (unlikely(irq >= NR_IRQS)) {
+	if (unlikely(irq >= nr_irqs)) {
 		if (printk_ratelimit())
 			printk(KERN_WARNING "Bad IRQ%u\n", irq);
 		ack_bad_irq(irq);
@@ -133,12 +135,12 @@ void set_irq_flags(unsigned int irq, unsigned int iflags)
 	struct irq_desc *desc;
 	unsigned long flags;

-	if (irq >= NR_IRQS) {
+	if (irq >= nr_irqs) {
 		printk(KERN_ERR "Trying to set irq flags for IRQ%d\n", irq);
 		return;
 	}

-	desc = irq_desc + irq;
+	desc = irq_to_desc(irq);
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	if (iflags & IRQF_VALID)
@@ -152,14 +154,25 @@ void set_irq_flags(unsigned int irq, unsigned int iflags)

 void __init init_IRQ(void)
 {
+	struct irq_desc *desc;
 	int irq;

-	for (irq = 0; irq < NR_IRQS; irq++)
-		irq_desc[irq].status |= IRQ_NOREQUEST | IRQ_NOPROBE;
+	for (irq = 0; irq < nr_irqs; irq++) {
+		desc = irq_to_desc_alloc_node(irq, 0);
+		desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE;
+	}

 	init_arch_irq();
 }

+#ifdef CONFIG_SPARSE_IRQ
+int __init arch_probe_nr_irqs(void)
+{
+	nr_irqs = NR_IRQS;
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_HOTPLUG_CPU

 static void route_irq(struct irq_desc *desc, unsigned int irq,
unsigned int cpu)
@@ -179,10 +192,9 @@ static void route_irq(struct irq_desc *desc,
unsigned int irq, unsigned int cpu)
 void migrate_irqs(void)
 {
 	unsigned int i, cpu = smp_processor_id();
+	struct irq_desc *desc;

-	for (i = 0; i < NR_IRQS; i++) {
-		struct irq_desc *desc = irq_desc + i;
-
+	for_each_irq_desc(i, desc) {
 		if (desc->node == cpu) {
 			unsigned int newcpu = cpumask_any_and(desc->affinity,
 							      cpu_online_mask);
