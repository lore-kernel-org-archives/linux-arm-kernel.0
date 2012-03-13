From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 13 Mar 2012 21:39:30 +0100
Subject: [PATCH v2 5/5] Cortex-M3: Add support for exception handling
In-Reply-To: <20120309171026.GF14148@arm.com>
References: <CAHkRjk70x+Fn+Z4iUxSMc7Zq2cKBo_ka0tNhV0i5JWmEixpRrA@mail.gmail.com>
 <1330967042-25612-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1330967042-25612-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120309171026.GF14148@arm.com>
Message-ID: <20120313203930.GD10400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

On Fri, Mar 09, 2012 at 05:10:26PM +0000, Catalin Marinas wrote:
> On Mon, Mar 05, 2012 at 05:04:02PM +0000, Uwe Kleine-K?nig wrote:
> > To save r0, I'd readd OLD_R0 at the end of pt_regs (plus one buffer word
> > to get even alignment). Or would that already be unacceptable because
> > it's an ABI change, too?
> 
> If we preserve the first part of the pt_regs structure, we could add the
> exception return at the end (with two additional 32-bit words to
> preserve the 64-bit alignment).
I will do that.

> > --- a/arch/arm/kernel/entry-common.S
> > +++ b/arch/arm/kernel/entry-common.S
> > @@ -473,7 +480,7 @@ __sys_trace:
> >  
> >  	adr	lr, BSYM(__sys_trace_return)	@ return address
> >  	mov	scno, r0			@ syscall number (possibly new)
> > -	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
> > +	add	r1, sp, #S_OFF			@ pointer to regs
> 
> This change is no longer needed since S_R0 is no 0.
hmm, I thought I had removed them. Seems I didn't.
 
> > --- a/arch/arm/kernel/entry-header.S
> > +++ b/arch/arm/kernel/entry-header.S
> > @@ -26,7 +26,7 @@
> >   * The SWI code relies on the fact that R0 is at the bottom of the stack
> >   * (due to slow/fast restore user regs).
> >   */
> > -#if S_R0 != 0
> > +#if S_R0 != 0 && !defined(CONFIG_CPU_V7M)
> 
> Same here.
Same here ;-)
> 
> > +#ifdef CONFIG_CPU_V7M
> > +/*
> > + * ARMv7-M exception entry/exit macros.
> > + *
> > + * xPSR, ReturnAddress(), LR (R14), R12, R3, R2, R1, and R0 are
> > + * automatically saved on the current stack (32 words) before
> > + * switching to the exception stack (SP_main).
> > + *
> > + * If exception is taken while in user mode, SP_main is
> > + * empty. Otherwise, SP_main is aligned to 64 bit automatically
> > + * (CCR.STKALIGN set).
> > + *
> > + * Linux assumes that the interrupts are disabled when entering an
> > + * exception handler and it may BUG if this is not the case. Interrupts
> > + * are disabled during entry and reenabled in the exit macro.
> > + *
> > + * v7m_exception_fast_exit is used when returning from interrupts.
> > + *
> > + * v7m_exception_slow_exit is used when returning from SVC or PendSV.
> > + * When returning to kernel mode, we don't return from exception.
> > + */
> > +	.macro	v7m_exception_entry
> > +	cpsid	i
> > +	sub	sp, #S_FRAME_SIZE
> > +	stmia	sp, {r0-r12}
> > +
> > +	@ set r0 to the location of the registers saved by the core during
> > +	@ exception entry. Depending on the mode the cpu was in when the
> > +	@ exception happend that is either on the main or the process stack.
> > +	@ Bit 2 of EXC_RETURN stored in the lr register specifies which stack
> > +	@ was used.
> > +	tst	lr, #0x4
> > +	mrsne	r0, psp
> > +	addeq	r0, sp, #S_FRAME_SIZE
> 
> Could we use some other registers here like r8-r12 so that we keep r0-r7
> for syscall handling later and avoid another ldmia?
One upside of using r0 is that

	addeq	r0, sp, #S_FRAME_SIZE

