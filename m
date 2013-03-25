From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 25 Mar 2013 18:50:43 +0000
Subject: [PATCH v9 2/3] ARM: ARMv7-M: Add support for exception handling
In-Reply-To: <1363901310-9474-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1363901310-9474-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1363901310-9474-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <51509C83.5000907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again Uwe,

On 21/03/13 21:28, Uwe Kleine-K?nig wrote:
> This patch implements the exception handling for the ARMv7-M
> architecture (pretty different from the A or R profiles).
>
> It bases on work done earlier by Catalin for 2.6.33 but was nearly
> completely rewritten to use a pt_regs layout compatible to the A
> profile.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Note there is one open issue in this patch that Jonny raised. He
> wondered if we need a clrex in the return path to user space. I'm not
> sure it's needed as in ARMv7-M, the local monitor is changed to Open
> Access automatically as part of an exception entry or exit sequence.
> For now I think it's not critical and can be addressed later.
>

I'd rather just be sure now what the situation is :)

Before we had three possible return paths, and one didn't have a 'real' 
exception return.

In your latest patches, we always have a proper 'exception return' 
before returning to userspace, so the case I was describing won't arise. 
As you note, A3.4.4 in the V7M ARMARM promises us that the monitor will 
be changed to Open Access by exception entry and exit.

So, I believe we don't need an explicit clrex in the exception return path.

