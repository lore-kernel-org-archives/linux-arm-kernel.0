From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 27 Mar 2014 15:12:16 +0100
Subject: [PATCH 1/6] ARM: mvebu: introduce CPU reset code
In-Reply-To: <1395927485-11842-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395927485-11842-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1395927485-11842-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <533431C0.2040402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2014 02:38 PM, Thomas Petazzoni wrote:
> The Armada 370 and Armada XP have registers that allow to reset the
> CPUs, which is particularly useful to take the secondary CPUs out of
> reset in the context of the SMP support.

[...]

 > In our case, the CPU reset handling and the SMP core code are both
 > located in arch/arm/mach-mvebu/ and are tightly linked together,
 > so there's no real benefit in going through a separate framework.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---

[...]

> diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
> index 237c86b..991ab32 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.h
> +++ b/arch/arm/mach-mvebu/armada-370-xp.h
> @@ -18,7 +18,8 @@
>   #ifdef CONFIG_SMP
>   #include <linux/cpumask.h>
>
> -#define ARMADA_XP_MAX_CPUS 4
> +#define ARMADA_370_MAX_CPUS 1
> +#define ARMADA_XP_MAX_CPUS  4
>
>   void armada_mpic_send_doorbell(const struct cpumask *mask, unsigned int irq);
>   void armada_xp_mpic_smp_cpu_init(void);

[...]

> diff --git a/arch/arm/mach-mvebu/cpu-reset.c b/arch/arm/mach-mvebu/cpu-reset.c
> new file mode 100644
> index 0000000..2819887
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/cpu-reset.c
> @@ -0,0 +1,89 @@
> +/*
> + * Copyright (C) 2013 Marvell
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#define pr_fmt(fmt) "mvebu-cpureset: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_address.h>
> +#include <linux/io.h>
> +#include <linux/resource.h>
> +#include "armada-370-xp.h"
> +
> +static struct of_device_id of_cpu_reset_table[] = {
> +	{.compatible = "marvell,armada-370-cpu-reset", .data = (void*) ARMADA_370_MAX_CPUS },
> +	{.compatible = "marvell,armada-xp-cpu-reset",  .data = (void*) ARMADA_XP_MAX_CPUS },
> +	{ /* end of list */ },
> +};
> +
> +static void __iomem *cpu_reset_base;
> +static int ncpus;
> +
> +#define CPU_RESET_OFFSET(cpu) (cpu * 0x8)
> +#define CPU_RESET_ASSERT      BIT(0)
> +
> +int mvebu_cpu_reset_deassert(int cpu)
> +{
> +	u32 reg;
> +
> +	if (cpu >= ncpus)
> +		return -EINVAL;

Is this check required at all? I mean, the function is supposed to
be called from sane environments, that determine cpu to reset from
some ID register or so. Removing the check will allow you to remove
ncpus and therefore the scratchy (void *)CONST in the of_device_ids
above.

Sebastian

> +	if (!cpu_reset_base)
> +		return -ENODEV;
> +
> +	reg = readl(cpu_reset_base + CPU_RESET_OFFSET(cpu));
> +	reg &= ~CPU_RESET_ASSERT;
> +	writel(reg, cpu_reset_base + CPU_RESET_OFFSET(cpu));
> +
> +	return 0;
> +}
