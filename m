From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Nov 2010 17:58:44 +0000
Subject: [PATCH 5/9] ARM: smp: provide accessors for irq_stat data
In-Reply-To: <20101115175553.GC31421@n2100.arm.linux.org.uk>
References: <20101115175553.GC31421@n2100.arm.linux.org.uk>
Message-ID: <E1PI3KG-00029m-Sd@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide __inc_irq_stat() and __get_irq_stat() to increment and
read the irq stat counters.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardirq.h |    3 +++
 arch/arm/kernel/smp.c          |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 522fb23..923eaa1 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -14,6 +14,9 @@ typedef struct {
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
+#define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
+#define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)
+
 #if NR_IRQS > 512
 #define HARDIRQ_BITS	10
 #elif NR_IRQS > 256
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b58b6c4..f276336 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -437,7 +437,7 @@ asmlinkage void __exception do_local_timer(struct pt_regs *regs)
 	int cpu = smp_processor_id();
 
 	if (local_timer_ack()) {
-		irq_stat[cpu].local_timer_irqs++;
+		__inc_irq_stat(cpu, local_timer_irqs);
 		ipi_timer();
 	}
 
@@ -451,7 +451,7 @@ void show_local_irqs(struct seq_file *p)
 	seq_printf(p, "LOC: ");
 
 	for_each_present_cpu(cpu)
-		seq_printf(p, "%10u ", irq_stat[cpu].local_timer_irqs);
+		seq_printf(p, "%10u ", __get_irq_stat(cpu, local_timer_irqs));
 
 	seq_putc(p, '\n');
 }
-- 
1.6.2.5
