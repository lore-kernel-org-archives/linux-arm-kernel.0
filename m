From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  5 Mar 2012 18:04:02 +0100
Subject: [PATCH v2 5/5] Cortex-M3: Add support for exception handling
In-Reply-To: <1330967042-25612-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <CAHkRjk70x+Fn+Z4iUxSMc7Zq2cKBo_ka0tNhV0i5JWmEixpRrA@mail.gmail.com>
 <1330967042-25612-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1330967042-25612-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the exception handling for the ARMv7-M
architecture (pretty different from the A or R profiles).

Initially this based on a patch by Catalin Marinas but was completely
reworked to use a pt_regs layout similar to the A profile.

Note this is broken in at least two ways:
 - r0 isn't saved for signal restarting (should be easy)
 - crashes early after reaching userspace.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

To save r0, I'd readd OLD_R0 at the end of pt_regs (plus one buffer word
to get even alignment). Or would that already be unacceptable because
it's an ABI change, too?

Anyhow, this is (once more :-) a great opportunity for you to blame me
in public by pointing out why my machine crashes with this patch. But to
be honest this time I wouldn't mind because hopefully after describing
your findings I'd be able to fix the problem.

Best regards
Uwe

 arch/arm/kernel/entry-common.S |    9 ++-
 arch/arm/kernel/entry-header.S |  149 +++++++++++++++++++++++++++++++++++++++-
 arch/arm/kernel/entry-v7m.S    |  135 ++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/process.c      |    8 ++
 4 files changed, 299 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/kernel/entry-v7m.S

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 9fd0ba9..953e517 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -345,6 +345,9 @@ ENDPROC(ftrace_stub)
 
 	.align	5
 ENTRY(vector_swi)
