From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu,  4 Sep 2014 17:03:36 +0100
Subject: [PATCH v1 2/6] arm: smp: Introduce a non-maskable IPI
In-Reply-To: <1409846620-14542-1-git-send-email-daniel.thompson@linaro.org>
References: <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
 <1409846620-14542-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1409846620-14542-3-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a new IPI intended to be routed to FIQ rather
than IRQ. An IPI based upon FIQ can be used to implement debug
features that require non-maskable interrupts.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/hardirq.h | 2 +-
 arch/arm/include/asm/smp.h     | 3 +++
 arch/arm/kernel/smp.c          | 7 +++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index fe3ea77..5df33e3 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	8
+#define NR_IPI	9
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 2ec765c..0e23384 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -20,6 +20,9 @@
 
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
+/* bitmap of IPIs that must be signalled using FIQ */
+#define SMP_IPI_FIQ_MASK 0x0100
+
 struct seq_file;
 
 /*
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 9388a3d..b2404d0 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -72,6 +72,7 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	IPI_FIQ,
 };
 
 static DECLARE_COMPLETION(cpu_running);
@@ -451,6 +452,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 	S(IPI_COMPLETION, "completion interrupts"),
+	S(IPI_FIQ, "FIQ interrupts"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
@@ -618,6 +620,11 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		irq_exit();
 		break;
 
+	case IPI_FIQ:
+		BUILD_BUG_ON(SMP_IPI_FIQ_MASK != BIT(IPI_FIQ));
+		pr_warn("CPU%u: IPI FIQ delivered via IRQ vector\n", cpu);
+		break;
+
 	default:
 		printk(KERN_CRIT "CPU%u: Unknown IPI message 0x%x\n",
 		       cpu, ipinr);
-- 
1.9.3
