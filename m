From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 23 May 2018 21:16:52 +0100
Subject: [PATCH v10 08/18] arm64/sve: Refactor user SVE trap maintenance
 for external use
In-Reply-To: <1527005119-6842-9-git-send-email-Dave.Martin@arm.com>
References: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
 <1527005119-6842-9-git-send-email-Dave.Martin@arm.com>
Message-ID: <87h8myt9e3.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> In preparation for optimising the way KVM manages switching the
> guest and host FPSIMD state, it is necessary to provide a means for
> code outside arch/arm64/kernel/fpsimd.c to restore the user trap
> configuration for SVE correctly for the current task.
>
> Rather than requiring external code to duplicate the maintenance
> explicitly, this patch wraps moves the trap maintenenace to
> fpsimd_bind_to_cpu(), since it is logically part of the work of
> associating the current task with the cpu.
>
> Because fpsimd_bind_to_cpu() is rather a cryptic name to publish
> alongside fpsimd_bind_state_to_cpu(), the former function is
> renamed to fpsimd_bind_task_to_cpu() to make its purpose more
> explicit.
>
> This patch makes appropriate changes to ensure that
> fpsimd_bind_task_to_cpu() is always called alongside
> task_fpsimd_load(), so that the trap maintenance continues to be
> done in every situation where it was done prior to this patch.
>
> As a side-effect, the metadata updates done by
> fpsimd_bind_task_to_cpu() now change from conditional to
> unconditional in the "already bound" case of sigreturn.  This is
> harmless, and a couple of extra stores on this slow path will not
> impact performance.  I consider this a reasonable price to pay for
> a slightly cleaner interface.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

In fact the comment I alluded to in 6/18 could be applied in this.

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>


> ---
>  arch/arm64/kernel/fpsimd.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 1222491..ba9e7df 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -257,16 +257,6 @@ static void task_fpsimd_load(void)
>  			       sve_vq_from_vl(current->thread.sve_vl) - 1);
>  	else
>  		fpsimd_load_state(&current->thread.uw.fpsimd_state);
> -
> -	if (system_supports_sve()) {
> -		/* Toggle SVE trapping for userspace if needed */
> -		if (test_thread_flag(TIF_SVE))
> -			sve_user_enable();
> -		else
> -			sve_user_disable();
> -
> -		/* Serialised by exception return to user */
> -	}
>  }
>
>  /*
> @@ -991,7 +981,7 @@ void fpsimd_signal_preserve_current_state(void)
>   * Associate current's FPSIMD context with this cpu
>   * Preemption must be disabled when calling this function.
>   */
> -static void fpsimd_bind_to_cpu(void)
> +static void fpsimd_bind_task_to_cpu(void)
>  {
>  	struct fpsimd_last_state_struct *last =
>  		this_cpu_ptr(&fpsimd_last_state);
> @@ -999,6 +989,16 @@ static void fpsimd_bind_to_cpu(void)
>  	last->st = &current->thread.uw.fpsimd_state;
>  	last->sve_in_use = test_thread_flag(TIF_SVE);
>  	current->thread.fpsimd_cpu = smp_processor_id();
> +
> +	if (system_supports_sve()) {
> +		/* Toggle SVE trapping for userspace if needed */
> +		if (test_thread_flag(TIF_SVE))
> +			sve_user_enable();
> +		else
> +			sve_user_disable();
> +
> +		/* Serialised by exception return to user */
> +	}
>  }
>
>  /*
> @@ -1015,7 +1015,7 @@ void fpsimd_restore_current_state(void)
>
>  	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
>  		task_fpsimd_load();
> -		fpsimd_bind_to_cpu();
> +		fpsimd_bind_task_to_cpu();
>  	}
>
>  	local_bh_enable();
> @@ -1038,9 +1038,9 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
>  		fpsimd_to_sve(current);
>
>  	task_fpsimd_load();
> +	fpsimd_bind_task_to_cpu();
>
> -	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE))
> -		fpsimd_bind_to_cpu();
> +	clear_thread_flag(TIF_FOREIGN_FPSTATE);
>
>  	local_bh_enable();
>  }


--
Alex Benn?e
