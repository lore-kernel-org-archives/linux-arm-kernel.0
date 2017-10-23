From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Oct 2017 18:43:23 +0100
Subject: [RFC PATCH] arm64/sve: ABI change: Zero SVE regs on syscall entry
In-Reply-To: <1508758664-24186-2-git-send-email-Dave.Martin@arm.com>
References: <1508758664-24186-1-git-send-email-Dave.Martin@arm.com>
 <1508758664-24186-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171023174322.v6vi2rrqxrhqxoem@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Mon, Oct 23, 2017 at 12:37:44PM +0100, Dave P Martin wrote:
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 6718780..68917de 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -850,6 +850,25 @@ el0_svc:
>  	adrp	stbl, sys_call_table		// load syscall table pointer
>  	mov	wscno, w8			// syscall number in w8
>  	mov	wsc_nr, #__NR_syscalls
> +
> +#ifdef CONFIG_ARM64_SVE
> +alternative_if_not ARM64_SVE
> +	b	1f
> +alternative_else
> +	ldr	x10, [tsk, #TSK_TI_FLAGS]
> +alternative_endif
> +	bic	x10, x10, #_TIF_SVE		// discard SVE state on syscall

Could we have:

	tbz	x10, #TIF_SVE, 1f

> +	str	x10, [tsk, #TSK_TI_FLAGS]
> +
> +	tbz	x10, #TIF_FOREIGN_FPSTATE, 2f
> +	ASM_BUG()
> +2:

If we've never hit this problem before, I think we can avoid the
TIF_FOREIGN_FPSTATE here. Just double-check the return path that we
always invoke do_notify_resume().

> +	mrs	x9, cpacr_el1
> +	bic	x9, x9, #CPACR_EL1_ZEN_EL0EN	// disable SVE for el0
> +	msr	cpacr_el1, x9			// synchronised by eret to el0

I haven't checked the other patches but do we context switch cpacr_el1?
If not, we may return to user with this enabled. Alternatively, can we
disable it on the return path?

> +1:
> +#endif
> +
>  el0_svc_naked:					// compat entry point
>  	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
>  	enable_dbg_and_irq

I think you could move the TIF_SVE checks above in el0_svc_naked and
reuse x16 to avoid loading TSK_TI_FLAGS twice. For compat tasks TIF_SVE
would be 0 anyway (as long as we can skip the whole block as per my
suggested tbz).

> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index ac56a96..9a3c561 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -247,22 +247,22 @@ void arch_release_task_struct(struct task_struct *tsk)
>  	fpsimd_release_task(tsk);
>  }
>  
> +/*
> + * src and dst may temporarily have aliased sve_state after task_struct
> + * is copied.  We cannot fix this properly here, because src may have
> + * live SVE state and dst's thread_info may not exist yet, so tweaking
> + * either src's or dst's TIF_SVE is not safe.
> + *
> + * The unaliasing is done in copy_thread() instead.  This works because
> + * dst is not schedulable or traceable until both of these functions
> + * have been called.
> + */
>  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  {
> -	/*
> -	 * For SVE, dst and src must not end up with aliases of the same
> -	 * sve_state.  Because we are definitely in a syscall here, SVE state
> -	 * can be discarded unconditionally without violating the user ABI.
> -	 * dst's sve_state pointer can then be zapped with no ill effects.
> -	 *
> -	 * src can safely retain its sve_state memory for later use.
> -	 */
>  	if (current->mm)
> -		fpsimd_preserve_current_state_discard_sve();
> +		fpsimd_preserve_current_state();
>  	*dst = *src;
>  
> -	dst->thread.sve_state = NULL;
> -
>  	return 0;
>  }
>  
> @@ -275,6 +275,13 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  
>  	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
>  
> +	/*
> +	 * Unalias p->thread.sve_state (if any) from the parent task
> +	 * and disable discard SVE state for p:
> +	 */
> +	clear_tsk_thread_flag(p, TIF_SVE);
> +	p->thread.sve_state = NULL;
> +
>  	if (likely(!(p->flags & PF_KTHREAD))) {
>  		*childregs = *current_pt_regs();
>  		childregs->regs[0] = 0;

This looks fine.

-- 
Catalin
