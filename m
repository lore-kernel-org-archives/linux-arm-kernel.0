From: geoff@infradead.org (Geoff Levand)
Date: Tue, 20 Oct 2015 11:54:06 -0700
Subject: [PATCH v10.1 12/16] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <10adbaf4a069aabc3d774963cf6613dfa46f923d.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
 <10adbaf4a069aabc3d774963cf6613dfa46f923d.1445297709.git.geoff@infradead.org>
Message-ID: <1445367246.30908.78.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

kdump calls machine_crash_shutdown() to shut down non-boot cpus and
save registers' status in per-cpu ELF notes before starting the crash
dump kernel. See kernel_kexec().

ipi_cpu_stop() is a bit modified and used to support this behavior.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
v10.1: Fixed: crash dump kernel won't be able to boot if a kvm
guest is running at crash. This is because we don't have any chance
to reset EL2 mode at crash and so "switch to EL2" in cpu_reset fails.


 arch/arm64/include/asm/kexec.h    | 34 +++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/machine_kexec.c | 32 ++++++++++++++++++++++++++++++--
 arch/arm64/kernel/smp.c           | 16 ++++++++++++++--
 3 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 46d63cd..555a955 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -30,6 +30,8 @@
 
 #if !defined(__ASSEMBLY__)
 
+extern bool in_crash_kexec;
+
 /**
  * crash_setup_regs() - save registers for the panic kernel
  *
@@ -40,7 +42,37 @@
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
 
 #endif /* !defined(__ASSEMBLY__) */
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 362f719..8595d43 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
@@ -28,6 +29,8 @@ extern unsigned long arm64_kexec_kimage_start_offset;
 static unsigned long kimage_head;
 static unsigned long kimage_start;
 
+bool in_crash_kexec;
+
 /**
  * kexec_is_dtb - Helper routine to check the device tree header signature.
  */
@@ -121,7 +124,7 @@ static void soft_restart(unsigned long addr)
 {
 	setup_mm_for_reboot();
 	cpu_soft_restart(virt_to_phys(cpu_reset), addr,
-		is_hyp_mode_available());
+		(in_crash_kexec ? 0 : is_hyp_mode_available()));
 
 	BUG(); /* Should never get here. */
 }
@@ -198,7 +201,32 @@ void machine_kexec(struct kimage *image)
 	soft_restart(reboot_code_buffer_phys);
 }
 
+/**
+ * machine_crash_shutdown - shutdown non-boot cpus and save registers
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
+	/* shutdown non-boot cpus */
+	smp_send_stop();
+
+	/* for boot cpu */
+	crash_save_cpu(regs, smp_processor_id());
+
+	pr_info("Loading crashdump kernel...\n");
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dbdaacd..88aec66 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -37,6 +37,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/irq_work.h>
+#include <linux/kexec.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -54,6 +55,8 @@
 #include <asm/ptrace.h>
 #include <asm/virt.h>
 
+#include "cpu-reset.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/ipi.h>
 
@@ -679,8 +682,12 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
 /*
  * ipi_cpu_stop - handle IPI from smp_send_stop()
  */
-static void ipi_cpu_stop(unsigned int cpu)
+static void ipi_cpu_stop(unsigned int cpu, struct pt_regs *regs)
 {
+#ifdef CONFIG_KEXEC
+	/* printing messages may slow down the shutdown. */
+	if (!in_crash_kexec)
+#endif
 	if (system_state == SYSTEM_BOOTING ||
 	    system_state == SYSTEM_RUNNING) {
 		raw_spin_lock(&stop_lock);
@@ -693,6 +700,11 @@ static void ipi_cpu_stop(unsigned int cpu)
 
 	local_irq_disable();
 
+#ifdef CONFIG_KEXEC
+	if (in_crash_kexec)
+		crash_save_cpu(regs, cpu);
+#endif /* CONFIG_KEXEC */
+
 	while (1)
 		cpu_relax();
 }
@@ -723,7 +735,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	case IPI_CPU_STOP:
 		irq_enter();
-		ipi_cpu_stop(cpu);
+		ipi_cpu_stop(cpu, regs);
 		irq_exit();
 		break;
 
-- 
2.5.0
