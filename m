From: saaguirre@ti.com (Aguirre, Sergio)
Date: Wed, 13 Jan 2010 12:22:11 -0600
Subject: [PATCH] Offer 'uncacheable memory' as DMA coherent memory for
	ARMv6
In-Reply-To: <20100113180327.GE28292@n2100.arm.linux.org.uk>
References: <20100113180327.GE28292@n2100.arm.linux.org.uk>
Message-ID: <A24693684029E5489D1D202277BE8944514AD02C@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Replacing linux-arm-kernel at lists.arm.linux.org.uk with linux-arm-kernel at lists.infradead.org, as I got a SMTP error: "550 Please direct your message to the new mailing lists on lists.infradead.org")

Russell,

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Wednesday, January 13, 2010 12:03 PM
> To: linux-arm-kernel at lists.arm.linux.org.uk
> Subject: [PATCH] Offer 'uncacheable memory' as DMA coherent memory for
> ARMv6
> 
> ARMv7 uses 'uncacheable normal memory' to implement DMA coherent memory,
> since mapping the same memory as two different types is defined to be
> unpredictable.
> 
> The same is strictly true for ARMv6 as well, although no bad behaviour
> has been observed thus far.  However, we do want to move ARMv6 to be
> architecturally compliant.  The down side is that some drivers may only
> have been tested on ARMv6, and may be missing the necessary barriers to
> make them work.
> 
> So, offer this as a configuration option, defaulting to enabled (to
> encourage drivers to be fixed.)
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Note that I do not have any ARMv6 platforms which make use of DMA
> coherent memory, so this is completely untested.
> 
>  arch/arm/include/asm/pgtable.h |    2 +-
>  arch/arm/include/asm/system.h  |    2 +-
>  arch/arm/mm/Kconfig            |   19 +++++++++++++++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h
> b/arch/arm/include/asm/pgtable.h
> index 1139768..ab68cf1 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -314,7 +314,7 @@ static inline pte_t pte_mkspecial(pte_t pte) { return
> pte; }
>  	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED)
>  #define pgprot_writecombine(prot) \
>  	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE)
> -#if __LINUX_ARM_ARCH__ >= 7
> +#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
>  #define pgprot_dmacoherent(prot) \
>  	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_BUFFERABLE)
>  #else
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 058e7e9..020891e 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -138,7 +138,7 @@ extern unsigned int user_debug;
>  #define dmb() __asm__ __volatile__ ("" : : : "memory")
>  #endif
> 
> -#if __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
> +#if defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
>  #define mb()		dmb()
>  #define rmb()		dmb()
>  #define wmb()		dmb()
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index baf6384..f0a3576 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -781,3 +781,22 @@ config ARM_L1_CACHE_SHIFT
>  	int
>  	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
>  	default 5
> +
> +config ARM_DMA_MEM_BUFFERABLE
> +	bool "Use non-cacheable memory for DMA" if CPU_V6 && !CPU_V7
> +	default y

Perhaps you meant here:

default y if CPU_V6 && !CPU_V7

?

Regards,
Sergio

> +	help
> +	  Historically, the kernel has used strongly ordered mappings to
> +	  provide DMA coherent memory.  With the advent of ARMv7, mapping
> +	  memory with differing types results in unpredictable behaviour,
> +	  so on these CPUs, this option is forced on.
> +
> +	  Multiple mappings with differing attributes is also unpredictable
> +	  on ARMv6 CPUs, but since they do not have aggressive speculative
> +	  prefetch, no harm appears to occur.
> +
> +	  However, drivers may be missing the necessary barriers for ARMv6,
> +	  and therefore turning this on may result in unpredictable driver
> +	  behaviour.  Therefore, we offer this as an option.
> +
> +	  You are recommended say 'Y' here and debug any affected drivers.
> 
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-
> kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
