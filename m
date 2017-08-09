From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 9 Aug 2017 14:57:24 +0100
Subject: [PATCH] arm64: neon: Forbid when irqs are disabled
In-Reply-To: <1502275408-16982-1-git-send-email-Dave.Martin@arm.com>
References: <1502275408-16982-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAKv+Gu9QB=yPsNhe+=O=DK1z8S9uGizZie50+mBqbFEG3OJYJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 August 2017 at 11:43, Dave Martin <Dave.Martin@arm.com> wrote:
> Currently, may_use_simd() can return true if IRQs are disabled.  If
> the caller goes ahead and calls kernel_neon_begin(), this can
> result in use of local_bh_enable() in an unsafe context.
>
> In particular, __efi_fpsimd_begin() may do this when calling EFI as
> part of system shutdown.
>
> This patch ensures that callers don't think they can use
> kernel_neon_begin() in such a context.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/include/asm/simd.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> index 5a1a927..fa8b3fe 100644
> --- a/arch/arm64/include/asm/simd.h
> +++ b/arch/arm64/include/asm/simd.h
> @@ -10,6 +10,7 @@
>  #define __ASM_SIMD_H
>
>  #include <linux/compiler.h>
> +#include <linux/irqflags.h>
>  #include <linux/percpu.h>
>  #include <linux/preempt.h>
>  #include <linux/types.h>
> @@ -40,7 +41,8 @@ static __must_check inline bool may_use_simd(void)
>          * can't migrate to another CPU and spuriously see it become
>          * false.
>          */
> -       return !in_irq() && !in_nmi() && !raw_cpu_read(kernel_neon_busy);
> +       return !in_irq() && !irqs_disabled() && !in_nmi() &&
> +               !raw_cpu_read(kernel_neon_busy);
>  }
>
>  #else /* ! CONFIG_KERNEL_MODE_NEON */
> --
> 2.1.4
>
