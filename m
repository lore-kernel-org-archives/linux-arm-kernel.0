From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 4 Dec 2017 13:46:57 +0000
Subject: [PATCH 2/3] arm64: fpsimd: Abstract out binding of task's fpsimd
 context to the cpu.
In-Reply-To: <1512141582-17474-3-git-send-email-Dave.Martin@arm.com>
References: <1512141582-17474-1-git-send-email-Dave.Martin@arm.com>
 <1512141582-17474-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAKv+Gu8BzFrc1U7r7iURfZqGKRqpwHJVFM6hvHOX5xghrXojtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 December 2017 at 15:19, Dave Martin <Dave.Martin@arm.com> wrote:
> There is currently some duplicate logic to associate current's
> FPSIMD context with the cpu when loading FPSIMD state into the cpu
> regs.
>
> Subsequent patches will update that logic, so in order to ensure it
> only needs to be done in one place, this patch factors the relevant
> code out into a new function fpsimd_bind_to_cpu().
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/fpsimd.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 143b3e7..007140b 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -992,6 +992,18 @@ void fpsimd_signal_preserve_current_state(void)
>  }
>
>  /*
> + * Associate current's FPSIMD context with this cpu
> + * Preemption must be disabled when calling this function.
> + */
> +static void fpsimd_bind_to_cpu(void)
> +{
> +       struct fpsimd_state *st = &current->thread.fpsimd_state;
> +
> +       __this_cpu_write(fpsimd_last_state, st);
> +       st->cpu = smp_processor_id();
> +}
> +
> +/*
>   * Load the userland FPSIMD state of 'current' from memory, but only if the
>   * FPSIMD state already held in the registers is /not/ the most recent FPSIMD
>   * state of 'current'
> @@ -1004,11 +1016,8 @@ void fpsimd_restore_current_state(void)
>         local_bh_disable();
>
>         if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> -               struct fpsimd_state *st = &current->thread.fpsimd_state;
> -
>                 task_fpsimd_load();
> -               __this_cpu_write(fpsimd_last_state, st);
> -               st->cpu = smp_processor_id();
> +               fpsimd_bind_to_cpu();
>         }
>
>         local_bh_enable();
> @@ -1032,12 +1041,8 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
>         }
>         task_fpsimd_load();
>
> -       if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> -               struct fpsimd_state *st = &current->thread.fpsimd_state;
> -
> -               __this_cpu_write(fpsimd_last_state, st);
> -               st->cpu = smp_processor_id();
> -       }
> +       if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE))
> +               fpsimd_bind_to_cpu();
>
>         local_bh_enable();
>  }

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
