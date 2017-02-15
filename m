From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 15 Feb 2017 21:52:21 +0000
Subject: [PATCH v3] ARM: wire up HWCAP2 feature bits to the CPU modalias
In-Reply-To: <1487194638-19675-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1487194638-19675-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <8211F33E-4899-483F-8927-E0E6215797D9@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 15 Feb 2017, at 21:37, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> 
> Wire up the generic support for exposing CPU feature bits via the
> modalias in /sys/device/system/cpu. This allows udev to automatically
> load modules for things like crypto algorithms that are implemented
> using optional instructions.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v3: add offset of 32 so that ELF_HWCAP could be added in the future as
>    well
> 
> arch/arm/Kconfig                  |  1 +
> arch/arm/include/asm/cpufeature.h | 32 ++++++++++++++++++++
> 2 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 186c4c214e0a..53689e386c47 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -21,6 +21,7 @@ config ARM
>    select GENERIC_ALLOCATOR
>    select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
>    select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> +    select GENERIC_CPU_AUTOPROBE
>    select GENERIC_EARLY_IOREMAP
>    select GENERIC_IDLE_POLL_SETUP
>    select GENERIC_IRQ_PROBE
> diff --git a/arch/arm/include/asm/cpufeature.h b/arch/arm/include/asm/cpufeature.h
> new file mode 100644
> index 000000000000..ec3ad45761aa
> --- /dev/null
> +++ b/arch/arm/include/asm/cpufeature.h
> @@ -0,0 +1,32 @@
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
> + * of optional CPU features it defines, ARM's CPU capability bits have been
> + * distributed over separate elf_hwcap and elf_hwcap2 variables, each of which
> + * covers a subset of the available CPU features.
> + *
> + * Currently, only a few of those are suitable for automatic module loading
> + * (which is the primary use case of this facility) and those happen to be all
> + * covered by HWCAP2. So let's only expose those via the CPU modalias for now.
> + */
> +#define MAX_CPU_FEATURES    64
> +#define cpu_feature(x)        (32 + ilog2(HWCAP2_ ## x))
> +
> +static inline bool cpu_have_feature(unsigned int num)
> +{

Grr forgot to handle num < 32 here

> +    return elf_hwcap2 & (1UL << (num - 32));
> +}
> +
> +#endif
> -- 
> 2.7.4
> 
