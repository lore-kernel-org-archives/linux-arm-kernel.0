From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jul 2010 10:59:40 +0100
Subject: =?iso-8859-1?B?W1JGQ12gYXJt?=
	=?iso-8859-1?Q?=3A?= versatile: enable PCI I/O space
In-Reply-To: <201007201123.38709.arnd@arndb.de>
References: <201007201123.38709.arnd@arndb.de>
Message-ID: <20100720095940.GA32702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 20, 2010 at 11:23:38AM +0200, Arnd Bergmann wrote:
> -/* macro to get at IO space when running virtually */
> +/* macro to get at MMIO space when running virtually */
>  #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
>  
> -#define __io_address(n)		__io(IO_ADDRESS(n))
> +#define __io_address(n)		__typesafe_io(IO_ADDRESS(n))

Hmm, that's not a scenario that I forsaw __typesafe_io() being used -
I'd prefer it to be restricted to only aliasing __io() to if it's
appropriate.  Either add an IOMEM() definition or open-code the cast
here.

> diff --git a/arch/arm/mach-versatile/include/mach/io.h b/arch/arm/mach-versatile/include/mach/io.h
> index f067c14..a276171 100644
> --- a/arch/arm/mach-versatile/include/mach/io.h
> +++ b/arch/arm/mach-versatile/include/mach/io.h
> @@ -20,9 +20,12 @@
>  #ifndef __ASM_ARM_ARCH_IO_H
>  #define __ASM_ARM_ARCH_IO_H
>  
> -#define IO_SPACE_LIMIT 0xffffffff
> +#include <mach/hardware.h>
> +#include <mach/platform.h>
>  
> -#define __io(a)		__typesafe_io(a)
> +#define IO_SPACE_LIMIT (VERSATILE_PCI_MEM_BASE0_SIZE - 1)
> +
> +#define __io(a)		(a + VERSATILE_PCI_VIRT_MEM_BASE0)

Not quite.  Have a look at arch/arm/mach-footbridge/include/mach/io.h to
see how __io is defined there.
