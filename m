From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:22:19 +0000
Subject: [PATCH 10/22] ARM: SMP: collect IPI and local timer IRQs for
	/proc/stat
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POc95-0007rd-KT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IPI and local timer interrupts weren't being properly accounted
for in /proc/stat.  Collect them from the irq_stat structure, and
return their sum.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardirq.h |    8 ++++++++
 arch/arm/kernel/smp.c          |   15 +++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index c52e250..89ad180 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -22,6 +22,14 @@ typedef struct {
 #define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
 #define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)
 
+#ifdef CONFIG_SMP
+u64 smp_irq_stat_cpu(unsigned int cpu);
+#else
+#define smp_irq_stat_cpu(cpu)	0
+#endif
+
+#define arch_irq_stat_cpu	smp_irq_stat_cpu
+
 #if NR_IRQS > 512
 #define HARDIRQ_BITS	10
 #elif NR_IRQS > 256
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 1d9d6d8..aa1c6f5 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -414,6 +414,21 @@ void show_ipi_list(struct seq_file *p, int prec)
 	}
 }
 
+u64 smp_irq_stat_cpu(unsigned int cpu)
+{
+	u64 sum = 0;
+	int i;
+
+	for (i = 0; i < NR_IPI; i++)
+		sum += __get_irq_stat(cpu, ipi_irqs[i]);
+
+#ifdef CONFIG_LOCAL_TIMERS
+	sum += __get_irq_stat(cpu, local_timer_irqs);
+#endif
+
+	return sum;
+}
+
 /*
  * Timer (local or broadcast) support
  */
-- 
1.6.2.5
