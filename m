From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Mar 2010 18:09:05 +0000
Subject: [RFC/PATCH] ARM: add Tegra support
In-Reply-To: <4B96798C.6060201@compulab.co.il>
References: <4B96798C.6060201@compulab.co.il>
Message-ID: <20100315180904.GH700@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 09, 2010 at 06:38:36PM +0200, Mike Rapoport wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3b18128..d479cd8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -750,6 +750,17 @@ config ARCH_U8500
>  	help
>  	  Support for ST-Ericsson's Ux500 architecture
>
> +config ARCH_TEGRA
> +        bool "NVIDIA Tegra"
> +        select GENERIC_TIME
> +        select GENERIC_CLOCKEVENTS
> +        select GENERIC_GPIO
> +        select HAVE_CLK
> +        select COMMON_CLKDEV
> +        help
> +          This enables support for NVIDIA Tegra based systems (Tegra APX,
> +          Tegra 6xx and Tegra 2 series).
> +

Please don't blindly add to the end of a sorted list; this causes disgusting
merge conflicts.  Please add to the correct place in the list instead.

"NVIDIA" belongs after "Nuvoton NUC93X CPU" but before
"Philips Nexperia PNX4008 Mobile".

> +static struct platform_device debug_uart = {
> +	.name = "serial8250",
> +	.id = 0,

PLAT8250_DEV_xxx please.

> +static void __init tegra_harmony_fixup(struct machine_desc *desc,
> +				       struct tag *tags,
> +				       char **cmdline, struct meminfo *mi)
> +{
> +	mi->nr_banks = 2;
> +	mi->bank[0].start = PHYS_OFFSET;
> +	mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
> +	mi->bank[0].size = (448*1024*1024);

Parens aren't required.

> diff --git a/arch/arm/mach-tegra/include/mach/vmalloc.h b/arch/arm/mach-tegra/include/mach/vmalloc.h
> new file mode 100644
> index 0000000..33444b1
> --- /dev/null
> +++ b/arch/arm/mach-tegra/include/mach/vmalloc.h
> @@ -0,0 +1,22 @@
> +/*
> + * arch/arm/mach-tegra/include/mach/vmalloc.h
> + *
> + * Copyright (C) 2010 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __MACH_TEGRA_VMALLOC_H
> +#define __MACH_TEGRA_VMALLOC_H
> +
> +#define VMALLOC_END        ((PAGE_OFFSET) + 0x38000000)

So if PAGE_OFFSET were to be 0xe0000000, this would still be valid?
And what if PAGE_OFFSET were 0x80000000 ?

Wouldn't it be better to define it in terms of the maximum address
as defined by the hardware maps - so that selecting 2GB of userspace
gives you more kernel space?
