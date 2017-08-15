From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 15 Aug 2017 18:11:27 +0100
Subject: [PATCH 05/27] arm64: fpsimd: Simplify uses of {set,
 clear}_ti_thread_flag()
In-Reply-To: <1502280338-23002-6-git-send-email-Dave.Martin@arm.com>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
 <1502280338-23002-6-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAKv+Gu8DsJTeX8=yWNd6vAaFQqBbQdcjyCBgiFhLAq9JiyEGRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 August 2017 at 13:05, Dave Martin <Dave.Martin@arm.com> wrote:
> The existing FPSIMD context switch code contains a couple of
> instances of {set,clear}_ti_thread(task_thread_info(task)).  Since
> there are thread flag manipulators that operate directly on
> task_struct, this verbosity isn't strictly needed.
>
> For consistency, this patch simplifies the affected calls.  This
> should have no impact on behaviour.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/kernel/fpsimd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 138fcfa..9c1f268e 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -159,11 +159,9 @@ void fpsimd_thread_switch(struct task_struct *next)
>
>                 if (__this_cpu_read(fpsimd_last_state) == st
>                     && st->cpu == smp_processor_id())
> -                       clear_ti_thread_flag(task_thread_info(next),
> -                                            TIF_FOREIGN_FPSTATE);
> +                       clear_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
>                 else
> -                       set_ti_thread_flag(task_thread_info(next),
> -                                          TIF_FOREIGN_FPSTATE);
> +                       set_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
>         }
>  }
>
> --
> 2.1.4
>
