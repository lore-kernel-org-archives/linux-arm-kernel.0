From: andr2000@gmail.com (Oleksandr Andrushchenko)
Date: Thu, 16 Mar 2017 17:56:04 +0200
Subject: [PATCH] arm64: add support for on-demand backtrace of other CPUs
Message-ID: <1489679764-14408-1-git-send-email-andr2000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Add missing support for on-demand backtrace of other CPUs
for ARM64.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 arch/arm64/include/asm/irq.h |  6 ++++++
 arch/arm64/kernel/smp.c      | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index b77197d941fc..56e09c0e8eaf 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -56,5 +56,11 @@ static inline bool on_irq_stack(unsigned long sp, int cpu)
 	return (low <= sp && sp <= high);
 }
 
+#ifdef CONFIG_SMP
+extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+					   bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+#endif
+
 #endif /* !__ASSEMBLER__ */
 #endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ef1caae02110..70175d3ec0e5 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -34,6 +34,7 @@
 #include <linux/smp.h>
 #include <linux/seq_file.h>
 #include <linux/irq.h>
+#include <linux/nmi.h>
 #include <linux/percpu.h>
 #include <linux/clockchips.h>
 #include <linux/completion.h>
@@ -78,7 +79,8 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP
+	IPI_WAKEUP,
+	IPI_CPU_BACKTRACE
 };
 
 #ifdef CONFIG_ARM64_VHE
@@ -883,6 +885,12 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 #endif
 
+	case IPI_CPU_BACKTRACE:
+		irq_enter();
+		nmi_cpu_backtrace(regs);
+		irq_exit();
+		break;
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
@@ -956,3 +964,13 @@ bool cpus_are_stuck_in_kernel(void)
 
 	return !!cpus_stuck_in_kernel || smp_spin_tables;
 }
+
+static void raise_nmi(cpumask_t *mask)
+{
+	smp_cross_call(mask, IPI_CPU_BACKTRACE);
+}
+
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_nmi);
+}
-- 
2.7.4
