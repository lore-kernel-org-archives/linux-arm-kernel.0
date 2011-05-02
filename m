From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 May 2011 23:52:42 +0100
Subject: [PATCH 3/3] at91: make PLAT_PHYS_OFFSET depending on
	!ARM_PATCH_PHYS_VIRT or XIP_KERNEL
In-Reply-To: <1304374403-28513-3-git-send-email-plagnioj@jcrosoft.com>
References: <1304374403-28513-1-git-send-email-plagnioj@jcrosoft.com>
	<1304374403-28513-3-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20110502225242.GC28001@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2011 at 12:13:23AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> diff --git a/arch/arm/mach-at91/include/mach/memory.h b/arch/arm/mach-at91/include/mach/memory.h
> index c2cfe50..a643b4e 100644
> --- a/arch/arm/mach-at91/include/mach/memory.h
> +++ b/arch/arm/mach-at91/include/mach/memory.h
> @@ -23,6 +23,15 @@
>  
>  #include <mach/hardware.h>
>  
> -#define PLAT_PHYS_OFFSET	(AT91_SDRAM_BASE)
> +#define AT91_SDRAM_BASE		AT91_CHIPSELECT_1
> +#define AT91SAM9G45_SDRAM_BASE	AT91_CHIPSELECT_6
> +
> +#if !defined(CONFIG_ARM_PATCH_PHYS_VIRT) || defined(CONFIG_XIP_KERNEL)
> +# if defined CONFIG_ARCH_AT91SAM9G45
> +#  define PLAT_PHYS_OFFSET		AT91SAM9G45_SDRAM_BASE
> +# else
> +#  define PLAT_PHYS_OFFSET		AT91_SDRAM_BASE
> +# endif
> +#endif

Ideally, I'd like to see platforms not provide PLAT_PHYS_OFFSET.
However, there are two cases where it's needed by generic ARM code as
you've identified above.

Does AT91 support XIP_KERNEL?  It doesn't support XIP from flash (MTD_XIP)
so I suspect this isn't a particularly useful configuration.

As far as ARM_PATCH_PHYS_VIRT, maybe AT91 should force this to always
be selected.  That then means it can eliminate the PLAT_PHYS_OFFSET
definition entirely.
