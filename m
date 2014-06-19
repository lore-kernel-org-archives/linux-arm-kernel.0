From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 19 Jun 2014 11:38:18 +0100
Subject: [PATCH v4 08/13] ARM: Add KGDB/KDB FIQ debugger generic code
In-Reply-To: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1403174303-25456-9-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anton Vorontsov <anton.vorontsov@linaro.org>

The FIQ debugger may be used to debug situations when the kernel stuck
in uninterruptable sections, e.g. the kernel infinitely loops or
deadlocked in an interrupt or with interrupts disabled.

By default KGDB FIQ is disabled in runtime, but can be enabled with
kgdb_fiq.enable=1 kernel command line option.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/Kconfig                 |   2 +
 arch/arm/Kconfig.debug           |  18 ++++
 arch/arm/include/asm/kgdb.h      |   7 ++
 arch/arm/kernel/Makefile         |   1 +
 arch/arm/kernel/entry-header.S   | 186 ---------------------------------------
 arch/arm/kernel/kgdb_fiq.c       | 124 ++++++++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq_entry.S |  87 ++++++++++++++++++
 7 files changed, 239 insertions(+), 186 deletions(-)
 create mode 100644 arch/arm/kernel/kgdb_fiq.c
 create mode 100644 arch/arm/kernel/kgdb_fiq_entry.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87b63fd..32795c2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -304,6 +304,7 @@ choice
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
 	depends on MMU
+	select ARCH_MIGHT_HAVE_KGDB_FIQ
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_HAS_SG_CHAIN
 	select ARM_PATCH_PHYS_VIRT
@@ -354,6 +355,7 @@ config ARCH_REALVIEW
 
 config ARCH_VERSATILE
 	bool "ARM Ltd. Versatile family"
+	select ARCH_MIGHT_HAVE_KGDB_FIQ
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_TIMER_SP804
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 26536f7..c7342b6 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -2,6 +2,24 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+config ARCH_MIGHT_HAVE_KGDB_FIQ
+	bool
+
+config KGDB_FIQ
+	bool "KGDB FIQ support"
+	depends on KGDB_KDB && ARCH_MIGHT_HAVE_KGDB_FIQ && !THUMB2_KERNEL
+	select FIQ
+	help
+	  The FIQ debugger may be used to debug situations when the
+	  kernel stuck in uninterruptable sections, e.g. the kernel
+	  infinitely loops or deadlocked in an interrupt or with
+	  interrupts disabled.
+
+	  By default KGDB FIQ is disabled at runtime, but can be
+	  enabled with kgdb_fiq.enable=1 kernel command line option.
+
+	  If unsure, say N.
+
 config ARM_PTDUMP
 	bool "Export kernel pagetable layout to userspace via debugfs"
 	depends on DEBUG_KERNEL
diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
index 0a9d5dd..5de21f01 100644
--- a/arch/arm/include/asm/kgdb.h
+++ b/arch/arm/include/asm/kgdb.h
@@ -11,7 +11,9 @@
 #define __ARM_KGDB_H__
 
 #include <linux/ptrace.h>
+#include <linux/linkage.h>
 #include <asm/opcodes.h>
