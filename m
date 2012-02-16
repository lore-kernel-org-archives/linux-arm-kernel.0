From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 16 Feb 2012 21:18:10 +0100
Subject: [PATCH 5/5] ARM: Cortex-M3: Add support for exception handling
In-Reply-To: <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120216200143.GS14173@pengutronix.de>
 <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1329423490-15580-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch implements the exception handling for the ARMv7-M
architecture (pretty different from the A or R profiles).

[ukleinek: small adaptions, e.g. use show_regs instead of __show_regs in
invalid_entry, fix stack corruption in v7m_exception_fast_exit, check
for bit 3 in exception lr only instead of explicit values]

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/entry-common.S |   18 +++++-
 arch/arm/kernel/entry-header.S |   94 ++++++++++++++++++++++++++++-
 arch/arm/kernel/entry-v7m.S    |  131 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/process.c      |    8 +++
 4 files changed, 249 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/kernel/entry-v7m.S

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 9fd0ba9..4a12bc3 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -43,7 +43,13 @@ ret_fast_syscall:
  * Ok, we need to do extra processing, enter the slow path.
  */
 fast_work_pending:
+#ifdef CONFIG_CPU_V7M
+	@ S_R0 not at the beginning of struct pt_regs
+	add	sp, #S_OFF
+	str	r0, [sp, #S_R0]			@ returned r0
+#else
 	str	r0, [sp, #S_R0+S_OFF]!		@ returned r0
+#endif
 work_pending:
 	tst	r1, #_TIF_NEED_RESCHED
 	bne	work_resched
@@ -345,6 +351,9 @@ ENDPROC(ftrace_stub)
 
 	.align	5
 ENTRY(vector_swi)
+#ifdef CONFIG_CPU_V7M
+	v7m_exception_entry
+#else
 	sub	sp, sp, #S_FRAME_SIZE
 	stmia	sp, {r0 - r12}			@ Calling r0 - r12
  ARM(	add	r8, sp, #S_PC		)
@@ -354,6 +363,7 @@ ENTRY(vector_swi)
 	mrs	r8, spsr			@ called from non-FIQ mode, so ok.
 	str	lr, [sp, #S_PC]			@ Save calling PC
 	str	r8, [sp, #S_PSR]		@ Save CPSR
+#endif
 	str	r0, [sp, #S_OLD_R0]		@ Save OLD_R0
 	zero_fp
 
@@ -473,14 +483,20 @@ __sys_trace:
 
 	adr	lr, BSYM(__sys_trace_return)	@ return address
 	mov	scno, r0			@ syscall number (possibly new)
-	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
+	add	r1, sp, #S_OFF			@ pointer to regs
 	cmp	scno, #NR_syscalls		@ check upper syscall limit
 	ldmccia	r1, {r0 - r3}			@ have to reload r0 - r3
 	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
 	b	2b
 
 __sys_trace_return:
+#ifdef CONFIG_CPU_V7M
+	@ S_R0 not at the beginning of struct pt_regs
+	add	sp, #S_OFF
+	str	r0, [sp, #S_R0]			@ save returned r0
+#else
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
+#endif
 	mov	r2, scno
 	mov	r1, sp
 	mov	r0, #1				@ trace exit [IP = 1]
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 9a8531e..80055b4 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -26,7 +26,7 @@
  * The SWI code relies on the fact that R0 is at the bottom of the stack
  * (due to slow/fast restore user regs).
  */
-#if S_R0 != 0
+#if S_R0 != 0 && !defined(CONFIG_CPU_V7M)
 #error "Please fix"
 #endif
 
@@ -44,6 +44,89 @@
 #endif
 	.endm
 
+#ifdef CONFIG_CPU_V7M
+/*
+ * ARMv7-M exception entry/exit macros.
+ *
+ * xPSR, ReturnAddress(), LR (R14), R12, R3, R2, R1, and R0 are
+ * automatically saved on the current stack (32 words) before
+ * switching to the exception stack (SP_main). The order of struct
+ * pt_regs members was changed to take advantage of the automatic
+ * state saving.
+ *
+ * If exception is taken while in user mode, SP_main is
+ * empty. Otherwise, SP_main is aligned to 64 bit automatically
+ * (CCR.STKALIGN set).
+ *
+ * Linux assumes that the interrupts are disabled when entering an
+ * exception handler and it may BUG if this is not the case. Interrupts
+ * are disabled during entry and reenabled in the exit macro.
+ *
+ * The v7m_exception_entry macro preserves the original r0-r5, r7 for
+ * the system call arguments.
+ *
+ * v7_exception_fast_exit is used when returning from interrupts.
+ *
+ * v7_exception_slow_exit is used when returning from SVC or PendSV.
+ * When returning to kernel mode, we don't return from exception.
+ */
+	.macro	v7m_exception_entry
+	cpsid	i
+	tst	lr, #0x8		@ check the return stack
+	bne	1f			@ exception on process stack
+	add	r12, sp, #32		@ MSP before exception
+	stmdb	sp!, {r4-r12, lr}	@ push unsaved registers
+	b	2f
+1:
+	mrs	r12, psp		@ get the process stack
+	sub	sp, #S_FRAME_SIZE
+	stmia	sp, {r4-r12, lr}	@ push unsaved registers
+	ldmia	r12, {r0-r3, r6, r8-r10} @ load automatically saved registers
+	add	r12, sp, #S_R0
+	stmia	r12, {r0-r3, r6, r8-r10} @ fill in the rest of struct pt_regs
+2:
+	.endm
+
+	.macro	v7m_exception_fast_exit
+	ldmia	sp!, {r4-r12, lr}	@ restore previously saved state
+	tst     lr, #0x8		@ check the return stack
+	addne	sp, #S_FRAME_SIZE-S_R0	@ returning to PSP, just restore MSP
+	cpsie	i
+	bx	lr
+	.endm
+
+	.macro	v7m_exception_slow_exit ret_r0
+	cpsid	i
+	ldr	lr, [sp, #S_EXC_LR]	@ read exception LR
+	tst	lr, #0x8
+	bne	1f			@ returning to PSP
+	@ Prepare the MSP stack
+	ldmia	sp, {r4-r11}		@ restore previously saved state
+	ldr	lr, [sp, #S_PC]
+	add	sp, #S_R0
+	ldmia	sp, {r0-r3, r12}	@ restore the rest of registers
+	add	sp, #S_FRAME_SIZE-S_R0	@ restore the stack pointer
+	cpsie	i
+	bx	lr
+1:
+	@ Prepare the PSP stack
+	ldr	r12, [sp, #S_SP]	@ read original PSP
+	.if	\ret_r0
+	add	r11, sp, #S_R1
+	ldmia	r11, {r1-r7}		@ read state saved on MSP (r0 preserved)
+	.else
+	add	r11, sp, #S_R0
+	ldmia	r11, {r0-r7}		@ read state saved on MSP
+	.endif
+	msr	psp, r12		@ restore PSP
+	stmia	r12, {r0-r7}		@ restore saved state to PSP
+	ldmia	sp, {r4-r11}		@ restore previously saved state
+	add	sp, #S_FRAME_SIZE	@ restore the original MSP
+	cpsie	i
+	bx	lr
+	.endm
+#endif	/* CONFIG_CPU_V7M */
+
 	@
 	@ Store/load the USER SP and LR registers by switching to the SYS
 	@ mode. Useful in Thumb-2 mode where "stm/ldm rd, {sp, lr}^" is not
@@ -131,6 +214,14 @@
 	rfeia	sp!
 	.endm
 
+#ifdef CONFIG_CPU_V7M
+	.macro	restore_user_regs, fast = 0, offset = 0
+	.if	\offset
+	add	sp, #\offset
+	.endif
+	v7m_exception_slow_exit ret_r0 = \fast
+	.endm
+#else	/* !CONFIG_CPU_V7M */
 	.macro	restore_user_regs, fast = 0, offset = 0
 	clrex					@ clear the exclusive monitor
 	mov	r2, sp
@@ -147,6 +238,7 @@
 	add	sp, sp, #S_FRAME_SIZE - S_SP
 	movs	pc, lr				@ return & move spsr_svc into cpsr
 	.endm
+#endif	/* CONFIG_CPU_V7M */
 
 	.macro	get_thread_info, rd
 	mov	\rd, sp
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
new file mode 100644
index 0000000..74a1b7e
--- /dev/null
+++ b/arch/arm/kernel/entry-v7m.S
@@ -0,0 +1,131 @@
+/*
+ * linux/arch/arm/kernel/entry-v7m.S
+ *
+ * Copyright (C) 2008 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Low-level vector interface routines for the ARMv7-M architecture
+ */
+#include <asm/memory.h>
+#include <asm/glue.h>
+#include <asm/thread_notify.h>
+
+#include <mach/entry-macro.S>
+
+#include "entry-header.S"
+
+#ifdef CONFIG_PREEMPT
+#error "CONFIG_PREEMPT not supported on the current ARMv7M implementation"
+#endif
+#ifdef CONFIG_TRACE_IRQFLAGS
+#error "CONFIG_TRACE_IRQFLAGS not supported on the current ARMv7M implementation"
+#endif
+
+__invalid_entry:
+	v7m_exception_entry
+	adr	r0, strerr
+	mrs	r1, ipsr
+	mov	r2, lr
+	bl	printk
+	mov	r0, sp
+	bl	show_regs
+1:	b	1b
+ENDPROC(__invalid_entry)
+
+strerr:	.asciz	"\nUnhandled exception: IPSR = %08lx LR = %08lx\n"
+
+	.align	2
+__irq_entry:
+	v7m_exception_entry
+
+	@
+	@ Invoke the IRQ handler
+	@
+	mrs	r0, ipsr
+	and	r0, #0xff
+	sub	r0, #16			@ IRQ number
+	mov	r1, sp
+	@ routine called with r0 = irq number, r1 = struct pt_regs *
+	bl	asm_do_IRQ
+
+	@
+	@ Check for any pending work if returning to user
+	@
+	ldr	lr, [sp, #S_EXC_LR]
+	tst	lr, #0x8		@ check the return stack
+	beq	2f			@ returning to kernel
+	get_thread_info tsk
+	ldr	r1, [tsk, #TI_FLAGS]
+	tst	r1, #_TIF_WORK_MASK
+	beq	2f			@ no work pending
+	ldr	r1, =0xe000ed04		@ ICSR
+	mov	r0, #1 << 28		@ ICSR.PENDSVSET
+	str	r0, [r1]		@ raise PendSV
+
+2:
+	v7m_exception_fast_exit
+ENDPROC(__irq_entry)
+
+__pendsv_entry:
+	v7m_exception_entry
+
+	ldr	r1, =0xe000ed04		@ ICSR
+	mov	r0, #1 << 27		@ ICSR.PENDSVCLR
+	str	r0, [r1]		@ clear PendSV
+
+	@ execute the pending work, including reschedule
+	get_thread_info tsk
+	mov	why, #0
+	b	ret_to_user
+ENDPROC(__pendsv_entry)
+
+/*
+ * Register switch for ARMv7-M processors.
+ * r0 = previous task_struct, r1 = previous thread_info, r2 = next thread_info
+ * previous and next are guaranteed not to be the same.
+ */
+ENTRY(__switch_to)
+	add	ip, r1, #TI_CPU_SAVE
+	stmia	ip!, {r4 - sl, fp}	@ Store most regs on stack
+	str	sp, [ip], #4
+	str	lr, [ip], #4
+	mov	r5, r0
+	add	r4, r2, #TI_CPU_SAVE
+	ldr	r0, =thread_notify_head
+	mov	r1, #THREAD_NOTIFY_SWITCH
+	bl	atomic_notifier_call_chain
+	mov	ip, r4
+	mov	r0, r5
+	ldmia	ip!, {r4 - sl, fp}	@ Load all regs saved previously
+	ldr	sp, [ip], #4
+	ldr	pc, [ip]
+ENDPROC(__switch_to)
+
+	.data
+	.align	8
+/*
+ * Vector table (64 words => 256 bytes natural alignment)
+ */
+ENTRY(vector_table)
+	.long	0			@ 0 - Reset stack pointer
+	.long	__invalid_entry		@ 1 - Reset
+	.long	__invalid_entry		@ 2 - NMI
+	.long	__invalid_entry		@ 3 - HardFault
+	.long	__invalid_entry		@ 4 - MemManage
+	.long	__invalid_entry		@ 5 - BusFault
+	.long	__invalid_entry		@ 6 - UsageFault
+	.long	__invalid_entry		@ 7 - Reserved
+	.long	__invalid_entry		@ 8 - Reserved
+	.long	__invalid_entry		@ 9 - Reserved
+	.long	__invalid_entry		@ 10 - Reserved
+	.long	vector_swi		@ 11 - SVCall
+	.long	__invalid_entry		@ 12 - Debug Monitor
+	.long	__invalid_entry		@ 13 - Reserved
+	.long	__pendsv_entry		@ 14 - PendSV
+	.long	__invalid_entry		@ 15 - SysTick
+	.rept	64 - 16
+	.long	__irq_entry		@ 16..64 - External Interrupts
+	.endr
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 971d65c..ee604dd 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -452,7 +452,11 @@ asm(	".pushsection .text\n"
 #ifdef CONFIG_TRACE_IRQFLAGS
 "	bl	trace_hardirqs_on\n"
 #endif
+#ifdef CONFIG_CPU_V7M
+"	msr	primask, r7\n"
+#else
 "	msr	cpsr_c, r7\n"
+#endif
 "	mov	r0, r4\n"
 "	mov	lr, r6\n"
 "	mov	pc, r5\n"
@@ -491,6 +495,10 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
 	regs.ARM_r7 = SVC_MODE | PSR_ENDSTATE | PSR_ISETSTATE;
 	regs.ARM_pc = (unsigned long)kernel_thread_helper;
 	regs.ARM_cpsr = regs.ARM_r7 | PSR_I_BIT;
+#ifdef CONFIG_CPU_V7M
+	/* Return to Handler mode */
+	regs.ARM_EXC_lr = 0xfffffff1L;
+#endif
 
 	return do_fork(flags|CLONE_VM|CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
 }
-- 
1.7.9
