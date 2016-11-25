From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 25 Nov 2016 20:45:02 +0000
Subject: [RFC PATCH 13/29] arm64/sve: Basic support for KERNEL_MODE_NEON
In-Reply-To: <1480102762-23647-14-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
 <1480102762-23647-14-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAKv+Gu-MKdNHNrvSvMeoAoENdfscbAK0==NEMu6KJn8fjxz_tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2016 at 19:39, Dave Martin <Dave.Martin@arm.com> wrote:
> In order to enable CONFIG_KERNEL_MODE_NEON and things that rely on
> it to be configured together with Scalable Vector Extension support
> in the same kernel, this patch implements basic support for
> saving/restoring the SVE state around kernel_neon_begin()...
> kernel_neon_end().
>
> This patch is not optimal and will generally save more state than
> necessary, more often than necessary.  Further optimisations can be
> implemented in future patches.
>
> This patch is not intended to allow general-purpose _SVE_ code to
> execute in the kernel safely.  That functionality may also follow
> in later patches.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/Kconfig         |  1 -
>  arch/arm64/kernel/fpsimd.c | 22 ++++++++++++++++++----
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e8d04dd..7266761 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -880,7 +880,6 @@ endmenu
>  config ARM64_SVE
>         bool "ARM Scalable Vector Extension support"
>         default y
> -       depends on !KERNEL_MODE_NEON    # until it works with SVE
>         help
>           The Scalable Vector Extension (SVE) is an extension to the AArch64
>           execution state which complements and extends the SIMD functionality
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 81cfdb5..cb947dd 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -282,11 +282,26 @@ static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);
>   */
>  void kernel_neon_begin_partial(u32 num_regs)
>  {
> +       preempt_disable();
> +
> +       /*
> +        * For now, we have no special storage for SVE registers in
> +        * interrupt context, so always save the userland SVE state
> +        * if there is any, even for interrupts.
> +        */
> +       if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE) &&
> +           current->mm &&
> +           !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE)) {
> +               fpsimd_save_state(&current->thread.fpsimd_state);
> +               this_cpu_write(fpsimd_last_state, NULL);
> +       }
> +

I am having trouble understanding why we need all of this if we don't
support SVE in the kernel. Could you elaborate?

>         if (in_interrupt()) {
>                 struct fpsimd_partial_state *s = this_cpu_ptr(
>                         in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> -
>                 BUG_ON(num_regs > 32);
> +
> +               /* Save partial state for interrupted kernel-mode NEON code: */
>                 fpsimd_save_partial_state(s, roundup(num_regs, 2));
>         } else {
>                 /*
> @@ -295,7 +310,6 @@ void kernel_neon_begin_partial(u32 num_regs)
>                  * that there is no longer userland FPSIMD state in the
>                  * registers.
>                  */
> -               preempt_disable();
>                 if (current->mm &&
>                     !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
>                         fpsimd_save_state(&current->thread.fpsimd_state);
> @@ -310,9 +324,9 @@ void kernel_neon_end(void)
>                 struct fpsimd_partial_state *s = this_cpu_ptr(
>                         in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
>                 fpsimd_load_partial_state(s);
> -       } else {
> -               preempt_enable();
>         }
> +
> +       preempt_enable();
>  }
>  EXPORT_SYMBOL(kernel_neon_end);
>
> --
> 2.1.4
>
