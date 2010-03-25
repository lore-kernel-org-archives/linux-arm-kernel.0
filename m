From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Mar 2010 20:23:08 +0000
Subject: [PATCH 1/4] cns3xxx: Add basic support for Cavium Networks
	CNS3xxx processors
In-Reply-To: <20100325201040.GA8014@oksana.dev.rtsoft.ru>
References: <20100325200851.GA6470@oksana.dev.rtsoft.ru>
	<20100325201040.GA8014@oksana.dev.rtsoft.ru>
Message-ID: <20100325202308.GA24984@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 11:10:40PM +0300, Anton Vorontsov wrote:
> diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
> new file mode 100644
> index 0000000..924e4da
> --- /dev/null
> +++ b/arch/arm/mach-cns3xxx/cns3420vb.c
> @@ -0,0 +1,160 @@
> +/*
> + * Cavium Networks CNS3420 Validation Board
> + *
> + * Copyright 2000 Deep Blue Solutions Ltd
> + * Copyright 2008 ARM Limited
> + * Copyright 2008 Cavium Networks
> + *		  Scott Shu
> + * Copyright 2010 MontaVista Software, LLC.
> + *		  Anton Vorontsov <avorontsov@mvista.com>
> + *
> + * This file is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, Version 2, as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/compiler.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_8250.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/physmap.h>
> +#include <linux/mtd/partitions.h>
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/time.h>
> +#include <mach/hardware.h>
> +#include <mach/io.h>

linux/io.h please.

> +static void __init cns3420_fixup(struct machine_desc *desc,
> +				 struct tag *tags, char **cmdline,
> +				 struct meminfo *mi)
> +{
> +	/* Fixup for old bootloaders. */
> +	mi->nr_banks = 1;
> +	mi->bank[0].start = 0x00000000;
> +	mi->bank[0].size = SZ_128M;
> +	mi->bank[0].node = 0;

Can you not supply this via a built-in command line or a command line
from the boot loader?

> diff --git a/arch/arm/mach-cns3xxx/include/mach/vmalloc.h b/arch/arm/mach-cns3xxx/include/mach/vmalloc.h
> new file mode 100644
> index 0000000..d0b4aff
> --- /dev/null
> +++ b/arch/arm/mach-cns3xxx/include/mach/vmalloc.h
> @@ -0,0 +1,11 @@
> +/*
> + * Copyright 2000 Russell King.
> + * Copyright 2003 ARM Limited
> + * Copyright 2008 Cavium Networks
> + *
> + * This file is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, Version 2, as
> + * published by the Free Software Foundation.
> + */
> +
> +#define VMALLOC_END		(PAGE_OFFSET + 0x18000000)

This should be defined as the maximum address of the vmalloc area,
which should be independent of PAGE_OFFSET.

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index c4ed9f9..488bcb1 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -384,7 +384,7 @@ config CPU_FEROCEON_OLD_ID
>  
>  # ARMv6
>  config CPU_V6
> -	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
> +	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE || ARCH_CNS3XXX

So I assume by this your platform can boot without having a processor of
any kind?

If not, why allow the user to disable the option?
