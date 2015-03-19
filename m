From: geoff@infradead.org (Geoff Levand)
Date: Thu, 19 Mar 2015 20:35:27 +0000
Subject: [PATCH 5/6] arm64/kexec: Add core kexec support
In-Reply-To: <cover.1426793116.git.geoff@infradead.org>
References: <cover.1426793116.git.geoff@infradead.org>
Message-ID: <88216e29d97715cecac8630bc57342d0be860235.1426793116.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
arm64 architecture that add support for the kexec re-boot mechanism
(CONFIG_KEXEC) on arm64 platforms.

With the addition of arm64 kexec support shutdown code paths through the kernel
are executed that previously were not.  To avoid system instability do to
problems in the current arm64 KVM kernel implementation add a Kconfig dependency
on !KEXEC to the arm64 KVM menu item.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/Kconfig                  |   9 +++
 arch/arm64/include/asm/kexec.h      |  48 ++++++++++++
 arch/arm64/kernel/Makefile          |   1 +
 arch/arm64/kernel/machine_kexec.c   | 125 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/relocate_kernel.S | 149 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/Kconfig              |   1 +
 include/uapi/linux/kexec.h          |   1 +
 7 files changed, 334 insertions(+)
 create mode 100644 arch/arm64/include/asm/kexec.h
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e973..5a606d1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -528,6 +528,15 @@ config SECCOMP
 	  and the task is only allowed to execute a few safe syscalls
 	  defined by each seccomp mode.
 
