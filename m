From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jul 2010 17:26:38 +0200
Subject: [RFC] dove: fix __io() definition to use bus based offset
In-Reply-To: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
References: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
Message-ID: <201007291726.39145.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 July 2010, Eric Miao wrote:
> diff --git a/arch/arm/mach-dove/include/mach/io.h
> b/arch/arm/mach-dove/include/mach/io.h
> index 3b3e472..067435e 100644
> --- a/arch/arm/mach-dove/include/mach/io.h
> +++ b/arch/arm/mach-dove/include/mach/io.h
> @@ -11,10 +11,9 @@
> 
>  #include "dove.h"
> 
> -#define IO_SPACE_LIMIT         0xffffffff
> -
> -#define __io(a)  ((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
> -                                  DOVE_PCIE0_IO_VIRT_BASE))
> -#define __mem_pci(a)           (a)
> +#define IO_SPACE_LIMIT 0xffffffff
> +#define __io(a)                __typesafe_io((a) - DOVE_PCIE0_IO_BUS_BASE + \
> +                                           DOVE_PCIE0_IO_VIRT_BASE)
> +#define __mem_pci(a)   (a)
> 
>  #endif
> 

The IO_SPACE_LIMIT still looks wrong, AFAICT it should be 

#define IO_SPACE_LIMIT (DOVE_PCIE0_IO_SIZE + DOVE_PCIE1_IO_SIZE - 1)

	Arnd
