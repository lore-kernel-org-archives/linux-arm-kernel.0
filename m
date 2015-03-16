From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Mar 2015 21:02:51 +0000
Subject: [PATCH 2/5] ARM: Add Broadcom Brahma-B15 readahead cache support
In-Reply-To: <1425689693-31034-3-git-send-email-f.fainelli@gmail.com>
References: <1425689693-31034-1-git-send-email-f.fainelli@gmail.com>
 <1425689693-31034-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <20150316210251.GP8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 04:54:50PM -0800, Florian Fainelli wrote:
> This patch adds support for the Broadcom Brahma-B15 CPU readahead cache
> controller. This cache controller sits between the L2 and the memory bus
> and its purpose is to provide a friendler burst size towards the DDR
> interface than the native cache line size.
> 
> The readahead cache is mostly transparent, except for
> flush_kern_cache_all, flush_kern_cache_louis and flush_icache_all, which
> is precisely what we are overriding here.
> 
> The readahead cache only intercepts reads, not writes, as such, some
> data can remain stale in any of its buffers, such that we need to flush
> it, which is an operation that needs to happen in a particular order:
> 
> - disable the readahead cache
> - flush it
> - call the appropriate cache-v7.S function
> - re-enable
> 
> This patch tries to minimize the impact to the cache-v7.S file by only
> providing a stub in case CONFIG_CACHE_B15_RAC is enabled (default for
> ARCH_BRCMSTB since it is the current user).
> 
> Signed-off-by: Alamy Liu <alamyliu@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/include/asm/cacheflush.h             |   2 +-
>  arch/arm/include/asm/glue-cache.h             |   4 +
>  arch/arm/include/asm/hardware/cache-b15-rac.h |  12 ++
>  arch/arm/mm/Kconfig                           |   8 ++
>  arch/arm/mm/Makefile                          |   1 +
>  arch/arm/mm/cache-b15-rac.c                   | 181 ++++++++++++++++++++++++++
>  6 files changed, 207 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/include/asm/hardware/cache-b15-rac.h
>  create mode 100644 arch/arm/mm/cache-b15-rac.c
> 
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 2d46862e7bef..4d847e185cf6 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -199,7 +199,7 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
>   */
>  #if (defined(CONFIG_CPU_V7) && \
>       (defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K))) || \
> -	defined(CONFIG_SMP_ON_UP)
> +	defined(CONFIG_SMP_ON_UP) || defined(CONFIG_CACHE_B15_RAC)
>  #define __flush_icache_preferred	__cpuc_flush_icache_all
>  #elif __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
>  #define __flush_icache_preferred	__flush_icache_all_v7_smp
> diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
> index a3c24cd5b7c8..11f33b5f9284 100644
> --- a/arch/arm/include/asm/glue-cache.h
> +++ b/arch/arm/include/asm/glue-cache.h
> @@ -117,6 +117,10 @@
>  # endif
>  #endif
>  
> +#if defined(CONFIG_CACHE_B15_RAC)
> +# define MULTI_CACHE 1
> +#endif
> +
>  #if defined(CONFIG_CPU_V7M)
>  # ifdef _CACHE
>  #  define MULTI_CACHE 1
> diff --git a/arch/arm/include/asm/hardware/cache-b15-rac.h b/arch/arm/include/asm/hardware/cache-b15-rac.h
> new file mode 100644
> index 000000000000..76b888f53f90
> --- /dev/null
> +++ b/arch/arm/include/asm/hardware/cache-b15-rac.h
> @@ -0,0 +1,12 @@
> +#ifndef __ASM_ARM_HARDWARE_CACHE_B15_RAC_H
> +#define __ASM_ARM_HARDWARE_CACHE_B15_RAC_H
> +
> +#ifndef __ASSEMBLY__
> +
> +void b15_flush_kern_cache_all(void);
> +void b15_flush_kern_cache_louis(void);
> +void b15_flush_icache_all(void);
> +
> +#endif
> +
> +#endif
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 9b4f29e595a4..4d5652a39304 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -853,6 +853,14 @@ config OUTER_CACHE_SYNC
>  	  The outer cache has a outer_cache_fns.sync function pointer
>  	  that can be used to drain the write buffer of the outer cache.
>  
> +config CACHE_B15_RAC
> +	bool "Enable the Broadcom Brahma-B15 read-ahead cache controller"
> +	depends on ARCH_BRCMSTB
> +	default y
> +	help
> +	  This option enables the Broadcom Brahma-B15 read-ahead cache
> +	  controller. If disabled, the read-ahead cache remains off.
> +
>  config CACHE_FEROCEON_L2
>  	bool "Enable the Feroceon L2 cache controller"
>  	depends on ARCH_MV78XX0 || ARCH_MVEBU
> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
> index d3afdf9eb65a..a6797fdb6721 100644
> --- a/arch/arm/mm/Makefile
> +++ b/arch/arm/mm/Makefile
> @@ -96,6 +96,7 @@ AFLAGS_proc-v6.o	:=-Wa,-march=armv6
>  AFLAGS_proc-v7.o	:=-Wa,-march=armv7-a
>  
>  obj-$(CONFIG_OUTER_CACHE)	+= l2c-common.o
> +obj-$(CONFIG_CACHE_B15_RAC)	+= cache-b15-rac.o
>  obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
>  obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o l2c-l2x0-resume.o
>  obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
> diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
> new file mode 100644
> index 000000000000..1c5bca6e906b
> --- /dev/null
> +++ b/arch/arm/mm/cache-b15-rac.c
> @@ -0,0 +1,181 @@
> +/*
> + * Broadcom Brahma-B15 CPU read-ahead cache management functions
> + *
> + * Copyright (C) 2015, Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/spinlock.h>
> +#include <linux/io.h>
> +#include <linux/bitops.h>
> +#include <linux/of_address.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/hardware/cache-b15-rac.h>
> +
> +extern void v7_flush_kern_cache_all(void);
> +extern void v7_flush_kern_cache_louis(void);
> +extern void v7_flush_icache_all(void);
> +
> +/* RAC register offsets, relative to the HIF_CPU_BIUCTRL register base */
> +#define RAC_CONFIG0_REG			(0x78)
> +#define  RACENPREF_MASK			(0x3)
> +#define  RACPREFINST_SHIFT		(0)
> +#define  RACENINST_SHIFT		(2)
> +#define  RACPREFDATA_SHIFT		(4)
> +#define  RACENDATA_SHIFT		(6)
> +#define  RAC_CPU_SHIFT			(8)
> +#define  RACCFG_MASK			(0xff)
> +#define RAC_CONFIG1_REG			(0x7c)
> +#define RAC_FLUSH_REG			(0x80)
> +#define  FLUSH_RAC			(1 << 0)

					BIT(0) ?