+#ifdef CONFIG_CPU_V7M
+	v7m_exception_entry
+#else
 	sub	sp, sp, #S_FRAME_SIZE
 	stmia	sp, {r0 - r12}			@ Calling r0 - r12
  ARM(	add	r8, sp, #S_PC		)
@@ -354,7 +357,11 @@ ENTRY(vector_swi)
 	mrs	r8, spsr			@ called from non-FIQ mode, so ok.
 	str	lr, [sp, #S_PC]			@ Save calling PC
 	str	r8, [sp, #S_PSR]		@ Save CPSR
+#endif
+#if XXX
+	/* XXX: fixme: we need to preserve r0 somewhere for signal stuff */
 	str	r0, [sp, #S_OLD_R0]		@ Save OLD_R0
+#endif
 	zero_fp
 
 	/*
@@ -473,7 +480,7 @@ __sys_trace:
 
 	adr	lr, BSYM(__sys_trace_return)	@ return address
 	mov	scno, r0			@ syscall number (possibly new)
-	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
+	add	r1, sp, #S_OFF			@ pointer to regs
 	cmp	scno, #NR_syscalls		@ check upper syscall limit
 	ldmccia	r1, {r0 - r3}			@ have to reload r0 - r3
 	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 9a8531e..6e03c8b 100644
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
 
@@ -44,6 +44,144 @@
 #endif
 	.endm
 
+#ifdef CONFIG_CPU_V7M
+/*
+ * ARMv7-M exception entry/exit macros.
+ *
+ * xPSR, ReturnAddress(), LR (R14), R12, R3, R2, R1, and R0 are
+ * automatically saved on the current stack (32 words) before
+ * switching to the exception stack (SP_main).
+ *
+ * If exception is taken while in user mode, SP_main is
+ * empty. Otherwise, SP_main is aligned to 64 bit automatically
+ * (CCR.STKALIGN set).
+ *
+ * Linux assumes that the interrupts are disabled when entering an
+ * exception handler and it may BUG if this is not the case. Interrupts
+ * are disabled during entry and reenabled in the exit macro.
+ *
+ * v7m_exception_fast_exit is used when returning from interrupts.
+ *
+ * v7m_exception_slow_exit is used when returning from SVC or PendSV.
+ * When returning to kernel mode, we don't return from exception.
+ */
+	.macro	v7m_exception_entry
+	cpsid	i
+	sub	sp, #S_FRAME_SIZE
+	stmia	sp, {r0-r12}
+
+	@ set r0 to the location of the registers saved by the core during
+	@ exception entry. Depending on the mode the cpu was in when the
+	@ exception happend that is either on the main or the process stack.
+	@ Bit 2 of EXC_RETURN stored in the lr register specifies which stack
+	@ was used.
+	tst	lr, #0x4
+	mrsne	r0, psp
+	addeq	r0, sp, #S_FRAME_SIZE
+
+	add	r0, r0, #20		@ skip over r0-r3, r12
+	ldmia	r0!, {r1-r3}		@ load saved lr, return address and xPSR
+
+	@ calculate the orignal stack pointer value.
+	@ r0 currently points to the memory location just above the auto saved
+	@ xPSR. If the FP extension is implemented and bit 4 of EXC_RETURN is 0
+	@ then space was allocated for FP state. That is space for 18 32-bit
+	@ values. (If FP extension is unimplemented, bit 4 is 1.)
+	@ Additionally the cpu might automatically 8-byte align the stack. Bit 9
+	@ of the saved xPSR specifies if stack aligning took place. In this case
+	@ another 32-bit value is included in the stack.
+
+	tst	lr, #0x10
+	addeq	r0, r0, #576
+
+	tst	r3, #0x100
+	addne	r0, r0, #4
+
+	@ save original sp, lr, return address, xPSR and EXC_RETURN
+	add	r12, sp, #52
+	stmia	r12, {r0-r3, lr}
+
+	@ restore registers for system calls
+	ldmia	sp, {r0-r12}
+	.endm
+
+	.macro	v7m_exception_fast_exit
+	@ read r12, sp, lr, return address, xPSR and EXC_RETURN
+	add	r12, sp, #48
+	ldmia	r12, {r1-r5, lr}
+
+	tst     r5, #0x100
+	subne   r2, r2, #4
+
+	tst	lr, #0x10
+	subeq	r2, r2, #576
+
+	stmdb	r2!, {r1, r3-r5}		@ write saved r12, lr, return address and xPSR
+
+	ldmia	sp, {r1, r3-r5}			@ read saved r0-r3
+	stmdb	r2!, {r1, r3-r5}		@ write r0-r3 to basic exception frame
+
+	tst	lr, #0x4
+	msrne	psp, r2
+
+	ldmia	sp, {r0-r12}
+	add	sp, #S_FRAME_SIZE
+	cpsie	i
+	bx	lr
+	.endm
+
+	.macro	v7m_exception_slow_exit ret_r0
+	cpsid	i
+	ldr	lr, [sp, #S_EXCRET]		@ read exception LR
+	tst     lr, #0x8
+	bne	1f				@ go to thread mode using exception return
+
+	/*
+	 * return to kernel thread
+	 * sp is already set up (and might be unset in pt_regs), so only
+	 * restore r0-r12 and pc
+	 */
+	ldmia	sp, {r0-r12}
+	ldr	lr, [sp, #S_PC]
+	add	sp, sp, #S_FRAME_SIZE
+	cpsie	i
+	bx	lr
+
+	/*
+	 * return to userspace
+	 */
+1:
+	@ read original r12, sp, lr, pc, xPSR
+	add	r12, sp, #48
+	ldmia	r12, {r1-r5}
+
+	/* stack aligning */
+	tst	r5, #0x100
+	subne	r2, r2, #4
+
+	/* skip over stack space for fp extension */
+	tst	lr, #0x10
+	subeq	r2, r2, #576
+
+	/* write basic exception frame */
+	stmdb	r2!, {r1, r3-r5}		@ saved r12, lr, return address and xPSR
+	ldmia	sp, {r1, r3-r5}			@ read saved r0-r3
+	.if	\ret_r0
+	stmdb	r2!, {r0, r3-r5}		@ restore r0-r3
+	.else
+	stmdb	r2!, {r1, r3-r5}		@ restore r0-r3
+	.endif
+
+	msr	psp, r2
+
+	ldmia	sp, {r0-r12}			@ restore original r4-r11
+
+	add	sp, #S_FRAME_SIZE		@ restore the original MSP
+	cpsie	i
+	bx	lr
+	.endm
+#endif	/* CONFIG_CPU_V7M */
+
 	@
 	@ Store/load the USER SP and LR registers by switching to the SYS
 	@ mode. Useful in Thumb-2 mode where "stm/ldm rd, {sp, lr}^" is not
@@ -131,6 +269,14 @@
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
@@ -147,6 +293,7 @@
 	add	sp, sp, #S_FRAME_SIZE - S_SP
 	movs	pc, lr				@ return & move spsr_svc into cpsr
 	.endm
+#endif	/* CONFIG_CPU_V7M */
 
 	.macro	get_thread_info, rd
 	mov	\rd, sp
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
new file mode 100644
index 0000000..5bca10b
--- /dev/null
+++ b/arch/arm/kernel/entry-v7m.S
@@ -0,0 +1,135 @@
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
+	mov	r3, sp
+	bl	printk
+	mov	r0, sp
+	bl	__show_regs
+1:	b	1b
+ENDPROC(__invalid_entry)
+
+strerr:	.asciz	"\nUnhandled exception: IPSR = %08lx LR = %08lx SP = %08lx\n"
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
+	ldr	lr, [sp, #S_EXCRET]
+	tst	lr, #0x8		@ check the return stack
+	beq	2f			@ returning to handler mode
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
+	.fnstart
+	.cantunwind
+	add	ip, r1, #TI_CPU_SAVE
+	stmia	ip!, {r4 - r11}		@ Store most regs on stack
+	str	sp, [ip], #4
+	str	lr, [ip], #4
+	mov	r5, r0
+	add	r4, r2, #TI_CPU_SAVE
+	ldr	r0, =thread_notify_head
+	mov	r1, #THREAD_NOTIFY_SWITCH
+	bl	atomic_notifier_call_chain
+	mov	ip, r4
+	mov	r0, r5
+	ldmia	ip!, {r4 - r11}		@ Load all regs saved previously
+	ldr	sp, [ip], #4
+	ldr	pc, [ip]
+	.fnend
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
index 971d65c..bdccb8f 100644
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
+	regs.ARM_EXCRET = 0xfffffff1L;
+#endif
 
 	return do_fork(flags|CLONE_VM|CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
 }
-- 
1.7.9.1
