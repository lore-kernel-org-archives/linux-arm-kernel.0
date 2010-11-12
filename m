From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Nov 2010 15:17:40 +0800
Subject: [PATCH 11/11] ARM: pxa: add iwmmx support for PJ4
In-Reply-To: <1289546260-6208-10-git-send-email-haojian.zhuang@marvell.com>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-3-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-4-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-5-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-6-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-7-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-8-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-9-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-10-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1289546260-6208-11-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iwmmxt is used in XScale, XScale3, Mohawk and PJ4 core. But the instructions
of accessing CP0 and CP1 is changed in PJ4. Append more files to support
iwmmxt in PJ4 core.

Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/kernel/Makefile        |   14 +-
 arch/arm/kernel/iwmmxt.S        |  317 --------------------------------------
 arch/arm/kernel/pj4-cp0.c       |  180 ++++++++++++++++++++++
 arch/arm/kernel/pj4-iwmmxt.S    |  319 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/xscale-iwmmxt.S |  317 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 825 insertions(+), 322 deletions(-)
 delete mode 100644 arch/arm/kernel/iwmmxt.S
 create mode 100644 arch/arm/kernel/pj4-cp0.c
 create mode 100644 arch/arm/kernel/pj4-iwmmxt.S
 create mode 100644 arch/arm/kernel/xscale-iwmmxt.S

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 5b9b268..af5cd47 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -47,13 +47,17 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
 AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
 
-obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
-obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
-obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
-obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
+ifeq ($(CONFIG_IWMMXT),y)
+  obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o xscale-iwmmxt.o
+  obj-$(CONFIG_CPU_XSC3)	+= xscale-cp0.o xscale-iwmmxt.o
+  obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o xscale-iwmmxt.o
+  AFLAGS_xscale-iwmmxt.o	:= -Wa,-mcpu=iwmmxt+iwmmxt2
+
+  obj-$(CONFIG_CPU_PJ4)		+= pj4-cp0.o pj4-iwmmxt.o
+  AFLAGS_pj4-iwmmxt.o		:= -Wa,-mcpu=iwmmxt+iwmmxt2
+endif
 obj-$(CONFIG_CPU_HAS_PMU)	+= pmu.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
-AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 
 ifneq ($(CONFIG_ARCH_EBSA110),y)
   obj-y		+= io.o
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
deleted file mode 100644
index b63b528..0000000
--- a/arch/arm/kernel/iwmmxt.S
+++ /dev/null
@@ -1,317 +0,0 @@
-/*
- *  linux/arch/arm/kernel/iwmmxt.S
- *
- *  XScale iWMMXt (Concan) context switching and handling
- *
- *  Initial code:
- *  Copyright (c) 2003, Intel Corporation
- *
- *  Full lazy switching support, optimizations and more, by Nicolas Pitre
-*   Copyright (c) 2003-2004, MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/linkage.h>
-#include <asm/ptrace.h>
-#include <asm/thread_info.h>
-#include <asm/asm-offsets.h>
-
-#define MMX_WR0		 	(0x00)
-#define MMX_WR1		 	(0x08)
-#define MMX_WR2		 	(0x10)
-#define MMX_WR3			(0x18)
-#define MMX_WR4		 	(0x20)
-#define MMX_WR5		 	(0x28)
-#define MMX_WR6		 	(0x30)
-#define MMX_WR7		 	(0x38)
-#define MMX_WR8		 	(0x40)
-#define MMX_WR9		 	(0x48)
-#define MMX_WR10		(0x50)
-#define MMX_WR11		(0x58)
-#define MMX_WR12		(0x60)
-#define MMX_WR13		(0x68)
-#define MMX_WR14		(0x70)
-#define MMX_WR15		(0x78)
-#define MMX_WCSSF		(0x80)
-#define MMX_WCASF		(0x84)
-#define MMX_WCGR0		(0x88)
-#define MMX_WCGR1		(0x8C)
-#define MMX_WCGR2		(0x90)
-#define MMX_WCGR3		(0x94)
-
-#define MMX_SIZE		(0x98)
-
-	.text
-
-/*
- * Lazy switching of Concan coprocessor context
- *
- * r10 = struct thread_info pointer
- * r9  = ret_from_exception
- * lr  = undefined instr exit
- *
- * called from prefetch exception handler with interrupts disabled
- */
-
-ENTRY(iwmmxt_task_enable)
-
-	mrc	p15, 0, r2, c15, c1, 0
-	tst	r2, #0x3			@ CP0 and CP1 accessible?
-	movne	pc, lr				@ if so no business here
-	orr	r2, r2, #0x3			@ enable access to CP0 and CP1
-	mcr	p15, 0, r2, c15, c1, 0
-
-	ldr	r3, =concan_owner
-	add	r0, r10, #TI_IWMMXT_STATE	@ get task Concan save area
-	ldr	r2, [sp, #60]			@ current task pc value
-	ldr	r1, [r3]			@ get current Concan owner
-	str	r0, [r3]			@ this task now owns Concan regs
-	sub	r2, r2, #4			@ adjust pc back
-	str	r2, [sp, #60]
-
-	mrc	p15, 0, r2, c2, c0, 0
-	mov	r2, r2				@ cpwait
-
-	teq	r1, #0				@ test for last ownership
-	mov	lr, r9				@ normal exit from exception
-	beq	concan_load			@ no owner, skip save
-
-concan_save:
-
-	tmrc	r2, wCon
-
-	@ CUP? wCx
-	tst	r2, #0x1
-	beq 	1f
-
-concan_dump:
-
-	wstrw	wCSSF, [r1, #MMX_WCSSF]
-	wstrw	wCASF, [r1, #MMX_WCASF]
-	wstrw	wCGR0, [r1, #MMX_WCGR0]
-	wstrw	wCGR1, [r1, #MMX_WCGR1]
-	wstrw	wCGR2, [r1, #MMX_WCGR2]
-	wstrw	wCGR3, [r1, #MMX_WCGR3]
-
-1:	@ MUP? wRn
-	tst	r2, #0x2
-	beq	2f
-
-	wstrd	wR0,  [r1, #MMX_WR0]
-	wstrd	wR1,  [r1, #MMX_WR1]
-	wstrd	wR2,  [r1, #MMX_WR2]
-	wstrd	wR3,  [r1, #MMX_WR3]
-	wstrd	wR4,  [r1, #MMX_WR4]
-	wstrd	wR5,  [r1, #MMX_WR5]
-	wstrd	wR6,  [r1, #MMX_WR6]
-	wstrd	wR7,  [r1, #MMX_WR7]
-	wstrd	wR8,  [r1, #MMX_WR8]
-	wstrd	wR9,  [r1, #MMX_WR9]
-	wstrd	wR10, [r1, #MMX_WR10]
-	wstrd	wR11, [r1, #MMX_WR11]
-	wstrd	wR12, [r1, #MMX_WR12]
-	wstrd	wR13, [r1, #MMX_WR13]
-	wstrd	wR14, [r1, #MMX_WR14]
-	wstrd	wR15, [r1, #MMX_WR15]
-
-2:	teq	r0, #0				@ anything to load?
-	moveq	pc, lr
-
-concan_load:
-
-	@ Load wRn
-	wldrd	wR0,  [r0, #MMX_WR0]
-	wldrd	wR1,  [r0, #MMX_WR1]
-	wldrd	wR2,  [r0, #MMX_WR2]
-	wldrd	wR3,  [r0, #MMX_WR3]
-	wldrd	wR4,  [r0, #MMX_WR4]
-	wldrd	wR5,  [r0, #MMX_WR5]
-	wldrd	wR6,  [r0, #MMX_WR6]
-	wldrd	wR7,  [r0, #MMX_WR7]
-	wldrd	wR8,  [r0, #MMX_WR8]
-	wldrd	wR9,  [r0, #MMX_WR9]
-	wldrd	wR10, [r0, #MMX_WR10]
-	wldrd	wR11, [r0, #MMX_WR11]
-	wldrd	wR12, [r0, #MMX_WR12]
-	wldrd	wR13, [r0, #MMX_WR13]
-	wldrd	wR14, [r0, #MMX_WR14]
-	wldrd	wR15, [r0, #MMX_WR15]
-
-	@ Load wCx
-	wldrw	wCSSF, [r0, #MMX_WCSSF]
-	wldrw	wCASF, [r0, #MMX_WCASF]
-	wldrw	wCGR0, [r0, #MMX_WCGR0]
-	wldrw	wCGR1, [r0, #MMX_WCGR1]
-	wldrw	wCGR2, [r0, #MMX_WCGR2]
-	wldrw	wCGR3, [r0, #MMX_WCGR3]
-
-	@ clear CUP/MUP (only if r1 != 0)
-	teq	r1, #0
-	mov 	r2, #0
-	moveq	pc, lr
-	tmcr	wCon, r2
-	mov	pc, lr
-
-/*
- * Back up Concan regs to save area and disable access to them
- * (mainly for gdb or sleep mode usage)
- *
- * r0 = struct thread_info pointer of target task or NULL for any
- */
-
-ENTRY(iwmmxt_task_disable)
-
-	stmfd	sp!, {r4, lr}
-
-	mrs	ip, cpsr
-	orr	r2, ip, #PSR_I_BIT		@ disable interrupts
-	msr	cpsr_c, r2
-
-	ldr	r3, =concan_owner
-	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
-	ldr	r1, [r3]			@ get current Concan owner
-	teq	r1, #0				@ any current owner?
-	beq	1f				@ no: quit
-	teq	r0, #0				@ any owner?
-	teqne	r1, r2				@ or specified one?
-	bne	1f				@ no: quit
-
-	mrc	p15, 0, r4, c15, c1, 0
-	orr	r4, r4, #0x3			@ enable access to CP0 and CP1
-	mcr	p15, 0, r4, c15, c1, 0
-	mov	r0, #0				@ nothing to load
-	str	r0, [r3]			@ no more current owner
-	mrc	p15, 0, r2, c2, c0, 0
-	mov	r2, r2				@ cpwait
-	bl	concan_save
-
-	bic	r4, r4, #0x3			@ disable access to CP0 and CP1
-	mcr	p15, 0, r4, c15, c1, 0
-	mrc	p15, 0, r2, c2, c0, 0
-	mov	r2, r2				@ cpwait
-
-1:	msr	cpsr_c, ip			@ restore interrupt mode
-	ldmfd	sp!, {r4, pc}
-
-/*
- * Copy Concan state to given memory address
- *
- * r0 = struct thread_info pointer of target task
- * r1 = memory address where to store Concan state
- *
- * this is called mainly in the creation of signal stack frames
- */
-
-ENTRY(iwmmxt_task_copy)
-
-	mrs	ip, cpsr
-	orr	r2, ip, #PSR_I_BIT		@ disable interrupts
-	msr	cpsr_c, r2
-
-	ldr	r3, =concan_owner
-	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
-	ldr	r3, [r3]			@ get current Concan owner
-	teq	r2, r3				@ does this task own it...
-	beq	1f
-
-	@ current Concan values are in the task save area
-	msr	cpsr_c, ip			@ restore interrupt mode
-	mov	r0, r1
-	mov	r1, r2
-	mov	r2, #MMX_SIZE
-	b	memcpy
-
-1:	@ this task owns Concan regs -- grab a copy from there
-	mov	r0, #0				@ nothing to load
-	mov	r2, #3				@ save all regs
-	mov	r3, lr				@ preserve return address
-	bl	concan_dump
-	msr	cpsr_c, ip			@ restore interrupt mode
-	mov	pc, r3
-
-/*
- * Restore Concan state from given memory address
- *
- * r0 = struct thread_info pointer of target task
- * r1 = memory address where to get Concan state from
- *
- * this is used to restore Concan state when unwinding a signal stack frame
- */
-
-ENTRY(iwmmxt_task_restore)
-
-	mrs	ip, cpsr
-	orr	r2, ip, #PSR_I_BIT		@ disable interrupts
-	msr	cpsr_c, r2
-
-	ldr	r3, =concan_owner
-	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
-	ldr	r3, [r3]			@ get current Concan owner
-	bic	r2, r2, #0x7			@ 64-bit alignment
-	teq	r2, r3				@ does this task own it...
-	beq	1f
-
-	@ this task doesn't own Concan regs -- use its save area
-	msr	cpsr_c, ip			@ restore interrupt mode
-	mov	r0, r2
-	mov	r2, #MMX_SIZE
-	b	memcpy
-
-1:	@ this task owns Concan regs -- load them directly
-	mov	r0, r1
-	mov	r1, #0				@ don't clear CUP/MUP
-	mov	r3, lr				@ preserve return address
-	bl	concan_load
-	msr	cpsr_c, ip			@ restore interrupt mode
-	mov	pc, r3
-
-/*
- * Concan handling on task switch
- *
- * r0 = next thread_info pointer
- *
- * Called only from the iwmmxt notifier with task preemption disabled.
- */
-ENTRY(iwmmxt_task_switch)
-
-	mrc	p15, 0, r1, c15, c1, 0
-	tst	r1, #0x3			@ CP0 and CP1 accessible?
-	bne	1f				@ yes: block them for next task
-
-	ldr	r2, =concan_owner
-	add	r3, r0, #TI_IWMMXT_STATE	@ get next task Concan save area
-	ldr	r2, [r2]			@ get current Concan owner
-	teq	r2, r3				@ next task owns it?
-	movne	pc, lr				@ no: leave Concan disabled
-
-1:	eor	r1, r1, #3			@ flip Concan access
-	mcr	p15, 0, r1, c15, c1, 0
-
-	mrc	p15, 0, r1, c2, c0, 0
-	sub	pc, lr, r1, lsr #32		@ cpwait and return
-
-/*
- * Remove Concan ownership of given task
- *
- * r0 = struct thread_info pointer
- */
-ENTRY(iwmmxt_task_release)
-
-	mrs	r2, cpsr
-	orr	ip, r2, #PSR_I_BIT		@ disable interrupts
-	msr	cpsr_c, ip
-	ldr	r3, =concan_owner
-	add	r0, r0, #TI_IWMMXT_STATE	@ get task Concan save area
-	ldr	r1, [r3]			@ get current Concan owner
-	eors	r0, r0, r1			@ if equal...
-	streq	r0, [r3]			@ then clear ownership
-	msr	cpsr_c, r2			@ restore interrupts
-	mov	pc, lr
-
-	.data
-concan_owner:
-	.word	0
-
diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
new file mode 100644
index 0000000..6d5ee12
--- /dev/null
+++ b/arch/arm/kernel/pj4-cp0.c
@@ -0,0 +1,180 @@
+/*
+ * linux/arch/arm/kernel/pj4-cp0.c
+ *
+ * XScale DSP and iWMMXt coprocessor context switching and handling
+ *
+ * Copyright (c) 2010 Marvell International Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <asm/thread_notify.h>
+
+static inline void dsp_save_state(u32 *state)
+{
+	__asm__ __volatile__ (
+		"mrrc	p0, 0, %0, %1, c0\n"
+		: "=r" (state[0]), "=r" (state[1]));
+}
+
+static inline void dsp_load_state(u32 *state)
+{
+	__asm__ __volatile__ (
+		"mcrr	p0, 0, %0, %1, c0\n"
+		: : "r" (state[0]), "r" (state[1]));
+}
+
+static int dsp_do(struct notifier_block *self, unsigned long cmd, void *t)
+{
+	struct thread_info *thread = t;
+
+	switch (cmd) {
+	case THREAD_NOTIFY_FLUSH:
+		thread->cpu_context.extra[0] = 0;
+		thread->cpu_context.extra[1] = 0;
+		break;
+
+	case THREAD_NOTIFY_SWITCH:
+		dsp_save_state(current_thread_info()->cpu_context.extra);
+		dsp_load_state(thread->cpu_context.extra);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block dsp_notifier_block = {
+	.notifier_call	= dsp_do,
+};
+
+
+#ifdef CONFIG_IWMMXT
+static int iwmmxt_do(struct notifier_block *self, unsigned long cmd, void *t)
+{
+	struct thread_info *thread = t;
+
+	switch (cmd) {
+	case THREAD_NOTIFY_FLUSH:
+		/*
+		 * flush_thread() zeroes thread->fpstate, so no need
+		 * to do anything here.
+		 *
+		 * FALLTHROUGH: Ensure we don't try to overwrite our newly
+		 * initialised state information on the first fault.
+		 */
+
+	case THREAD_NOTIFY_EXIT:
+		iwmmxt_task_release(thread);
+		break;
+
+	case THREAD_NOTIFY_SWITCH:
+		iwmmxt_task_switch(thread);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block iwmmxt_notifier_block = {
+	.notifier_call	= iwmmxt_do,
+};
+#endif
+
+
+static u32 __init pj4_cp_access_read(void)
+{
+	u32 value;
+
+	__asm__ __volatile__ (
+		"mrc	p15, 0, %0, c1, c0, 2\n\t"
+		: "=r" (value));
+	return value;
+}
+
+static void __init pj4_cp_access_write(u32 value)
+{
+	u32 temp;
+
+	__asm__ __volatile__ (
+		"mcr	p15, 0, %1, c1, c0, 2\n\t"
+		"mrc	p15, 0, %0, c1, c0, 2\n\t"
+		"mov	%0, %0\n\t"
+		"sub	pc, pc, #4\n\t"
+		: "=r" (temp) : "r" (value));
+}
+
+/*
+ * Detect whether we have a MAC coprocessor (40 bit register) or an
+ * iWMMXt coprocessor (64 bit registers) by loading 00000100:00000000
+ * into a coprocessor register and reading it back, and checking
+ * whether the upper word survived intact.
+ */
+static int __init cpu_has_iwmmxt(void)
+{
+	u32 lo;
+	u32 hi;
+
+	/*
+	 * This sequence is interpreted by the DSP coprocessor as:
+	 *	mar	acc0, %2, %3
+	 *	mra	%0, %1, acc0
+	 *
+	 * And by the iWMMXt coprocessor as:
+	 *	tmcrr	wR0, %2, %3
+	 *	tmrrc	%0, %1, wR0
+	 */
+	__asm__ __volatile__ (
+		"mcrr	p0, 0, %2, %3, c0\n"
+		"mrrc	p0, 0, %0, %1, c0\n"
+		: "=r" (lo), "=r" (hi)
+		: "r" (0), "r" (0x100));
+
+	return !!hi;
+}
+
+
+/*
+ * If we detect that the CPU has iWMMXt (and CONFIG_IWMMXT=y), we
+ * disable CP0/CP1 on boot, and let call_fpe() and the iWMMXt lazy
+ * switch code handle iWMMXt context switching.  If on the other
+ * hand the CPU has a DSP coprocessor, we keep access to CP0 enabled
+ * all the time, and save/restore acc0 on context switch in non-lazy
+ * fashion.
+ */
+static int __init pj4_cp0_init(void)
+{
+	u32 cp_access;
+
+	cp_access = pj4_cp_access_read() & ~0xf;
+	pj4_cp_access_write(cp_access | 0xf);
+
+	if (cpu_has_iwmmxt()) {
+#ifndef CONFIG_IWMMXT
+		printk(KERN_WARNING "CAUTION: XScale iWMMXt coprocessor "
+			"detected, but kernel support is missing.\n");
+#else
+		printk(KERN_INFO "XScale iWMMXt coprocessor detected.\n");
+		elf_hwcap |= HWCAP_IWMMXT;
+		thread_register_notifier(&iwmmxt_notifier_block);
+#endif
+	} else {
+		printk(KERN_INFO "XScale DSP coprocessor detected.\n");
+		thread_register_notifier(&dsp_notifier_block);
+		cp_access |= 1;
+	}
+
+	pj4_cp_access_write(cp_access);
+
+	return 0;
+}
+
+late_initcall(pj4_cp0_init);
diff --git a/arch/arm/kernel/pj4-iwmmxt.S b/arch/arm/kernel/pj4-iwmmxt.S
new file mode 100644
index 0000000..db500f3
--- /dev/null
+++ b/arch/arm/kernel/pj4-iwmmxt.S
@@ -0,0 +1,319 @@
+/*
+ *  linux/arch/arm/kernel/pj4-iwmmxt.S
+ *
+ *  PJ4 iWMMXt (Concan) context switching and handling
+ *
+ *  Initial code:
+ *  Copyright (c) 2003, Intel Corporation
+ *
+ *  Full lazy switching support, optimizations and more, by Nicolas Pitre
+ *  Copyright (c) 2003-2004, MontaVista Software, Inc.
+ *
+ *  Copyright (c) 2010 Marvell International Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/ptrace.h>
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+
+#define MMX_WR0		 	(0x00)
+#define MMX_WR1		 	(0x08)
+#define MMX_WR2		 	(0x10)
+#define MMX_WR3			(0x18)
+#define MMX_WR4		 	(0x20)
+#define MMX_WR5		 	(0x28)
+#define MMX_WR6		 	(0x30)
+#define MMX_WR7		 	(0x38)
+#define MMX_WR8		 	(0x40)
+#define MMX_WR9		 	(0x48)
+#define MMX_WR10		(0x50)
+#define MMX_WR11		(0x58)
+#define MMX_WR12		(0x60)
+#define MMX_WR13		(0x68)
+#define MMX_WR14		(0x70)
+#define MMX_WR15		(0x78)
+#define MMX_WCSSF		(0x80)
+#define MMX_WCASF		(0x84)
+#define MMX_WCGR0		(0x88)
+#define MMX_WCGR1		(0x8C)
+#define MMX_WCGR2		(0x90)
+#define MMX_WCGR3		(0x94)
+
+#define MMX_SIZE		(0x98)
+
+	.text
+
+/*
+ * Lazy switching of Concan coprocessor context
+ *
+ * r10 = struct thread_info pointer
+ * r9  = ret_from_exception
+ * lr  = undefined instr exit
+ *
+ * called from prefetch exception handler with interrupts disabled
+ */
+
+ENTRY(iwmmxt_task_enable)
+
+	mrc	p15, 0, r2, c1, c0, 2
+	tst	r2, #0xf			@ CP0 and CP1 accessible?
+	movne	pc, lr				@ if so no business here
+	orr	r2, r2, #0xf			@ enable access to CP0 and CP1
+	mcr	p15, 0, r2, c1, c0, 2
+
+	ldr	r3, =concan_owner
+	add	r0, r10, #TI_IWMMXT_STATE	@ get task Concan save area
+	ldr	r2, [sp, #60]			@ current task pc value
+	ldr	r1, [r3]			@ get current Concan owner
+	str	r0, [r3]			@ this task now owns Concan regs
+	sub	r2, r2, #4			@ adjust pc back
+	str	r2, [sp, #60]
+
+	mrc	p15, 0, r2, c2, c0, 0
+	mov	r2, r2				@ cpwait
+
+	teq	r1, #0				@ test for last ownership
+	mov	lr, r9				@ normal exit from exception
+	beq	concan_load			@ no owner, skip save
+
+concan_save:
+
+	tmrc	r2, wCon
+
+	@ CUP? wCx
+	tst	r2, #0x1
+	beq 	1f
+
+concan_dump:
+
+	wstrw	wCSSF, [r1, #MMX_WCSSF]
+	wstrw	wCASF, [r1, #MMX_WCASF]
+	wstrw	wCGR0, [r1, #MMX_WCGR0]
+	wstrw	wCGR1, [r1, #MMX_WCGR1]
+	wstrw	wCGR2, [r1, #MMX_WCGR2]
+	wstrw	wCGR3, [r1, #MMX_WCGR3]
+
+1:	@ MUP? wRn
+	tst	r2, #0x2
+	beq	2f
+
+	wstrd	wR0,  [r1, #MMX_WR0]
+	wstrd	wR1,  [r1, #MMX_WR1]
+	wstrd	wR2,  [r1, #MMX_WR2]
+	wstrd	wR3,  [r1, #MMX_WR3]
+	wstrd	wR4,  [r1, #MMX_WR4]
+	wstrd	wR5,  [r1, #MMX_WR5]
+	wstrd	wR6,  [r1, #MMX_WR6]
+	wstrd	wR7,  [r1, #MMX_WR7]
+	wstrd	wR8,  [r1, #MMX_WR8]
+	wstrd	wR9,  [r1, #MMX_WR9]
+	wstrd	wR10, [r1, #MMX_WR10]
+	wstrd	wR11, [r1, #MMX_WR11]
+	wstrd	wR12, [r1, #MMX_WR12]
+	wstrd	wR13, [r1, #MMX_WR13]
+	wstrd	wR14, [r1, #MMX_WR14]
+	wstrd	wR15, [r1, #MMX_WR15]
+
+2:	teq	r0, #0				@ anything to load?
+	moveq	pc, lr
+
+concan_load:
+
+	@ Load wRn
+	wldrd	wR0,  [r0, #MMX_WR0]
+	wldrd	wR1,  [r0, #MMX_WR1]
+	wldrd	wR2,  [r0, #MMX_WR2]
+	wldrd	wR3,  [r0, #MMX_WR3]
+	wldrd	wR4,  [r0, #MMX_WR4]
+	wldrd	wR5,  [r0, #MMX_WR5]
+	wldrd	wR6,  [r0, #MMX_WR6]
+	wldrd	wR7,  [r0, #MMX_WR7]
+	wldrd	wR8,  [r0, #MMX_WR8]
+	wldrd	wR9,  [r0, #MMX_WR9]
+	wldrd	wR10, [r0, #MMX_WR10]
+	wldrd	wR11, [r0, #MMX_WR11]
+	wldrd	wR12, [r0, #MMX_WR12]
+	wldrd	wR13, [r0, #MMX_WR13]
+	wldrd	wR14, [r0, #MMX_WR14]
+	wldrd	wR15, [r0, #MMX_WR15]
+
+	@ Load wCx
+	wldrw	wCSSF, [r0, #MMX_WCSSF]
+	wldrw	wCASF, [r0, #MMX_WCASF]
+	wldrw	wCGR0, [r0, #MMX_WCGR0]
+	wldrw	wCGR1, [r0, #MMX_WCGR1]
+	wldrw	wCGR2, [r0, #MMX_WCGR2]
+	wldrw	wCGR3, [r0, #MMX_WCGR3]
+
+	@ clear CUP/MUP (only if r1 != 0)
+	teq	r1, #0
+	mov 	r2, #0
+	moveq	pc, lr
+	tmcr	wCon, r2
+	mov	pc, lr
+
+/*
+ * Back up Concan regs to save area and disable access to them
+ * (mainly for gdb or sleep mode usage)
+ *
+ * r0 = struct thread_info pointer of target task or NULL for any
+ */
+
+ENTRY(iwmmxt_task_disable)
+
+	stmfd	sp!, {r4, lr}
+
+	mrs	ip, cpsr
+	orr	r2, ip, #PSR_I_BIT		@ disable interrupts
+	msr	cpsr_c, r2
+
+	ldr	r3, =concan_owner
+	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	ldr	r1, [r3]			@ get current Concan owner
+	teq	r1, #0				@ any current owner?
+	beq	1f				@ no: quit
+	teq	r0, #0				@ any owner?
+	teqne	r1, r2				@ or specified one?
+	bne	1f				@ no: quit
+
+	mrc	p15, 0, r4, c1, c0, 2
+	orr	r4, r4, #0xf			@ enable access to CP0 and CP1
+	mcr	p15, 0, r4, c1, c0, 2
+	mov	r0, #0				@ nothing to load
+	str	r0, [r3]			@ no more current owner
+	mrc	p15, 0, r2, c2, c0, 0
+	mov	r2, r2				@ cpwait
+	bl	concan_save
+
+	bic	r4, r4, #0xf			@ disable access to CP0 and CP1
+	mcr	p15, 0, r4, c1, c0, 2
+	mrc	p15, 0, r2, c2, c0, 0
+	mov	r2, r2				@ cpwait
+
+1:	msr	cpsr_c, ip			@ restore interrupt mode
+	ldmfd	sp!, {r4, pc}
+
+/*
+ * Copy Concan state to given memory address
+ *
+ * r0 = struct thread_info pointer of target task
+ * r1 = memory address where to store Concan state
+ *
+ * this is called mainly in the creation of signal stack frames
+ */
+
+ENTRY(iwmmxt_task_copy)
+
+	mrs	ip, cpsr
+	orr	r2, ip, #PSR_I_BIT		@ disable interrupts
+	msr	cpsr_c, r2
+
+	ldr	r3, =concan_owner
+	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	ldr	r3, [r3]			@ get current Concan owner
+	teq	r2, r3				@ does this task own it...
+	beq	1f
+
+	@ current Concan values are in the task save area
+	msr	cpsr_c, ip			@ restore interrupt mode
+	mov	r0, r1
+	mov	r1, r2
+	mov	r2, #MMX_SIZE
+	b	memcpy
+
+1:	@ this task owns Concan regs -- grab a copy from there
+	mov	r0, #0				@ nothing to load
+	mov	r2, #3				@ save all regs
+	mov	r3, lr				@ preserve return address
+	bl	concan_dump
+	msr	cpsr_c, ip			@ restore interrupt mode
+	mov	pc, r3
+
+/*
+ * Restore Concan state from given memory address
+ *
+ * r0 = struct thread_info pointer of target task
+ * r1 = memory address where to get Concan state from
+ *
+ * this is used to restore Concan state when unwinding a signal stack frame
+ */
+
+ENTRY(iwmmxt_task_restore)
+
+	mrs	ip, cpsr
+	orr	r2, ip, #PSR_I_BIT		@ disable interrupts
+	msr	cpsr_c, r2
+
+	ldr	r3, =concan_owner
+	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	ldr	r3, [r3]			@ get current Concan owner
+	bic	r2, r2, #0x7			@ 64-bit alignment
+	teq	r2, r3				@ does this task own it...
+	beq	1f
+
+	@ this task doesn't own Concan regs -- use its save area
+	msr	cpsr_c, ip			@ restore interrupt mode
+	mov	r0, r2
+	mov	r2, #MMX_SIZE
+	b	memcpy
+
+1:	@ this task owns Concan regs -- load them directly
+	mov	r0, r1
+	mov	r1, #0				@ don't clear CUP/MUP
+	mov	r3, lr				@ preserve return address
+	bl	concan_load
+	msr	cpsr_c, ip			@ restore interrupt mode
+	mov	pc, r3
+
+/*
+ * Concan handling on task switch
+ *
+ * r0 = next thread_info pointer
+ *
+ * Called only from the iwmmxt notifier with task preemption disabled.
+ */
+ENTRY(iwmmxt_task_switch)
+
+	mrc	p15, 0, r1, c1, c0, 2
+	tst	r1, #0xf			@ CP0 and CP1 accessible?
+	bne	1f				@ yes: block them for next task
+
+	ldr	r2, =concan_owner
+	add	r3, r0, #TI_IWMMXT_STATE	@ get next task Concan save area
+	ldr	r2, [r2]			@ get current Concan owner
+	teq	r2, r3				@ next task owns it?
+	movne	pc, lr				@ no: leave Concan disabled
+
+1:	eor	r1, r1, #0xf			@ flip Concan access
+	mcr	p15, 0, r1, c1, c0, 2
+
+	mrc	p15, 0, r1, c2, c0, 0
+	sub	pc, lr, r1, lsr #32		@ cpwait and return
+
+/*
+ * Remove Concan ownership of given task
+ *
+ * r0 = struct thread_info pointer
+ */
+ENTRY(iwmmxt_task_release)
+
+	mrs	r2, cpsr
+	orr	ip, r2, #PSR_I_BIT		@ disable interrupts
+	msr	cpsr_c, ip
+	ldr	r3, =concan_owner
+	add	r0, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	ldr	r1, [r3]			@ get current Concan owner
+	eors	r0, r0, r1			@ if equal...
+	streq	r0, [r3]			@ then clear ownership
+	msr	cpsr_c, r2			@ restore interrupts
+	mov	pc, lr
+
+	.data
+concan_owner:
+	.word	0
+
diff --git a/arch/arm/kernel/xscale-iwmmxt.S b/arch/arm/kernel/xscale-iwmmxt.S
new file mode 100644
index 0000000..b63b528
--- /dev/null
+++ b/arch/arm/kernel/xscale-iwmmxt.S
@@ -0,0 +1,317 @@
+/*
+ *  linux/arch/arm/kernel/iwmmxt.S
+ *
+ *  XScale iWMMXt (Concan) context switching and handling
+ *
+ *  Initial code:
+ *  Copyright (c) 2003, Intel Corporation
+ *
+ *  Full lazy switching support, optimizations and more, by Nicolas Pitre
+*   Copyright (c) 2003-2004, MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/ptrace.h>
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+
+#define MMX_WR0		 	(0x00)
+#define MMX_WR1		 	(0x08)
+#define MMX_WR2		 	(0x10)
+#define MMX_WR3			(0x18)
+#define MMX_WR4		 	(0x20)
+#define MMX_WR5		 	(0x28)
+#define MMX_WR6		 	(0x30)
+#define MMX_WR7		 	(0x38)
+#define MMX_WR8		 	(0x40)
+#define MMX_WR9		 	(0x48)
+#define MMX_WR10		(0x50)
+#define MMX_WR11		(0x58)
+#define MMX_WR12		(0x60)
+#define MMX_WR13		(0x68)
+#define MMX_WR14		(0x70)
+#define MMX_WR15		(0x78)
+#define MMX_WCSSF		(0x80)
+#define MMX_WCASF		(0x84)
+#define MMX_WCGR0		(0x88)
+#define MMX_WCGR1		(0x8C)
+#define MMX_WCGR2		(0x90)
+#define MMX_WCGR3		(0x94)
+
+#define MMX_SIZE		(0x98)
+
+	.text
+
+/*
+ * Lazy switching of Concan coprocessor context
+ *
+ * r10 = struct thread_info pointer
+ * r9  = ret_from_exception
+ * lr  = undefined instr exit
+ *
+ * called from prefetch exception handler with interrupts disabled
+ */
+
+ENTRY(iwmmxt_task_enable)
+
+	mrc	p15, 0, r2, c15, c1, 0
+	tst	r2, #0x3			@ CP0 and CP1 accessible?
+	movne	pc, lr				@ if so no business here
+	orr	r2, r2, #0x3			@ enable access to CP0 and CP1
+	mcr	p15, 0, r2, c15, c1, 0
+
+	ldr	r3, =concan_owner
+	add	r0, r10, #TI_IWMMXT_STATE	@ get task Concan save area
+	ldr	r2, [sp, #60]			@ current task pc value
+	ldr	r1, [r3]			@ get current Concan owner
+	str	r0, [r3]			@ this task now owns Concan regs
+	sub	r2, r2, #4			@ adjust pc back
+	str	r2, [sp, #60]
+
+	mrc	p15, 0, r2, c2, c0, 0
+	mov	r2, r2				@ cpwait
+
+	teq	r1, #0				@ test for last ownership
+	mov	lr, r9				@ normal exit from exception
+	beq	concan_load			@ no owner, skip save
+
+concan_save:
+
+	tmrc	r2, wCon
+
+	@ CUP? wCx
+	tst	r2, #0x1
+	beq 	1f
+
+concan_dump:
+
+	wstrw	wCSSF, [r1, #MMX_WCSSF]
+	wstrw	wCASF, [r1, #MMX_WCASF]
+	wstrw	wCGR0, [r1, #MMX_WCGR0]
+	wstrw	wCGR1, [r1, #MMX_WCGR1]
+	wstrw	wCGR2, [r1, #MMX_WCGR2]
+	wstrw	wCGR3, [r1, #MMX_WCGR3]
+
+1:	@ MUP? wRn
+	tst	r2, #0x2
+	beq	2f
+
+	wstrd	wR0,  [r1, #MMX_WR0]
+	wstrd	wR1,  [r1, #MMX_WR1]
+	wstrd	wR2,  [r1, #MMX_WR2]
+	wstrd	wR3,  [r1, #MMX_WR3]
+	wstrd	wR4,  [r1, #MMX_WR4]
+	wstrd	wR5,  [r1, #MMX_WR5]
+	wstrd	wR6,  [r1, #MMX_WR6]
+	wstrd	wR7,  [r1, #MMX_WR7]
+	wstrd	wR8,  [r1, #MMX_WR8]
+	wstrd	wR9,  [r1, #MMX_WR9]
+	wstrd	wR10, [r1, #MMX_WR10]
+	wstrd	wR11, [r1, #MMX_WR11]
+	wstrd	wR12, [r1, #MMX_WR12]
+	wstrd	wR13, [r1, #MMX_WR13]
+	wstrd	wR14, [r1, #MMX_WR14]
+	wstrd	wR15, [r1, #MMX_WR15]
+
+2:	teq	r0, #0				@ anything to load?
+	moveq	pc, lr
+
+concan_load:
+
+	@ Load wRn
+	wldrd	wR0,  [r0, #MMX_WR0]
+	wldrd	wR1,  [r0, #MMX_WR1]
+	wldrd	wR2,  [r0, #MMX_WR2]
+	wldrd	wR3,  [r0, #MMX_WR3]
+	wldrd	wR4,  [r0, #MMX_WR4]
+	wldrd	wR5,  [r0, #MMX_WR5]
+	wldrd	wR6,  [r0, #MMX_WR6]
+	wldrd	wR7,  [r0, #MMX_WR7]
+	wldrd	wR8,  [r0, #MMX_WR8]
+	wldrd	wR9,  [r0, #MMX_WR9]
+	wldrd	wR10, [r0, #MMX_WR10]
+	wldrd	wR11, [r0, #MMX_WR11]
+	wldrd	wR12, [r0, #MMX_WR12]
+	wldrd	wR13, [r0, #MMX_WR13]
+	wldrd	wR14, [r0, #MMX_WR14]
+	wldrd	wR15, [r0, #MMX_WR15]
+
+	@ Load wCx
+	wldrw	wCSSF, [r0, #MMX_WCSSF]
+	wldrw	wCASF, [r0, #MMX_WCASF]
+	wldrw	wCGR0, [r0, #MMX_WCGR0]
+	wldrw	wCGR1, [r0, #MMX_WCGR1]
+	wldrw	wCGR2, [r0, #MMX_WCGR2]
+	wldrw	wCGR3, [r0, #MMX_WCGR3]
+
+	@ clear CUP/MUP (only if r1 != 0)
+	teq	r1, #0
+	mov 	r2, #0
+	moveq	pc, lr
+	tmcr	wCon, r2
+	mov	pc, lr
+
+/*
+ * Back up Concan regs to save area and disable access to them
+ * (mainly for gdb or sleep mode usage)
+ *
+ * r0 = struct thread_info pointer of target task or NULL for any
+ */
+
+ENTRY(iwmmxt_task_disable)
+
+	stmfd	sp!, {r4, lr}
+
+	mrs	ip, cpsr
+	orr	r2, ip, #PSR_I_BIT		@ disable interrupts
+	msr	cpsr_c, r2
+
+	ldr	r3, =concan_owner
+	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	ldr	r1, [r3]			@ get current Concan owner
+	teq	r1, #0				@ any current owner?
+	beq	1f				@ no: quit
+	teq	r0, #0				@ any owner?
+	teqne	r1, r2				@ or specified one?
+	bne	1f				@ no: quit
+
+	mrc	p15, 0, r4, c15, c1, 0
+	orr	r4, r4, #0x3			@ enable access to CP0 and CP1
+	mcr	p15, 0, r4, c15, c1, 0
+	mov	r0, #0				@ nothing to load
+	str	r0, [r3]			@ no more current owner
+	mrc	p15, 0, r2, c2, c0, 0
+	mov	r2, r2				@ cpwait
+	bl	concan_save
+
+	bic	r4, r4, #0x3			@ disable access to CP0 and CP1
+	mcr	p15, 0, r4, c15, c1, 0
+	mrc	p15, 0, r2, c2, c0, 0
+	mov	r2, r2				@ cpwait
+
+1:	msr	cpsr_c, ip			@ restore interrupt mode
+	ldmfd	sp!, {r4, pc}
+
+/*
+ * Copy Concan state to given memory address
+ *
+ * r0 = struct thread_info pointer of target task
+ * r1 = memory address where to store Concan state
+ *
+ * this is called mainly in the creation of signal stack frames
+ */
+
+ENTRY(iwmmxt_task_copy)
+
+	mrs	ip, cpsr
+	orr	r2, ip, #PSR_I_BIT		@ disable interrupts
+	msr	cpsr_c, r2
+
+	ldr	r3, =concan_owner
+	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	ldr	r3, [r3]			@ get current Concan owner
+	teq	r2, r3				@ does this task own it...
+	beq	1f
+
+	@ current Concan values are in the task save area
+	msr	cpsr_c, ip			@ restore interrupt mode
+	mov	r0, r1
+	mov	r1, r2
+	mov	r2, #MMX_SIZE
+	b	memcpy
+
+1:	@ this task owns Concan regs -- grab a copy from there
+	mov	r0, #0				@ nothing to load
+	mov	r2, #3				@ save all regs
+	mov	r3, lr				@ preserve return address
+	bl	concan_dump
+	msr	cpsr_c, ip			@ restore interrupt mode
+	mov	pc, r3
+
+/*
+ * Restore Concan state from given memory address
+ *
+ * r0 = struct thread_info pointer of target task
+ * r1 = memory address where to get Concan state from
+ *
+ * this is used to restore Concan state when unwinding a signal stack frame
+ */
+
+ENTRY(iwmmxt_task_restore)
+
+	mrs	ip, cpsr
+	orr	r2, ip, #PSR_I_BIT		@ disable interrupts
+	msr	cpsr_c, r2
+
+	ldr	r3, =concan_owner
+	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	ldr	r3, [r3]			@ get current Concan owner
+	bic	r2, r2, #0x7			@ 64-bit alignment
+	teq	r2, r3				@ does this task own it...
+	beq	1f
+
+	@ this task doesn't own Concan regs -- use its save area
+	msr	cpsr_c, ip			@ restore interrupt mode
+	mov	r0, r2
+	mov	r2, #MMX_SIZE
+	b	memcpy
+
+1:	@ this task owns Concan regs -- load them directly
+	mov	r0, r1
+	mov	r1, #0				@ don't clear CUP/MUP
+	mov	r3, lr				@ preserve return address
+	bl	concan_load
+	msr	cpsr_c, ip			@ restore interrupt mode
+	mov	pc, r3
+
+/*
+ * Concan handling on task switch
+ *
+ * r0 = next thread_info pointer
+ *
+ * Called only from the iwmmxt notifier with task preemption disabled.
+ */
+ENTRY(iwmmxt_task_switch)
+
+	mrc	p15, 0, r1, c15, c1, 0
+	tst	r1, #0x3			@ CP0 and CP1 accessible?
+	bne	1f				@ yes: block them for next task
+
+	ldr	r2, =concan_owner
+	add	r3, r0, #TI_IWMMXT_STATE	@ get next task Concan save area
+	ldr	r2, [r2]			@ get current Concan owner
+	teq	r2, r3				@ next task owns it?
+	movne	pc, lr				@ no: leave Concan disabled
+
+1:	eor	r1, r1, #3			@ flip Concan access
+	mcr	p15, 0, r1, c15, c1, 0
+
+	mrc	p15, 0, r1, c2, c0, 0
+	sub	pc, lr, r1, lsr #32		@ cpwait and return
+
+/*
+ * Remove Concan ownership of given task
+ *
+ * r0 = struct thread_info pointer
+ */
+ENTRY(iwmmxt_task_release)
+
+	mrs	r2, cpsr
+	orr	ip, r2, #PSR_I_BIT		@ disable interrupts
+	msr	cpsr_c, ip
+	ldr	r3, =concan_owner
+	add	r0, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	ldr	r1, [r3]			@ get current Concan owner
+	eors	r0, r0, r1			@ if equal...
+	streq	r0, [r3]			@ then clear ownership
+	msr	cpsr_c, r2			@ restore interrupts
+	mov	pc, lr
+
+	.data
+concan_owner:
+	.word	0
+
-- 
1.5.6.5
