From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Mar 2010 20:31:07 +0000
Subject: [PATCH 1/7 v2] Introduce plat-tcc
In-Reply-To: <20100325200746.GD2047@bluebox.local>
References: <20100325200427.GC2047@bluebox.local>
	<20100325200746.GD2047@bluebox.local>
Message-ID: <20100325203107.GB24984@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 09:07:48PM +0100, Hans J. Koch wrote:
> +#define __virt_to_bus(x)	__virt_to_phys(x)
> +#define __bus_to_virt(x)	__phys_to_virt(x)
> +#define __pfn_to_bus(x)		__pfn_to_phys(x)
> +#define __bus_to_pfn(x)		__phys_to_pfn(x)

You don't need to define any of these.

> diff --git a/arch/arm/plat-tcc/include/mach/vmalloc.h b/arch/arm/plat-tcc/include/mach/vmalloc.h
> new file mode 100644
> index 0000000..9635303
> --- /dev/null
> +++ b/arch/arm/plat-tcc/include/mach/vmalloc.h
> @@ -0,0 +1,11 @@
> +/*
> + * Author: <linux@telechips.com>
> + * Created: June 10, 2008
> + *
> + * Copyright (C) 2000 Russell King.
> + * Copyright (C) 2008-2009 Telechips
> + *
> + * Licensed under the terms of the GPL v2.
> + */
> +#define VMALLOC_END	  (PAGE_OFFSET + 0x10000000)

Base address of IO rather than something dependent on PAGE_OFFSET?

> +
> diff --git a/arch/arm/plat-tcc/system.c b/arch/arm/plat-tcc/system.c
> new file mode 100644
> index 0000000..1a33ced
> --- /dev/null
> +++ b/arch/arm/plat-tcc/system.c
> @@ -0,0 +1,24 @@
> +/*
> + * System functions for Telechips TCCxxxx SoCs
> + *
> + * Copyright (C) Hans J. Koch <hjk@linutronix.de>
> + *
> + * Licensed under the terms of the GPL v2.
> + *
> + */
> +
> +#include <asm/io.h>

linux/io.h ?

> +#include <mach/tcc8k-regs.h>
> +
> +/* System reboot */
> +void plat_tcc_reboot(void)
> +{
> +	/* Make sure clocks are on */
> +	__raw_writel(0xffffffff, CKC_BASE + BCLKCTR0_OFFS);
> +
> +	/* Enable watchdog reset */
> +	__raw_writel(0x49, TIMER_BASE + TWDCFG_OFFS);
> +	/* Wait for reset */
> +	unreachable();
> +}
> +
> -- 
> 1.6.3.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
