From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 13 Jan 2015 10:26:58 +0000
Subject: [PATCH 3.19-rc2 v14 7/7] ARM: Fix on-demand backtrace triggered by IRQ
In-Reply-To: <1421144818-14036-1-git-send-email-daniel.thompson@linaro.org>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1421144818-14036-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1421144818-14036-8-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently if arch_trigger_all_cpu_backtrace() is called with interrupts
disabled and on a platform the delivers IPI_CPU_BACKTRACE using regular
IRQ requests the system will wedge for ten seconds waiting for the
current CPU to react to a masked interrupt.

This patch resolves this issue by calling directly into the backtrace
dump code instead of generating an IPI.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/kernel/smp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index afb094a1e6d4..cf3b738568b8 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -742,6 +742,16 @@ void arch_trigger_all_cpu_backtrace(bool include_self)
 		cpumask_clear_cpu(this_cpu, to_cpumask(backtrace_mask));
 	cpumask_copy(&printtrace_mask, to_cpumask(backtrace_mask));
 
+	/*
+	 * If irqs are disabled on the current processor then, if
+	 * IPI_CPU_BACKTRACE is delivered using IRQ, we will won't be able to
+	 * react to IPI_CPU_BACKTRACE until we leave this function. We avoid
+	 * the potential timeout (not to mention the failure to print useful
+	 * information) by calling the backtrace directly.
+	 */
+	if (include_self && irqs_disabled())
+		ipi_cpu_backtrace(in_interrupt() ? get_irq_regs() : NULL);
+
 	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
 		pr_info("Sending FIQ to %s CPUs:\n",
 			(include_self ? "all" : "other"));
@@ -770,7 +780,10 @@ void ipi_cpu_backtrace(struct pt_regs *regs)
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
 		orig = this_cpu_begin_nmi_printk();
 		pr_warn("FIQ backtrace for cpu %d\n", cpu);
-		show_regs(regs);
+		if (regs != NULL)
+			show_regs(regs);
+		else
+			dump_stack();
 		this_cpu_end_nmi_printk(orig);
 
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
-- 
1.9.3
