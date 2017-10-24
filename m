From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 24 Oct 2017 18:05:23 +0100
Subject: [PATCH] arm64/sve: ABI change: Zero SVE regs on syscall entry
In-Reply-To: <20171024163524.mxn5puf3fmajrjbr@armageddon.cambridge.arm.com>
References: <1508859966-7671-1-git-send-email-Dave.Martin@arm.com>
 <20171024163524.mxn5puf3fmajrjbr@armageddon.cambridge.arm.com>
Message-ID: <20171024170523.GG19485@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 05:35:25PM +0100, Catalin Marinas wrote:
> On Tue, Oct 24, 2017 at 04:46:06PM +0100, Dave P Martin wrote:
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 6718780..fbc0eb5 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -660,6 +660,7 @@ el0_svc_compat:
> >  	/*
> >  	 * AArch32 syscall handling
> >  	 */
> > +	ldr	x16, [tsk, #TSK_TI_FLAGS]	// load thread flags
> >  	adrp	stbl, compat_sys_call_table	// load compat syscall table pointer
> >  	mov	wscno, w7			// syscall number in w7 (r7)
> >  	mov     wsc_nr, #__NR_compat_syscalls
> > @@ -847,16 +848,35 @@ ENDPROC(ret_to_user)
> >   */
> >  	.align	6
> >  el0_svc:
> > +	ldr	x16, [tsk, #TSK_TI_FLAGS]	// load thread flags
> >  	adrp	stbl, sys_call_table		// load syscall table pointer
> >  	mov	wscno, w8			// syscall number in w8
> >  	mov	wsc_nr, #__NR_syscalls
> > +
> > +#ifdef CONFIG_ARM64_SVE
> > +alternative_if_not ARM64_SVE
> > +	b	el0_svc_naked
> > +alternative_else
> > +	tbz	x16, #_TIF_SVE, el0_svc_naked	// Skip unless TIF_SVE set:

This goes out of range btw due to the limited range of tbz and the
fact that this is assembled into the alternatives section instead of
.text.  So I changed to:

alternative_else
	tst	x16, #TIF_SVE
alternative_endif
	b.eq	el0_svc_naked


There's nothing more useful to put info the _else slot that I could
see.

> > +alternative_endif
> > +	bic	x16, x16, #_TIF_SVE		// discard SVE state
> > +	str	x16, [tsk, #TSK_TI_FLAGS]
> > +
> > +	// task_fpsimd_load() won't be called to update CPACR
> > +	// unless TIF_FOREIGN_FPSTATE is set, which only happens if a
> > +	// context switch of kernel_neon_begin() gets in the way.
> 
> s/of/or/

Oops, thanks

> 
> > +	// So, ensure that CPACR is correct for the fast-path case:
> > +	mrs	x9, cpacr_el1
> > +	bic	x9, x9, #CPACR_EL1_ZEN_EL0EN	// disable SVE for el0
> > +	msr	cpacr_el1, x9			// synchronised by eret to el0
> > +#endif
> 
> Just a nitpick, I'd like multi-line asm comments to still follow the C
> style:
> 
> 	/*
> 	 * ...
> 	 */

Will do.

> 
> Otherwise,
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks
---Dave
