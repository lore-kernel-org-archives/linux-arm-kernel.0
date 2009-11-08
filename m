From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Nov 2009 17:45:03 +0000
Subject: [PATCH 4/4] RealView: Add sparsemem support for the RealView
	PBX platform
In-Reply-To: <20091015122209.739.42849.stgit@pc1117.cambridge.arm.com>
References: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
	<20091015122209.739.42849.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091108174503.GB28368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2009 at 01:22:09PM +0100, Catalin Marinas wrote:
> diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
> index dfc9b0b..ba548ab 100644
> --- a/arch/arm/mach-realview/Kconfig
> +++ b/arch/arm/mach-realview/Kconfig
> @@ -70,12 +70,14 @@ config MACH_REALVIEW_PBX
>  	bool "Support RealView/PBX platform"
>  	select ARM_GIC
>  	select HAVE_PATA_PLATFORM
> +	select ARCH_SPARSEMEM_ENABLE if CPU_V7
> +	select ZONE_DMA if SPARSEMEM
>  	help
>  	  Include support for the ARM(R) RealView PBX platform.
>  
>  config REALVIEW_HIGH_PHYS_OFFSET
>  	bool "High physical base address for the RealView platform"
> -	depends on MMU && !MACH_REALVIEW_PB1176
> +	depends on MMU && !MACH_REALVIEW_PB1176 && !SPARSEMEM
>  	default y
>  	help
>  	  RealView boards other than PB1176 have the RAM available at
> @@ -84,4 +86,8 @@ config REALVIEW_HIGH_PHYS_OFFSET
>  	  memory to be accessed contiguously at the high physical
>  	  offset.
>  
> +config ARCH_FLATMEM_ENABLE
> +	bool
> +	default y if ARCH_SPARSEMEM_ENABLE
> +

I seem to have missed this.  Why do we want to enable flatmem support for
_everything_ which enables sparsemem?

In fact, why do you even have this at all?

Not pulling your latest pull request due to this.
