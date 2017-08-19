From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 19 Aug 2017 11:58:00 +0100
Subject: [PATCH] arm64: fpsimd: Prevent registers leaking across exec
In-Reply-To: <1503071821-13845-1-git-send-email-Dave.Martin@arm.com>
References: <1503071821-13845-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAKv+Gu8w0Mr61LZ57fLxCuHqakfYMt1tvMfbbTdNAeaOYoVTYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 August 2017 at 16:57, Dave Martin <Dave.Martin@arm.com> wrote:
> There are some tricky dependencies between the different stages of
> flushing the FPSIMD register state during exec, and these can race
> with context switch in ways that can cause the old task's regs to
> leak across.  In particular, a context switch during the memset() can
> cause some of the task's old FPSIMD registers to reappear.
>
> Disabling preemption for this small window would be no big deal for
> performance: preemption is already disabled for similar scenarios
> like updating the FPSIMD registers in sigreturn.
>
> So, instead of rearranging things in ways that might swap existing
> subtle bugs for new ones, this patch just disables preemption
> around the FPSIMD state flushing so that races of this type can't
> occur here.  This brings fpsimd_flush_thread() into line with other
> code paths.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: stable at vger.kernel.org
> Fixes: 674c242c9323 ("arm64: flush FP/SIMD state correctly after execve()")
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>
> NOTE TO MAINTAINERS: This is a fix, applicable to *v4.13* and stable.
>
> The kernel-mode NEON rework already queued for v4.14 turns this into a
> local_bh_disable() as a side effect, so does not strictly need this
> patch.  When merging, the queued v4.14 changes should be retained.
>
>  arch/arm64/kernel/fpsimd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 06da8ea..c7b4995 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -161,9 +161,11 @@ void fpsimd_flush_thread(void)
>  {
>         if (!system_supports_fpsimd())
>                 return;
> +       preempt_disable();
>         memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
>         fpsimd_flush_task_state(current);
>         set_thread_flag(TIF_FOREIGN_FPSTATE);
> +       preempt_enable();
>  }
>
>  /*
> --
> 2.1.4
>
