From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 24 Aug 2012 18:40:16 +0200
Subject: [PATCH v5 1/2] ARM: Make a compile firmware conditionally
In-Reply-To: <20120824083351.GA25369@july>
References: <20120824083351.GA25369@july>
Message-ID: <1672307.utfAA3y7zd@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday 24 of August 2012 17:33:51 Kyungmin Park wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Some boards can use the firmware at trustzone but others can't use this.
> However we need to build it simultaneously. To address this issue,
> introduce arm firmware support and use it at each board files.
> 
> e.g., In boot_secondary at mach-exynos/platsmp.c
> 
>         __raw_writel(virt_to_phys(exynos4_secondary_startup),
>                 CPU1_BOOT_REG);
> 
>         if (IS_ENABLED(CONFIG_ARM_FIRMWARE)) {
>                 /* Call Exynos specific smc call */
>                 do_firmware_op(cpu_boot, cpu);
>         }

There is no need for if (IS_ENABLED(CONFIG_ARM_FIRMWARE)) now when we have 
conditional call_firmware_op macro.

Also I guess there is a typo: s/do_firmware_op/call_firmware_op/ .

--
Best regards,
Tomasz Figa

>         gic_raise_softirq(cpumask_of(cpu), 1);
> 
>         if (pen_release == -1)
> 
> e.g., exynos4412 based board
> 
> static void __init board_init_early(void)
> {
>         exynos_firmware_init();
> }
> 
> TODO
>         1. DT support.
>         2. call firmware init by smp_ops.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changelog v4
> 	use call_firmware_op commented by Tomasz Figa.
> 	remove useless core_initcall
> 
> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> index 283fa1d..5b097ca 100644
> --- a/arch/arm/common/Kconfig
> +++ b/arch/arm/common/Kconfig
> @@ -21,6 +21,9 @@ config ARM_VIC_NR
>  	  The maximum number of VICs available in the system, for
>  	  power management.
> 
> +config ARM_FIRMWARE
> +	bool
> +
>  config ICST
>  	bool
> 
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index e8a4e58..4af6568 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -4,6 +4,7 @@
> 
>  obj-$(CONFIG_ARM_GIC)		+= gic.o
>  obj-$(CONFIG_ARM_VIC)		+= vic.o
> +obj-$(CONFIG_ARM_FIRMWARE)	+= firmware.o
>  obj-$(CONFIG_ICST)		+= icst.o
>  obj-$(CONFIG_SA1111)		+= sa1111.o
>  obj-$(CONFIG_PCI_HOST_VIA82C505) += via82c505.o
> diff --git a/arch/arm/common/firmware.c b/arch/arm/common/firmware.c
> new file mode 100644
> index 0000000..e375e9f
> --- /dev/null
> +++ b/arch/arm/common/firmware.c
> @@ -0,0 +1,25 @@
> +/*
> + *  Copyright (C) 2012 Samsung Electronics.
> + *  Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/suspend.h>
> +
> +#include <asm/firmware.h>
> +
> +static void cpu_boot(int cpu)
> +{
> +	/* Do nothing */
> +}
> +
> +static struct firmware_ops default_firmware_ops = {
> +	.do_idle		= cpu_do_idle,
> +	.cpu_boot		= cpu_boot,
> +};
> +
> +struct firmware_ops *firmware_ops = &default_firmware_ops;
> diff --git a/arch/arm/include/asm/firmware.h
> b/arch/arm/include/asm/firmware.h new file mode 100644
> index 0000000..99c97ff
> --- /dev/null
> +++ b/arch/arm/include/asm/firmware.h
> @@ -0,0 +1,27 @@
> +/*
> + *  Copyright (C) 2012 Samsung Electronics.
> + *  Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_ARM_FIRMWARE_H
> +#define __ASM_ARM_FIRMWARE_H
> +
> +struct firmware_ops {
> +	int	(*do_idle)(void);
> +	void	(*cpu_boot)(int cpu);
> +};
> +
> +extern struct firmware_ops *firmware_ops;
> +
> +#ifdef CONFIG_ARM_FIRMWARE
> +#define call_firmware_op(op, ...)					\
> +	((firmware_ops->op) ? firmware_ops->op(__VA_ARGS__) : 0)
> +#else
> +#define call_firmware_op(op, ...)		do { } while (0)
> +#endif
> +
> +#endif
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
