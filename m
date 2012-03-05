From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 05 Mar 2012 15:12:20 -0500 (EST)
Subject: [PATCH v3 26/30] ARM: dove: use fixed PCI i/o mapping
In-Reply-To: <1330658022-14559-27-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
 <1330658022-14559-27-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1203051505230.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Mar 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> The i/o regions are changed from 1MB to 64KB. It's likely that the 2nd
> bus is not setup correctly.
[...]
> index ad1165d..50b9046 100644
> --- a/arch/arm/mach-dove/include/mach/dove.h
> +++ b/arch/arm/mach-dove/include/mach/dove.h
> @@ -50,14 +50,12 @@
>  #define DOVE_NB_REGS_SIZE		SZ_8M
>  
>  #define DOVE_PCIE0_IO_PHYS_BASE		0xf2000000
> -#define DOVE_PCIE0_IO_VIRT_BASE		0xfee00000
>  #define DOVE_PCIE0_IO_BUS_BASE		0x00000000
> -#define DOVE_PCIE0_IO_SIZE		SZ_1M
> +#define DOVE_PCIE0_IO_SIZE		SZ_64K
>  
>  #define DOVE_PCIE1_IO_PHYS_BASE		0xf2100000
> -#define DOVE_PCIE1_IO_VIRT_BASE		0xfef00000
> -#define DOVE_PCIE1_IO_BUS_BASE		0x00100000
> -#define DOVE_PCIE1_IO_SIZE		SZ_1M
> +#define DOVE_PCIE1_IO_BUS_BASE		0x00010000
> +#define DOVE_PCIE1_IO_SIZE		SZ_64K

You better not touch DOVE_PCIE1_IO_BUS_BASE and just leave it at 
0x00100000.  This is used for configuration of the physical window 
address, to match with DOVE_PCIE1_IO_PHYS_BASE, and that has no impact 
on the virtual address used to map that window (yes, Dove and the rest 
of the Orion based SOCs have the ability to change their physical memory 
map).

With that fixed:

Acked-by: Nicolas Pitre <nico@linaro.org>

>  
>  /*
>   * Dove Core Registers Map
> diff --git a/arch/arm/mach-dove/include/mach/io.h b/arch/arm/mach-dove/include/mach/io.h
> deleted file mode 100644
> index 29c8b85..0000000
> --- a/arch/arm/mach-dove/include/mach/io.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/*
> - * arch/arm/mach-dove/include/mach/io.h
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __ASM_ARCH_IO_H
> -#define __ASM_ARCH_IO_H
> -
> -#include "dove.h"
> -
> -#define IO_SPACE_LIMIT		0xffffffff
> -
> -#define __io(a)  	((void __iomem *)(((a) - DOVE_PCIE0_IO_BUS_BASE) + \
> -						 DOVE_PCIE0_IO_VIRT_BASE))
> -
> -#endif
> diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
> index 52e96d3..0a741bd 100644
> --- a/arch/arm/mach-dove/pcie.c
> +++ b/arch/arm/mach-dove/pcie.c
> @@ -59,13 +59,8 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
>  		 "PCIe %d I/O", pp->index);
>  	pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
>  	pp->res[0].name = pp->io_space_name;
> -	if (pp->index == 0) {
> -		pp->res[0].start = DOVE_PCIE0_IO_PHYS_BASE;
> -		pp->res[0].end = pp->res[0].start + DOVE_PCIE0_IO_SIZE - 1;
> -	} else {
> -		pp->res[0].start = DOVE_PCIE1_IO_PHYS_BASE;
> -		pp->res[0].end = pp->res[0].start + DOVE_PCIE1_IO_SIZE - 1;
> -	}
> +	pp->res[0].start = nr * SZ_64K;
> +	pp->res[0].end = pp->res[0].start + SZ_64K;
>  	pp->res[0].flags = IORESOURCE_IO;
>  	if (request_resource(&ioport_resource, &pp->res[0]))
>  		panic("Request PCIe IO resource failed\n");
> -- 
> 1.7.5.4
> 
