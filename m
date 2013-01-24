From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 24 Jan 2013 18:21:17 +0000
Subject: [PATCH v8 3/3] Cortex-M3: Add support for exception handling
In-Reply-To: <1358413196-5609-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1358413196-5609-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1358413196-5609-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <51017B9D.8070801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Here's the next bunch of comments on this series...

This patch, like the other one, introduces another lot of magic 
constants that I'd really rather have #defined as it is much cleaner to 
read.

Culprits for this are things in the 0xe000XXXX range, as well as 
bitmasks for certain parts of special registers.

Do we need something like arch/arm/include/asm/cp15.h for M?

The second major comment that arises from this patch is that the FP 
stuff looks untested/incomplete for M. I would prefer that there was no 
FP stuff (for example in this patch the optional skipping of the extra 
space in the FP stack-frame) and we added something later. For example, 
I imagine that when we come to implement FP for v7-M we might well find 
we don't want to use the larger stack-frame every anyway!

These comments, as well as a few related to the idea from the previous 
patch of deriving EXC_RETURN rather than storing it in pt_regs.

The final thing that I would like to think a bit more about is whether 
we can align our fast and slow exception exits better with what happens 
for A-class. At the moment we're quite different (and for good reason, 
too), but is there a way to map the M-case more closely on to the 
existing code?

On 17/01/13 08:59, Uwe Kleine-K?nig wrote:
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
>   arch/arm/kernel/entry-common.S |    4 ++
>   arch/arm/kernel/entry-header.S |  148 ++++++++++++++++++++++++++++++++++++++++
>   arch/arm/kernel/entry-v7m.S    |  134 ++++++++++++++++++++++++++++++++++++
>   arch/arm/kernel/process.c      |    4 ++
>   arch/arm/kernel/ptrace.c       |    3 +
>   5 files changed, 293 insertions(+)
>   create mode 100644 arch/arm/kernel/entry-v7m.S
>
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 3471175..48d8dc0 100644
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
> index 9a8531e..33d9900 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -44,6 +44,145 @@
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
> + * v7m_exception_fast_exit is used when returning from interrupts.
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
> +	tst	lr, #0x4
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
> +	@ xPSR. If the FP extension is implemented and bit 4 of EXC_RETURN is 0
> +	@ then space was allocated for FP state. That is space for 18 32-bit
> +	@ values. (If FP extension is unimplemented, bit 4 is 1.)
> +	@ Additionally the cpu might automatically 8-byte align the stack. Bit 9
> +	@ of the saved xPSR specifies if stack aligning took place. In this case
> +	@ another 32-bit value is included in the stack.
> +
> +	tst	lr, #0x10

Can we name these constants please as the bitmasks are architecturally 
defined. I think if we name the constants the code is more 'self 
documenting' ;)

> +	addeq	r9, r9, #576

Okay, this looks weird, and I don't think it gets tested in the code 
path for efm32 as there's not FP support there, correct?

Do we want to add 576 to r9? It looks more like we should be adding 
4*18, not 32*18...

I think I probably don't need to go on about them in this patch too, but 
this is another bit of magic that I'd like to see #defined. If this was

32*FP_STACK_SIZE

then this would be clearer.

