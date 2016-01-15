From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Jan 2016 19:18:38 +0000
Subject: [PATCH 15/19] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <cover.1452884156.git.geoff@infradead.org>
References: <cover.1452884156.git.geoff@infradead.org>
Message-ID: <c39ce3cf694a3582d66e38d6925f235e3663588d.1452884156.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

kdump calls machine_crash_shutdown() to shut down non-boot cpus and
save registers' status in per-cpu ELF notes before starting the crash
dump kernel. See kernel_kexec().

ipi_cpu_stop() is a bit modified and used to support this behavior.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/kexec.h    | 47 +++++++++++++++++++++++++++-
 arch/arm64/kernel/machine_kexec.c | 65 +++++++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/smp.c           | 18 ++++++++---
 3 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 04744dc..3dffb1d 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -30,6 +30,21 @@
 
 #ifndef __ASSEMBLY__
 
+extern bool in_crash_kexec;
+
+static inline bool is_in_crash_kexec(void)
+{
+#ifdef CONFIG_KEXEC_CORE
+	return in_crash_kexec;
+#else
+	return false;
+#endif
+}
+
+#ifndef CONFIG_KEXEC_CORE
+#define crash_save_cpu(regs, cpu)
+#endif
+
 /**
  * crash_setup_regs() - save registers for the panic kernel
  *
@@ -40,7 +55,37 @@
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
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index a375268..0ba2ae4 100644
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
@@ -212,13 +216,70 @@ void machine_kexec(struct kimage *kimage)
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
+	struct pt_regs dummy_regs;
+	int cpu;
+
+	local_irq_disable();
+
+	in_crash_kexec = true;
+
+	/*
+	 * clear and initialize the per-cpu info. This is necessary
+	 * because, otherwise, slots for offline cpus would never be
+	 * filled up. See smp_send_stop().
+	 */
+	memset(&dummy_regs, 0, sizeof(dummy_regs));
+	for_each_possible_cpu(cpu)
+		crash_save_cpu(&dummy_regs, cpu);
+
+	/* shutdown non-crashing cpus */
+	smp_send_stop();
+
+	/* for crashing cpu */
+	crash_save_cpu(regs, smp_processor_id());
+	machine_kexec_mask_interrupts();
+
+	pr_info("Starting crashdump kernel...\n");
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b1adc51..aa45c21 100644
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
@@ -54,6 +56,8 @@
 #include <asm/ptrace.h>
 #include <asm/virt.h>
 
+#include "cpu-reset.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/ipi.h>
 
@@ -683,10 +687,16 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
 /*
  * ipi_cpu_stop - handle IPI from smp_send_stop()
  */
-static void ipi_cpu_stop(unsigned int cpu)
+static void ipi_cpu_stop(unsigned int cpu, struct pt_regs *regs)
 {
-	if (system_state == SYSTEM_BOOTING ||
-	    system_state == SYSTEM_RUNNING) {
+	if (is_in_crash_kexec()) {
+		crash_save_cpu(regs, cpu);
+		/*
+		 * printing messages at panic may slow down the shutdown.
+		 * So don't fall through dump_stack().
+		 */
+	} else if (system_state == SYSTEM_BOOTING ||
+			system_state == SYSTEM_RUNNING) {
 		raw_spin_lock(&stop_lock);
 		pr_crit("CPU%u: stopping\n", cpu);
 		dump_stack();
@@ -727,7 +737,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	case IPI_CPU_STOP:
 		irq_enter();
-		ipi_cpu_stop(cpu);
+		ipi_cpu_stop(cpu, regs);
 		irq_exit();
 		break;
 
-- 
2.5.0