can be encoded in 16 bits while this is not possible and 32 bits are
needed. And I wonder if it's allowed to corrupt r8-r12?

> > +	add	r0, r0, #20		@ skip over r0-r3, r12
> > +	ldmia	r0!, {r1-r3}		@ load saved lr, return address and xPSR
> > +
> > +	@ calculate the orignal stack pointer value.
> > +	@ r0 currently points to the memory location just above the auto saved
> > +	@ xPSR. If the FP extension is implemented and bit 4 of EXC_RETURN is 0
> > +	@ then space was allocated for FP state. That is space for 18 32-bit
> > +	@ values. (If FP extension is unimplemented, bit 4 is 1.)
> > +	@ Additionally the cpu might automatically 8-byte align the stack. Bit 9
> > +	@ of the saved xPSR specifies if stack aligning took place. In this case
> > +	@ another 32-bit value is included in the stack.
> > +
> > +	tst	lr, #0x10
> > +	addeq	r0, r0, #576
> 
> I think you can ignore VFP for now. We could change it to do lazy
> save/restore and avoid the automatic state saving. If it does this while
> in kernel, it takes a bit of extra stack space.
If I understood correctly this will never trigger for kernel tasks,
won't it?

> > +	@ save original sp, lr, return address, xPSR and EXC_RETURN
> > +	add	r12, sp, #52
> 
> Just use S_ARM_SP or whatever asm offsets, it's easier to read.
OK, right.

> > +	stmia	r12, {r0-r3, lr}
> > +
> > +	@ restore registers for system calls
> > +	ldmia	sp, {r0-r12}
> 
> We could avoid reloading r0-r7 (that's what we actually need for
> syscalls) if we don't corrupt them.
See question above. And I noticed that because of tail-chaining we need
to load the register values from the exception frame at least once
anyhow. I will try to optimise here.

> > +	.endm
> > +
> > +	.macro	v7m_exception_fast_exit
> > +	@ read r12, sp, lr, return address, xPSR and EXC_RETURN
> > +	add	r12, sp, #48
> 
> S_ARM_R12?
> 
> > +	ldmia	r12, {r1-r5, lr}
> > +
> > +	tst     r5, #0x100
> > +	subne   r2, r2, #4
> > +
> > +	tst	lr, #0x10
> > +	subeq	r2, r2, #576
> > +
> > +	stmdb	r2!, {r1, r3-r5}		@ write saved r12, lr, return address and xPSR
> > +
> > +	ldmia	sp, {r1, r3-r5}			@ read saved r0-r3
> > +	stmdb	r2!, {r1, r3-r5}		@ write r0-r3 to basic exception frame
> > +
> > +	tst	lr, #0x4
> > +	msrne	psp, r2
> > +
> > +	ldmia	sp, {r0-r12}
> > +	add	sp, #S_FRAME_SIZE
> > +	cpsie	i
> > +	bx	lr
> > +	.endm
> 
> In the context v7m_exception_fast_exit is used (return from interrupts),
> the previously saved r0-r4,r12 etc. are still on the return stack and
> restored from there. There is no need for the ldmia/stmdb to re-create
> the interrupted process stack. Here we only need to make sure that we
> restore the registers that were not automatically saved and also move
> the kernel SP back to the original location (add S_FRAME_SIZE).
>
> We handle rescheduling and work pending by raising PendSV, so we get
> another interrupt which would be returned via the slow_exit macro.
I was not sure if a task could be preempted during an exception. So I
choosed to play save.

