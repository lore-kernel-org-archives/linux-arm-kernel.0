From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jan 2013 16:08:34 +0000
Subject: [PATCH 1/4] ARM: cache-l2x0: Manage the errata at run time
In-Reply-To: <20130121131451.GA29855@bnru10>
References: <20130121131451.GA29855@bnru10>
Message-ID: <20130121160833.GQ23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 06:44:53PM +0530, srinidhi kasagar wrote:
> +/*
> + * Identify ther RTL releases of l2x0 - This might help in applying
> + * the l2x0 errata's dynamically rather compile time options
> + */
> +asmlinkage u32 l2x0_get_rtl_release(void)

Why asmlinkage?

> +{
> +	return readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
> +			L2X0_CACHE_ID_RTL_MASK;
> +}
> +
>  static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
>  {
>  	/* wait for cache operation by line or way to complete */
> @@ -87,46 +97,41 @@ static inline void l2x0_inv_line(unsigned long addr)
>  	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
>  }
>  
> -#if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_727915)
> -static inline void debug_writel(unsigned long val)
> +static void debug_writel(unsigned long val)
>  {
> -	if (outer_cache.set_debug)
> -		outer_cache.set_debug(val);
> +	u32 l2x0_revision = l2x0_get_rtl_release();
> +
> +	if (l2x0_revision == L2X0_CACHE_ID_RTL_R3P0 ||
> +		l2x0_revision == L2X0_CACHE_ID_RTL_R2P0 ||
> +		l2x0_revision == L2X0_CACHE_ID_RTL_R1P0 ||
> +		l2x0_revision == L2X0_CACHE_ID_RTL_R0P0)
> +			if (outer_cache.set_debug)
> +				outer_cache.set_debug(val);

This needs comments from the TI folk.  Also, change this around - if
there's no setting for 'set_debug' there's no point reading the rtl
release and checking it against a set of values.  Added Santosh.

>  static inline void l2x0_flush_line(unsigned long addr)
>  {
>  	void __iomem *base = l2x0_base;
> -	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> -	writel_relaxed(addr, base + L2X0_CLEAN_INV_LINE_PA);
> +	u32 l2x0_revision = l2x0_get_rtl_release();
> +
> +	if (l2x0_revision == L2X0_CACHE_ID_RTL_R0P0 ||
> +		l2x0_revision == L2X0_CACHE_ID_RTL_R1P0)
> +	{

Coding standards.

	if (l2x0_revision == L2X0_CACHE_ID_RTL_R0P0 ||
	    l2x0_revision == L2X0_CACHE_ID_RTL_R1P0) {