+config KEXEC
+	depends on (!SMP || PM_SLEEP_SMP)
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
index 0000000..3530ff5
--- /dev/null
+++ b/arch/arm64/include/asm/kexec.h
@@ -0,0 +1,48 @@
+/*
+ * kexec for arm64
+ *
+ * Copyright (C) Linaro.
+ * Copyright (C) Futurewei Technologies.
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
index 5ee07ee..da9a7ee 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -35,6 +35,7 @@ arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
 arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
+arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
new file mode 100644
index 0000000..f1387d0
--- /dev/null
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -0,0 +1,125 @@
+/*
+ * kexec for arm64
+ *
+ * Copyright (C) Linaro.
+ * Copyright (C) Futurewei Technologies.
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
+/* Global variables for the relocate_kernel routine. */
+extern const unsigned char relocate_new_kernel[];
+extern const unsigned long relocate_new_kernel_size;
+extern unsigned long arm64_kexec_dtb_addr;
+extern unsigned long arm64_kexec_kimage_head;
+extern unsigned long arm64_kexec_kimage_start;
+
+void machine_kexec_cleanup(struct kimage *image)
+{
+	/* Empty routine needed to avoid build errors. */
+}
+
+/**
+ * machine_kexec_prepare - Prepare for a kexec reboot.
+ *
+ * Called from the core kexec code when a kernel image is loaded.
+ */
+int machine_kexec_prepare(struct kimage *image)
+{
+	arm64_kexec_kimage_start = image->start;
+	return 0;
+}
+
+/**
+ * kexec_list_flush - Helper to flush the kimage list to PoC.
+ */
+static void kexec_list_flush(unsigned long kimage_head)
+{
+	void *dest;
+	unsigned long *entry;
+
+	for (entry = &kimage_head, dest = NULL; ; entry++) {
+		unsigned int flag = *entry &
+			(IND_DESTINATION | IND_INDIRECTION | IND_DONE |
+			IND_SOURCE);
+		void *addr = phys_to_virt(*entry & PAGE_MASK);
+
+		switch (flag) {
+		case IND_INDIRECTION:
+			entry = (unsigned long *)addr - 1;
+			__flush_dcache_area(addr, PAGE_SIZE);
+			break;
+		case IND_DESTINATION:
+			dest = addr;
+			break;
+		case IND_SOURCE:
+			__flush_dcache_area(addr, PAGE_SIZE);
+			dest += PAGE_SIZE;
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
+ * machine_kexec - Do the kexec reboot.
+ *
+ * Called from the core kexec code for a sys_reboot with LINUX_REBOOT_CMD_KEXEC.
+ */
+void machine_kexec(struct kimage *image)
+{
+	phys_addr_t reboot_code_buffer_phys;
+	void *reboot_code_buffer;
+
+	BUG_ON(num_online_cpus() > 1);
+
+	arm64_kexec_kimage_head = image->head;
+
+	reboot_code_buffer_phys = page_to_phys(image->control_code_page);
+	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
+
+	/*
+	 * Copy relocate_new_kernel to the reboot_code_buffer for use
+	 * after the kernel is shut down.
+	 */
+	memcpy(reboot_code_buffer, relocate_new_kernel,
+		relocate_new_kernel_size);
+
+	/* Flush the reboot_code_buffer in preparation for its execution. */
+	__flush_dcache_area(reboot_code_buffer, relocate_new_kernel_size);
+
+	/* Flush the kimage list. */
+	kexec_list_flush(image->head);
+
+	pr_info("Bye!\n");
+
+	/* Disable all DAIF exceptions. */
+	asm volatile ("msr daifset, #0xf" : : : "memory");
+
+	/*
+	 * soft_restart() will shutdown the MMU, disable data caches, then
+	 * transfer control to the reboot_code_buffer which contains a copy of
+	 * the relocate_new_kernel routine.  relocate_new_kernel will use
+	 * physical addressing to relocate the new kernel to its final position
+	 * and then will transfer control to the entry point of the new kernel.
+	 */
+	soft_restart(reboot_code_buffer_phys);
+}
+
+void machine_crash_shutdown(struct pt_regs *regs)
+{
+	/* Empty routine needed to avoid build errors. */
+}
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
new file mode 100644
index 0000000..166d960
--- /dev/null
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -0,0 +1,149 @@
+/*
+ * kexec for arm64
+ *
+ * Copyright (C) Linaro.
+ * Copyright (C) Futurewei Technologies.
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
+#include <asm/memory.h>
+#include <asm/page.h>
+
+
+/*
+ * relocate_new_kernel - Put a 2nd stage kernel image in place and boot it.
+ *
+ * The memory that the old kernel occupies may be overwritten when coping the
+ * new image to its final location.  To assure that the relocate_new_kernel
+ * routine which does that copy is not overwritten all code and data needed
+ * by relocate_new_kernel must be between the symbols relocate_new_kernel and
+ * relocate_new_kernel_end.  The machine_kexec() routine will copy
+ * relocate_new_kernel to the kexec control_code_page, a special page which
+ * has been set up to be preserved during the copy operation.
+ */
+.globl relocate_new_kernel
+relocate_new_kernel:
+
+	/* Setup the list loop variables. */
+	ldr	x18, arm64_kexec_kimage_head	/* x18 = list entry */
+	dcache_line_size x17, x0		/* x17 = dcache line size */
+	mov	x16, xzr			/* x16 = segment start */
+	mov	x15, xzr			/* x15 = entry ptr */
+	mov	x14, xzr			/* x14 = copy dest */
+
+	/* Check if the new image needs relocation. */
+	cbz	x18, .Ldone
+	tbnz	x18, IND_DONE_BIT, .Ldone
+
+.Lloop:
+	and	x13, x18, PAGE_MASK		/* x13 = addr */
+
+	/* Test the entry flags. */
+.Ltest_source:
+	tbz	x18, IND_SOURCE_BIT, .Ltest_indirection
+
+	mov x20, x14				/*  x20 = copy dest */
+	mov x21, x13				/*  x21 = copy src */
+
+	/* Invalidate dest page to PoC. */
+	mov	x0, x20
+	add	x19, x0, #PAGE_SIZE
+	sub	x1, x17, #1
+	bic	x0, x0, x1
+1:	dc	ivac, x0
+	add	x0, x0, x17
+	cmp	x0, x19
+	b.lo	1b
+	dsb	sy
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
+	add	x14, x14, PAGE_SIZE
+	b	.Lnext
+
+.Ltest_indirection:
+	tbz	x18, IND_INDIRECTION_BIT, .Ltest_destination
+
+	/* ptr = addr */
+	mov	x15, x13
+	b	.Lnext
+
+.Ltest_destination:
+	tbz	x18, IND_DESTINATION_BIT, .Lnext
+
+	mov	x16, x13
+
+	/* dest = addr */
+	mov	x14, x13
+
+.Lnext:
+	/* entry = *ptr++ */
+	ldr	x18, [x15], #8
+
+	/* while (!(entry & DONE)) */
+	tbz	x18, IND_DONE_BIT, .Lloop
+
+.Ldone:
+	dsb	sy
+	isb
+	ic	ialluis
+	dsb	sy
+	isb
+
+	/* Start new image. */
+	ldr	x4, arm64_kexec_kimage_start
+	mov	x0, xzr
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
+	br	x4
+
+.align 3	/* To keep the 64-bit values below naturally aligned. */
+
+/* The machine_kexec routines set these variables. */
+
+/*
+ * arm64_kexec_kimage_start - Copy of image->start, the entry point of the new
+ * image.
+ */
+.globl arm64_kexec_kimage_start
+arm64_kexec_kimage_start:
+	.quad	0x0
+
+/*
+ * arm64_kexec_kimage_head - Copy of image->head, the list of kimage entries.
+ */
+.globl arm64_kexec_kimage_head
+arm64_kexec_kimage_head:
+	.quad	0x0
+
+.Lrelocate_new_kernel_end:
+
+/*
+ * relocate_new_kernel_size - Number of bytes to copy to the control_code_page.
+ */
+.globl relocate_new_kernel_size
+relocate_new_kernel_size:
+	.quad .Lrelocate_new_kernel_end - relocate_new_kernel
+
+.org	KEXEC_CONTROL_PAGE_SIZE
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index f5590c8..30ae7a7 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -18,6 +18,7 @@ if VIRTUALIZATION
 
 config KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
+	depends on !KEXEC
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
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
2.1.0