> Changes since v8, sent with
> Message-id: <1358413196-5609-4-git-send-email-u.kleine-koenig@pengutronix.de>:
>
>   - inline v7m_exception_fast_exit
>   - use more symbolic names
>   - use ICSR.RETTOBASE instead of EXC_RET & 8 to determine return mode
>   - don't save EXC_RET to into pt_regs
>   - drop handling of FP extention
> ---
>   arch/arm/kernel/entry-common.S |   4 ++
>   arch/arm/kernel/entry-header.S | 120 ++++++++++++++++++++++++++++++++++
>   arch/arm/kernel/entry-v7m.S    | 142 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 266 insertions(+)
>   create mode 100644 arch/arm/kernel/entry-v7m.S
>
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 3248cde..c45e002 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -339,6 +339,9 @@ ENDPROC(ftrace_stub)
>
>   	.align	5
>   ENTRY(vector_swi)
> +#ifdef CONFIG_CPU_V7M
> +	v7m_exception_entry
> +#else
>   	sub	sp, sp, #S_FRAME_SIZE
>   	stmia	sp, {r0 - r12}			@ Calling r0 - r12
>    ARM(	add	r8, sp, #S_PC		)
> @@ -349,6 +352,7 @@ ENTRY(vector_swi)
>   	str	lr, [sp, #S_PC]			@ Save calling PC
>   	str	r8, [sp, #S_PSR]		@ Save CPSR
>   	str	r0, [sp, #S_OLD_R0]		@ Save OLD_R0
> +#endif
>   	zero_fp
>
>   	/*
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index 9a8531e..4caccb4 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -5,6 +5,7 @@
>   #include <asm/asm-offsets.h>
>   #include <asm/errno.h>
>   #include <asm/thread_info.h>
> +#include <asm/v7m.h>
>
>   @ Bad Abort numbers
>   @ -----------------
> @@ -44,6 +45,115 @@
>   #endif
>   	.endm
>
> +#ifdef CONFIG_CPU_V7M
> +/*
> + * ARMv7-M exception entry/exit macros.
> + *
> + * xPSR, ReturnAddress(), LR (R14), R12, R3, R2, R1, and R0 are
> + * automatically saved on the current stack (32 words) before
> + * switching to the exception stack (SP_main).
> + *
> + * If exception is taken while in user mode, SP_main is
> + * empty. Otherwise, SP_main is aligned to 64 bit automatically
> + * (CCR.STKALIGN set).
> + *
> + * Linux assumes that the interrupts are disabled when entering an
> + * exception handler and it may BUG if this is not the case. Interrupts
> + * are disabled during entry and reenabled in the exit macro.
> + *
> + * v7m_exception_slow_exit is used when returning from SVC or PendSV.
> + * When returning to kernel mode, we don't return from exception.
> + */
> +	.macro	v7m_exception_entry
> +	@ determine the location of the registers saved by the core during
> +	@ exception entry. Depending on the mode the cpu was in when the
> +	@ exception happend that is either on the main or the process stack.
> +	@ Bit 2 of EXC_RETURN stored in the lr register specifies which stack
> +	@ was used.
> +	tst	lr, #EXC_RET_STACK_MASK
> +	mrsne	r12, psp
> +	moveq	r12, sp
> +
> +	@ we cannot rely on r0-r3 and r12 matching the value saved in the
> +	@ exception frame because of tail-chaining. So these have to be
> +	@ reloaded.
> +	ldmia	r12!, {r0-r3}
> +
> +	@ Linux expects to have irqs off. Do it here before taking stack space
> +	cpsid	i
> +
> +	sub	sp, #S_FRAME_SIZE-S_IP
> +	stmdb	sp!, {r0-r11}
> +
> +	@ load saved r12, lr, return address and xPSR.
> +	@ r0-r7 are used for signals and never touched from now on. Clobbering
> +	@ r8-r12 is OK.
> +	mov	r9, r12
> +	ldmia	r9!, {r8, r10-r12}
> +
> +	@ calculate the original stack pointer value.
> +	@ r9 currently points to the memory location just above the auto saved
> +	@ xPSR.
> +	@ The cpu might automatically 8-byte align the stack. Bit 9
> +	@ of the saved xPSR specifies if stack aligning took place. In this case
> +	@ another 32-bit value is included in the stack.
> +
> +	tst	r12, V7M_xPSR_FPALIGN

Minor nit, but we should explain the relationship to FP and bit 9 of the 
xPSR if we're going to call it this... (see B1.5.7 --Note--)

Otherwise the casual reader is confused by why FP suddenly ended up in 
here :)

> +	addne	r9, r9, #4
> +
> +	@ store saved r12 using str to have a register to hold the base for stm
> +	str	r8, [sp, #S_IP]
> +	add	r8, sp, #S_SP
> +	@ store r13-r15, xPSR
> +	stmia	r8!, {r9-r12}
> +	@ store old_r0
> +	str	r0, [r8]
> +	.endm
> +
> +
> +/*
> + * We won't return to kernel space here because a kernel thread runs in SVCALL
> + * context and so cannot be preempted by PENDSV.
> + */

The reason we can't return to kernel space isn't the context we're in, 
but rather the priority we set for the exceptions... (both at the same 
priority => can't preempt each other)

> +	.macro	v7m_exception_slow_exit ret_r0
> +	cpsid	i
> +	ldr	lr, =EXC_RET_THREADMODE_PROCESSSTACK
> +
> +	@ read original r12, sp, lr, pc and xPSR
> +	add	r12, sp, #S_IP
> +	ldmia	r12, {r1-r5}
> +
> +	@ an exception frame is always 8-byte aligned. To tell the hardware if
> +	@ the sp to be restored is aligned or not set bit 9 of the saved xPSR
> +	@ accordingly.

Does this comment make sense? I can't make much of it, because it says 
that the exception frame is always 8-byte aligned by then checks to see 
if it is...

> +	tst	r2, #4
> +	subne	r2, r2, #4
> +	orrne	r5, V7M_xPSR_FPALIGN
> +	biceq	r5, V7M_xPSR_FPALIGN
> +

As we've discussed a bit already on IRC, I don't think we need to test 
the stack pointer here and modify r5, we should be able to use the saved 
xPSR value. This is a pretty hot path and I think we're better tp have 
fewer instructions!

As far as I can see, if sp's alignment here is different to what it was 
when we took the exception, we either have a bug (some code hasn't 
respected the stack), or someone's interfered externally and is about to 
cause a bug.

What use cases do you think we are adding this test for? If it is just 
people manually modifying sp with debuggers then I'd really rather not 
have it.

> +	@ write basic exception frame
> +	stmdb	r2!, {r1, r3-r5}
> +	ldmia	sp, {r1, r3-r5}
> +	.if	\ret_r0
> +	stmdb	r2!, {r0, r3-r5}
> +	.else
> +	stmdb	r2!, {r1, r3-r5}
> +	.endif
> +
> +	@ restore process sp
> +	msr	psp, r2
> +
> +	@ restore original r4-r11
> +	ldmia	sp!, {r0-r11}
> +
> +	@ restore main sp
> +	add	sp, sp, #S_FRAME_SIZE-S_IP
> +
> +	cpsie	i
> +	bx	lr
> +	.endm
> +#endif	/* CONFIG_CPU_V7M */
> +
>   	@
>   	@ Store/load the USER SP and LR registers by switching to the SYS
>   	@ mode. Useful in Thumb-2 mode where "stm/ldm rd, {sp, lr}^" is not
> @@ -131,6 +241,15 @@
>   	rfeia	sp!
>   	.endm
>
> +#ifdef CONFIG_CPU_V7M
> +	.macro	restore_user_regs, fast = 0, offset = 0
> +	@ XXX: clrex?

As we've discussed, above, I don't think this is required... It is also 
fine to have it, but definitely remove the @XXX before putting in next.

Also perhaps replace this XXX comment with one explaining that exception 
return guarantees the monitor is cleared? Otherwise someone reading the 
code and comparing V7M with V7 might wonder where the clrex went.

> +	.if	\offset
> +	add	sp, #\offset
> +	.endif
> +	v7m_exception_slow_exit ret_r0 = \fast
> +	.endm
> +#else	/* ifdef CONFIG_CPU_V7M */
>   	.macro	restore_user_regs, fast = 0, offset = 0
>   	clrex					@ clear the exclusive monitor
>   	mov	r2, sp
> @@ -147,6 +266,7 @@
>   	add	sp, sp, #S_FRAME_SIZE - S_SP
>   	movs	pc, lr				@ return & move spsr_svc into cpsr
>   	.endm
> +#endif	/* ifdef CONFIG_CPU_V7M / else */
>
>   	.macro	get_thread_info, rd
>   	mov	\rd, sp
> diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
> new file mode 100644
> index 0000000..9518c96
> --- /dev/null
> +++ b/arch/arm/kernel/entry-v7m.S
> @@ -0,0 +1,142 @@
> +/*
> + * linux/arch/arm/kernel/entry-v7m.S
> + *
> + * Copyright (C) 2008 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Low-level vector interface routines for the ARMv7-M architecture
> + */
> +#include <asm/memory.h>
> +#include <asm/glue.h>
> +#include <asm/thread_notify.h>
> +#include <asm/v7m.h>
> +
> +#include <mach/entry-macro.S>
> +
> +#include "entry-header.S"
> +
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +#error "CONFIG_TRACE_IRQFLAGS not supported on the current ARMv7M implementation"
> +#endif
> +
> +__invalid_entry:
> +	v7m_exception_entry
> +	adr	r0, strerr
> +	mrs	r1, ipsr
> +	mov	r2, lr
> +	bl	printk
> +	mov	r0, sp
> +	bl	show_regs
> +1:	b	1b
> +ENDPROC(__invalid_entry)
> +
> +strerr:	.asciz	"\nUnhandled exception: IPSR = %08lx LR = %08lx\n"
> +
> +	.align	2
> +__irq_entry:
> +	v7m_exception_entry
> +
> +	@
> +	@ Invoke the IRQ handler
> +	@
> +	mrs	r0, ipsr
> +	ldr	r1, =0x1ff

Did this mask not get defined in v7m.h for a reason?

> +	and	r0, r1
> +	mov	r1, sp
> +	stmdb	sp!, {lr}
> +	@ routine called with r0 = irq number, r1 = struct pt_regs *
> +	bl	asm_do_IRQ
> +
> +	pop	{lr}
> +	@
> +	@ Check for any pending work if returning to user
> +	@
> +	ldr	r1, =V7M_SCS_ICSR
> +	ldr	r0, [r1]
> +	tst	r0, V7M_SCS_ICSR_RETTOBASE
> +	beq	2f
> +
> +	get_thread_info tsk
> +	ldr	r2, [tsk, #TI_FLAGS]
> +	tst	r2, #_TIF_WORK_MASK
> +	beq	2f			@ no work pending
> +	mov	r0, #V7M_SCS_ICSR_PENDSVSET
> +	str	r0, [r1]		@ raise PendSV
> +
> +2:
> +	@ registers r0-r3 and r12 are automatically restored on exception
> +	@ return. r4-r7 were not clobbered in v7m_exception_entry so for
> +	@ correctness they don't need to be restored. So only r8-r11 must be
> +	@ restored here. The easiest way to do so is to restore r0-r7, too.
> +	ldmia	sp!, {r0-r11}
> +	add	sp, #S_FRAME_SIZE-S_IP
> +	cpsie	i
> +	bx	lr
> +ENDPROC(__irq_entry)
> +
> +__pendsv_entry:
> +	v7m_exception_entry
> +
> +	ldr	r1, =V7M_SCS_ICSR
> +	mov	r0, #V7M_SCS_ICSR_PENDSVCLR
> +	str	r0, [r1]		@ clear PendSV
> +
> +	@ execute the pending work, including reschedule
> +	get_thread_info tsk
> +	mov	why, #0
> +	b	ret_to_user
> +ENDPROC(__pendsv_entry)
> +
> +/*
> + * Register switch for ARMv7-M processors.
> + * r0 = previous task_struct, r1 = previous thread_info, r2 = next thread_info
> + * previous and next are guaranteed not to be the same.
> + */
> +ENTRY(__switch_to)
> +	.fnstart
> +	.cantunwind
> +	add	ip, r1, #TI_CPU_SAVE
> +	stmia	ip!, {r4 - r11}		@ Store most regs on stack
> +	str	sp, [ip], #4
> +	str	lr, [ip], #4
> +	mov	r5, r0
> +	add	r4, r2, #TI_CPU_SAVE
> +	ldr	r0, =thread_notify_head
> +	mov	r1, #THREAD_NOTIFY_SWITCH
> +	bl	atomic_notifier_call_chain
> +	mov	ip, r4
> +	mov	r0, r5
> +	ldmia	ip!, {r4 - r11}		@ Load all regs saved previously
> +	ldr	sp, [ip]
> +	ldr	pc, [ip, #4]!
> +	.fnend
> +ENDPROC(__switch_to)
> +
> +	.data
> +	.align	8
> +/*
> + * Vector table (64 words => 256 bytes natural alignment)
> + */
> +ENTRY(vector_table)
> +	.long	0			@ 0 - Reset stack pointer
> +	.long	__invalid_entry		@ 1 - Reset
> +	.long	__invalid_entry		@ 2 - NMI
> +	.long	__invalid_entry		@ 3 - HardFault
> +	.long	__invalid_entry		@ 4 - MemManage
> +	.long	__invalid_entry		@ 5 - BusFault
> +	.long	__invalid_entry		@ 6 - UsageFault
> +	.long	__invalid_entry		@ 7 - Reserved
> +	.long	__invalid_entry		@ 8 - Reserved
> +	.long	__invalid_entry		@ 9 - Reserved
> +	.long	__invalid_entry		@ 10 - Reserved
> +	.long	vector_swi		@ 11 - SVCall
> +	.long	__invalid_entry		@ 12 - Debug Monitor
> +	.long	__invalid_entry		@ 13 - Reserved
> +	.long	__pendsv_entry		@ 14 - PendSV
> +	.long	__invalid_entry		@ 15 - SysTick
> +	.rept	64 - 16
> +	.long	__irq_entry		@ 16..64 - External Interrupts
> +	.endr
>

Thanks,

Jonny
