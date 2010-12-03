From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:21:38 +0000
Subject: [PATCH 08/22] ARM: fix /proc/interrupts formatting
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POc8Q-0007rV-P2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per x86, align the initial column according to how many IRQs we
have.  Also, provide an english explaination for the 'LOC:' and
'IPI:' lines.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/irq.h |    2 +-
 arch/arm/include/asm/smp.h      |    4 ++--
 arch/arm/kernel/fiq.c           |    5 +++--
 arch/arm/kernel/irq.c           |   16 ++++++++++------
 arch/arm/kernel/smp.c           |   14 +++++++-------
 5 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
index ce3eee9..2bc47fb 100644
--- a/arch/arm/include/asm/mach/irq.h
+++ b/arch/arm/include/asm/mach/irq.h
@@ -20,7 +20,7 @@ struct seq_file;
 extern unsigned int arch_nr_irqs;
 extern void (*init_arch_irq)(void);
 extern void init_FIQ(void);
-extern int show_fiq_list(struct seq_file *, void *);
+extern int show_fiq_list(struct seq_file *, int);
 
 /*
  * This is for easy migration, but should be changed in the source
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index da7e7ca..f93d0a6 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -33,7 +33,7 @@ struct seq_file;
 /*
  * generate IPI list text
  */
-extern void show_ipi_list(struct seq_file *p);
+extern void show_ipi_list(struct seq_file *, int);
 
 /*
  * Called from assembly code, this handles an IPI.
@@ -97,6 +97,6 @@ extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 /*
  * show local interrupt info
  */
-extern void show_local_irqs(struct seq_file *);
+extern void show_local_irqs(struct seq_file *, int);
 
 #endif /* ifndef __ASM_ARM_SMP_H */
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 6ff7919..47837b8 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -67,10 +67,11 @@ static struct fiq_handler default_owner = {
 
 static struct fiq_handler *current_fiq = &default_owner;
 
-int show_fiq_list(struct seq_file *p, void *v)
+int show_fiq_list(struct seq_file *p, int prec)
 {
 	if (current_fiq != &default_owner)
-		seq_printf(p, "FIQ:              %s\n", current_fiq->name);
+		seq_printf(p, "%*s:              %s\n", prec, "FIQ",
+			current_fiq->name);
 
 	return 0;
 }
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index ea29721..4e7a7d2 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -57,11 +57,15 @@ int show_interrupts(struct seq_file *p, void *v)
 	struct irq_desc *desc;
 	struct irqaction * action;
 	unsigned long flags;
+	int prec, n;
+
+	for (prec = 3, n = 1000; prec < 10 && n <= nr_irqs; prec++)
+		n *= 10;
 
 	if (i == 0) {
 		char cpuname[12];
 
-		seq_printf(p, "    ");
+		seq_printf(p, "%*s ", prec, "");
 		for_each_present_cpu(cpu) {
 			sprintf(cpuname, "CPU%d", cpu);
 			seq_printf(p, " %10s", cpuname);
@@ -76,7 +80,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		if (!action)
 			goto unlock;
 
-		seq_printf(p, "%3d: ", i);
+		seq_printf(p, "%*d: ", prec, i);
 		for_each_present_cpu(cpu)
 			seq_printf(p, "%10u ", kstat_irqs_cpu(i, cpu));
 		seq_printf(p, " %10s", desc->chip->name ? : "-");
@@ -89,15 +93,15 @@ unlock:
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	} else if (i == nr_irqs) {
 #ifdef CONFIG_FIQ
-		show_fiq_list(p, v);
+		show_fiq_list(p, prec);
 #endif
 #ifdef CONFIG_SMP
-		show_ipi_list(p);
+		show_ipi_list(p, prec);
 #endif
 #ifdef CONFIG_LOCAL_TIMERS
-		show_local_irqs(p);
+		show_local_irqs(p, prec);
 #endif
-		seq_printf(p, "Err: %10lu\n", irq_err_count);
+		seq_printf(p, "%*s: %10lu\n", prec, "Err", irq_err_count);
 	}
 	return 0;
 }
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 42e0ae9..e45efae 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -390,16 +390,16 @@ void arch_send_call_function_single_ipi(int cpu)
 	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
 }
 
-void show_ipi_list(struct seq_file *p)
+void show_ipi_list(struct seq_file *p, int prec)
 {
 	unsigned int cpu;
 
-	seq_puts(p, "IPI:");
+	seq_printf(p, "%*s: ", prec, "IPI");
 
 	for_each_present_cpu(cpu)
-		seq_printf(p, " %10u", __get_irq_stat(cpu, ipi_irqs));
+		seq_printf(p, "%10u ", __get_irq_stat(cpu, ipi_irqs));
 
-	seq_putc(p, '\n');
+	seq_printf(p, " Inter-processor interrupts\n");
 }
 
 /*
@@ -429,16 +429,16 @@ asmlinkage void __exception do_local_timer(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
-void show_local_irqs(struct seq_file *p)
+void show_local_irqs(struct seq_file *p, int prec)
 {
 	unsigned int cpu;
 
-	seq_printf(p, "LOC: ");
+	seq_printf(p, "%*s: ", prec, "LOC");
 
 	for_each_present_cpu(cpu)
 		seq_printf(p, "%10u ", __get_irq_stat(cpu, local_timer_irqs));
 
-	seq_putc(p, '\n');
+	seq_printf(p, " Local timer interrupts\n");
 }
 #endif
 
-- 
1.6.2.5
