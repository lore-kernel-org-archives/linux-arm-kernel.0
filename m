From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 03 Nov 2015 10:55:04 +0900
Subject: [PATCH v3 3/7] ARCH: EXYNOS: split up exynos3250 SoC specific PMU
 data
In-Reply-To: <1445864143-25695-4-git-send-email-pankaj.dubey@samsung.com>
References: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
 <1445864143-25695-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <563813F8.6000201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.10.2015 21:55, Pankaj Dubey wrote:
> This patch splits up mach-exynos/pmu.c file, and moves exynos3250 PMU
> configuration data and functions handing those data into exynos3250
> SoC specific PMU file mach-exynos/exynos3250-pmu.c.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/Makefile         |   2 +-
>  arch/arm/mach-exynos/exynos-pmu.h     |  47 +++++++++
>  arch/arm/mach-exynos/exynos3250-pmu.c | 175 +++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/pmu.c            | 189 +---------------------------------
>  4 files changed, 224 insertions(+), 189 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/exynos-pmu.h
>  create mode 100644 arch/arm/mach-exynos/exynos3250-pmu.c
> 
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index 2f30676..e869f86 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -9,7 +9,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)
>  
>  # Core
>  
> -obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o
> +obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o exynos3250-pmu.o
>  
>  obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
>  obj-$(CONFIG_PM_SLEEP)		+= suspend.o
> diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/arch/arm/mach-exynos/exynos-pmu.h
> new file mode 100644
> index 0000000..2da4964
> --- /dev/null
> +++ b/arch/arm/mach-exynos/exynos-pmu.h
> @@ -0,0 +1,47 @@
> +/*
> + * Copyright (c) 2015 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Header for EXYNOS PMU Driver support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __EXYNOSPMU_H
> +#define __EXYNOSPMU_H

__EXYNOS_PMU_H
(and rename it in last patch)

> +
> +#include <linux/io.h>
> +
> +#define PMU_TABLE_END	(-1U)
> +
> +extern void __iomem *pmu_base_addr;
> +
> +struct exynos_pmu_conf {
> +	unsigned int offset;
> +	u8 val[NUM_SYS_POWERDOWN];
> +};
> +
> +struct exynos_pmu_data {
> +	const struct exynos_pmu_conf *pmu_config;
> +	const struct exynos_pmu_conf *pmu_config_extra;
> +
> +	void (*pmu_init)(void);
> +	void (*powerdown_conf)(enum sys_powerdown);
> +	void (*powerdown_conf_extra)(enum sys_powerdown);
> +};
> +
> +static inline void pmu_raw_writel(u32 val, u32 offset)
> +{
> +	writel_relaxed(val, pmu_base_addr + offset);
> +}
> +
> +static inline u32 pmu_raw_readl(u32 offset)
> +{
> +	return readl_relaxed(pmu_base_addr + offset);
> +}

These shouldn't be static inlines in header because you will duplicate
it in each compiled object. Leave optimizations to compiler.

Rest looks good,
Krzysztof
