From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 24 May 2018 11:12:52 +0100
Subject: [PATCH v10 12/18] arm64/sve: Switch sve_pffr() argument from task
 to thread
In-Reply-To: <1527005119-6842-13-git-send-email-Dave.Martin@arm.com>
References: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
 <1527005119-6842-13-git-send-email-Dave.Martin@arm.com>
Message-ID: <874lixtl97.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> sve_pffr(), which is used to derive the base address used for
> low-level SVE save/restore routines, currently takes the relevant
> task_struct as an argument.
>
> The only accessed fields are actually part of thread_struct, so
> this patch changes the argument type accordingly.  This is done in
> preparation for moving this function to a header, where we do not
> want to have to include <linux/sched.h> due to the consequent
> circular #include problems.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

> ---
>  arch/arm64/kernel/fpsimd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 5152bbc..c4e9762 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -44,6 +44,7 @@
>  #include <asm/fpsimd.h>
>  #include <asm/cpufeature.h>
>  #include <asm/cputype.h>
> +#include <asm/processor.h>
>  #include <asm/simd.h>
>  #include <asm/sigcontext.h>
>  #include <asm/sysreg.h>
> @@ -167,10 +168,9 @@ static size_t sve_ffr_offset(int vl)
>  	return SVE_SIG_FFR_OFFSET(sve_vq_from_vl(vl)) - SVE_SIG_REGS_OFFSET;
>  }
>
> -static void *sve_pffr(struct task_struct *task)
> +static void *sve_pffr(struct thread_struct *thread)
>  {
> -	return (char *)task->thread.sve_state +
> -		sve_ffr_offset(task->thread.sve_vl);
> +	return (char *)thread->sve_state + sve_ffr_offset(thread->sve_vl);
>  }
>
>  static void change_cpacr(u64 val, u64 mask)
> @@ -253,7 +253,7 @@ static void task_fpsimd_load(void)
>  	WARN_ON(!in_softirq() && !irqs_disabled());
>
>  	if (system_supports_sve() && test_thread_flag(TIF_SVE))
> -		sve_load_state(sve_pffr(current),
> +		sve_load_state(sve_pffr(&current->thread),
>  			       &current->thread.uw.fpsimd_state.fpsr,
>  			       sve_vq_from_vl(current->thread.sve_vl) - 1);
>  	else
> @@ -284,7 +284,7 @@ void fpsimd_save(void)
>  				return;
>  			}
>
> -			sve_save_state(sve_pffr(current), &st->fpsr);
> +			sve_save_state(sve_pffr(&current->thread), &st->fpsr);
>  		} else
>  			fpsimd_save_state(st);
>  	}


--
Alex Benn?e
