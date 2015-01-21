From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 21 Jan 2015 17:03:38 +0000
Subject: [RFC PATCH v2 1/5] arm: irq: Add a __nmi_count stat
In-Reply-To: <1421859822-3621-1-git-send-email-daniel.thompson@linaro.org>
References: <1421166931-14134-1-git-send-email-daniel.thompson@linaro.org>
 <1421859822-3621-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1421859822-3621-2-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extends the irq statistics for ARM, making it possible to quickly
observe how many times the default FIQ handler has executed.

In /proc/interrupts we use the NMI terminology (rather than FIQ) because
the statistic is only likely to be updated when we run the default FIQ
handler (handle_fiq_as_nmi).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/include/asm/hardirq.h | 1 +
 arch/arm/kernel/irq.c          | 7 ++++++-
 arch/arm/kernel/traps.c        | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 5df33e30ae1b..27ab43b5d7e2 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -9,6 +9,7 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
+	unsigned int __nmi_count;
 #ifdef CONFIG_SMP
 	unsigned int ipi_irqs[NR_IPI];
 #endif
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index ad857bada96c..6dd1619e0700 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -48,13 +48,18 @@ unsigned long irq_err_count;
 
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
+	int i;
+
 #ifdef CONFIG_FIQ
 	show_fiq_list(p, prec);
 #endif
 #ifdef CONFIG_SMP
 	show_ipi_list(p, prec);
 #endif
-	seq_printf(p, "%*s: %10lu\n", prec, "Err", irq_err_count);
+	seq_printf(p, "%*s: ", prec, "NMI");
+	for_each_online_cpu(i)
+		seq_printf(p, "%10u ", __get_irq_stat(i, __nmi_count));
+	seq_printf(p, "\n%*s: %10lu\n", prec, "Err", irq_err_count);
 	return 0;
 }
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1836415b8a5c..5645f81ac4cc 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -476,8 +476,10 @@ die_sig:
  */
 asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
 {
+	unsigned int cpu = smp_processor_id();
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
+	__inc_irq_stat(cpu, __nmi_count);
 	nmi_enter();
 
 #ifdef CONFIG_ARM_GIC
-- 
1.9.3
