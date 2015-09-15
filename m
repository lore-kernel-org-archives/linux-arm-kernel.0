From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 15 Sep 2015 14:11:10 +0200
Subject: [PATCH 1/2] arm64: fpsimd: Fix FPSIMD corruption in rt_sigreturn
 with CONFIG_PREEMPT
In-Reply-To: <1442316997-32282-1-git-send-email-will.deacon@arm.com>
References: <1442316997-32282-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAKv+Gu8Yt0T6AF7MmOtpPpk8VcDBVraSNMbgm03dW5BR1QMqsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 15 September 2015 at 13:36, Will Deacon <will.deacon@arm.com> wrote:
> From: Dave P Martin <Dave.Martin@arm.com>
>
> The arm64 context switch implementation uses a flag
> TIF_FOREIGN_FPSTATE to track whether the hardware FPSIMD regs are
> out of sync with the logical state of current's registers.
>
> During sigreturn, the registers and task_struct are temporarily out
> of sync, between writing the task_struct and loading its contents
> back into the FPSIMD registers -- however, TIF_FOREIGN_FPSTATE is
> not set.  This can cause the context switch code to discard some or
> all of the restored FPSIMD state if preemption occurs during the
> critical region of rt_sigreturn.
>
> This patch sets TIF_FOREIGN_FPSTATE before transferring the
> sigframe's saved registers back to the task_struct, so that the
> task_struct data will take precedence over the hardware registers
> if a context switch occurs before everything is back in sync.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> [will: removed preempt_{enable,disable} calls, added compat version]
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/signal.c   | 3 +++
>  arch/arm64/kernel/signal32.c | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index e18c48cb6db1..6d50d839b6e9 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -79,6 +79,9 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
>         if (magic != FPSIMD_MAGIC || size != sizeof(struct fpsimd_context))
>                 return -EINVAL;
>
> +       /* Ensure we don't reload stale data from the hardware registers */
> +       set_ti_thread_flag(current_thread_info(), TIF_FOREIGN_FPSTATE);
> +
>         /* copy the FP and status/control registers */
>         err = __copy_from_user(fpsimd.vregs, ctx->vregs,
>                                sizeof(fpsimd.vregs));

I am not following something here. If the task gets preempted before
the call to fpsimd_update_current_state(), it will proceed to
overwrite the registers with whatever is on the stack in fpsimd after
being scheduled back in, and everything should work fine, right?. So
the problem must lie /after/ (or during) the call to
fpsimd_update_current_state(), which does the following

void fpsimd_update_current_state(struct fpsimd_state *state)
{
        preempt_disable();
        fpsimd_load_state(state);
        if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
                struct fpsimd_state *st = &current->thread.fpsimd_state;

                this_cpu_write(fpsimd_last_state, st);
                st->cpu = smp_processor_id();
        }
        preempt_enable();
}

i.e., it copies the FP/SIMD state into the registers, and then marks
the h/w state of this cpu as the most recent for current.

It is not clear to me at which point the preemption is hitting when it
causes this problem.

Other than that, I think it may be more appropriate to call
fpsimd_flush_task_state() to invalidate any in-register copies of the
task's FP/SIMD state rather than setting the TIF flag directly (which
is normally only used as a shorthand to indicate that this cpu's
fpsimd_last_state and this tasks fpsimd_state::cpu are out of sync,
and set automatically by the context switch code)

-- 
Ard.




> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> index 948f0ad2de23..ae46ffad5aea 100644
> --- a/arch/arm64/kernel/signal32.c
> +++ b/arch/arm64/kernel/signal32.c
> @@ -273,6 +273,8 @@ static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *frame)
>         if (magic != VFP_MAGIC || size != VFP_STORAGE_SIZE)
>                 return -EINVAL;
>
> +       set_ti_thread_flag(current_thread_info(), TIF_FOREIGN_FPSTATE);
> +
>         /*
>          * Copy the FP registers into the start of the fpsimd_state.
>          * FIXME: Won't work if big endian.
> --
> 2.1.4
>
