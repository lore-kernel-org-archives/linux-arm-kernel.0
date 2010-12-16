From: mike@compulab.co.il (Mike Rapoport)
Date: Thu, 16 Dec 2010 08:51:45 +0200
Subject: [PATCH 07/16] ARM: Make PCIBIOS_* into global variables.
In-Reply-To: <20101215020331.GZ15575@mail.wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
	<20101215020331.GZ15575@mail.wantstofly.org>
Message-ID: <4D09B701.3060204@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/10 04:03, Lennert Buytenhek wrote:
> From: Eric Miao <eric.miao@canonical.com>
> 
> And initialized with pci_common_init(), so that now <asm/pci.h>
> doesn't depend on <mach/hardware.h> any more.
> 
> Signed-off-by: Eric Miao <eric.miao@canonical.com>
> 
> [ buytenh at wantstofly.org: adapt to "Always reassign PCI bus numbers"
>   change, added support for cns3xxx, ixp4xx/vulcan-pci.c, mv78xx0,
>   tegra, rename platform PCIBIOS_MIN_* defines to avoid namespace
>   clashes, rename the arch-wide global variables themselves to
>   PCIBIOS_MIN_* to match mips/sh, build fixes. ]
> 
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---

[ snip ]

> diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
> index 0f31305..f810a0e 100644
> --- a/arch/arm/mach-pxa/cm-x2xx-pci.c
> +++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
> @@ -21,6 +21,8 @@
>  #include <linux/irq.h>
>  #include <linux/gpio.h>
>  
> +#include <mach/hardware.h>
> +
>  #include <asm/mach/pci.h>
>  #include <asm/mach-types.h>
>  
> @@ -214,8 +216,10 @@ static struct hw_pci cmx2xx_pci __initdata = {
>  
>  static int __init cmx2xx_init_pci(void)
>  {
> -	if (machine_is_armcore())
> -		pci_common_init(&cmx2xx_pci);
> +	if (machine_is_armcore()) {
> +		pci_common_init(&cmx2xx_pci, PXA_PCIBIOS_MIN_IO,
> +				PXA_PCIBIOS_MIN_MEM);
> +	}
>  
>  	return 0;
>  }
> diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
> index ad448af..86ea43f 100644
> --- a/arch/arm/mach-pxa/include/mach/hardware.h
> +++ b/arch/arm/mach-pxa/include/mach/hardware.h
> @@ -318,8 +318,8 @@ extern unsigned long get_clock_tick_rate(void);
>  #endif
>  
>  #if defined(CONFIG_MACH_ARMCORE) && defined(CONFIG_PCI)
> -#define PCIBIOS_MIN_IO		0
> -#define PCIBIOS_MIN_MEM		0
> +#define PXA_PCIBIOS_MIN_IO	0
> +#define PXA_PCIBIOS_MIN_MEM	0
>  #define ARCH_HAS_DMA_SET_COHERENT_MASK
>  #endif
>  

I think that in PXA case the PCIBIOS_MIN_{IO,MEM} can be completely dropped from
the mach/hardware.h and defined locally in the cm-x2xx-pci.c. Since PXA does not
have on-SoC PCI controller, there's no much sense to define
PXA_PCIBIOS_MIN_{IO,MEM} at all.

> diff --git a/arch/arm/mach-shark/include/mach/hardware.h b/arch/arm/mach-shark/include/mach/hardware.h
> index 24639ce..7d3f0e3 100644
> --- a/arch/arm/mach-shark/include/mach/hardware.h
> +++ b/arch/arm/mach-shark/include/mach/hardware.h
> @@ -12,8 +12,9 @@


-- 
Sincerely yours,
Mike.
