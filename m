From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 11 Jun 2013 16:10:32 -0400
Subject: [PATCH 1/3] ARM: keystone: Add minimal TI Keystone platform
 support
In-Reply-To: <3148358.YM4iO29jiR@wuerfel>
References: <1370894123-26846-1-git-send-email-santosh.shilimkar@ti.com>
 <1370894123-26846-2-git-send-email-santosh.shilimkar@ti.com>
 <3148358.YM4iO29jiR@wuerfel>
Message-ID: <51B78438.6090604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 June 2013 03:27 PM, Arnd Bergmann wrote:
> On Monday 10 June 2013 15:55:21 Santosh Shilimkar wrote:
>>
>> diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
>> new file mode 100644
>> index 0000000..62e968c
>> --- /dev/null
>> +++ b/arch/arm/configs/keystone_defconfig
>> @@ -0,0 +1,157 @@
>> +# CONFIG_SWAP is not set
>> +CONFIG_POSIX_MQUEUE=y
>> +CONFIG_HIGH_RES_TIMERS=y
>> +CONFIG_IKCONFIG=y
> 
> How about adding the things you need to multi_v7_defconfig instead?
> We try not to have too many defconfigs.
>
I initially thought about it but after looking at various subsystems needed
(from internal trees), we will need to 1 custom defoconfig and my plan
is to limit to only one for all Keystone machines.

>> diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
>> new file mode 100644
>> index 0000000..39fab74
>> --- /dev/null
>> +++ b/arch/arm/mach-keystone/Kconfig
>> @@ -0,0 +1,16 @@
>> +config ARCH_KEYSTONE
>> +	bool "Texas Instruments Keystone Devices"
>> +	select CPU_V7
>> +	select ARM_GIC
>> +	select HAVE_ARM_ARCH_TIMER
>> +	select USE_OF
>> +	select MULTI_IRQ_HANDLER
>> +	select CLKSRC_MMIO
>> +	select GENERIC_CLOCKEVENTS
>> +	select SPARSE_IRQ
>> +	select HAVE_SCHED_CLOCK
>> +	select ARCH_WANT_OPTIONAL_GPIOLIB
>> +	select ARM_ERRATA_798181
> 
> You don't need to select any of the options that are already selected
> by CONFIG_ARCH_MULTIPLATFORM.
> 
Good to know.

> Please add a 'depends on ARCH_MULTI_V7' statement in there to prevent
> this option from showing up for incompatible platforms.
> 
Will do.

>> diff --git a/arch/arm/mach-keystone/include/mach/timex.h b/arch/arm/mach-keystone/include/mach/timex.h
>> new file mode 100644
>> index 0000000..e4c595a
>> --- /dev/null
>> +++ b/arch/arm/mach-keystone/include/mach/timex.h
>> @@ -0,0 +1,15 @@
>> +/*
>> + * Copyright 2013 Texas Instruments, Inc.
>> + *	Cyril Chemparathy <cyril@ti.com>
>> + *	Santosh Shilimkar <santosh.shillimkar@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + */
>> +#ifndef __MACH_TIMEX_H
>> +#define __MACH_TIMEX_H
>> +
>> +#define CLOCK_TICK_RATE		1000000
>> +
>> +#endif
> 
> Not needed any more
> 
ok

>> diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
>> new file mode 100644
>> index 0000000..6c6fc42
>> --- /dev/null
>> +++ b/arch/arm/mach-keystone/keystone.c
> 
>> +static void __iomem *keystone_rstctrl;
>> +
>> +static void __init keystone_init(void)
>> +{
>> +	struct device_node *node;
>> +
>> +	node = of_find_compatible_node(NULL, NULL, "ti,keystone-reset");
>> +	if (WARN_ON(!node)) {
>> +		pr_warn("ti, keystone-reset node undefined\n");
>> +		return;
>> +	}
>> +
>> +	keystone_rstctrl = of_iomap(node, 0);
>> +	if (WARN_ON(!keystone_rstctrl)) {
>> +		pr_warn("ti, keystone-reset iomap error\n");
>> +		return;
>> +	}
>> +
>> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>> +}
>> +
>> +static const char *keystone_match[] __initconst = {
>> +	"ti,keystone-evm",
>> +	NULL,
>> +};
>> +
>> +void keystone_restart(char mode, const char *cmd)
>> +{
>> +	u32 val;
>> +
>> +	/* Enable write access to RSTCTRL */
>> +	val = __raw_readl(keystone_rstctrl);
>> +	val &= PLL_RESET_WRITE_KEY_MASK;
>> +	val |= PLL_RESET_WRITE_KEY;
>> +	__raw_writel(val, keystone_rstctrl);
>> +
>> +	/* Reset the SOC */
>> +	val = __raw_readl(keystone_rstctrl);
>> +	val &= ~PLL_RESET;
>> +	__raw_writel(val, keystone_rstctrl);
>> +}
> 
> Please use 'readl', not '__raw_readl' unless you are accessing memory.
> 
Just oversight. Will fix that.

>> +DT_MACHINE_START(KEYSTONE, "Keystone")
>> +	.map_io		= debug_ll_io_init,
>> +	.init_machine	= keystone_init,
>> +	.dt_compat	= keystone_match,
>> +	.restart	= keystone_restart,
>> +MACHINE_END
> 
> You can leave out the  map_io line now.
> 
Cool. Will drop that.