+#include <asm/exception.h>
 
 /*
  * GDB assumes that we're a user process being debugged, so
@@ -48,6 +50,11 @@ static inline void arch_kgdb_breakpoint(void)
 extern void kgdb_handle_bus_error(void);
 extern int kgdb_fault_expected;
 
+extern char kgdb_fiq_handler;
+extern char kgdb_fiq_handler_end;
+asmlinkage void __exception_irq_entry kgdb_fiq_do_handle(struct pt_regs *regs);
+extern int kgdb_register_fiq(unsigned int fiq);
+
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 38ddd9f..30ee8f3 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -68,6 +68,7 @@ endif
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
 obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
+obj-$(CONFIG_KGDB_FIQ)		+= kgdb_fiq_entry.o kgdb_fiq.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
 obj-$(CONFIG_OF)		+= devtree.o
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 572f4b4..eb2c426 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -477,192 +477,6 @@ tsk	.req	r9		@ current thread_info
 #endif
 	.endm
 
-#error "sizeof(struct pt_regs) must be a multiple of 8"
-#endif
-
-	.macro	usr_entry
- UNWIND(.fnstart	)
- UNWIND(.cantunwind	)	@ don't unwind the user space
-	sub	sp, sp, #S_FRAME_SIZE
- ARM(	stmib	sp, {r1 - r12}	)
- THUMB(	stmia	sp, {r0 - r12}	)
-
-	ldmia	r0, {r3 - r5}
-	add	r0, sp, #S_PC		@ here for interlock avoidance
-	mov	r6, #-1			@  ""  ""     ""        ""
-
-	str	r3, [sp]		@ save the "real" r0 copied
-					@ from the exception stack
-
-	@
-	@ We are now ready to fill in the remaining blanks on the stack:
-	@
-	@  r4 - lr_<exception>, already fixed up for correct return/restart
-	@  r5 - spsr_<exception>
-	@  r6 - orig_r0 (see pt_regs definition in ptrace.h)
-	@
-	@ Also, separately save sp_usr and lr_usr
-	@
-	stmia	r0, {r4 - r6}
- ARM(	stmdb	r0, {sp, lr}^			)
- THUMB(	store_user_sp_lr r0, r1, S_SP - S_PC	)
-
-	@
-	@ Enable the alignment trap while in kernel mode
-	@
-	alignment_trap r0, .LCcralign
-
-	@
-	@ Clear FP to mark the first stack frame
-	@
-	zero_fp
-
-#ifdef CONFIG_IRQSOFF_TRACER
-	bl	trace_hardirqs_off
-#endif
-	ct_user_exit save = 0
-	.endm
-
-	.macro	kuser_cmpxchg_check
-#if !defined(CONFIG_CPU_32v6K) && defined(CONFIG_KUSER_HELPERS) && \
-    !defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
-#ifndef CONFIG_MMU
-#warning "NPTL on non MMU needs fixing"
-#else
-	@ Make sure our user space atomic helper is restarted
-	@ if it was interrupted in a critical region.  Here we
-	@ perform a quick test inline since it should be false
-	@ 99.9999% of the time.  The rest is done out of line.
-	cmp	r4, #TASK_SIZE
-	blhs	kuser_cmpxchg64_fixup
-#endif
-#endif
-	.endm
-
-#error "sizeof(struct pt_regs) must be a multiple of 8"
-#endif
-
-	.macro	usr_entry
- UNWIND(.fnstart	)
- UNWIND(.cantunwind	)	@ don't unwind the user space
-	sub	sp, sp, #S_FRAME_SIZE
- ARM(	stmib	sp, {r1 - r12}	)
- THUMB(	stmia	sp, {r0 - r12}	)
-
-	ldmia	r0, {r3 - r5}
-	add	r0, sp, #S_PC		@ here for interlock avoidance
-	mov	r6, #-1			@  ""  ""     ""        ""
-
-	str	r3, [sp]		@ save the "real" r0 copied
-					@ from the exception stack
-
-	@
-	@ We are now ready to fill in the remaining blanks on the stack:
-	@
-	@  r4 - lr_<exception>, already fixed up for correct return/restart
-	@  r5 - spsr_<exception>
-	@  r6 - orig_r0 (see pt_regs definition in ptrace.h)
-	@
-	@ Also, separately save sp_usr and lr_usr
-	@
-	stmia	r0, {r4 - r6}
- ARM(	stmdb	r0, {sp, lr}^			)
- THUMB(	store_user_sp_lr r0, r1, S_SP - S_PC	)
-
-	@
-	@ Enable the alignment trap while in kernel mode
-	@
-	alignment_trap r0, .LCcralign
-
-	@
-	@ Clear FP to mark the first stack frame
-	@
-	zero_fp
-
-#ifdef CONFIG_IRQSOFF_TRACER
-	bl	trace_hardirqs_off
-#endif
-	ct_user_exit save = 0
-	.endm
-
-	.macro	kuser_cmpxchg_check
-#if !defined(CONFIG_CPU_32v6K) && defined(CONFIG_KUSER_HELPERS) && \
-    !defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
-#ifndef CONFIG_MMU
-#warning "NPTL on non MMU needs fixing"
-#else
-	@ Make sure our user space atomic helper is restarted
-	@ if it was interrupted in a critical region.  Here we
-	@ perform a quick test inline since it should be false
-	@ 99.9999% of the time.  The rest is done out of line.
-	cmp	r4, #TASK_SIZE
-	blhs	kuser_cmpxchg64_fixup
-#endif
-#endif
-	.endm
-
-#error "sizeof(struct pt_regs) must be a multiple of 8"
-#endif
-
-	.macro	usr_entry
- UNWIND(.fnstart	)
- UNWIND(.cantunwind	)	@ don't unwind the user space
-	sub	sp, sp, #S_FRAME_SIZE
- ARM(	stmib	sp, {r1 - r12}	)
- THUMB(	stmia	sp, {r0 - r12}	)
-
-	ldmia	r0, {r3 - r5}
-	add	r0, sp, #S_PC		@ here for interlock avoidance
-	mov	r6, #-1			@  ""  ""     ""        ""
-
-	str	r3, [sp]		@ save the "real" r0 copied
-					@ from the exception stack
-
-	@
-	@ We are now ready to fill in the remaining blanks on the stack:
-	@
-	@  r4 - lr_<exception>, already fixed up for correct return/restart
-	@  r5 - spsr_<exception>
-	@  r6 - orig_r0 (see pt_regs definition in ptrace.h)
-	@
-	@ Also, separately save sp_usr and lr_usr
-	@
-	stmia	r0, {r4 - r6}
- ARM(	stmdb	r0, {sp, lr}^			)
- THUMB(	store_user_sp_lr r0, r1, S_SP - S_PC	)
-
-	@
-	@ Enable the alignment trap while in kernel mode
-	@
-	alignment_trap r0
-
-	@
-	@ Clear FP to mark the first stack frame
-	@
-	zero_fp
-
-#ifdef CONFIG_IRQSOFF_TRACER
-	bl	trace_hardirqs_off
-#endif
-	ct_user_exit save = 0
-	.endm
-
-	.macro	kuser_cmpxchg_check
-#if !defined(CONFIG_CPU_32v6K) && defined(CONFIG_KUSER_HELPERS) && \
-    !defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
-#ifndef CONFIG_MMU
-#warning "NPTL on non MMU needs fixing"
-#else
-	@ Make sure our user space atomic helper is restarted
-	@ if it was interrupted in a critical region.  Here we
-	@ perform a quick test inline since it should be false
-	@ 99.9999% of the time.  The rest is done out of line.
-	cmp	r4, #TASK_SIZE
-	blhs	kuser_cmpxchg64_fixup
-#endif
-#endif
-	.endm
-
 /*
  * Vector stubs macro.
  */
