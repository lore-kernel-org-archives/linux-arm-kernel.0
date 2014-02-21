From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Feb 2014 17:48:55 +0000
Subject: [PATCH v2 2/4] arm64: defer reloading a task's FPSIMD state to
 userland resume
In-Reply-To: <1391620418-3999-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1391620418-3999-1-git-send-email-ard.biesheuvel@linaro.org>
 <1391620418-3999-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140221174855.GD25351@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 05:13:36PM +0000, Ard Biesheuvel wrote:
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index 7807974b49ee..f7e70f3f1eb7 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -37,6 +37,8 @@ struct fpsimd_state {
>  			u32 fpcr;
>  		};
>  	};
> +	/* the id of the last cpu to have restored this state */
> +	unsigned int last_cpu;

Just "cpu" is enough.

>  };
>  
>  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
> @@ -61,6 +63,8 @@ void fpsimd_set_task_state(struct fpsimd_state *state);
>  struct user_fpsimd_state *fpsimd_get_user_state(struct task_struct *t);
>  void fpsimd_set_user_state(struct task_struct *t, struct user_fpsimd_state *st);
>  
> +void fpsimd_reload_fpstate(void);
> +
>  #endif
>  
>  #endif
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 720e70b66ffd..4a1ca1cfb2f8 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -100,6 +100,7 @@ static inline struct thread_info *current_thread_info(void)
>  #define TIF_SIGPENDING		0
>  #define TIF_NEED_RESCHED	1
>  #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
> +#define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
>  #define TIF_SYSCALL_TRACE	8
>  #define TIF_POLLING_NRFLAG	16
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
> @@ -112,10 +113,11 @@ static inline struct thread_info *current_thread_info(void)
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
> +#define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
>  #define _TIF_32BIT		(1 << TIF_32BIT)
>  
>  #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
> -				 _TIF_NOTIFY_RESUME)
> +				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE)
>  
>  #endif /* __KERNEL__ */
>  #endif /* __ASM_THREAD_INFO_H */
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 39ac630d83de..80464e2fb1a5 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -576,7 +576,7 @@ fast_work_pending:
>  	str	x0, [sp, #S_X0]			// returned x0
>  work_pending:
>  	tbnz	x1, #TIF_NEED_RESCHED, work_resched
> -	/* TIF_SIGPENDING or TIF_NOTIFY_RESUME case */
> +	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
>  	ldr	x2, [sp, #S_PSTATE]
>  	mov	x0, sp				// 'regs'
>  	tst	x2, #PSR_MODE_MASK		// user mode regs?
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index eeb003f54ad0..239c8162473f 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -39,6 +39,23 @@ void fpsimd_save_state(struct fpsimd_state *state);
>  void fpsimd_load_state(struct fpsimd_state *state);
>  
>  /*
> + * In order to reduce the number of times the fpsimd state is needlessly saved
> + * and restored, keep track here of which task's userland owns the current state
> + * of the FPSIMD register file.
> + *
> + * This percpu variable points to the fpsimd_state.last_cpu field of the task
> + * whose FPSIMD state was most recently loaded onto this cpu. The last_cpu field
> + * itself contains the id of the cpu onto which the task's FPSIMD state was
> + * loaded most recently. So, to decide whether we can skip reloading the FPSIMD
> + * state, we need to check
> + * (a) whether this task was the last one to have its FPSIMD state loaded onto
> + *     this cpu
> + * (b) whether this task may have manipulated its FPSIMD state on another cpu in
> + *     the meantime
> + */
> +static DEFINE_PER_CPU(unsigned int *, fpsimd_last_task);

This can simply be struct fpsimd_state * to avoid &st->last_cpu. Also
rename to fpsimd_state_last.

> +
> +/*
>   * Trapped FP/ASIMD access.
>   */
>  void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
> @@ -76,36 +93,84 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
>  
>  void fpsimd_thread_switch(struct task_struct *next)
>  {
> -	/* check if not kernel threads */
> -	if (current->mm)
> +	/*
> +	 * The thread flag TIF_FOREIGN_FPSTATE conveys that the userland FPSIMD
> +	 * state belonging to the current task is not present in the registers
> +	 * but has (already) been saved to memory in order for the kernel to be
> +	 * able to go off and use the registers for something else. Therefore,
> +	 * we must not (re)save the register contents if this flag is set.
> +	 */
> +	if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
>  		fpsimd_save_state(&current->thread.fpsimd_state);
> -	if (next->mm)
> -		fpsimd_load_state(&next->thread.fpsimd_state);
> +
> +	if (next->mm) {
> +		/*
> +		 * If we are switching to a task whose most recent userland
> +		 * FPSIMD contents are already in the registers of *this* cpu,
> +		 * we can skip loading the state from memory. Otherwise, set
> +		 * the TIF_FOREIGN_FPSTATE flag so the state will be loaded
> +		 * upon the next entry of userland.

I would say "return" instead of "entry" (we enter the kernel and return
to user space ;)).

> +		 */
> +		struct fpsimd_state *st = &next->thread.fpsimd_state;
> +
> +		if (__get_cpu_var(fpsimd_last_task) == &st->last_cpu
> +		    && st->last_cpu == smp_processor_id())
> +			clear_ti_thread_flag(task_thread_info(next),
> +					     TIF_FOREIGN_FPSTATE);
> +		else
> +			set_ti_thread_flag(task_thread_info(next),
> +					   TIF_FOREIGN_FPSTATE);
> +	}
>  }

I'm still trying to get my head around why we have 3 different type of
checks for this (fpsimd_last_task, last_cpu and TIF). The code seems
correct but I wonder whether we can reduce this to 2 checks?

-- 
Catalin
