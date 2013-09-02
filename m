From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 2 Sep 2013 09:13:16 +0200
Subject: [PATCH v2] arm64: add support for kernel mode NEON
In-Reply-To: <1373375892-25390-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1373375892-25390-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu_KsXMM=ax4+0ozZchEidZ=6NktWQ+iw1Q45xUEtCYi7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

Now that the ARM version of this patch has been accepted by Russell,
would you please consider taking this in as well?

Regards,
Ard.


On 9 July 2013 15:18, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Add <asm/neon.h> containing kernel_neon_begin/kernel_neon_end function
> declarations and corresponding definitions in fpsimd.c
>
> These are needed to wrap uses of NEON in kernel mode. The names are
> identical to the ones used in arm/ so code using intrinsics or
> vectorized by GCC can be shared between arm and arm64.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/Kconfig            |  3 +++
>  arch/arm64/include/asm/neon.h | 14 ++++++++++++++
>  arch/arm64/kernel/fpsimd.c    | 28 ++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
>  create mode 100644 arch/arm64/include/asm/neon.h
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 56b3f6d..46ba680 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -95,6 +95,9 @@ config SWIOTLB
>  config IOMMU_HELPER
>         def_bool SWIOTLB
>
> +config KERNEL_MODE_NEON
> +       def_bool y
> +
>  source "init/Kconfig"
>
>  source "kernel/Kconfig.freezer"
> diff --git a/arch/arm64/include/asm/neon.h b/arch/arm64/include/asm/neon.h
> new file mode 100644
> index 0000000..b0cc58a9
> --- /dev/null
> +++ b/arch/arm64/include/asm/neon.h
> @@ -0,0 +1,14 @@
> +/*
> + * linux/arch/arm64/include/asm/neon.h
> + *
> + * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define cpu_has_neon()         (1)
> +
> +void kernel_neon_begin(void);
> +void kernel_neon_end(void);
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index e8b8357..1f2e4d5 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -21,6 +21,7 @@
>  #include <linux/init.h>
>  #include <linux/sched.h>
>  #include <linux/signal.h>
> +#include <linux/hardirq.h>
>
>  #include <asm/fpsimd.h>
>  #include <asm/cputype.h>
> @@ -83,6 +84,33 @@ void fpsimd_flush_thread(void)
>         fpsimd_load_state(&current->thread.fpsimd_state);
>  }
>
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +
> +/*
> + * Kernel-side NEON support functions
> + */
> +void kernel_neon_begin(void)
> +{
> +       /* Avoid using the NEON in interrupt context */
> +       BUG_ON(in_interrupt());
> +       preempt_disable();
> +
> +       if (current->mm)
> +               fpsimd_save_state(&current->thread.fpsimd_state);
> +}
> +EXPORT_SYMBOL(kernel_neon_begin);
> +
> +void kernel_neon_end(void)
> +{
> +       if (current->mm)
> +               fpsimd_load_state(&current->thread.fpsimd_state);
> +
> +       preempt_enable();
> +}
> +EXPORT_SYMBOL(kernel_neon_end);
> +
> +#endif /* CONFIG_KERNEL_MODE_NEON */
> +
>  /*
>   * FP/SIMD support code initialisation.
>   */
> --
> 1.8.1.2
>