diff --git a/arch/arm/kernel/kgdb_fiq.c b/arch/arm/kernel/kgdb_fiq.c
new file mode 100644
index 0000000..dbf4873
--- /dev/null
+++ b/arch/arm/kernel/kgdb_fiq.c
@@ -0,0 +1,124 @@
+/*
+ * KGDB FIQ
+ *
+ * Copyright 2010 Google, Inc.
+ *		  Arve Hj?nnev?g <arve@android.com>
+ *		  Colin Cross <ccross@android.com>
+ * Copyright 2012 Linaro Ltd.
+ *		  Anton Vorontsov <anton.vorontsov@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/hardirq.h>
+#include <linux/atomic.h>
+#include <linux/kdb.h>
+#include <linux/kgdb.h>
+#include <asm/fiq.h>
+#include <asm/exception.h>
+
+static int kgdb_fiq_enabled;
+module_param_named(enable, kgdb_fiq_enabled, int, 0600);
+MODULE_PARM_DESC(enable, "set to 1 to enable FIQ KGDB");
+
+static unsigned int kgdb_fiq;
+
+asmlinkage void __exception_irq_entry kgdb_fiq_do_handle(struct pt_regs *regs)
+{
+	if (kgdb_nmi_poll_knock()) {
+		nmi_enter();
+		kgdb_handle_exception(1, 0, 0, regs);
+		nmi_exit();
+	}
+
+	eoi_fiq(kgdb_fiq);
+}
+
+static struct fiq_handler kgdb_fiq_desc = {
+	.name = "kgdb",
+};
+
+static long kgdb_fiq_setup_stack(void *info)
+{
+	struct pt_regs regs;
+
+	regs.ARM_sp = __get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER) +
+			THREAD_START_SP;
+	WARN_ON(!regs.ARM_sp);
+
+	set_fiq_regs(&regs);
+	return 0;
+}
+
+/**
+ * kgdb_fiq_enable_nmi - Manage NMI-triggered entry to KGDB
+ * @on: Flag to either enable or disable an NMI
+ *
+ * This function manages NMIs that usually cause KGDB to enter. That is, not
+ * all NMIs should be enabled or disabled, but only those that issue
+ * kgdb_handle_exception().
+ *
+ * The call counts disable requests, and thus allows to nest disables. But
+ * trying to enable already enabled NMI is an error.
+ */
+static void kgdb_fiq_enable_nmi(bool on)
+{
+	static atomic_t cnt;
+	int ret;
+
+	ret = atomic_add_return(on ? 1 : -1, &cnt);
+	if (ret > 1 && on) {
+		/*
+		 * There should be only one instance that calls this function
+		 * in "enable, disable" order. All other users must call
+		 * disable first, then enable. If not, something is wrong.
+		 */
+		WARN_ON(1);
+		return;
+	}
+
+	if (ret > 0)
+		enable_fiq(kgdb_fiq);
+	else
+		disable_fiq(kgdb_fiq);
+}
+
+int kgdb_register_fiq(unsigned int fiq)
+{
+	int err;
+	int cpu;
+
+	if (!kgdb_fiq_enabled)
+		return -ENODEV;
+
+	if (!has_fiq(fiq)) {
+		pr_warn(
+		    "%s: Cannot register %u (no FIQ with this number)\n",
+		    __func__, fiq);
+		return -ENODEV;
+	}
+
+	kgdb_fiq = fiq;
+
+	err = claim_fiq(&kgdb_fiq_desc);
+	if (err) {
+		pr_warn("%s: unable to claim fiq", __func__);
+		return err;
+	}
+
+	for_each_possible_cpu(cpu)
+		work_on_cpu(cpu, kgdb_fiq_setup_stack, NULL);
+
+	set_fiq_handler(&kgdb_fiq_handler,
+			&kgdb_fiq_handler_end - &kgdb_fiq_handler);
+
+	arch_kgdb_ops.enable_nmi = kgdb_fiq_enable_nmi;
+	return 0;
+}
diff --git a/arch/arm/kernel/kgdb_fiq_entry.S b/arch/arm/kernel/kgdb_fiq_entry.S
new file mode 100644
index 0000000..d6becca
--- /dev/null
+++ b/arch/arm/kernel/kgdb_fiq_entry.S
@@ -0,0 +1,87 @@
+/*
+ * KGDB FIQ entry
+ *
+ * Copyright 1996,1997,1998 Russell King.
+ * Copyright 2012 Linaro Ltd.
+ *		  Anton Vorontsov <anton.vorontsov@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/memory.h>
+#include <asm/unwind.h>
+#include "entry-header.S"
+
+	.text
+
+@ This is needed for usr_entry/alignment_trap
+.LCcralign:
+	.long	cr_alignment
+.LCdohandle:
+	.long	kgdb_fiq_do_handle
+
+	.macro	fiq_handler
+	ldr	r1, =.LCdohandle
+	mov	r0, sp
+	adr	lr, BSYM(9997f)
+	ldr	pc, [r1]
+9997:
+	.endm
+
+	.align	5
+__fiq_svc:
+	svc_entry
+	fiq_handler
+	mov	r0, sp
+	ldmib	r0, {r1 - r14}
+	msr	cpsr_c, #FIQ_MODE | PSR_I_BIT | PSR_F_BIT
+	add	r8, r0, #S_PC
+	ldr	r9, [r0, #S_PSR]
+	msr	spsr_cxsf, r9
+	ldr	r0, [r0, #S_R0]
+	ldmia	r8, {pc}^
+
+ UNWIND(.fnend		)
+ENDPROC(__fiq_svc)
+	.ltorg
+
+	.align	5
+__fiq_usr:
+	usr_entry
+	kuser_cmpxchg_check
+	fiq_handler
+	get_thread_info tsk
+	mov	why, #0
+	b	ret_to_user_from_irq
+ UNWIND(.fnend		)
+ENDPROC(__fiq_usr)
+	.ltorg
+
+	.global kgdb_fiq_handler
+kgdb_fiq_handler:
+
+	vector_stub	fiq, FIQ_MODE, 4
+
+	.long	__fiq_usr			@  0  (USR_26 / USR_32)
+	.long	__fiq_svc			@  1  (FIQ_26 / FIQ_32)
+	.long	__fiq_svc			@  2  (IRQ_26 / IRQ_32)
+	.long	__fiq_svc			@  3  (SVC_26 / SVC_32)
+	.long	__fiq_svc			@  4
+	.long	__fiq_svc			@  5
+	.long	__fiq_svc			@  6
+	.long	__fiq_svc			@  7
+	.long	__fiq_svc			@  8
+	.long	__fiq_svc			@  9
+	.long	__fiq_svc			@  a
+	.long	__fiq_svc			@  b
+	.long	__fiq_svc			@  c
+	.long	__fiq_svc			@  d
+	.long	__fiq_svc			@  e
+	.long	__fiq_svc			@  f
+
+	.global kgdb_fiq_handler_end
+kgdb_fiq_handler_end:
-- 
1.9.3
