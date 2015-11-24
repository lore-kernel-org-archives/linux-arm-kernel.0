From: geoff@infradead.org (Geoff Levand)
Date: Tue, 24 Nov 2015 22:25:34 +0000
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <cover.1448403503.git.geoff@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
Message-ID: <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
arm64 architecture that add support for the kexec re-boot mechanism
(CONFIG_KEXEC) on arm64 platforms.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/Kconfig                  |  10 +++
 arch/arm64/include/asm/kexec.h      |  48 ++++++++++++
 arch/arm64/kernel/Makefile          |   2 +
 arch/arm64/kernel/machine_kexec.c   | 152 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/relocate_kernel.S | 131 +++++++++++++++++++++++++++++++
 include/uapi/linux/kexec.h          |   1 +
 6 files changed, 344 insertions(+)
 create mode 100644 arch/arm64/include/asm/kexec.h
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9ac16a4..c23fd77 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -535,6 +535,16 @@ config SECCOMP
 	  and the task is only allowed to execute a few safe syscalls
 	  defined by each seccomp mode.
 
+config KEXEC
+	depends on PM_SLEEP_SMP
+	select KEXEC_CORE
+	bool "kexec system call"
+	---help---
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is independent of the system firmware.   And like a reboot
+	  you can start any kernel with it, not just Linux.
+
 config XEN_DOM0
 	def_bool y
 	depends on XEN
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
new file mode 100644
index 0000000..46d63cd
--- /dev/null
+++ b/arch/arm64/include/asm/kexec.h
@@ -0,0 +1,48 @@
+/*
+ * kexec for arm64
+ *
+ * Copyright (C) Linaro.
+ * Copyright (C) Huawei Futurewei Technologies.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#if !defined(_ARM64_KEXEC_H)
+#define _ARM64_KEXEC_H
+
+/* Maximum physical address we can use pages from */
+
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can reach in physical address mode */
+
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can use for the control code buffer */
+
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
+
+#define KEXEC_CONTROL_PAGE_SIZE	4096
+
+#define KEXEC_ARCH KEXEC_ARCH_ARM64
+
+#if !defined(__ASSEMBLY__)
+
+/**
+ * crash_setup_regs() - save registers for the panic kernel
+ *
+ * @newregs: registers are saved here
+ * @oldregs: registers to be saved (may be %NULL)
+ */
+
+static inline void crash_setup_regs(struct pt_regs *newregs,
+				    struct pt_regs *oldregs)
+{
+	/* Empty routine needed to avoid build errors. */
+}
+
+#endif /* !defined(__ASSEMBLY__) */
+
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 474691f..f68420d 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -41,6 +41,8 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
+arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
+					   cpu-reset.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
new file mode 100644
index 0000000..8b990b8
--- /dev/null
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -0,0 +1,152 @@
+/*
+ * kexec for arm64
+ *
+ * Copyright (C) Linaro.
+ * Copyright (C) Huawei Futurewei Technologies.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kexec.h>
+#include <linux/of_fdt.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <asm/cacheflush.h>
+#include <asm/system_misc.h>
+
+#include "cpu-reset.h"
+
+/* Global variables for the arm64_relocate_new_kernel routine. */
+extern const unsigned char arm64_relocate_new_kernel[];
+extern const unsigned long arm64_relocate_new_kernel_size;
+
+static unsigned long kimage_start;
+
+void machine_kexec_cleanup(struct kimage *kimage)
+{
+	/* Empty routine needed to avoid build errors. */
+}
+
+/**
+ * machine_kexec_prepare - Prepare for a kexec reboot.
+ *
+ * Called from the core kexec code when a kernel image is loaded.
+ */
+int machine_kexec_prepare(struct kimage *kimage)
+{
+	kimage_start = kimage->start;
+	return 0;
+}
+
+/**
+ * kexec_list_flush - Helper to flush the kimage list to PoC.
+ */
+static void kexec_list_flush(unsigned long kimage_head)
+{
+	unsigned long *entry;
+
+	for (entry = &kimage_head; ; entry++) {
+		unsigned int flag = *entry & IND_FLAGS;
+		void *addr = phys_to_virt(*entry & PAGE_MASK);
+
+		switch (flag) {
+		case IND_INDIRECTION:
+			entry = (unsigned long *)addr - 1;
+			__flush_dcache_area(addr, PAGE_SIZE);
+			break;
+		case IND_DESTINATION:
+			break;
+		case IND_SOURCE:
+			__flush_dcache_area(addr, PAGE_SIZE);
+			break;
+		case IND_DONE:
+			return;
+		default:
+			BUG();
+		}
+	}
+}
+
+/**
+ * kexec_segment_flush - Helper to flush the kimage segments to PoC.
+ */
+static void kexec_segment_flush(const struct kimage *kimage)
+{
+	unsigned long i;
+
+	pr_devel("%s:\n", __func__);
+
+	for (i = 0; i < kimage->nr_segments; i++) {
+		pr_devel("  segment[%lu]: %016lx - %016lx, %lx bytes, %lu pages\n",
+			i,
+			kimage->segment[i].mem,
+			kimage->segment[i].mem + kimage->segment[i].memsz,
+			kimage->segment[i].memsz,
+			kimage->segment[i].memsz /  PAGE_SIZE);
+
+		__flush_dcache_area(phys_to_virt(kimage->segment[i].mem),
+			kimage->segment[i].memsz);
+	}
+}
+
+/**
+ * machine_kexec - Do the kexec reboot.
+ *
+ * Called from the core kexec code for a sys_reboot with LINUX_REBOOT_CMD_KEXEC.
+ */
+void machine_kexec(struct kimage *kimage)
+{
+	phys_addr_t reboot_code_buffer_phys;
+	void *reboot_code_buffer;
+
+	BUG_ON(num_online_cpus() > 1);
+
+	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
+	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
+
+	/*
+	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
+	 * after the kernel is shut down.
+	 */
+	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
+		arm64_relocate_new_kernel_size);
+
+	/* Flush the reboot_code_buffer in preparation for its execution. */
+	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
+
+	/* Flush the new image. */
+	kexec_segment_flush(kimage);
+
+	/* Flush the kimage list. */
+	kexec_list_flush(kimage->head);
+
+	pr_info("Bye!\n");
+
+	/* Disable all DAIF exceptions. */
+	asm volatile ("msr daifset, #0xf" : : : "memory");
+
+	setup_mm_for_reboot();
+
+	/*
+	 * cpu_soft_restart will shutdown the MMU, disable data caches, then
+	 * transfer control to the reboot_code_buffer which contains a copy of
+	 * the arm64_relocate_new_kernel routine.  arm64_relocate_new_kernel
+	 * uses physical addressing to relocate the new image to its final
+	 * position and transfers control to the image entry point when the
+	 * relocation is complete.
+	 */
+
+	cpu_soft_restart(virt_to_phys(cpu_reset),
+		is_hyp_mode_available(),
+		reboot_code_buffer_phys, kimage->head, kimage_start);
+
+	BUG(); /* Should never get here. */
+}
+
+void machine_crash_shutdown(struct pt_regs *regs)
+{
+	/* Empty routine needed to avoid build errors. */
+}
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
new file mode 100644
index 0000000..71cab0e
--- /dev/null
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -0,0 +1,131 @@
+/*
+ * kexec for arm64
+ *
+ * Copyright (C) Linaro.
+ * Copyright (C) Huawei Futurewei Technologies.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kexec.h>
+
+#include <asm/assembler.h>
+#include <asm/kexec.h>
+#include <asm/kvm_arm.h>
+#include <asm/page.h>
+
+/*
+ * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
+ *
+ * The memory that the old kernel occupies may be overwritten when coping the
+ * new image to its final location.  To assure that the
+ * arm64_relocate_new_kernel routine which does that copy is not overwritten,
+ * all code and data needed by arm64_relocate_new_kernel must be between the
+ * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
+ * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
+ * control_code_page, a special page which has been set up to be preserved
+ * during the copy operation.
+ */
+.globl arm64_relocate_new_kernel
+arm64_relocate_new_kernel:
+
+	/* Setup the list loop variables. */
+	mov	x18, x0				/* x18 = kimage_head */
+	mov	x17, x1				/* x17 = kimage_start */
+	dcache_line_size x16, x0		/* x16 = dcache line size */
+	mov	x15, xzr			/* x15 = segment start */
+	mov	x14, xzr			/* x14 = entry ptr */
+	mov	x13, xzr			/* x13 = copy dest */
+
+	/* Clear the sctlr_el2 flags. */
+	mrs	x0, CurrentEL
+	cmp	x0, #CurrentEL_EL2
+	b.ne	1f
+	mrs	x0, sctlr_el2
+	ldr	x1, =SCTLR_EL2_FLAGS
+	bic	x0, x0, x1
+	msr	sctlr_el2, x0
+	isb
+1:
+
+	/* Check if the new image needs relocation. */
+	cbz	x18, .Ldone
+	tbnz	x18, IND_DONE_BIT, .Ldone
+
+.Lloop:
+	and	x12, x18, PAGE_MASK		/* x12 = addr */
+
+	/* Test the entry flags. */
+.Ltest_source:
+	tbz	x18, IND_SOURCE_BIT, .Ltest_indirection
+
+	mov x20, x13				/*  x20 = copy dest */
+	mov x21, x12				/*  x21 = copy src */
+
+	/* Copy page. */
+1:	ldp	x22, x23, [x21]
+	ldp	x24, x25, [x21, #16]
+	ldp	x26, x27, [x21, #32]
+	ldp	x28, x29, [x21, #48]
+	add	x21, x21, #64
+	stnp	x22, x23, [x20]
+	stnp	x24, x25, [x20, #16]
+	stnp	x26, x27, [x20, #32]
+	stnp	x28, x29, [x20, #48]
+	add	x20, x20, #64
+	tst	x21, #(PAGE_SIZE - 1)
+	b.ne	1b
+
+	/* dest += PAGE_SIZE */
+	add	x13, x13, PAGE_SIZE
+	b	.Lnext
+
+.Ltest_indirection:
+	tbz	x18, IND_INDIRECTION_BIT, .Ltest_destination
+
+	/* ptr = addr */
+	mov	x14, x12
+	b	.Lnext
+
+.Ltest_destination:
+	tbz	x18, IND_DESTINATION_BIT, .Lnext
+
+	mov	x15, x12
+
+	/* dest = addr */
+	mov	x13, x12
+
+.Lnext:
+	/* entry = *ptr++ */
+	ldr	x18, [x14], #8
+
+	/* while (!(entry & DONE)) */
+	tbz	x18, IND_DONE_BIT, .Lloop
+
+.Ldone:
+	dsb	sy
+	ic	ialluis
+	dsb	sy
+	isb
+
+	/* Start new image. */
+	mov	x0, xzr
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
+	br	x17
+
+.align 3	/* To keep the 64-bit values below naturally aligned. */
+
+.Lcopy_end:
+.org	KEXEC_CONTROL_PAGE_SIZE
+
+/*
+ * arm64_relocate_new_kernel_size - Number of bytes to copy to the
+ * control_code_page.
+ */
+.globl arm64_relocate_new_kernel_size
+arm64_relocate_new_kernel_size:
+	.quad	.Lcopy_end - arm64_relocate_new_kernel
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 99048e5..ccec467 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -39,6 +39,7 @@
 #define KEXEC_ARCH_SH      (42 << 16)
 #define KEXEC_ARCH_MIPS_LE (10 << 16)
 #define KEXEC_ARCH_MIPS    ( 8 << 16)
+#define KEXEC_ARCH_ARM64   (183 << 16)
 
 /* The artificial cap on the number of segments passed to kexec_load. */
 #define KEXEC_SEGMENT_MAX 16
-- 
2.5.0
