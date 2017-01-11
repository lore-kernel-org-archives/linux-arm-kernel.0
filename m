From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Jan 2017 17:40:11 +0000
Subject: [RFC PATCH 1/2] ARM: vfp - allow kernel mode NEON in softirq
 context
In-Reply-To: <1483991849-32448-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1483991849-32448-1-git-send-email-ard.biesheuvel@linaro.org>
 <1483991849-32448-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu-ykMwg7ta41viF3pvtdmbkRBv+v09n87ZhQs3TiVXmuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2017 at 19:57, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This updates the kernel mode NEON handling to allow the NEON to be used
> in softirq context as well as process context. This involves disabling
> softirq processing when the NEON is used in kernel mode in process context,
> and dealing with the situation where 'current' is not the owner of the
> userland context that is present in the NEON register file when the NEON
> is enabled in kernel mode.
>
> The rationale for this change is that the NEON is shared with the ARMv8
> Crypto Extensions (which are also defined for the AArch32 execution state),
> which can give a huge performance boost (15x) to use cases like mac80211
> CCMP processing, which executes in softirq context.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/vfp/vfpmodule.c | 22 ++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 569d5a650a4a..814752811537 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -690,26 +690,33 @@ void kernel_neon_begin(void)
>         u32 fpexc;
>
>         /*
> -        * Kernel mode NEON is only allowed outside of interrupt context
> +        * Kernel mode NEON is only allowed outside of hardirq context
>          * with preemption disabled. This will make sure that the kernel
>          * mode NEON register contents never need to be preserved.
>          */
> -       BUG_ON(in_interrupt());
> +       BUG_ON(in_irq());
>         cpu = get_cpu();
>
> +       /*
> +        * Disable softirq processing while the NEON is used by the kernel in
> +        * process context. This ensures that only a single kernel mode NEON
> +        * state is live at any given time.
> +        */
> +       if (!in_serving_softirq())
> +               local_bh_disable();
> +
>         fpexc = fmrx(FPEXC) | FPEXC_EN;
>         fmxr(FPEXC, fpexc);
>
>         /*
> -        * Save the userland NEON/VFP state. Under UP,
> -        * the owner could be a task other than 'current'
> +        * Save the userland NEON/VFP state. Under UP, or when executing in
> +        * softirq context, the owner could be a task other than 'current'
>          */
>         if (vfp_state_in_hw(cpu, thread))
>                 vfp_save_state(&thread->vfpstate, fpexc);
> -#ifndef CONFIG_SMP
>         else if (vfp_current_hw_state[cpu] != NULL)
>                 vfp_save_state(vfp_current_hw_state[cpu], fpexc);
> -#endif
> +

Actually, I think this should not be necessary (and the change to the
comment is incorrect). Whether we're in process or softirq context
makes no difference here, and the comment is slightly confusing: under
SMP, the owner could also be a task other than 'current', but due to
the eager preserve, the latest userland NEON state will already have
been recorded, and there is no need doing it again.

>         vfp_current_hw_state[cpu] = NULL;
>  }
>  EXPORT_SYMBOL(kernel_neon_begin);
> @@ -718,7 +725,10 @@ void kernel_neon_end(void)
>  {
>         /* Disable the NEON/VFP unit. */
>         fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
> +       if (!in_serving_softirq())
> +               local_bh_enable();
>         put_cpu();
> +
>  }
>  EXPORT_SYMBOL(kernel_neon_end);
>
> --
> 2.7.4
>
