From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 05 Mar 2012 14:59:03 -0500 (EST)
Subject: [PATCH v3 27/30] ARM: kirkwood: use fixed PCI i/o mapping
In-Reply-To: <1330658022-14559-28-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
 <1330658022-14559-28-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1203051455080.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Mar 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>

I have no PCI hardware making use of the legacy IO area to test this 
with.  But this looks fine.

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/Kconfig                               |    1 -
>  arch/arm/mach-kirkwood/common.c                |   21 +++++++++------------
>  arch/arm/mach-kirkwood/include/mach/io.h       |   24 ------------------------
>  arch/arm/mach-kirkwood/include/mach/kirkwood.h |    8 +++-----
>  arch/arm/mach-kirkwood/pcie.c                  |    8 ++++----
>  5 files changed, 16 insertions(+), 46 deletions(-)
>  delete mode 100644 arch/arm/mach-kirkwood/include/mach/io.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 24fe29e..50e68b6 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -563,7 +563,6 @@ config ARCH_KIRKWOOD
>  	select PCI
>  	select ARCH_REQUIRE_GPIOLIB
>  	select GENERIC_CLOCKEVENTS
> -	select NEED_MACH_IO_H
>  	select PLAT_ORION
>  	help
>  	  Support for the following Marvell Kirkwood series SoCs:
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index cc15426..db4caa3 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -20,6 +20,7 @@
>  #include <asm/timex.h>
>  #include <asm/kexec.h>
>  #include <asm/mach/map.h>
> +#include <asm/mach/pci.h>
>  #include <asm/mach/time.h>
>  #include <mach/kirkwood.h>
>  #include <mach/bridge-regs.h>
> @@ -37,16 +38,6 @@
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
> @@ -56,6 +47,12 @@ static struct map_desc kirkwood_io_desc[] __initdata = {
>  
>  void __init kirkwood_map_io(void)
>  {
> +	unsigned long pci_io_pfn[] = {
> +		__phys_to_pfn(KIRKWOOD_PCIE_IO_PHYS_BASE),
> +		__phys_to_pfn(KIRKWOOD_PCIE1_IO_PHYS_BASE),
> +	};
> +	pci_map_io_pfn(pci_io_pfn, ARRAY_SIZE(pci_io_pfn));
> +
>  	iotable_init(kirkwood_io_desc, ARRAY_SIZE(kirkwood_io_desc));
>  }
>  
> @@ -472,7 +469,7 @@ void __init kirkwood_init(void)
>  	kirkwood_xor1_init();
>  	kirkwood_crypto_init();
>  
> -#ifdef CONFIG_KEXEC 
> +#ifdef CONFIG_KEXEC
>  	kexec_reinit = kirkwood_enable_pcie;
>  #endif
>  }
> @@ -502,7 +499,7 @@ static int __init kirkwood_clock_gate(void)
>  		/* Disable PHY */
>  		writel(readl(SATA1_IF_CTRL) | 0x200, SATA1_IF_CTRL);
>  	}
> -	
> +
>  	/* For PCIe: first shutdown the phy */
>  	if (!(kirkwood_clk_ctrl & CGC_PEX0)) {
>  		writel(readl(PCIE_LINK_CTRL) | 0x10, PCIE_LINK_CTRL);
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
> index fede3d5..63565fb 100644
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
> index a066a6d..11f557e 100644
> --- a/arch/arm/mach-kirkwood/pcie.c
> +++ b/arch/arm/mach-kirkwood/pcie.c
> @@ -126,8 +126,8 @@ static void __init pcie0_ioresources_init(struct pcie_port *pp)
>  	 * IORESOURCE_IO
>  	 */
>  	pp->res[0].name = "PCIe 0 I/O Space";
> -	pp->res[0].start = KIRKWOOD_PCIE_IO_BUS_BASE;
> -	pp->res[0].end = pp->res[0].start + KIRKWOOD_PCIE_IO_SIZE - 1;
> +	pp->res[0].start = 0;
> +	pp->res[0].end = pp->res[0].start + SZ_64K - 1;
>  	pp->res[0].flags = IORESOURCE_IO;
>  
>  	/*
> @@ -148,8 +148,8 @@ static void __init pcie1_ioresources_init(struct pcie_port *pp)
>  	 * IORESOURCE_IO
>  	 */
>  	pp->res[0].name = "PCIe 1 I/O Space";
> -	pp->res[0].start = KIRKWOOD_PCIE1_IO_BUS_BASE;
> -	pp->res[0].end = pp->res[0].start + KIRKWOOD_PCIE1_IO_SIZE - 1;
> +	pp->res[0].start = SZ_64K;
> +	pp->res[0].end = pp->res[0].start + SZ_64K - 1;
>  	pp->res[0].flags = IORESOURCE_IO;
>  
>  	/*
> -- 
> 1.7.5.4
> 