> +
> +/* Bitmask to enable instruction and data prefetching with a 256-bytes stride */
> +#define RAC_DATA_INST_EN_MASK		(1 << RACPREFINST_SHIFT | \
> +					 RACENPREF_MASK << RACENINST_SHIFT | \
> +					 1 << RACPREFDATA_SHIFT | \
> +					 RACENPREF_MASK << RACENDATA_SHIFT)
> +
> +#define RAC_ENABLED			(1 << 0)

					BIT(0) ?

However, you don't use RAC_ENABLED as a bitmask, but a bit index, so
shouldn't this be zero?

> +
> +static void __iomem *b15_rac_base;
> +static DEFINE_SPINLOCK(rac_lock);
> +
> +/* Initialization flag to avoid checking for b15_rac_base, and to prevent
> + * multi-platform kernels from crashing here as well.
> + */
> +static unsigned long b15_rac_flags;
> +
> +static inline u32 __b15_rac_disable(void)
> +{
> +	u32 val = __raw_readl(b15_rac_base + RAC_CONFIG0_REG);
> +	__raw_writel(0, b15_rac_base + RAC_CONFIG0_REG);
> +	dmb();
> +	return val;
> +}
> +
> +static inline void __b15_rac_flush(void)
> +{
> +	u32 reg;
> +
> +	__raw_writel(FLUSH_RAC, b15_rac_base + RAC_FLUSH_REG);
> +	do {
> +		/* This dmb() is required to force the Bus Interface Unit
> +		 * to clean oustanding writes, and forces an idle cycle
> +		 * to be inserted.
> +		 */
> +		dmb();
> +		reg = __raw_readl(b15_rac_base + RAC_FLUSH_REG);
> +	} while (reg & RAC_FLUSH_REG);
> +}
> +
> +static inline u32 b15_rac_disable_and_flush(void)
> +{
> +	u32 reg;
> +
> +	reg = __b15_rac_disable();
> +	__b15_rac_flush();
> +	return reg;
> +}
> +
> +static inline void __b15_rac_enable(u32 val)
> +{
> +	__raw_writel(val, b15_rac_base + RAC_CONFIG0_REG);
> +	/* dsb() is required here to be consistent with __flush_icache_all() */
> +	dsb();
> +}
> +
> +#define BUILD_RAC_CACHE_OP(name, bar)				\
> +void b15_flush_##name(void)					\
> +{								\
> +	unsigned int do_flush;					\
> +	u32 val = 0;						\
> +								\
> +	spin_lock(&rac_lock);					\
> +	do_flush = test_bit(RAC_ENABLED, &b15_rac_flags);	\

Do you need to use test_bit() here?  You set and test this location
under a spinlock, so it's safe to use non-atomic ops here.

> +static void b15_rac_enable(void)
> +{
> +	unsigned int cpu;
> +	u32 enable = 0;
> +
> +	for_each_possible_cpu(cpu)
> +		enable |= (RAC_DATA_INST_EN_MASK << (cpu * RAC_CPU_SHIFT));

		enable |= RAC_DATA_INST_EN_MASK << (cpu * RAC_CPU_SHIFT);

You don't need the additional parens - the right hand side of |= is
already expected to be an expression by the compiler.

> +	spin_lock(&rac_lock);
> +	reg = __raw_readl(b15_rac_base + RAC_CONFIG0_REG);
> +	for_each_possible_cpu(cpu)
> +		en_mask |= ((1 << RACPREFDATA_SHIFT) << (cpu * RAC_CPU_SHIFT));

		en_mask |= 1 << (RACPREFDATA_SHIFT + cpu * RAC_CPU_SHIFT);

looks nicer, rather than having two shifts.

What happens when the system goes down (eg, for kexec?)  Does the RAC
need to be disabled for that?

-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
