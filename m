From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 1 Sep 2014 08:32:40 +0200
Subject: [PATCH v2] arm64: fix bug for reloading FPSIMD state after cpu
 power off
In-Reply-To: <1409540991-7573-1-git-send-email-leoy@marvell.com>
References: <1409540991-7573-1-git-send-email-leoy@marvell.com>
Message-ID: <CAKv+Gu998+fVe3=ufC-37LXke3brG12k1=1vGxiSfkcWrHhv6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 September 2014 05:09, Leo Yan <leoy@marvell.com> wrote:
> Now arm64 defers reloading FPSIMD state, but this optimization also
> introduces the bug after cpu resume back from low power mode.
>
> The reason is after the cpu has been powered off, s/w need set the
> cpu's fpsimd_last_state to NULL so that it will force to reload
> FPSIMD state for the thread, otherwise there has the chance to meet
> the condition for both the task's fpsimd_state.cpu field contains the
> id of the current cpu, and the cpu's fpsimd_last_state per-cpu variable
> points to the task's fpsimd_state, so finally kernel will skip to reload
> the context during it return back to userland.
>
> Signed-off-by: Leo Yan <leoy@marvell.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/kernel/fpsimd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index ad8aebb..3dca156 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -270,6 +270,7 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>         case CPU_PM_ENTER:
>                 if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
>                         fpsimd_save_state(&current->thread.fpsimd_state);
> +               this_cpu_write(fpsimd_last_state, NULL);
>                 break;
>         case CPU_PM_EXIT:
>                 if (current->mm)
> --
> 1.9.1
>
