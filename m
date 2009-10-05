From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Mon, 05 Oct 2009 13:21:12 +0100
Subject: [PATCH v1.0 4/4] MM: Switch TS72XX to use sparemem
In-Reply-To: <20091004011434.12578.76922.stgit@localhost.localdomain>
References: <20091004011413.12578.89897.stgit@localhost.localdomain>
	<20091004011434.12578.76922.stgit@localhost.localdomain>
Message-ID: <4AC9E4B8.1040208@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

What people think about enabling sparsemem on EP93XX? I know this 
patch as it is will break all but this board.

Can we define defaults SECTION_SIZE_BITS and MAX_PHYSMEM_BITS that 
will suit all the supported boards?

Regards,
Chris

Christian Gagneraud wrote:
> Tested on TS7260 with 64MB SDRAM (8*8MB). (Other boards will be tested
> soon-ish). Special thanks to Matthieu Crappet, Charlie M.
> 
> I'm not sure what's the impact for other machine based on EP93XX, it's likely
> that SECTION_SIZE_BITS and MAX_PHYSMEM_BITS needs to be define with default
> values that suits everyone
> 
> PS: Has to be apply on top of this patch:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/001706.html
> 
> Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
> Signed-off-by: Christian Gagneraud <cgagneraud@techworks.ie>
> ---
> 
>  arch/arm/Kconfig                           |    1 +
>  arch/arm/include/asm/memory.h              |    2 ++
>  arch/arm/mach-ep93xx/include/mach/memory.h |   30 ++++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1c4119c..0f1d52f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -288,6 +288,7 @@ config ARCH_EP93XX
>  	select CPU_ARM920T
>  	select ARM_AMBA
>  	select ARM_VIC
> +	select ARCH_SPARSEMEM_ENABLE
>  	select GENERIC_GPIO
>  	select HAVE_CLK
>  	select COMMON_CLKDEV
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index cefedf0..6be9d9b 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -125,8 +125,10 @@
>   * private definitions which should NOT be used outside memory.h
>   * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
>   */
> +#ifndef __phys_to_virt
>  #define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
>  #define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
> +#endif
>  
>  /*
>   * Convert a physical address to a Page Frame Number and back
> diff --git a/arch/arm/mach-ep93xx/include/mach/memory.h b/arch/arm/mach-ep93xx/include/mach/memory.h
> index 554064e..4cb3329 100644
> --- a/arch/arm/mach-ep93xx/include/mach/memory.h
> +++ b/arch/arm/mach-ep93xx/include/mach/memory.h
> @@ -19,4 +19,34 @@
>  #error "Kconfig bug: No EP93xx PHYS_OFFSET set"
>  #endif
>  
> +#ifdef CONFIG_MACH_TS72XX
> +/*
> + * Non-linear mapping like so:
> + * phys       => virt
> + * 0x00000000 => 0xc0000000
> + * 0x01000000 => 0xc1000000
> + * 0x04000000 => 0xc4000000
> + * 0x05000000 => 0xc5000000
> + * 0xe0000000 => 0xc8000000
> + * 0xe1000000 => 0xc9000000
> + * 0xe4000000 => 0xcc000000
> + * 0xe5000000 => 0xcd000000
> + *
> + * As suggested here: http://marc.info/?l=linux-arm&m=122754446724900&w=2
> + *
> + * Note that static inline functions won't work here because
> + * arch/arm/include/asm/memory.h uses "#ifndef __virt_to_phys" to check whether to
> + * use generic functions or not.
> + */
> +#define __phys_to_virt(p)   \
> +            (((p) & 0x07ffffff) | (((p) & 0xe0000000) ? 0x08000000 : 0) | PAGE_OFFSET)
> +
> +#define __virt_to_phys(v)   \
> +            (((v) & 0x07ffffff) | (((v) & 0x08000000) ? 0xe0000000 : 0 ))
> +
> +#define SECTION_SIZE_BITS 24
> +#define MAX_PHYSMEM_BITS 32
> +
> +#endif /* CONFIG_ARCH_TS72XX */
> +
>  #endif
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
