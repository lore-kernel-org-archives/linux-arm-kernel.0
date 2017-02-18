From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 18 Feb 2017 09:36:02 +0000
Subject: [PATCH v4] ARM: wire up HWCAP/HWCAP2 feature bits to the CPU
 modalias
In-Reply-To: <1487230156-6016-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1487230156-6016-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9T2EY4ymKTOVjwiS1o1XbTumx3zyg=6kPDUokCcZcDdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 February 2017 at 07:29, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Wire up the generic support for exposing CPU feature bits via the
> modalias in /sys/device/system/cpu. This allows udev to automatically
> load modules for things like crypto algorithms that are implemented
> using optional instructions.
>
> Since it is non-trivial to transparantly support both HWCAP and HWCAP2
> capabilities in the cpu_feature() macro (which allows a module's hwcap
> dependency and init routine to be declared using a single invocation of
> module_cpu_feature_match()), support only HWCAP2 for now, which covers
> the capabilities that are most likely to be useful in this manner.
> Module dependencies on HWCAP will need to be declared explicitly via a
> MODULE_DEVICE_TABLE(cpu, ...) declaration.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v4: expose both elf_hwcap and elf_hwcap2 via the kernel modalias, and allow
>     both to be used in MODULE_DEVICE_TABLE()s, but keep cpu_feature() as
>     hwcap2 specific.
>

If there are no further remarks, I will go ahead and drop this version
into the patch system. Thanks.


> v3: add offset of 32 so that ELF_HWCAP could be added in the future as
>     well
>
>  arch/arm/Kconfig                  |  1 +
>  arch/arm/include/asm/cpufeature.h | 37 ++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 186c4c214e0a..53689e386c47 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -21,6 +21,7 @@ config ARM
>         select GENERIC_ALLOCATOR
>         select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
>         select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> +       select GENERIC_CPU_AUTOPROBE
>         select GENERIC_EARLY_IOREMAP
>         select GENERIC_IDLE_POLL_SETUP
>         select GENERIC_IRQ_PROBE
> diff --git a/arch/arm/include/asm/cpufeature.h b/arch/arm/include/asm/cpufeature.h
> new file mode 100644
> index 000000000000..9ac822e927ac
> --- /dev/null
> +++ b/arch/arm/include/asm/cpufeature.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (C) 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_CPUFEATURE_H
> +#define __ASM_CPUFEATURE_H
> +
> +#include <asm/hwcap.h>
> +
> +/*
> + * Due to the fact that ELF_HWCAP is a 32-bit type on ARM, and given the number
> + * of optional CPU features it defines, ARM's CPU hardware capability bits have
> + * been distributed over separate elf_hwcap and elf_hwcap2 variables, each of
> + * which covers a subset of the available CPU features.
> + *
> + * Currently, only a few of those are suitable for automatic module loading
> + * (which is the primary use case of this facility) and those happen to be all
> + * covered by HWCAP2. So let's only cover those via the cpu_feature()
> + * convenience macro for now (which is used by module_cpu_feature_match()).
> + * However, all capabilities are exposed via the modalias, and can be matched
> + * using an explicit MODULE_DEVICE_TABLE() that uses __hwcap_feature() directly.
> + */
> +#define MAX_CPU_FEATURES       64
> +#define __hwcap_feature(x)     ilog2(HWCAP_ ## x)
> +#define __hwcap2_feature(x)    (32 + ilog2(HWCAP2_ ## x))
> +#define cpu_feature(x)         __hwcap2_feature(x)
> +
> +static inline bool cpu_have_feature(unsigned int num)
> +{
> +       return num < 32 ? elf_hwcap & BIT(num) : elf_hwcap2 & BIT(num - 32);
> +}
> +
> +#endif
> --
> 2.7.4
>
