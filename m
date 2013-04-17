From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Apr 2013 18:14:58 +0200
Subject: [PATCH v11 2/3] ARM: ARMv7-M: Add support for exception handling
In-Reply-To: <1366215299-31969-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1366215299-31969-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1366215299-31969-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the exception handling for the ARMv7-M
architecture (pretty different from the A or R profiles).

It bases on work done earlier by Catalin for 2.6.33 but was nearly
completely rewritten to use a pt_regs layout compatible to the A
profile.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---

Notes:
    Changes since v9, sent with
    Message-id:1363901310-9474-3-git-send-email-u.kleine-koenig at pengutronix.de:
    
     - s/V7M_xPSR_FPALIGN/V7M_xPSR_FRAMEPTRALIGN/
     - expand comments
     - drop XXX item about clrex
     - make 0x1ff a #define
     - followup changes for changes in previous
    
    Changes since v10, sent with
    Message-id:1364381692-7955-3-git-send-email-u.kleine-koenig at pengutronix.de:
    
     - Adaptions for changes in the irq-nvic driver

 arch/arm/kernel/entry-common.S |   4 ++
 arch/arm/kernel/entry-header.S | 124 +++++++++++++++++++++++++++++++++++
 arch/arm/kernel/entry-v7m.S    | 143 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+)
 create mode 100644 arch/arm/kernel/entry-v7m.S

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 3248cde..c45e002 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -339,6 +339,9 @@ ENDPROC(ftrace_stub)
 
 	.align	5
 ENTRY(vector_swi)
