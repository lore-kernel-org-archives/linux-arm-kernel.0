From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:21:18 +0000
Subject: [PATCH 07/22] ARM: SMP: move ipi_count into irq_stat structure
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POc86-0007rR-B9@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the ipi_count into irq_stat, which allows the ipi_data structure
to be entirely removed.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardirq.h |    3 +++
 arch/arm/kernel/smp.c          |   14 ++------------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 923eaa1..824b08a 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -10,6 +10,9 @@ typedef struct {
 #ifdef CONFIG_LOCAL_TIMERS
 	unsigned int local_timer_irqs;
 #endif
+#ifdef CONFIG_SMP
+	unsigned int ipi_irqs;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 101bce0..42e0ae9 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -46,15 +46,6 @@
  */
 struct secondary_data secondary_data;
 
-/*
- * structures for inter-processor calls
- */
-struct ipi_data {
-	unsigned long ipi_count;
-};
-
-static DEFINE_PER_CPU(struct ipi_data, ipi_data);
-
 enum ipi_msg_type {
 	IPI_TIMER = 2,
 	IPI_RESCHEDULE,
@@ -406,7 +397,7 @@ void show_ipi_list(struct seq_file *p)
 	seq_puts(p, "IPI:");
 
 	for_each_present_cpu(cpu)
-		seq_printf(p, " %10lu", per_cpu(ipi_data, cpu).ipi_count);
+		seq_printf(p, " %10u", __get_irq_stat(cpu, ipi_irqs));
 
 	seq_putc(p, '\n');
 }
@@ -521,10 +512,9 @@ static void ipi_cpu_stop(unsigned int cpu)
 asmlinkage void __exception do_IPI(int ipinr, struct pt_regs *regs)
 {
 	unsigned int cpu = smp_processor_id();
-	struct ipi_data *ipi = &per_cpu(ipi_data, cpu);
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	ipi->ipi_count++;
+	__inc_irq_stat(cpu, ipi_irqs);
 
 	switch (ipinr) {
 	case IPI_TIMER:
-- 
1.6.2.5
