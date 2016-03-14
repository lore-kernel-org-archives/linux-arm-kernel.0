From: geoff@infradead.org (Geoff Levand)
Date: Mon, 14 Mar 2016 17:48:01 +0000
Subject: [PATCH v15 17/20] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <cover.1457977401.git.geoff@infradead.org>
References: <cover.1457977401.git.geoff@infradead.org>
Message-ID: <8f53a31cf8bbfdd73eb289e078addc31c5a19fcf.1457977403.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Primary kernel calls machine_crash_shutdown() to shut down non-boot cpus
and save registers' status in per-cpu ELF notes before starting crash
dump kernel. See kernel_kexec().
Even if not all secondary cpus have shut down, we do kdump anyway.

As we don't have to make non-boot(crashed) cpus offline (to preserve
correct status of cpus at crash dump) before shutting down, this patch
also adds a variant of smp_send_stop().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/hardirq.h  |  2 +-
 arch/arm64/include/asm/kexec.h    | 36 ++++++++++++++++++++++++-
 arch/arm64/include/asm/smp.h      |  5 ++++
 arch/arm64/kernel/machine_kexec.c | 55 +++++++++++++++++++++++++++++++++++---
 arch/arm64/kernel/smp.c           | 56 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index a57601f..8740297 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -20,7 +20,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	5
+#define NR_IPI	6
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 04744dc..2f089b3 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -30,6 +30,10 @@
 
 #ifndef __ASSEMBLY__
 
+#ifndef CONFIG_KEXEC_CORE
+#define crash_save_cpu(regs, cpu)
+#endif
+
 /**
  * crash_setup_regs() - save registers for the panic kernel
  *
@@ -40,7 +44,37 @@
 static inline void crash_setup_regs(struct pt_regs *newregs,
 				    struct pt_regs *oldregs)
 {
-	/* Empty routine needed to avoid build errors. */
+	if (oldregs) {
+		memcpy(newregs, oldregs, sizeof(*newregs));
+	} else {
+		__asm__ __volatile__ (
+			"stp	 x0,   x1, [%3, #16 *  0]\n"
+			"stp	 x2,   x3, [%3, #16 *  1]\n"
+			"stp	 x4,   x5, [%3, #16 *  2]\n"
+			"stp	 x6,   x7, [%3, #16 *  3]\n"
+			"stp	 x8,   x9, [%3, #16 *  4]\n"
+			"stp	x10,  x11, [%3, #16 *  5]\n"
+			"stp	x12,  x13, [%3, #16 *  6]\n"
+			"stp	x14,  x15, [%3, #16 *  7]\n"
+			"stp	x16,  x17, [%3, #16 *  8]\n"
+			"stp	x18,  x19, [%3, #16 *  9]\n"
+			"stp	x20,  x21, [%3, #16 * 10]\n"
+			"stp	x22,  x23, [%3, #16 * 11]\n"
+			"stp	x24,  x25, [%3, #16 * 12]\n"
+			"stp	x26,  x27, [%3, #16 * 13]\n"
+			"stp	x28,  x29, [%3, #16 * 14]\n"
+			"str	x30,	   [%3, #16 * 15]\n"
+			"mov	%0, sp\n"
+			"adr	%1, 1f\n"
+			"mrs	%2, spsr_el1\n"
+		"1:"
+			: "=r" (newregs->sp),
+			  "=r" (newregs->pc),
+			  "=r" (newregs->pstate)
+			: "r"  (&newregs->regs)
+			: "memory"
+		);
+	}
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index d9c3d6a..0e42ece 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -69,4 +69,9 @@ extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
 extern void cpu_die(void);
 
+/*
+ * for crash dump
+ */
+extern void smp_send_crash_stop(void);
+
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 75f6696..8651b27 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -10,6 +10,9 @@
  */
 
 #include <linux/highmem.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/libfdt_env.h>
 #include <linux/of_fdt.h>
@@ -25,6 +28,7 @@
 extern const unsigned char arm64_relocate_new_kernel[];
 extern const unsigned long arm64_relocate_new_kernel_size;
 