+#ifdef CONFIG_CPU_V7M
+	v7m_exception_entry
+#else
 	sub	sp, sp, #S_FRAME_SIZE
 	stmia	sp, {r0 - r12}			@ Calling r0 - r12
  ARM(	add	r8, sp, #S_PC		)
@@ -349,6 +352,7 @@ ENTRY(vector_swi)
 	str	lr, [sp, #S_PC]			@ Save calling PC
 	str	r8, [sp, #S_PSR]		@ Save CPSR
 	str	r0, [sp, #S_OLD_R0]		@ Save OLD_R0
+#endif
 	zero_fp
 
 	/*
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 9a8531e..b02e139 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -5,6 +5,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/errno.h>
 #include <asm/thread_info.h>
+#include <asm/v7m.h>
 
 @ Bad Abort numbers
 @ -----------------
@@ -44,6 +45,116 @@
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
+ * v7m_exception_slow_exit is used when returning from SVC or PendSV.
+ * When returning to kernel mode, we don't return from exception.
+ */
+	.macro	v7m_exception_entry
+	@ determine the location of the registers saved by the core during
+	@ exception entry. Depending on the mode the cpu was in when the
+	@ exception happend that is either on the main or the process stack.
+	@ Bit 2 of EXC_RETURN stored in the lr register specifies which stack
+	@ was used.
+	tst	lr, #EXC_RET_STACK_MASK
+	mrsne	r12, psp
+	moveq	r12, sp
+
+	@ we cannot rely on r0-r3 and r12 matching the value saved in the
+	@ exception frame because of tail-chaining. So these have to be
+	@ reloaded.
+	ldmia	r12!, {r0-r3}
+
+	@ Linux expects to have irqs off. Do it here before taking stack space
+	cpsid	i
+
+	sub	sp, #S_FRAME_SIZE-S_IP
+	stmdb	sp!, {r0-r11}
+
+	@ load saved r12, lr, return address and xPSR.
+	@ r0-r7 are used for signals and never touched from now on. Clobbering
+	@ r8-r12 is OK.
+	mov	r9, r12
+	ldmia	r9!, {r8, r10-r12}
+
+	@ calculate the original stack pointer value.
+	@ r9 currently points to the memory location just above the auto saved
+	@ xPSR.
+	@ The cpu might automatically 8-byte align the stack. Bit 9
+	@ of the saved xPSR specifies if stack aligning took place. In this case
+	@ another 32-bit value is included in the stack.
+
+	tst	r12, V7M_xPSR_FRAMEPTRALIGN
+	addne	r9, r9, #4
+
+	@ store saved r12 using str to have a register to hold the base for stm
+	str	r8, [sp, #S_IP]
+	add	r8, sp, #S_SP
+	@ store r13-r15, xPSR
+	stmia	r8!, {r9-r12}
+	@ store old_r0
+	str	r0, [r8]
+	.endm
+
+        /*
+	 * PENDSV and SVCALL are configured to have the same exception
+	 * priorities. As a kernel thread runs at SVCALL execution priority it
+	 * can never be preempted and so we will never have to return to a
+	 * kernel thread here.
+         */
+	.macro	v7m_exception_slow_exit ret_r0
+	cpsid	i
+	ldr	lr, =EXC_RET_THREADMODE_PROCESSSTACK
+
+	@ read original r12, sp, lr, pc and xPSR
+	add	r12, sp, #S_IP
+	ldmia	r12, {r1-r5}
+
+	@ an exception frame is always 8-byte aligned. To tell the hardware if
+	@ the sp to be restored is aligned or not set bit 9 of the saved xPSR
+	@ accordingly.
+	tst	r2, #4
+	subne	r2, r2, #4
+	orrne	r5, V7M_xPSR_FRAMEPTRALIGN
+	biceq	r5, V7M_xPSR_FRAMEPTRALIGN
+
+	@ write basic exception frame
+	stmdb	r2!, {r1, r3-r5}
+	ldmia	sp, {r1, r3-r5}
+	.if	\ret_r0
+	stmdb	r2!, {r0, r3-r5}
+	.else
+	stmdb	r2!, {r1, r3-r5}
+	.endif
+
+	@ restore process sp
+	msr	psp, r2
+
+	@ restore original r4-r11
+	ldmia	sp!, {r0-r11}
+
+	@ restore main sp
+	add	sp, sp, #S_FRAME_SIZE-S_IP
+
+	cpsie	i
+	bx	lr
+	.endm
+#endif	/* CONFIG_CPU_V7M */
+
 	@
 	@ Store/load the USER SP and LR registers by switching to the SYS
 	@ mode. Useful in Thumb-2 mode where "stm/ldm rd, {sp, lr}^" is not
@@ -131,6 +242,18 @@
 	rfeia	sp!
 	.endm
 
+#ifdef CONFIG_CPU_V7M
+	/*
+	 * Note we don't need to do clrex here as clearing the local monitor is
+	 * part of each exception entry and exit sequence.
+	 */
+	.macro	restore_user_regs, fast = 0, offset = 0
+	.if	\offset
+	add	sp, #\offset
+	.endif
+	v7m_exception_slow_exit ret_r0 = \fast
+	.endm
+#else	/* ifdef CONFIG_CPU_V7M */
 	.macro	restore_user_regs, fast = 0, offset = 0
 	clrex					@ clear the exclusive monitor
 	mov	r2, sp
@@ -147,6 +270,7 @@
 	add	sp, sp, #S_FRAME_SIZE - S_SP
 	movs	pc, lr				@ return & move spsr_svc into cpsr
 	.endm
+#endif	/* ifdef CONFIG_CPU_V7M / else */
 
 	.macro	get_thread_info, rd
 	mov	\rd, sp
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
new file mode 100644
index 0000000..e00621f
--- /dev/null
+++ b/arch/arm/kernel/entry-v7m.S
@@ -0,0 +1,143 @@
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
+#include <asm/v7m.h>
+
+#include <mach/entry-macro.S>
+
+#include "entry-header.S"
+
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
+	ldr	r1, =V7M_xPSR_EXCEPTIONNO
+	and	r0, r1
+	sub	r0, #16
+	mov	r1, sp
+	stmdb	sp!, {lr}
+	@ routine called with r0 = irq number, r1 = struct pt_regs *
+	bl	nvic_do_IRQ
+
+	pop	{lr}
+	@
+	@ Check for any pending work if returning to user
+	@
+	ldr	r1, =BASEADDR_V7M_SCB
+	ldr	r0, [r1, V7M_SCB_ICSR]
+	tst	r0, V7M_SCB_ICSR_RETTOBASE
+	beq	2f
+
+	get_thread_info tsk
+	ldr	r2, [tsk, #TI_FLAGS]
+	tst	r2, #_TIF_WORK_MASK
+	beq	2f			@ no work pending
+	mov	r0, #V7M_SCB_ICSR_PENDSVSET
+	str	r0, [r1, V7M_SCB_ICSR]	@ raise PendSV
+
+2:
+	@ registers r0-r3 and r12 are automatically restored on exception
+	@ return. r4-r7 were not clobbered in v7m_exception_entry so for
+	@ correctness they don't need to be restored. So only r8-r11 must be
+	@ restored here. The easiest way to do so is to restore r0-r7, too.
+	ldmia	sp!, {r0-r11}
+	add	sp, #S_FRAME_SIZE-S_IP
+	cpsie	i
+	bx	lr
+ENDPROC(__irq_entry)
+
+__pendsv_entry:
+	v7m_exception_entry
+
+	ldr	r1, =BASEADDR_V7M_SCB
+	mov	r0, #V7M_SCB_ICSR_PENDSVCLR
+	str	r0, [r1, V7M_SCB_ICSR]	@ clear PendSV
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
+	ldr	sp, [ip]
+	ldr	pc, [ip, #4]!
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
-- 
1.8.2.rc3