> > +	.macro	v7m_exception_slow_exit ret_r0
> > +	cpsid	i
> > +	ldr	lr, [sp, #S_EXCRET]		@ read exception LR
> > +	tst     lr, #0x8
> > +	bne	1f				@ go to thread mode using exception return
> > +
> > +	/*
> > +	 * return to kernel thread
> > +	 * sp is already set up (and might be unset in pt_regs), so only
> > +	 * restore r0-r12 and pc
> > +	 */
> > +	ldmia	sp, {r0-r12}
> > +	ldr	lr, [sp, #S_PC]
> > +	add	sp, sp, #S_FRAME_SIZE
> > +	cpsie	i
> > +	bx	lr
> > +	/*
> > +	 * return to userspace
> > +	 */
> > +1:
> > +	@ read original r12, sp, lr, pc, xPSR
> > +	add	r12, sp, #48
> > +	ldmia	r12, {r1-r5}
> > +
> > +	/* stack aligning */
> > +	tst	r5, #0x100
> > +	subne	r2, r2, #4
> > +
> > +	/* skip over stack space for fp extension */
> > +	tst	lr, #0x10
> > +	subeq	r2, r2, #576
> > +
> > +	/* write basic exception frame */
> > +	stmdb	r2!, {r1, r3-r5}		@ saved r12, lr, return address and xPSR
> > +	ldmia	sp, {r1, r3-r5}			@ read saved r0-r3
> > +	.if	\ret_r0
> > +	stmdb	r2!, {r0, r3-r5}		@ restore r0-r3
> > +	.else
> > +	stmdb	r2!, {r1, r3-r5}		@ restore r0-r3
> > +	.endif
> 
> This looks fine.
> 
> > +	msr	psp, r2
> > +
> > +	ldmia	sp, {r0-r12}			@ restore original r4-r11
> 
> Isn't this reading too much (optimisation)?
yeah, I think r12 isn't needed. For r0-r3 I'm not sure which is better:

	ldmia	sp, {r0-r11}
	add	sp, #S_FRAME_SIZE

vs.

	add	sp, #S_R4
	ldmia	sp, {r4-r11}
	add	sp, #S_FRAME_SIZE - S_R4

It's not described in the V7-M reverence. Do you know a document where I
can look that up?

> > +	add	sp, #S_FRAME_SIZE		@ restore the original MSP
> > +	cpsie	i
> > +	bx	lr
> > +	.endm
> > +#endif	/* CONFIG_CPU_V7M */
> ...
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -452,7 +452,11 @@ asm(	".pushsection .text\n"
> >  #ifdef CONFIG_TRACE_IRQFLAGS
> >  "	bl	trace_hardirqs_on\n"
> >  #endif
> > +#ifdef CONFIG_CPU_V7M
> > +"	msr	primask, r7\n"
> > +#else
> >  "	msr	cpsr_c, r7\n"
> > +#endif
> >  "	mov	r0, r4\n"
> >  "	mov	lr, r6\n"
> >  "	mov	pc, r5\n"
> > @@ -491,6 +495,10 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
> >  	regs.ARM_r7 = SVC_MODE | PSR_ENDSTATE | PSR_ISETSTATE;
> >  	regs.ARM_pc = (unsigned long)kernel_thread_helper;
> >  	regs.ARM_cpsr = regs.ARM_r7 | PSR_I_BIT;
> > +#ifdef CONFIG_CPU_V7M
> > +	/* Return to Handler mode */
> > +	regs.ARM_EXCRET = 0xfffffff1L;
> > +#endif
> 
> BTW, do we need to set this here? We don't return to a kernel thread via
> exception return.
But we need it to decide in slow_return if we should use exception
return or not. So yes, I think it's needed.

> I currently cannot see any obvious bugs in the code. Since you said it
> doesn't work, what are the symptoms?
I found two problems. One is I wasn't aware that r0-r3,r12 doesn't
necessarily need to match the values on exception entry (because of
tail-chaining) and in start_thread decreasing sp is wrong.

I will reimplement the three macros now with the new lessons learned.

Best regards and thanks for your input (here and on irc)
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
