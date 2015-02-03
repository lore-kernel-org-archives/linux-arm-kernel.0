From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 03 Feb 2015 11:00:35 -0800
Subject: [PATCH v4 3/6] ARM: Alpine: smp support
In-Reply-To: <54d0cd2c.9vODWxCn7cznpq0G%tsahee@annapurnalabs.com>
References: <54d0cd2c.9vODWxCn7cznpq0G%tsahee@annapurnalabs.com>
Message-ID: <54D11AD3.1030600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/15 05:29, Tsahee Zidenberg wrote:
> diff --git a/arch/arm/mach-alpine/alpine_cpu_pm.h b/arch/arm/mach-alpine/alpine_cpu_pm.h
> new file mode 100644
> index 0000000..4d32716
> --- /dev/null
> +++ b/arch/arm/mach-alpine/alpine_cpu_pm.h
> @@ -0,0 +1,26 @@
> +/*
> + * Low-level power-management support for Alpine platform.
> + *
> + * Copyright (C) 2015 Annapurna Labs Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __ALPINE_CPU_PM_H__
> +#define __ALPINE_CPU_PM_H__
> +
> +/* Alpine CPU Power Management Services Initialization */
> +void __init alpine_cpu_pm_init(void);

No need to have __init in header files.

>
> diff --git a/arch/arm/mach-alpine/platsmp.c b/arch/arm/mach-alpine/platsmp.c
> new file mode 100644
> index 0000000..43b7641
> --- /dev/null
> +++ b/arch/arm/mach-alpine/platsmp.c
> @@ -0,0 +1,49 @@
> +/*
> + * SMP operations for Alpine platform.
> + *
> + * Copyright (C) 2015 Annapurna Labs Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +
> +#include <asm/smp_plat.h>
> +
> +#include "alpine_cpu_pm.h"
> +
> +int __cpuinit alpine_boot_secondary(unsigned int cpu, struct task_struct *idle)

static? There's no such thing as __cpuinit anymore, please remove.

> +{
> +	phys_addr_t addr;
> +
> +	addr = virt_to_phys(secondary_startup);
> +
> +	if (addr > (phys_addr_t)(uint32_t)(-1)) {
> +		pr_err("FAIL: resume address over 32bit (%pa)", &addr);
> +		return -EINVAL;
> +	}
> +
> +	return alpine_cpu_wakeup(cpu_logical_map(cpu), (uint32_t)addr);
> +}
> +
> +void __init alpine_smp_prepare_cpus(unsigned int max_cpus)

static?

> +{
> +	alpine_cpu_pm_init();
> +}
> +
> +struct smp_operations __initdata alpine_smp_ops = {

static struct smp_operations alpine_smp_ops __initdata= {

> +	.smp_prepare_cpus	= alpine_smp_prepare_cpus,
> +	.smp_boot_secondary	= alpine_boot_secondary,
> +};
> +CPU_METHOD_OF_DECLARE(alpine_smp, "al,alpine-smp", &alpine_smp_ops);


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
