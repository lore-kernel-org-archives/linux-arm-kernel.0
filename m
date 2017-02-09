From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 8 Feb 2017 19:37:28 -0800
Subject: [PATCH 1/2] ARM: add ARM_SINGLE_ARMV7 as config option
In-Reply-To: <20170209033044.19513-2-chris.brandt@renesas.com>
References: <20170209033044.19513-1-chris.brandt@renesas.com>
 <20170209033044.19513-2-chris.brandt@renesas.com>
Message-ID: <519f1f67-5cfc-db78-c2b7-6bb74b78f3c8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2017 07:30 PM, Chris Brandt wrote:
> Creates a new ARM_SINGLE_ARMV7 option as an alternative ARCH_MULTIPLATFORM.
> 
> ARM_SINGLE_ARMV7 is very similar to ARCH_MULTIPLATFORM, except the options
> from ARCH_MULTI_V6_V7 were copied directly into the new ARM_SINGLE_ARMV7.
> 
> Additionally, everywhere ARCH_MULTIPLATFORM existed in build scripts,
> ARM_SINGLE_ARMV7 was added along side it in order to produce similar
> results.

Could we try to be a little smarter than this and if ARCH_MULTIPLATFORM
is selected but only one platform beneath is we automatically select
ARM_SINGLE_ARMV7 (this may require Kconfig hackery)?

I see value in what you are doing, but I don't think pulling the
platforms out of the menu like what you do in the subsequent patch is
looking nice as an user/configurator.

> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  arch/arm/Kconfig          | 18 ++++++++++++++++++
>  arch/arm/Kconfig.debug    |  6 ++++--
>  arch/arm/Makefile         |  5 +++++
>  arch/arm/kernel/devtree.c |  3 ++-
>  4 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index bf8d86d..36107e7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -317,6 +317,24 @@ config ARCH_MMAP_RND_BITS_MAX
>  	default 15 if PAGE_OFFSET=0x80000000
>  	default 16
>  
> +config ARM_SINGLE_ARMV7
> +	bool "ARMv7 based single platforms"
> +	depends on MMU
> +	select ARM_HAS_SG_CHAIN
> +	select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL
> +	select AUTO_ZRELADDR
> +	select CLKSRC_OF
> +	select COMMON_CLK
> +	select CPU_V7
> +	select GENERIC_CLOCKEVENTS
> +	select MIGHT_HAVE_PCI
> +	select MULTI_IRQ_HANDLER
> +	select PCI_DOMAINS if PCI
> +	select SPARSE_IRQ
> +	select USE_OF
> +	select HAVE_SMP
> +	select MIGHT_HAVE_CACHE_L2X0
> +
>  #
>  # The "ARM system type" choice list is ordered alphabetically by option
>  # text.  Please add new entries in the option alphabetic order.
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index d83f7c3..31db9e3 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1694,7 +1694,8 @@ config DEBUG_UART_8250_FLOW_CONTROL
>  
>  config DEBUG_UNCOMPRESS
>  	bool
> -	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
> +	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M || \
> +		   ARM_SINGLE_ARMV7
>  	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
>  		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
>  		     !DEBUG_BRCMSTB_UART
> @@ -1712,7 +1713,8 @@ config DEBUG_UNCOMPRESS
>  config UNCOMPRESS_INCLUDE
>  	string
>  	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
> -					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
> +					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M || \
> +					ARM_SINGLE_ARMV7
>  	default "mach/uncompress.h"
>  
>  config EARLY_PRINTK
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index ab30cc6..c9809b6 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -255,12 +255,16 @@ endif
>  ifeq ($(CONFIG_ARCH_MULTIPLATFORM),y)
>  MACHINE  :=
>  endif
> +ifeq ($(CONFIG_ARM_SINGLE_ARMV7),y)
> +MACHINE  :=
> +endif
>  
>  machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
>  platdirs := $(patsubst %,arch/arm/plat-%/,$(sort $(plat-y)))
>  
>  ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)
>  ifneq ($(CONFIG_ARM_SINGLE_ARMV7M),y)
> +ifneq ($(CONFIG_ARM_SINGLE_ARMV7),y)
>  ifeq ($(KBUILD_SRC),)
>  KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
>  else
> @@ -268,6 +272,7 @@ KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
>  endif
>  endif
>  endif
> +endif
>  
>  export	TEXT_OFFSET GZFLAGS MMUEXT
>  
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index f676feb..26cbc29 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -220,7 +220,8 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>  {
>  	const struct machine_desc *mdesc, *mdesc_best = NULL;
>  
> -#if defined(CONFIG_ARCH_MULTIPLATFORM) || defined(CONFIG_ARM_SINGLE_ARMV7M)
> +#if defined(CONFIG_ARCH_MULTIPLATFORM) || defined(CONFIG_ARM_SINGLE_ARMV7M) || \
> +    defined(CONFIG_ARM_SINGLE_ARMV7)
>  	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
>  		.l2c_aux_val = 0x0,
>  		.l2c_aux_mask = ~0x0,
> 


-- 
Florian
