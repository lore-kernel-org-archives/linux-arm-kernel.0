From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 23 May 2018 21:15:11 +0100
Subject: [PATCH v10 06/18] arm64: fpsimd: Generalise context saving for
 non-task contexts
In-Reply-To: <1527005119-6842-7-git-send-email-Dave.Martin@arm.com>
References: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
 <1527005119-6842-7-git-send-email-Dave.Martin@arm.com>
Message-ID: <87in7et9gw.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> In preparation for allowing non-task (i.e., KVM vcpu) FPSIMD
> contexts to be handled by the fpsimd common code, this patch adapts
> task_fpsimd_save() to save back the currently loaded context,
> removing the explicit dependency on current.
>
> The relevant storage to write back to in memory is now found by
> examining the fpsimd_last_state percpu struct.
>
> fpsimd_save() does nothing unless TIF_FOREIGN_FPSTATE is clear, and
> fpsimd_last_state is updated under local_bh_disable() or
> local_irq_disable() everywhere that TIF_FOREIGN_FPSTATE is cleared:
> thus, fpsimd_save() will write back to the correct storage for the
> loaded context.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 9d85373..3aa100a 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -270,13 +270,15 @@ static void task_fpsimd_load(void)
>  }
>
>  /*
> - * Ensure current's FPSIMD/SVE storage in thread_struct is up to date
> - * with respect to the CPU registers.
> + * Ensure FPSIMD/SVE storage in memory for the loaded context is up to
> + * date with respect to the CPU registers.
>   *
>   * Softirqs (and preemption) must be disabled.
>   */
> -static void task_fpsimd_save(void)
> +static void fpsimd_save(void)
>  {
> +	struct user_fpsimd_state *st = __this_cpu_read(fpsimd_last_state.st);
> +

I thought I was missing something but the only write I saw of this was:

  __this_cpu_write(fpsimd_last_state.st, NULL);

which implied to me it is possible to have an invalid de-reference. I
did figure it out eventually as fpsimd_bind_state_to_cpu uses a more
indirect this_cpu_ptr idiom for tweaking this. I guess a reference to
fpsimd_bind_[task|state]_to_cpu in the comment would have helped my
confusion.

Anyway:

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>


>  	WARN_ON(!in_softirq() && !irqs_disabled());
>
>  	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
> @@ -291,10 +293,9 @@ static void task_fpsimd_save(void)
>  				return;
>  			}
>
> -			sve_save_state(sve_pffr(current),
> -				       &current->thread.uw.fpsimd_state.fpsr);
> +			sve_save_state(sve_pffr(current), &st->fpsr);
>  		} else
> -			fpsimd_save_state(&current->thread.uw.fpsimd_state);
> +			fpsimd_save_state(st);
>  	}
>  }
>
> @@ -598,7 +599,7 @@ int sve_set_vector_length(struct task_struct *task,
>  	if (task == current) {
>  		local_bh_disable();
>
> -		task_fpsimd_save();
> +		fpsimd_save();
>  		set_thread_flag(TIF_FOREIGN_FPSTATE);
>  	}
>
> @@ -837,7 +838,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
>
>  	local_bh_disable();
>
> -	task_fpsimd_save();
> +	fpsimd_save();
>  	fpsimd_to_sve(current);
>
>  	/* Force ret_to_user to reload the registers: */
> @@ -898,7 +899,7 @@ void fpsimd_thread_switch(struct task_struct *next)
>  	 * 'current'.
>  	 */
>  	if (current->mm)
> -		task_fpsimd_save();
> +		fpsimd_save();
>
>  	if (next->mm) {
>  		/*
> @@ -980,7 +981,7 @@ void fpsimd_preserve_current_state(void)
>  		return;
>
>  	local_bh_disable();
> -	task_fpsimd_save();
> +	fpsimd_save();
>  	local_bh_enable();
>  }
>
> @@ -1121,7 +1122,7 @@ void kernel_neon_begin(void)
>
>  	/* Save unsaved task fpsimd state, if any: */
>  	if (current->mm)
> -		task_fpsimd_save();
> +		fpsimd_save();
>
>  	/* Invalidate any task state remaining in the fpsimd regs: */
>  	fpsimd_flush_cpu_state();
> @@ -1244,7 +1245,7 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>  	switch (cmd) {
>  	case CPU_PM_ENTER:
>  		if (current->mm)
> -			task_fpsimd_save();
> +			fpsimd_save();
>  		fpsimd_flush_cpu_state();
>  		break;
>  	case CPU_PM_EXIT:


--
Alex Benn?e
