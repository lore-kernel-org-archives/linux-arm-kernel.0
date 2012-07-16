From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 16 Jul 2012 09:10:57 +0200
Subject: [PATCH v2 10/15] ARM: kirkwood: use fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-11-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <1342231451-28861-11-git-send-email-robherring2@gmail.com>
Message-ID: <20120716071057.GB2163@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 09:04:06PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Move kirkwood PCI to fixed i/o mapping and remove io.h.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>

Hi Rob

I boot tested this, on a board without any PCI devices.
At least the PCI controllers were found O.K.

So although its not worth much:

Tested-by: Andrew Lunn <andrew@lunn.ch>

I have one question, see below.


> ---
>  arch/arm/Kconfig                               |    1 -
>  arch/arm/mach-kirkwood/common.c                |   10 ----------
>  arch/arm/mach-kirkwood/include/mach/io.h       |   24 ------------------------
>  arch/arm/mach-kirkwood/include/mach/kirkwood.h |    8 +++-----
>  arch/arm/mach-kirkwood/pcie.c                  |   22 ++--------------------
>  5 files changed, 5 insertions(+), 60 deletions(-)
>  delete mode 100644 arch/arm/mach-kirkwood/include/mach/io.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ed930ad..8a74244 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -547,7 +547,6 @@ config ARCH_KIRKWOOD
>  	select PCI
>  	select ARCH_REQUIRE_GPIOLIB
>  	select GENERIC_CLOCKEVENTS
> -	select NEED_MACH_IO_H
>  	select PLAT_ORION
>  	help
>  	  Support for the following Marvell Kirkwood series SoCs:
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index f261cd2..55e4d79 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -41,16 +41,6 @@
>   ****************************************************************************/
>  static struct map_desc kirkwood_io_desc[] __initdata = {
>  	{
> -		.virtual	= KIRKWOOD_PCIE_IO_VIRT_BASE,
> -		.pfn		= __phys_to_pfn(KIRKWOOD_PCIE_IO_PHYS_BASE),
> -		.length		= KIRKWOOD_PCIE_IO_SIZE,
> -		.type		= MT_DEVICE,
> -	}, {
> -		.virtual	= KIRKWOOD_PCIE1_IO_VIRT_BASE,
> -		.pfn		= __phys_to_pfn(KIRKWOOD_PCIE1_IO_PHYS_BASE),
> -		.length		= KIRKWOOD_PCIE1_IO_SIZE,
> -		.type		= MT_DEVICE,
> -	}, {
>  		.virtual	= KIRKWOOD_REGS_VIRT_BASE,
>  		.pfn		= __phys_to_pfn(KIRKWOOD_REGS_PHYS_BASE),
>  		.length		= KIRKWOOD_REGS_SIZE,
> diff --git a/arch/arm/mach-kirkwood/include/mach/io.h b/arch/arm/mach-kirkwood/include/mach/io.h
> deleted file mode 100644
> index 5d0ab61..0000000
> --- a/arch/arm/mach-kirkwood/include/mach/io.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * arch/arm/mach-kirkwood/include/mach/io.h
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __ASM_ARCH_IO_H
> -#define __ASM_ARCH_IO_H
> -
> -#include "kirkwood.h"
> -
> -#define IO_SPACE_LIMIT		0xffffffff
> -
> -static inline void __iomem *__io(unsigned long addr)
> -{
> -	return (void __iomem *)((addr - KIRKWOOD_PCIE_IO_BUS_BASE)
> -					+ KIRKWOOD_PCIE_IO_VIRT_BASE);
> -}
> -
> -#define __io(a)			__io(a)
> -
> -#endif
> diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
> index c5b6851..af4f000 100644
> --- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
> +++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
> @@ -37,14 +37,12 @@
>  #define KIRKWOOD_NAND_MEM_SIZE		SZ_1K
>  
>  #define KIRKWOOD_PCIE1_IO_PHYS_BASE	0xf3000000
> -#define KIRKWOOD_PCIE1_IO_VIRT_BASE	0xfef00000
> -#define KIRKWOOD_PCIE1_IO_BUS_BASE	0x00100000
> -#define KIRKWOOD_PCIE1_IO_SIZE		SZ_1M
> +#define KIRKWOOD_PCIE1_IO_BUS_BASE	0x00010000
> +#define KIRKWOOD_PCIE1_IO_SIZE		SZ_64K
>  
>  #define KIRKWOOD_PCIE_IO_PHYS_BASE	0xf2000000
> -#define KIRKWOOD_PCIE_IO_VIRT_BASE	0xfee00000
>  #define KIRKWOOD_PCIE_IO_BUS_BASE	0x00000000
> -#define KIRKWOOD_PCIE_IO_SIZE		SZ_1M
> +#define KIRKWOOD_PCIE_IO_SIZE		SZ_64K
>  
>  #define KIRKWOOD_REGS_PHYS_BASE		0xf1000000
>  #define KIRKWOOD_REGS_VIRT_BASE		0xfed00000
> diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
> index 6e8b2ef..092b36f 100644
> --- a/arch/arm/mach-kirkwood/pcie.c
> +++ b/arch/arm/mach-kirkwood/pcie.c
> @@ -137,14 +137,6 @@ static void __init pcie0_ioresources_init(struct pcie_port *pp)
>  	pp->irq	= IRQ_KIRKWOOD_PCIE;
>  
>  	/*
> -	 * IORESOURCE_IO
> -	 */
> -	pp->res[0].name = "PCIe 0 I/O Space";
> -	pp->res[0].start = KIRKWOOD_PCIE_IO_BUS_BASE;
> -	pp->res[0].end = pp->res[0].start + KIRKWOOD_PCIE_IO_SIZE - 1;
> -	pp->res[0].flags = IORESOURCE_IO;
> -
> -	/*
>  	 * IORESOURCE_MEM
>  	 */
>  	pp->res[1].name = "PCIe 0 MEM";

...

>  	if (request_resource(&iomem_resource, &pp->res[1]))
>  		panic("Request PCIe%d Memory resource failed\n", index);
>  
> -	sys->io_offset = 0;
> -	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->io_offset);
>  	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);

pp->res[0] is now unused. Do you plan to also clean up the PCI MEM
space at some point? And then at the same time remove the rest of this
code?

Thanks
	Andrew
