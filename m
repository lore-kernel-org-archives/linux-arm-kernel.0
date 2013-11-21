From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 21 Nov 2013 11:24:16 +0000
Subject: [PATCH RFC v3 09/12] arm64: enable generic clockevent broadcast
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1385033059-25896-10-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On platforms with power management capabilities, timers that are shut
down when a CPU enters deep C-states must be emulated using an always-on
timer and a timer IPI to relay the timer IRQ to target CPUs on an SMP
system.

This patch enables the generic clockevents broadcast infrastructure for
arm64, by providing the required Kconfig entries and adding the timer
IPI infrastructure.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig               |  2 ++
 arch/arm64/include/asm/hardirq.h |  2 +-
 arch/arm64/kernel/smp.c          | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 88c8b6c1..1d222b1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
@@ -12,6 +13,7 @@ config ARM64
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 990c051..ae4801d 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -20,7 +20,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	4
+#define NR_IPI	5
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a5aeefa..56b68d7 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -61,6 +61,7 @@ enum ipi_msg_type {
 	IPI_CALL_FUNC,
 	IPI_CALL_FUNC_SINGLE,
 	IPI_CPU_STOP,
+	IPI_TIMER,
 };
 
 /*
@@ -446,6 +447,7 @@ static const char *ipi_types[NR_IPI] = {
 	S(IPI_CALL_FUNC, "Function call interrupts"),
 	S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
+	S(IPI_TIMER, "Timer broadcast interrupts"),
 };
 
 void show_ipi_list(struct seq_file *p, int prec)
@@ -531,6 +533,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		irq_exit();
 		break;
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+	case IPI_TIMER:
+		irq_enter();
+		tick_receive_broadcast();
+		irq_exit();
+		break;
+#endif
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
@@ -543,6 +553,13 @@ void smp_send_reschedule(int cpu)
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+void tick_broadcast(const struct cpumask *mask)
+{
+	smp_cross_call(mask, IPI_TIMER);
+}
+#endif
+
 void smp_send_stop(void)
 {
 	unsigned long timeout;
-- 
1.8.4
