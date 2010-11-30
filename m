From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Nov 2010 18:14:42 +0000
Subject: [PATCH 2/8] ARM: cns3xxx: Add support for SMP
In-Reply-To: <20101130171700.GB24034@oksana.dev.rtsoft.ru>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
	<20101130171700.GB24034@oksana.dev.rtsoft.ru>
Message-ID: <20101130181442.GA9137@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 08:17:00PM +0300, Anton Vorontsov wrote:
> Nothing fancy needs to be done, just use generic SCU routines.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

This I assume is an age old patch.

> diff --git a/arch/arm/mach-cns3xxx/include/mach/smp.h b/arch/arm/mach-cns3xxx/include/mach/smp.h
> new file mode 100644
> index 0000000..44aa7ea
> --- /dev/null
> +++ b/arch/arm/mach-cns3xxx/include/mach/smp.h
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright 2002 ARM Ltd.
> + * Copyright 2008 Cavium Networks
> + *
> + * This file is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, Version 2, as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __MACH_SMP_H
> +#define __MACH_SMP_H
> +
> +#include <asm/hardware/gic.h>
> +
> +#define hard_smp_processor_id()				\
> +	({						\
> +		unsigned int cpunum;			\
> +		__asm__("mrc p15, 0, %0, c0, c0, 5"	\
> +			: "=r" (cpunum));		\
> +		cpunum &= 0x0F;				\
> +	})

#include <asm/smp_mpidr.h>

replaces this, but it's not actually necessary - it's only used by some
bug checking code in the CPU hotplug code.  I'm shortly going to be
deleting all hard_smp_processor_id() implementations.
