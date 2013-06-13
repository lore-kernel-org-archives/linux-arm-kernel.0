From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 13 Jun 2013 16:49:49 +0100
Subject: [PATCH v2 3/3] ARM: keystone: Enable SMP support on Keystone
 machines
In-Reply-To: <1371072317-15030-4-git-send-email-santosh.shilimkar@ti.com>
References: <1371072317-15030-1-git-send-email-santosh.shilimkar@ti.com>
 <1371072317-15030-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130613154949.GD27414@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 10:25:17PM +0100, Santosh Shilimkar wrote:
> Add basic SMP support for Keystone machines. This does not
> include support for CPU hotplug for now.
> 
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: arm at kernel.org
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-keystone/Kconfig    |    1 +
>  arch/arm/mach-keystone/Makefile   |    1 +
>  arch/arm/mach-keystone/keystone.c |    4 +++
>  arch/arm/mach-keystone/keystone.h |   17 ++++++++++++
>  arch/arm/mach-keystone/platsmp.c  |   52 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 75 insertions(+)
>  create mode 100644 arch/arm/mach-keystone/keystone.h
>  create mode 100644 arch/arm/mach-keystone/platsmp.c
> 

[...]

> diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
> new file mode 100644
> index 0000000..630ab3b
> --- /dev/null
> +++ b/arch/arm/mach-keystone/platsmp.c
> @@ -0,0 +1,52 @@
> +/*
> + * Keystone SOC SMP platform code
> + *
> + * Copyright 2013 Texas Instruments, Inc.
> + *	Cyril Chemparathy <cyril@ti.com>
> + *	Santosh Shilimkar <santosh.shillimkar@ti.com>
> + *
> + * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/smp.h>
> +#include <linux/io.h>
> +
> +#include <asm/smp_plat.h>
> +#include <asm/prom.h>
> +
> +#include "keystone.h"
> +
> +static int __cpuinit keystone_smp_boot_secondary(unsigned int cpu,
> +						struct task_struct *idle)
> +{
> +	unsigned long start = virt_to_phys(&secondary_startup);
> +	int error;
> +
> +	pr_debug("keystone-smp: booting cpu %d, vector %08lx\n",
> +		 cpu, start);
> +
> +	asm volatile (
> +		"mov    r0, #0\n"	/* power on cmd	*/
> +		"mov    r1, %1\n"	/* cpu		*/
> +		"mov    r2, %2\n"	/* start	*/
> +		".inst  0xe1600070\n"	/* smc #0	*/

In arch/arm/asm/opcodes-sec.h we have an __SMC() macro you could use here
that'll use the correct opcode for arm or thumb kernels.

Thanks,
Mark.
