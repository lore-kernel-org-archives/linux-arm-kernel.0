From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 28 Apr 2012 14:55:11 +0000
Subject: [PATCH 1/1] ARM: clps711x: Using a single definition for the PHYS
 and VIRT registers offset Using a single definition for the physical and
 virtual address register for all variants boards clps711x.
In-Reply-To: <1335610552-22483-2-git-send-email-shc_work@mail.ru>
References: <1335610552-22483-1-git-send-email-shc_work@mail.ru>
 <1335610552-22483-2-git-send-email-shc_work@mail.ru>
Message-ID: <201204281455.12189.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 April 2012, Alexander Shiyan wrote:
> diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
> index d0b7d87..49345e2 100644
> --- a/arch/arm/mach-clps711x/include/mach/hardware.h
> +++ b/arch/arm/mach-clps711x/include/mach/hardware.h
> @@ -22,9 +22,18 @@
>  #ifndef __ASM_ARCH_HARDWARE_H
>  #define __ASM_ARCH_HARDWARE_H
>  
> +#include <asm/hardware/clps7111.h>
> +
> +#define CLPS7111_VIRT_BASE	(0xff000000)
>  
> -#define CLPS7111_VIRT_BASE	0xff000000
> -#define CLPS7111_BASE		CLPS7111_VIRT_BASE
> +#ifndef __ASSEMBLY__
> +#define clps_readb(off)		__raw_readb(CLPS7111_VIRT_BASE + (off))
> +#define clps_readw(off)		__raw_readw(CLPS7111_VIRT_BASE + (off))
> +#define clps_readl(off)		__raw_readl(CLPS7111_VIRT_BASE + (off))
> +#define clps_writeb(val,off)	__raw_writeb(val, CLPS7111_VIRT_BASE + (off))
> +#define clps_writew(val,off)	__raw_writew(val, CLPS7111_VIRT_BASE + (off))
> +#define clps_writel(val,off)	__raw_writel(val, CLPS7111_VIRT_BASE + (off))
> +#endif

This is a type mismatch, the argument to any readl/writel variant should be
an __iomem pointer, so best make the definition above

#define CLPS7111_VIRT_BASE	(void __iomem *)(0xff000000)

It would also be better to use the non-raw variants of the accessors, which
are generally safer to use, e.g. in combination with DMA.

Of course, the best solution would be to not have any of these macros and
instead do an ioremap of a resource that gets passed as part of the
platform device. You don't have to do that change now though, that can be
a cleanup for another time, but you should do it right when you add new
drivers.

	Arnd
