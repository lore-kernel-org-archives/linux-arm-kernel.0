From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 24 May 2018 10:19:26 +0100
Subject: [PATCH v10 07/18] arm64: fpsimd: Eliminate task->mm checks
In-Reply-To: <1527005119-6842-8-git-send-email-Dave.Martin@arm.com>
References: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
 <1527005119-6842-8-git-send-email-Dave.Martin@arm.com>
Message-ID: <87bmd5tnq9.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> Currently the FPSIMD handling code uses the condition task->mm ==
> NULL as a hint that task has no FPSIMD register context.
>
> The ->mm check is only there to filter out tasks that cannot
> possibly have FPSIMD context loaded, for optimisation purposes.
> Also, TIF_FOREIGN_FPSTATE must always be checked anyway before
> saving FPSIMD context back to memory.  For these reasons, the ->mm
> checks are not useful, providing that that TIF_FOREIGN_FPSTATE is
> maintained in a consistent way for kernel threads.
>
> This is true by construction however: TIF_FOREIGN_FPSTATE is never
> cleared except when returning to userspace or returning from a
> signal: thus, for a true kernel thread no FPSIMD context is ever
> loaded, TIF_FOREIGN_FPSTATE will remain set and no context will
> ever be saved.
>
> This patch removes the redundant checks and special-case code.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

With Christoffer's commit text:

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

>
> ---
>
> Changes since v9:
>
>  * New patch.  Introduced during debugging, since the ->mm checks
>    appear bogus and/or redundant, so are likely to be hiding or
>    causing bugs.
> ---
>  arch/arm64/include/asm/thread_info.h |  1 +
>  arch/arm64/kernel/fpsimd.c           | 38 ++++++++++++------------------------
>  2 files changed, 14 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 740aa03c..a2ac914 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -47,6 +47,7 @@ struct thread_info {
>
>  #define INIT_THREAD_INFO(tsk)						\
>  {									\
> +	.flags		= _TIF_FOREIGN_FPSTATE,				\
>  	.preempt_count	= INIT_PREEMPT_COUNT,				\
>  	.addr_limit	= KERNEL_DS,					\
>  }
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 3aa100a..1222491 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -891,31 +891,21 @@ asmlinkage void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
>
>  void fpsimd_thread_switch(struct task_struct *next)
>  {
> +	bool wrong_task, wrong_cpu;
> +
>  	if (!system_supports_fpsimd())
>  		return;
> -	/*
> -	 * Save the current FPSIMD state to memory, but only if whatever is in
> -	 * the registers is in fact the most recent userland FPSIMD state of
> -	 * 'current'.
> -	 */
> -	if (current->mm)
> -		fpsimd_save();
>
> -	if (next->mm) {
> -		/*
> -		 * If we are switching to a task whose most recent userland
> -		 * FPSIMD state is already in the registers of *this* cpu,
> -		 * we can skip loading the state from memory. Otherwise, set
> -		 * the TIF_FOREIGN_FPSTATE flag so the state will be loaded
> -		 * upon the next return to userland.
> -		 */
> -		bool wrong_task = __this_cpu_read(fpsimd_last_state.st) !=
> +	/* Save unsaved fpsimd state, if any: */
> +	fpsimd_save();
> +
> +	/* Fix up TIF_FOREIGN_FPSTATE to correctly describe next's state: */
> +	wrong_task = __this_cpu_read(fpsimd_last_state.st) !=
>  					&next->thread.uw.fpsimd_state;
> -		bool wrong_cpu = next->thread.fpsimd_cpu != smp_processor_id();
> +	wrong_cpu = next->thread.fpsimd_cpu != smp_processor_id();
>
> -		update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
> -				       wrong_task || wrong_cpu);
> -	}
> +	update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
> +			       wrong_task || wrong_cpu);
>  }
>
>  void fpsimd_flush_thread(void)
> @@ -1120,9 +1110,8 @@ void kernel_neon_begin(void)
>
>  	__this_cpu_write(kernel_neon_busy, true);
>
> -	/* Save unsaved task fpsimd state, if any: */
> -	if (current->mm)
> -		fpsimd_save();
> +	/* Save unsaved fpsimd state, if any: */
> +	fpsimd_save();
>
>  	/* Invalidate any task state remaining in the fpsimd regs: */
>  	fpsimd_flush_cpu_state();
> @@ -1244,8 +1233,7 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>  {
>  	switch (cmd) {
>  	case CPU_PM_ENTER:
> -		if (current->mm)
> -			fpsimd_save();
> +		fpsimd_save();
>  		fpsimd_flush_cpu_state();
>  		break;
>  	case CPU_PM_EXIT:


--
Alex Benn?e
