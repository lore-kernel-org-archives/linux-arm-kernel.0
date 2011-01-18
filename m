From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Jan 2011 10:36:08 -0000
Subject: [PATCH 04/14] ARM: v6k: introduce CPU_V6K option
In-Reply-To: <E1Peuej-0003SV-Dn@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peuej-0003SV-Dn@rmk-PC.arm.linux.org.uk>
Message-ID: <000601cbb6fb$8465c620$8d315260$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> Introduce a CPU_V6K configuration option for platforms to select if they
> have a V6K CPU core.  This allows us to identify whether we need to
> support ARMv6 CPUs without the V6K SMP extensions at build time.
> 
> Currently CPU_V6K is just an alias for CPU_V6, and all places which
> reference CPU_V6 are replaced by (CPU_V6 || CPU_V6K).
> 
> Select CPU_V6K from platforms which are known to be V6K-only.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

[...]

> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c22c1ad..9c43052 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -89,6 +89,7 @@ tune-$(CONFIG_CPU_XSCALE)	:=$(call cc-option,-mtune=xscale,-mtune=strongarm110)
>  tune-$(CONFIG_CPU_XSC3)		:=$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-
> mcpu=xscale
>  tune-$(CONFIG_CPU_FEROCEON)	:=$(call cc-option,-mtune=marvell-f,-mtune=xscale)
>  tune-$(CONFIG_CPU_V6)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
> +tune-$(CONFIG_CPU_V6K)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)

Can we change the tune target to 1176 for v6k?
 
>  config DMA_CACHE_RWFO
>  	bool "Enable read/write for ownership DMA cache maintenance"
> -	depends on CPU_V6 && SMP
> +	depends on (CPU_V6 || CPU_V6K) && SMP
>  	default y
>  	help
>  	  The Snoop Control Unit on ARM11MPCore does not detect the

Can we lose the CPU_V6 check here? RWFO is only required for 11MPCore
so I think we just need to check CPU_V6K && SMP.

Will