> +
> +	tst	r12, 0x100
> +	addne	r9, r9, #4
> +
> +	@ store saved r12 using str to have a register to hold the base for stm
> +	str	r8, [sp, #S_IP]
> +	add	r8, sp, #S_SP
> +	@ store r13-r15, xPSR
> +	stmia	r8!, {r9-r12}
> +	@ store r0 once more and EXC_RETURN
> +	stmia	r8, {r0, lr}
> +	.endm
> +
> +	.macro	v7m_exception_fast_exit
> +	@ registers r0-r3 and r12 are automatically restored on exception
> +	@ return. r4-r7 were not clobbered in v7m_exception_entry so for
> +	@ correctness they don't need to be restored. So only r8-r11 must be
> +	@ restored here. The easiest way to do so is to restore r0-r7, too.
> +	ldmia	sp!, {r0-r11}
> +	add	sp, #S_FRAME_SIZE-S_IP
> +	cpsie	i
> +	bx	lr
> +	.endm

We don't set lr here - we seem to rely on whatever is calling 
v7m_fast_exit to do that.

Is that safe? So far it works because we only do a fast exit from a few 
locations, but as the port grows I worry about that being always true...

Secondly, I think we need a clrex somewhere in this path:

The ARM ARM states that if a strex is performed to any address other 
than the last one from which a ldrex was done AND the exclusive monitor 
is exclusive access state then it is implementation defined whether the 
store succeeds. In ARMv7-M this must be treated as a programming error.

I think without a clrex here we can provoke this:

        (A)        (b)
        ...        ...
     ldrex(a)
        ...
-------context switch--------
                  ...
                ldrex(b)
                  ...
-------context switch--------
     strex(a)


And I believe the same is required in the slow path, as this could be 
required after returning from a pend_sv or even when switching between 
kernel threads if we've got a pre-emptable kernel

And that leads me to think perhaps we should have some unified part of 
the exception return path?

> +
> +	.macro	v7m_exception_slow_exit ret_r0
> +	cpsid	i
> +	ldr	lr, [sp, #S_EXC_RET]	@ read exception LR0.11.22

So, if we chose to remove ARM_EXC_RET from pt_regs we could instead load 
S_PSR, and check if the IPSR part of this is zero to decide whether 
we're going back to handler or thread mode. Put the appropriate EXC_RET 
in to lr and carry on as usual...

(typed in editor/intended for explanation not compilation)
ldr	lr, [sp, #S_PSR]
ands	lr, lr, #IPSR_MASK
ldreq	lr, #ER_THREAD_PROCESS_BASIC
ldrne	lr, #ER_THREAD_HANDLER_BASIC

Where IPSR_MASK is 0x1FF (bits 0-8 of the xPSR)

> +	tst     lr, #0x8
> +	bne	1f			@ go to thread mode using exception return
> +
> +	/*
> +	 * return to kernel thread
> +	 * sp is already set up (and might be unset in pt_regs), so only
> +	 * restore r0-r12 and pc
> +	 */
> +	ldmia	sp, {r0-r12}
> +	ldr	lr, [sp, #S_PC]
> +	add	sp, sp, #S_FRAME_SIZE
> +	cpsie	i

As I mentioned above, this path needs a clrex too (or we should have 
some unified return path with a clrex)

> +	bx	lr
> +
> +1:	/*
> +	 * return to userspace
> +	 */
> +
> +	@ read original r12, sp, lr, pc and xPSR
> +	add	r12, sp, #S_IP
> +	ldmia	r12, {r1-r5}
> +
> +	@ handle stack aligning
> +	tst	r5, #0x100
> +	subne	r2, r2, #4
> +
> +	@ skip over stack space for fp saving
> +	tst	lr, #0x10
> +	subeq	r2, r2, #576
> +

This is another bit/byte error, I presume?

We could simplify this code quite a lot by enforcing that we only ever 
use the standard (basic) exception frame size...

Given the extra overhead of saving all the FP registers, what do you 
think about doing that in a lazy fashion, a bit like we do for A-class.

This way we could always disable FP on return to userspace, and we'd not 
need to worry about the different size frames?

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

The comment and the code don't match here.

Didn't we just set up a stack frame so that the hardware would restore 
r0-r3 for us? I guess perhaps you're doing this to save an instruction 
but I had a quick chat with the hardware guys and they reckon that we're 
better to fix up sp with an add first, then ldmia fewer registers.

Is there something I'm missing about why you're written back r0-r3 too?

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
> @@ -131,6 +270,14 @@
>   	rfeia	sp!
>   	.endm
>
> +#ifdef CONFIG_CPU_V7M
> +	.macro	restore_user_regs, fast = 0, offset = 0
> +	.if	\offset
> +	add	sp, #\offset
> +	.endif
> +	v7m_exception_slow_exit ret_r0 = \fast
> +	.endm
> +#else	/* !CONFIG_CPU_V7M */
>   	.macro	restore_user_regs, fast = 0, offset = 0
>   	clrex					@ clear the exclusive monitor
>   	mov	r2, sp
> @@ -147,6 +294,7 @@
>   	add	sp, sp, #S_FRAME_SIZE - S_SP
>   	movs	pc, lr				@ return & move spsr_svc into cpsr
>   	.endm
> +#endif	/* CONFIG_CPU_V7M */
>
>   	.macro	get_thread_info, rd
>   	mov	\rd, sp
> diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
> new file mode 100644
> index 0000000..842394c
> --- /dev/null
> +++ b/arch/arm/kernel/entry-v7m.S
> @@ -0,0 +1,134 @@
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
> +
> +#include <mach/entry-macro.S>
> +
> +#include "entry-header.S"
> +
> +#ifdef CONFIG_PREEMPT
> +#error "CONFIG_PREEMPT not supported on the current ARMv7M implementation"
> +#endif
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
> +	and	r0, #0xff
> +	sub	r0, #16			@ IRQ number
> +	mov	r1, sp
> +	@ routine called with r0 = irq number, r1 = struct pt_regs *
> +	bl	asm_do_IRQ
> +
> +	@
> +	@ Check for any pending work if returning to user
> +	@
> +	ldr	lr, [sp, #S_EXC_RET]

Same kind of change as I describe above might work here, too.

It also struck me as a bit weird that we do this in the __irq_entry 
*not* in the fast exit path. What's the reasoning behind that. I know at 
the moment that the only user of the fast_exit is the irq handler, but 
is that always going to be true?


> +	tst	lr, #0x8		@ check the return stack
> +	beq	2f			@ returning to handler mode
> +	get_thread_info tsk
> +	ldr	r1, [tsk, #TI_FLAGS]
> +	tst	r1, #_TIF_WORK_MASK
> +	beq	2f			@ no work pending
> +	ldr	r1, =0xe000ed04		@ ICSR
> +	mov	r0, #1 << 28		@ ICSR.PENDSVSET
> +	str	r0, [r1]		@ raise PendSV
> +
> +2:
> +	v7m_exception_fast_exit

At the moment this is the only place that we use fast_exit, and I wonder 
if there is scope to inline *some* of fast_exit here and split the rest 
of it off in to a common exit path.

For example

fast_exit becomes
* new stuff at the end of __irq_entry
* common_exit

slow_exit becomes
* slow_exit
* common_exit

But if you have plans to use v7m_exception_fast_exit more broadly in the 
future then disregard this...

> +ENDPROC(__irq_entry)
> +
> +__pendsv_entry:
> +	v7m_exception_entry
> +
> +	ldr	r1, =0xe000ed04		@ ICSR
> +	mov	r0, #1 << 27		@ ICSR.PENDSVCLR
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

Out of curiosity, why ip here not r12 as later in the code?

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
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 90084a6..3d745d4 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -387,6 +387,10 @@ copy_thread(unsigned long clone_flags, unsigned long stack_start,
>   		*childregs = *regs;
>   		childregs->ARM_r0 = 0;
>   		childregs->ARM_sp = stack_start;
> +#if defined CONFIG_CPU_V7M
> +		/* Return to Thread mode with Process stack */
> +		childregs->ARM_EXC_RET = 0xfffffffdUL;
> +#endif

Another justification for deriving this instead of 
saving/storing/copying it - we could remove another #ifdef block.

>   	} else {
>   		memset(childregs, 0, sizeof(struct pt_regs));
>   		thread->cpu_context.r4 = stk_sz;
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index 739db3a..55df1d5 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -87,6 +87,9 @@ static const struct pt_regs_offset regoffset_table[] = {
>   	REG_OFFSET_NAME(pc),
>   	REG_OFFSET_NAME(cpsr),
>   	REG_OFFSET_NAME(ORIG_r0),
> +#ifdef CONFIG_CPU_V7M
> +	REG_OFFSET_NAME(EXC_RET),
> +#endif
>   	REG_OFFSET_END,
>   };
>
>

Hope you find these comments useful!

Jonny
