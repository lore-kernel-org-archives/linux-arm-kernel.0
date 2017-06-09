From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 9 Jun 2017 10:06:17 +0300
Subject: [PATCH 14/20] arm64: ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <593967C0.4030904@arm.com>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-15-ynorov@caviumnetworks.com>
 <593967C0.4030904@arm.com>
Message-ID: <20170609070617.74bimhscmzeykx6d@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 04:05:36PM +0100, James Morse wrote:
> Hi Yury,
> 
> On 04/06/17 13:00, Yury Norov wrote:
> > From: Andrew Pinski <apinski@cavium.com>
> > 
> > Add a separate syscall-table for ILP32, which dispatches either to native
> > LP64 system call implementation or to compat-syscalls, as appropriate.
> 
> (I'm still reading through this series trying to understand it, but spotted this: )
> 
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 279bc2ab10c3..7d52fe1ec6bd 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -577,6 +594,7 @@ el0_svc_compat:
> >  	 * AArch32 syscall handling
> >  	 */
> >  	adrp	stbl, compat_sys_call_table	// load compat syscall table pointer
> > +	ldr     x16, [tsk, #TSK_TI_FLAGS]
> >  	uxtw	scno, w7			// syscall number in w7 (r7)
> >  	mov     sc_nr, #__NR_compat_syscalls
> >  	b	el0_svc_naked
> > @@ -798,15 +816,21 @@ ENDPROC(ret_from_fork)
> >  	.align	6
> >  el0_svc:
> >  	adrp	stbl, sys_call_table		// load syscall table pointer
> > +	ldr	x16, [tsk, #TSK_TI_FLAGS]
> >  	uxtw	scno, w8			// syscall number in w8
> >  	mov	sc_nr, #__NR_syscalls
> > +#ifdef CONFIG_ARM64_ILP32
> > +	tst	x16, #_TIF_32BIT_AARCH64
> > +	b.eq	el0_svc_naked			// We are using LP64  syscall table
> > +	adrp	stbl, sys_call_ilp32_table	// load ilp32 syscall table pointer
> > +	delouse_input_regs
> > +#endif
> >  el0_svc_naked:					// compat entry point
> >  	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
> >  	enable_dbg_and_irq
> >  	ct_user_exit 1
> >  
> 
> > -	ldr	x16, [tsk, #TSK_TI_FLAGS]	// check for syscall hooks
> 
> If built with CONFIG_CONTEXT_TRACKING, ct_user_exit will call
> context_tracking_user_exit(), this will clobber x16 which you depend on not
> changing below:
> 
> 
> > -	tst	x16, #_TIF_SYSCALL_WORK
> > +	tst	x16, #_TIF_SYSCALL_WORK		// check for syscall hooks
> 
> >  	b.ne	__sys_trace
> >  	cmp     scno, sc_nr                     // check upper syscall limit
> >  	b.hs	ni_sys

Hi James,

Thanks for the catch. I'll use x19 insteas - it's callee-saved.

Yury
