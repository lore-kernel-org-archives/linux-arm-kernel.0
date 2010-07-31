From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 12:08:02 +0100
Subject: [RFC] dove: fix __io() definition to use bus based offset
In-Reply-To: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
References: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
Message-ID: <20100731110802.GL23886@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 01:45:35PM +0800, Eric Miao wrote:
> diff --git a/arch/arm/mach-dove/include/mach/io.h
> b/arch/arm/mach-dove/include/mach/io.h
> index 3b3e472..067435e 100644
> --- a/arch/arm/mach-dove/include/mach/io.h
> +++ b/arch/arm/mach-dove/include/mach/io.h
> @@ -11,10 +11,9 @@
> 
>  #include "dove.h"
> 
> -#define IO_SPACE_LIMIT		0xffffffff
> -
> -#define __io(a)  ((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
> -				   DOVE_PCIE0_IO_VIRT_BASE))
> -#define __mem_pci(a)		(a)
> +#define IO_SPACE_LIMIT	0xffffffff
> +#define __io(a)		__typesafe_io((a) - DOVE_PCIE0_IO_BUS_BASE + \
> +					    DOVE_PCIE0_IO_VIRT_BASE)

I recommend against this use of __typesafe_io():

http://lists.arm.linux.org.uk/lurker/message/20090214.154245.6325bc9d.en.html
