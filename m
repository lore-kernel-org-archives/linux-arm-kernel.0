From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 18 Feb 2016 11:02:33 -0500 (EST)
Subject: [PATCH 4/9] ARM: add CONFIG_PHYS_OFFSET default values
In-Reply-To: <1455804123-2526139-5-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-5-git-send-email-arnd@arndb.de>
Message-ID: <alpine.LFD.2.20.1602181100410.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Feb 2016, Arnd Bergmann wrote:

> For platforms that are not yet converted to ARCH_MULTIPLATFORM,
> we can disable CONFIG_ARM_PATCH_PHYS_VIRT, which in turn requires
> setting a correct address here.
> 
> As we actualy know what all the values are supposed to be based
> on the old mach/memory.h header file contents (from git history),
> we can just add them here.
> 
> This also solves a problem in Kconfig where 'make randconfig'
> fails to continue if no number is selected for a 'hex' option.
> Users can still override the number at configuration time, e.g.
> when the memory visible to the kernel starts at a nonstandard
> address on some machine, but it should no longer be required
> now.
> 
> To make this foolproof, another patch is required in mach-davinci
> to prevent a configuration with both DMx and DA8xx enabled but
> ARM_PATCH_PHYS_VIRT disabled. The two patches however can be
> merged independently as there is no direct dependency between
> them.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Pitre <nico@linaro.org>

Is there a way to provide a default for defaults?


> ---
>  arch/arm/Kconfig | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index be00b53f399b..7839c9923709 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -271,15 +271,29 @@ config PHYS_OFFSET
>  	depends on !ARM_PATCH_PHYS_VIRT
>  	default DRAM_BASE if !MMU
>  	default 0x00000000 if ARCH_EBSA110 || \
> +			ARCH_DOVE || \
>  			ARCH_FOOTBRIDGE || \
> +			(ARCH_GEMINI && GEMINI_MEM_SWAP) || \
>  			ARCH_INTEGRATOR || \
> +			ARCH_IOP33X || \
>  			ARCH_IOP13XX || \
> +			ARCH_IXP4XX || \
>  			ARCH_KS8695 || \
> -			(ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET)
> -	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
> +			(ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET) || \
> +			ARCH_W90X900
> +	default 0x10000000 if (ARCH_GEMINI && !GEMINI_MEM_SWAP) || \
> +			ARCH_OMAP1 || \
> +			ARCH_RPC
>  	default 0x20000000 if ARCH_S5PV210
> +	default 0x30000000 if ARCH_S3C24XX
>  	default 0x70000000 if REALVIEW_HIGH_PHYS_OFFSET
> -	default 0xc0000000 if ARCH_SA1100
> +	default 0x80000000 if (ARCH_DAVINCI_DMx && !ARCH_DAVINCI_DA8XX) || \
> +			ARCH_NETX || \
> +			ARCH_LPC32XX
> +	default 0xa0000000 if ARCH_IOP32X || ARCH_PXA
> +	default 0xc0000000 if (ARCH_DAVINCI_DA8XX && !ARCH_DAVINCI_DMx) || \
> +			ARCH_CLPS711X || \
> +			ARCH_SA1100
>  	help
>  	  Please provide the physical address corresponding to the
>  	  location of main memory in your system.
> -- 
> 2.7.0
> 
> 
