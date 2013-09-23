From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:48 -0400
Subject: [PATCH 05/13] ARM: SMP: basic IPI triggered completion support
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-6-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need a mechanism to let an inbound CPU signal that it is alive before
even getting into the kernel environment i.e. from early assembly code.
Using an IPI is the simplest way to achieve that.

This adds some basic infrastructure to register a struct completion
pointer to be "completed" when the dedicated IPI for this task is
received.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/hardirq.h |  2 +-
 arch/arm/include/asm/smp.h     |  2 ++
 arch/arm/kernel/smp.c          | 21 +++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 2740c2a2df..3d7351c844 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	6
+#define NR_IPI	7
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index a8cae71cac..22a3b9b5d4 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -84,6 +84,8 @@ extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
 
+extern int register_ipi_completion(struct completion *completion, int cpu);
+
 struct smp_operations {
 #ifdef CONFIG_SMP
 	/*
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 72024ea8a3..7d80a549ca 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -66,6 +66,7 @@ enum ipi_msg_type {
 	IPI_CALL_FUNC,
 	IPI_CALL_FUNC_SINGLE,
 	IPI_CPU_STOP,
+	IPI_COMPLETION,
 };
 
 static DECLARE_COMPLETION(cpu_running);
@@ -456,6 +457,7 @@ static const char *ipi_types[NR_IPI] = {
 	S(IPI_CALL_FUNC, "Function call interrupts"),
 	S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
+	S(IPI_COMPLETION, "completion interrupts"),
 };
 
 void show_ipi_list(struct seq_file *p, int prec)
@@ -515,6 +517,19 @@ static void ipi_cpu_stop(unsigned int cpu)
 		cpu_relax();
 }
 
+static DEFINE_PER_CPU(struct completion *, cpu_completion);
+
+int register_ipi_completion(struct completion *completion, int cpu)
+{
+	per_cpu(cpu_completion, cpu) = completion;
+	return IPI_COMPLETION;
+}
+
+static void ipi_complete(unsigned int cpu)
+{
+	complete(per_cpu(cpu_completion, cpu));
+}
+
 /*
  * Main handler for inter-processor interrupts
  */
@@ -565,6 +580,12 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		irq_exit();
 		break;
 
+	case IPI_COMPLETION:
+		irq_enter();
+		ipi_complete(cpu);
+		irq_exit();
+		break;
+
 	default:
 		printk(KERN_CRIT "CPU%u: Unknown IPI message 0x%x\n",
 		       cpu, ipinr);
-- 
1.8.4.98.gb022869