+bool in_crash_kexec;
 static unsigned long kimage_start;
 
 /**
@@ -150,7 +154,7 @@ void machine_kexec(struct kimage *kimage)
 	phys_addr_t reboot_code_buffer_phys;
 	void *reboot_code_buffer;
 
-	BUG_ON(num_online_cpus() > 1);
+	BUG_ON((num_online_cpus() > 1) && !WARN_ON(in_crash_kexec));
 
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
 	reboot_code_buffer = kmap(kimage->control_code_page);
@@ -209,13 +213,58 @@ void machine_kexec(struct kimage *kimage)
 	 * relocation is complete.
 	 */
 
-	cpu_soft_restart(is_hyp_mode_available(),
+	cpu_soft_restart(in_crash_kexec ? 0 : is_hyp_mode_available(),
 		reboot_code_buffer_phys, kimage->head, kimage_start, 0);
 
 	BUG(); /* Should never get here. */
 }
 
+static void machine_kexec_mask_interrupts(void)
+{
+	unsigned int i;
+	struct irq_desc *desc;
+
+	for_each_irq_desc(i, desc) {
+		struct irq_chip *chip;
+		int ret;
+
+		chip = irq_desc_get_chip(desc);
+		if (!chip)
+			continue;
+
+		/*
+		 * First try to remove the active state. If this
+		 * fails, try to EOI the interrupt.
+		 */
+		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
+
+		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
+		    chip->irq_eoi)
+			chip->irq_eoi(&desc->irq_data);
+
+		if (chip->irq_mask)
+			chip->irq_mask(&desc->irq_data);
+
+		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
+			chip->irq_disable(&desc->irq_data);
+	}
+}
+
+/**
+ * machine_crash_shutdown - shutdown non-crashing cpus and save registers
+ */
 void machine_crash_shutdown(struct pt_regs *regs)
 {
-	/* Empty routine needed to avoid build errors. */
+	local_irq_disable();
+
+	in_crash_kexec = true;
+
+	/* shutdown non-crashing cpus */
+	smp_send_crash_stop();
+
+	/* for crashing cpu */
+	crash_save_cpu(regs, smp_processor_id());
+	machine_kexec_mask_interrupts();
+
+	pr_info("Starting crashdump kernel...\n");
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b1adc51..76402c6cd 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -37,6 +37,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/irq_work.h>
+#include <linux/kexec.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -44,6 +45,7 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
+#include <asm/kexec.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -68,6 +70,7 @@ enum ipi_msg_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
+	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
 };
@@ -625,6 +628,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
 	S(IPI_CALL_FUNC, "Function call interrupts"),
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
+	S(IPI_CPU_CRASH_STOP, "CPU stop (for crash dump) interrupts"),
 	S(IPI_TIMER, "Timer broadcast interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 };
@@ -701,6 +705,28 @@ static void ipi_cpu_stop(unsigned int cpu)
 		cpu_relax();
 }
 
+static atomic_t waiting_for_crash_ipi;
+
+static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
+{
+	crash_save_cpu(regs, cpu);
+
+	raw_spin_lock(&stop_lock);
+	pr_debug("CPU%u: stopping\n", cpu);
+	raw_spin_unlock(&stop_lock);
+
+	atomic_dec(&waiting_for_crash_ipi);
+
+	local_irq_disable();
+
+	if (cpu_ops[cpu]->cpu_die)
+		cpu_ops[cpu]->cpu_die(cpu);
+
+	/* just in case */
+	while (1)
+		wfi();
+}
+
 /*
  * Main handler for inter-processor interrupts
  */
@@ -731,6 +757,12 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		irq_exit();
 		break;
 
+	case IPI_CPU_CRASH_STOP:
+		irq_enter();
+		ipi_cpu_crash_stop(cpu, regs);
+		irq_exit();
+		break;
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	case IPI_TIMER:
 		irq_enter();
@@ -791,6 +823,30 @@ void smp_send_stop(void)
 		pr_warning("SMP: failed to stop secondary CPUs\n");
 }
 
+void smp_send_crash_stop(void)
+{
+	cpumask_t mask;
+	unsigned long timeout;
+
+	if (num_online_cpus() == 1)
+		return;
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &mask);
+
+	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
+
+	smp_cross_call(&mask, IPI_CPU_CRASH_STOP);
+
+	/* Wait up to one second for other CPUs to stop */
+	timeout = USEC_PER_SEC;
+	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
+		udelay(1);
+
+	if (atomic_read(&waiting_for_crash_ipi) > 0)
+		pr_warn("SMP: failed to stop secondary CPUs\n");
+}
+
 /*
  * not supported here
  */
-- 
2.5.0
