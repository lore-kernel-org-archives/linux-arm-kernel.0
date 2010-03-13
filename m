From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 13 Mar 2010 19:04:35 +0530
Subject: [PATCH] ARM: Improve the L2 cache performance when PL310 is used
In-Reply-To: <20100309101248.7359.60873.stgit@e102109-lin.cambridge.arm.com>
References: <20100309101248.7359.60873.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C47A6ADF@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Tuesday, March 09, 2010 3:45 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Shilimkar, Santosh; Russell King
> Subject: [PATCH] ARM: Improve the L2 cache performance when PL310 is used
> 
> With this L2 cache controller, the cache maintenance by PA and sync
> operations are atomic and do not require a "wait" loop or spinlocks.
> This patch conditionally defines the cache_wait() function and locking
> primitives (rather than duplicating the functions or file).
> 
> Since L2x0 cache controllers do not work with ARMv7 CPUs, the patch
> automatically enables CACHE_PL310 when CPU_V7 is defined.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Russell King <rmk@arm.linux.org.uk>
> ---
> 
> We did some benchmarks and the performance benefit of this patch with a
> PL310 cache controller is considerable.
> 
I tested this patch and indeed it improves the performance by 
12 % to 28 % for buffers ranging from 1 MB to 10 MB.
 
> I also considered separate functions in the same file or a separate file
> but this would mean having to move the TI's workaround to a new file as
> well. Suggestions welcome.
> 
> 
>  arch/arm/mm/Kconfig      |    7 +++++
>  arch/arm/mm/cache-l2x0.c |   70 ++++++++++++++++++++++++++++++++--------------
>  2 files changed, 56 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index ef61c93..0a59071 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -781,6 +781,13 @@ config CACHE_L2X0
>  	help
>  	  This option enables the L2x0 PrimeCell.
> 
> +config CACHE_PL310
> +	bool
> +	depends on CACHE_L2X0
> +	default y if CPU_V7
> +	help
> +	  This option enables support for the PL310 cache controller.
> +
>  config CACHE_TAUROS2
>  	bool "Enable the Tauros2 L2 cache controller"
>  	depends on ARCH_DOVE
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 9fc01b4..2a20d95 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -26,9 +26,21 @@
>  #define CACHE_LINE_SIZE		32
> 
>  static void __iomem *l2x0_base;
> -static DEFINE_SPINLOCK(l2x0_lock);
>  bool l2x0_disabled;
> 
> +#ifdef CONFIG_CACHE_PL310
> +static inline void cache_wait(void __iomem *reg, unsigned long mask)
> +{
> +	/* cache operations are atomic */
> +}
> +
> +#define l2x0_lock(lock, flags)		((void)(flags))
> +#define l2x0_unlock(lock, flags)	((void)(flags))
> +
> +#define block_end(start, end)		(end)
> +
> +#define L2CC_TYPE			"PL310/L2C-310"
> +#else
>  static inline void cache_wait(void __iomem *reg, unsigned long mask)
>  {
>  	/* wait for the operation to complete */
> @@ -36,6 +48,22 @@ static inline void cache_wait(void __iomem *reg, unsigned long mask)
>  		;
>  }
> 
> +static DEFINE_SPINLOCK(l2x0_lock);
> +#define l2x0_lock(lock, flags)		spin_lock_irqsave(lock, flags)
> +#define l2x0_unlock(lock, flags)	spin_unlock_irqrestore(lock, flags)
> +
> +#define block_end(start, end)		((start) + min((end) - (start), 4096UL))
> +
> +#define L2CC_TYPE			"L2x0"
> +#endif
> +
> +static inline void cache_wait_always(void __iomem *reg, unsigned long mask)
> +{
> +	/* wait for the operation to complete */
> +	while (readl(reg) & mask)
> +		;
> +}
> +
>  static inline void cache_sync(void)
>  {
>  	void __iomem *base = l2x0_base;
> @@ -99,11 +127,11 @@ static inline void l2x0_inv_all(void)
>  	unsigned long flags;
> 
>  	/* invalidate all ways */
> -	spin_lock_irqsave(&l2x0_lock, flags);
> +	l2x0_lock(&l2x0_lock, flags);
>  	writel(0xff, l2x0_base + L2X0_INV_WAY);
> -	cache_wait(l2x0_base + L2X0_INV_WAY, 0xff);
> +	cache_wait_always(l2x0_base + L2X0_INV_WAY, 0xff);
>  	cache_sync();
> -	spin_unlock_irqrestore(&l2x0_lock, flags);
> +	l2x0_unlock(&l2x0_lock, flags);
>  }
> 
>  static void l2x0_inv_range(unsigned long start, unsigned long end)
> @@ -111,7 +139,7 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
>  	void __iomem *base = l2x0_base;
>  	unsigned long flags;
> 
> -	spin_lock_irqsave(&l2x0_lock, flags);
> +	l2x0_lock(&l2x0_lock, flags);
>  	if (start & (CACHE_LINE_SIZE - 1)) {
>  		start &= ~(CACHE_LINE_SIZE - 1);
>  		debug_writel(0x03);
> @@ -128,7 +156,7 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
>  	}
> 
>  	while (start < end) {
> -		unsigned long blk_end = start + min(end - start, 4096UL);
> +		unsigned long blk_end = block_end(start, end);
> 
>  		while (start < blk_end) {
>  			l2x0_inv_line(start);
> @@ -136,13 +164,13 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
>  		}
> 
>  		if (blk_end < end) {
> -			spin_unlock_irqrestore(&l2x0_lock, flags);
> -			spin_lock_irqsave(&l2x0_lock, flags);
> +			l2x0_unlock(&l2x0_lock, flags);
> +			l2x0_lock(&l2x0_lock, flags);
>  		}
>  	}
>  	cache_wait(base + L2X0_INV_LINE_PA, 1);
>  	cache_sync();
> -	spin_unlock_irqrestore(&l2x0_lock, flags);
> +	l2x0_unlock(&l2x0_lock, flags);
>  }
> 
>  static void l2x0_clean_range(unsigned long start, unsigned long end)
> @@ -150,10 +178,10 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
>  	void __iomem *base = l2x0_base;
>  	unsigned long flags;
> 
> -	spin_lock_irqsave(&l2x0_lock, flags);
> +	l2x0_lock(&l2x0_lock, flags);
>  	start &= ~(CACHE_LINE_SIZE - 1);
>  	while (start < end) {
> -		unsigned long blk_end = start + min(end - start, 4096UL);
> +		unsigned long blk_end = block_end(start, end);
> 
>  		while (start < blk_end) {
>  			l2x0_clean_line(start);
> @@ -161,13 +189,13 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
>  		}
> 
>  		if (blk_end < end) {
> -			spin_unlock_irqrestore(&l2x0_lock, flags);
> -			spin_lock_irqsave(&l2x0_lock, flags);
> +			l2x0_unlock(&l2x0_lock, flags);
> +			l2x0_lock(&l2x0_lock, flags);
>  		}
>  	}
>  	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
>  	cache_sync();
> -	spin_unlock_irqrestore(&l2x0_lock, flags);
> +	l2x0_unlock(&l2x0_lock, flags);
>  }
> 
>  static void l2x0_flush_range(unsigned long start, unsigned long end)
> @@ -175,10 +203,10 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
>  	void __iomem *base = l2x0_base;
>  	unsigned long flags;
> 
> -	spin_lock_irqsave(&l2x0_lock, flags);
> +	l2x0_lock(&l2x0_lock, flags);
>  	start &= ~(CACHE_LINE_SIZE - 1);
>  	while (start < end) {
> -		unsigned long blk_end = start + min(end - start, 4096UL);
> +		unsigned long blk_end = block_end(start, end);
> 
>  		debug_writel(0x03);
>  		while (start < blk_end) {
> @@ -188,13 +216,13 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
>  		debug_writel(0x00);
> 
>  		if (blk_end < end) {
> -			spin_unlock_irqrestore(&l2x0_lock, flags);
> -			spin_lock_irqsave(&l2x0_lock, flags);
> +			l2x0_unlock(&l2x0_lock, flags);
> +			l2x0_lock(&l2x0_lock, flags);
>  		}
>  	}
>  	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
>  	cache_sync();
> -	spin_unlock_irqrestore(&l2x0_lock, flags);
> +	l2x0_unlock(&l2x0_lock, flags);
>  }
> 
>  void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
> @@ -202,7 +230,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
>  	__u32 aux;
> 
>  	if (l2x0_disabled) {
> -		printk(KERN_INFO "L2X0 cache controller disabled\n");
> +		pr_info(L2CC_TYPE " cache controller disabled\n");
>  		return;
>  	}
> 
> @@ -232,7 +260,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
>  	outer_cache.clean_range = l2x0_clean_range;
>  	outer_cache.flush_range = l2x0_flush_range;
> 
> -	printk(KERN_INFO "L2X0 cache controller enabled\n");
> +	pr_info(L2CC_TYPE " cache controller enabled\n");
>  }
> 
>  static int __init l2x0_disable(char *unused)
