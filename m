From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Nov 2010 17:59:15 +0000
Subject: [PATCH 8/9] ARM: smp: provide individual IPI interrupt statistics
In-Reply-To: <20101115175553.GC31421@n2100.arm.linux.org.uk>
References: <20101115175553.GC31421@n2100.arm.linux.org.uk>
Message-ID: <E1PI3Kl-00029y-6h@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This separates out the individual IPI interrupt counts from the
total IPI count, which allows better visibility of what IPIs are
being used for.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardirq.h |    4 +++-
 arch/arm/kernel/irq.c          |    5 +++++
 arch/arm/kernel/smp.c          |   25 +++++++++++++++++++------
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 824b08a..c52e250 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,13 +5,15 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
+#define NR_IPI	5
+
 typedef struct {
 	unsigned int __softirq_pending;
 #ifdef CONFIG_LOCAL_TIMERS
 	unsigned int local_timer_irqs;
 #endif
 #ifdef CONFIG_SMP
-	unsigned int ipi_irqs;
+	unsigned int ipi_irqs[NR_IPI];
 #endif
 } ____cacheline_aligned irq_cpustat_t;
 
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 4e7a7d2..6276f01 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -62,6 +62,11 @@ int show_interrupts(struct seq_file *p, void *v)
 	for (prec = 3, n = 1000; prec < 10 && n <= nr_irqs; prec++)
 		n *= 10;
 
+#ifdef CONFIG_SMP
+	if (prec < 4)
+		prec = 4;
+#endif
+
 	if (i == 0) {
 		char cpuname[12];
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d0e36e3..c088485 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -396,16 +396,28 @@ void arch_send_call_function_single_ipi(int cpu)
 	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
 }
 
+static const char *ipi_types[NR_IPI] = {
+#define S(x,s)	[x - IPI_TIMER] = s
+	S(IPI_TIMER, "Timer broadcast interrupts"),
+	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
+	S(IPI_CALL_FUNC, "Function call interrupts"),
+	S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
+	S(IPI_CPU_STOP, "CPU stop interrupts"),
+};
+
 void show_ipi_list(struct seq_file *p, int prec)
 {
-	unsigned int cpu;
+	unsigned int cpu, i;
 
-	seq_printf(p, "%*s: ", prec, "IPI");
+	for (i = 0; i < NR_IPI; i++) {
+		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
 
-	for_each_present_cpu(cpu)
-		seq_printf(p, "%10u ", __get_irq_stat(cpu, ipi_irqs));
+		for_each_present_cpu(cpu)
+			seq_printf(p, "%10u ",
+				   __get_irq_stat(cpu, ipi_irqs[i]));
 
-	seq_printf(p, " Inter-processor interrupts\n");
+		seq_printf(p, " %s\n", ipi_types[i]);
+	}
 }
 
 /*
@@ -520,7 +532,8 @@ asmlinkage void __exception do_IPI(int ipinr, struct pt_regs *regs)
 	unsigned int cpu = smp_processor_id();
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	__inc_irq_stat(cpu, ipi_irqs);
+	if (ipinr >= IPI_TIMER && ipinr < IPI_TIMER + NR_IPI)
+		__inc_irq_stat(cpu, ipi_irqs[ipinr - IPI_TIMER]);
 
 	switch (ipinr) {
 	case IPI_TIMER:
-- 
1.6.2.5
