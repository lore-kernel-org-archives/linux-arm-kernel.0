From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 21:39:42 +0100
Subject: [PATCH 3/3] ARM: add basic support for on-demand backtrace of other
 CPUs
In-Reply-To: <20150715203911.GF7557@n2100.arm.linux.org.uk>
References: <20150715203911.GF7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFTSw-0006vI-C2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we now have generic infrastructure to support backtracing of other
CPUs in the system on lockups, we can start to implement this for ARM.
Initially, we add an IPI based implementation, as the GIC code needs
modification to support the generation of FIQ IPIs, and not all ARM
platforms have the ability to raise a FIQ in the non-secure world.

This provides us with a "best efforts" implementation in the absence
of FIQs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/irq.h |  5 +++++
 arch/arm/kernel/smp.c      | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 53c15dec7af6..be1d07d59ee9 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -35,6 +35,11 @@ extern void (*handle_arch_irq)(struct pt_regs *);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 #endif
 
+#ifdef CONFIG_SMP
+extern void arch_trigger_all_cpu_backtrace(bool);
+#define arch_trigger_all_cpu_backtrace(x) arch_trigger_all_cpu_backtrace(x)
+#endif
+
 #endif
 
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 90dfbedfbfb8..3a20c386fd33 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -21,6 +21,7 @@
 #include <linux/cpu.h>
 #include <linux/seq_file.h>
 #include <linux/irq.h>
+#include <linux/nmi.h>
 #include <linux/percpu.h>
 #include <linux/clockchips.h>
 #include <linux/completion.h>
@@ -72,6 +73,7 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	IPI_CPU_BACKTRACE = 15,
 };
 
 static DECLARE_COMPLETION(cpu_running);
@@ -630,6 +632,12 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		irq_exit();
 		break;
 
+	case IPI_CPU_BACKTRACE:
+		irq_enter();
+		nmi_cpu_backtrace(regs);
+		irq_exit();
+		break;
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n",
 		        cpu, ipinr);
@@ -724,3 +732,13 @@ static int __init register_cpufreq_notifier(void)
 core_initcall(register_cpufreq_notifier);
 
 #endif
+
+static void raise_nmi(cpumask_t *mask)
+{
+	smp_cross_call(mask, IPI_CPU_BACKTRACE);
+}
+
+void arch_trigger_all_cpu_backtrace(bool include_self)
+{
+	nmi_trigger_all_cpu_backtrace(include_self, raise_nmi);
+}
-- 
2.1.0
