From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 25 Jan 2010 11:55:00 +0530
Subject: [PATCH] ARM: L2 : Add maintainace by line helper functions
In-Reply-To: <1263996546-18629-1-git-send-email-santosh.shilimkar@ti.com>
References: <1263996546-18629-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0894011@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
Can below patches make way to patch system now ?

[PATCH] ARM: L2 : Add maintainace by line helper functions
[PATCH] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines

> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Wednesday, January 20, 2010 7:39 PM
> To: linux at arm.linux.org.uk
> Cc: linux-arm-kernel at lists.infradead.org; tony at atomide.com; Shilimkar, Santosh
> Subject: [PATCH] ARM: L2 : Add maintainace by line helper functions
> 
> This patch adds the cache maintainance by line helper functions.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/mm/cache-l2x0.c |   36 ++++++++++++++++++++++++++----------
>  1 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index cb8fc65..1a14d18 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -42,6 +42,27 @@ static inline void cache_sync(void)
>  	cache_wait(base + L2X0_CACHE_SYNC, 1);
>  }
> 
> +static inline void l2x0_clean_line(unsigned long addr)
> +{
> +	void __iomem *base = l2x0_base;
> +	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
> +	writel(addr, base + L2X0_CLEAN_LINE_PA);
> +}
> +
> +static inline void l2x0_inv_line(unsigned long addr)
> +{
> +	void __iomem *base = l2x0_base;
> +	cache_wait(base + L2X0_INV_LINE_PA, 1);
> +	writel(addr, base + L2X0_INV_LINE_PA);
> +}
> +
> +static inline void l2x0_flush_line(unsigned long addr)
> +{
> +	void __iomem *base = l2x0_base;
> +	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> +	writel(addr, base + L2X0_CLEAN_INV_LINE_PA);
> +}
> +
>  static inline void l2x0_inv_all(void)
>  {
>  	unsigned long flags;
> @@ -62,23 +83,20 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
>  	spin_lock_irqsave(&l2x0_lock, flags);
>  	if (start & (CACHE_LINE_SIZE - 1)) {
>  		start &= ~(CACHE_LINE_SIZE - 1);
> -		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> -		writel(start, base + L2X0_CLEAN_INV_LINE_PA);
> +		l2x0_flush_line(start);
>  		start += CACHE_LINE_SIZE;
>  	}
> 
>  	if (end & (CACHE_LINE_SIZE - 1)) {
>  		end &= ~(CACHE_LINE_SIZE - 1);
> -		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> -		writel(end, base + L2X0_CLEAN_INV_LINE_PA);
> +		l2x0_flush_line(end);
>  	}
> 
>  	while (start < end) {
>  		unsigned long blk_end = start + min(end - start, 4096UL);
> 
>  		while (start < blk_end) {
> -			cache_wait(base + L2X0_INV_LINE_PA, 1);
> -			writel(start, base + L2X0_INV_LINE_PA);
> +			l2x0_inv_line(start);
>  			start += CACHE_LINE_SIZE;
>  		}
> 
> @@ -103,8 +121,7 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
>  		unsigned long blk_end = start + min(end - start, 4096UL);
> 
>  		while (start < blk_end) {
> -			cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
> -			writel(start, base + L2X0_CLEAN_LINE_PA);
> +			l2x0_clean_line(start);
>  			start += CACHE_LINE_SIZE;
>  		}
> 
> @@ -129,8 +146,7 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
>  		unsigned long blk_end = start + min(end - start, 4096UL);
> 
>  		while (start < blk_end) {
> -			cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> -			writel(start, base + L2X0_CLEAN_INV_LINE_PA);
> +			l2x0_flush_line(start);
>  			start += CACHE_LINE_SIZE;
>  		}
> 
> --
> 1.6.0.4
