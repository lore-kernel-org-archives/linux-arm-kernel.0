From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 18 Jun 2012 09:58:06 +0900
Subject: [RFC PATCH] ARM: Make a compile trustzone conditionally
In-Reply-To: <20120611051502.GA24030@july>
References: <20120611051502.GA24030@july>
Message-ID: <CAH9JG2UujiQr2ixs7kqpP9vLi=cpswwTGWNPnEcC_5_XgH_esw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Any comments?

On 6/11/12, Kyungmin Park <kmpark@infradead.org> wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> Some boards can use the trustzone but others can't use trustzone.
> However we need to build it simultaneously. To address this issue,
> introduce arm trustzone support and use it at each board files.
>
> e.g., In boot_secondary at mach-exynos/platsmp.c
>
> 	__raw_writel(virt_to_phys(exynos4_secondary_startup),
> 		CPU1_BOOT_REG);
>
> 	if (trustzone_enabled()) {
> 		/* Call Exynos specific smc call */
> 		/* exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0); */
> 	}
>
> 	gic_raise_softirq(cpumask_of(cpu), 1);
>
> 	if (pen_release == -1)
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> index 283fa1d..16b7047 100644
> --- a/arch/arm/common/Kconfig
> +++ b/arch/arm/common/Kconfig
> @@ -21,6 +21,9 @@ config ARM_VIC_NR
>  	  The maximum number of VICs available in the system, for
>  	  power management.
>
> +config ARM_TRUSTZONE
> +	bool
> +
>  config ICST
>  	bool
>
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index e8a4e58..5820e49 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -4,6 +4,7 @@
>
>  obj-$(CONFIG_ARM_GIC)		+= gic.o
>  obj-$(CONFIG_ARM_VIC)		+= vic.o
> +obj-$(CONFIG_ARM_TRUSTZONE)	+= trustzone.o
>  obj-$(CONFIG_ICST)		+= icst.o
>  obj-$(CONFIG_SA1111)		+= sa1111.o
>  obj-$(CONFIG_PCI_HOST_VIA82C505) += via82c505.o
> diff --git a/arch/arm/common/trustzone.c b/arch/arm/common/trustzone.c
> new file mode 100644
> index 0000000..5104a1f
> --- /dev/null
> +++ b/arch/arm/common/trustzone.c
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (C) 2012 Samsung Electronics.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include <asm/cache.h>
> +
> +static bool trustzone_enable __read_mostly = false;
> +
> +bool trustzone_enabled(void)
> +{
> +	return trustzone_enable;
> +}
> +
> +void trustzone_set_enable(void)
> +{
> +	trustzone_enable = true;
> +}
> diff --git a/arch/arm/include/asm/trustzone.h
> b/arch/arm/include/asm/trustzone.h
> new file mode 100644
> index 0000000..126dd22
> --- /dev/null
> +++ b/arch/arm/include/asm/trustzone.h
> @@ -0,0 +1,20 @@
> +/*
> + *  Copyright (C) 2012 Samsung Electronics.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_ARM_TRUSTZONE_H
> +#define __ASM_ARM_TRUSTZONE_H
> +
> +#ifdef CONFIG_ARM_TRUSTZONE
> +extern bool trustzone_enabled(void);
> +extern void trustzone_set_enable(void);
> +#else
> +#define trustzone_enabled()		(0)
> +#define trustzone_set_enable()		do { } while (0)
> +#endif
> +
> +#endif
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
