From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 26 Mar 2015 17:28:50 +0900
Subject: [PATCH 2/5] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1427358533-3754-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kdump calls machine_crash_shutdown() to shut down non-boot cpus and
save per-cpu general-purpose registers before restarting the crash dump
kernel. See kernel_kexec().
ipi_cpu_stop() is used and a bit modified to support this behavior.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/kexec.h    |   34 ++++++++++++++++++++++-
 arch/arm64/kernel/machine_kexec.c |   55 ++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/smp.c           |   10 +++++--
 3 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 3530ff5..eaf3fcb 100644
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
+			"stp	 x0,   x1, [%3]\n\t"
+			"stp	 x2,   x3, [%3, 0x10]\n\t"
+			"stp	 x4,   x5, [%3, 0x20]\n\t"
+			"stp	 x6,   x7, [%3, 0x30]\n\t"
+			"stp	 x8,   x9, [%3, 0x40]\n\t"
+			"stp	x10,  x11, [%3, 0x50]\n\t"
+			"stp	x12,  x13, [%3, 0x60]\n\t"
+			"stp	x14,  x15, [%3, 0x70]\n\t"
+			"stp	x16,  x17, [%3, 0x80]\n\t"
+			"stp	x18,  x19, [%3, 0x90]\n\t"
+			"stp	x20,  x21, [%3, 0xa0]\n\t"
+			"stp	x22,  x23, [%3, 0xb0]\n\t"
+			"stp	x24,  x25, [%3, 0xc0]\n\t"
+			"stp	x26,  x27, [%3, 0xd0]\n\t"
+			"stp	x28,  x29, [%3, 0xe0]\n\t"
+			"str	x30,	   [%3, 0xf0]\n\t"
+			"mov	%0, sp\n\t"
+			"adr	%1, 1f\n\t"
+			"mrs	%2, spsr_el1\n\t"
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
index 7aa2fa2..375dd1f 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -9,6 +9,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
@@ -24,6 +26,8 @@ extern unsigned long arm64_kexec_dtb_addr;
 extern unsigned long arm64_kexec_kimage_head;
 extern unsigned long arm64_kexec_kimage_start;
 
+bool in_crash_kexec = false;
+
 /**
  * kexec_is_dtb - Helper routine to check the device tree header signature.
  */
@@ -183,7 +187,56 @@ void machine_kexec(struct kimage *image)
 	soft_restart(reboot_code_buffer_phys);
 }
 
+static void machine_kexec_mask_interrupts(void)
+{
+	unsigned int i;
+	struct irq_desc *desc;
+
+	for_each_irq_desc(i, desc) {
+		struct irq_chip *chip;
+
+		chip = irq_desc_get_chip(desc);
+		if (!chip)
+			continue;
+
+		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
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
+	 * because, otherwise, slots for offline cpus would not be
+	 * filled up. See smp_send_stop().
+	 */
+	memset(&dummy_regs, 0, sizeof(dummy_regs));
+	for_each_possible_cpu(cpu)
+		crash_save_cpu(&dummy_regs, cpu);
+
+	/* shutdown non-boot cpus */
+	smp_send_stop();
+
+	/* for this cpu */
+	crash_save_cpu(regs, smp_processor_id());
+	machine_kexec_mask_interrupts();
+
+	pr_info("Loading crashdump kernel...\n");
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 328b8ce..593d969 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -36,6 +36,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/irq_work.h>
+#include <linux/kexec.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -541,7 +542,7 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
 /*
  * ipi_cpu_stop - handle IPI from smp_send_stop()
  */
-static void ipi_cpu_stop(unsigned int cpu)
+static void ipi_cpu_stop(unsigned int cpu, struct pt_regs *regs)
 {
 	if (system_state == SYSTEM_BOOTING ||
 	    system_state == SYSTEM_RUNNING) {
@@ -555,6 +556,11 @@ static void ipi_cpu_stop(unsigned int cpu)
 
 	local_irq_disable();
 
+#ifdef CONFIG_KEXEC
+	if (in_crash_kexec)
+		crash_save_cpu(regs, cpu);
+#endif /* CONFIG_KEXEC */
+
 	while (1)
 		cpu_relax();
 }
@@ -585,7 +591,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	case IPI_CPU_STOP:
 		irq_enter();
-		ipi_cpu_stop(cpu);
+		ipi_cpu_stop(cpu, regs);
 		irq_exit();
 		break;
 
-- 
1.7.9.5
