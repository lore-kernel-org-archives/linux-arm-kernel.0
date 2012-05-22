From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 May 2012 10:21:07 +0100
Subject: [PATCH v2] RFC: ARM: cache-l2x0: update workaround for PL310
 errata 727915
In-Reply-To: <1337546505-24660-1-git-send-email-linus.walleij@stericsson.com>
References: <1337546505-24660-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120522092107.GB7286@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, May 20, 2012 at 09:41:45PM +0100, Linus Walleij wrote:
> From: Colin Cross <ccross@android.com>
> 
> ARM errata 727915 for PL310 has been updated to include a new
> workaround required for PL310 r2p0 for l2x0_flush_all, which also
> affects l2x0_clean_all in my testing. For r2p0, clean or flush
> each set/way individually. For r3p0 or greater, use the debug
> register for cleaning and flushing.
> 
> Requires exporting the cache_id, sets and ways detected in the
> init function for later use.

[...]

> +#ifdef CONFIG_PL310_ERRATA_727915
> +static void l2x0_for_each_set_way(void __iomem *reg)
> +{
> +	int set;
> +	int way;
> +	unsigned long flags;
> +
> +	for (way = 0; way < l2x0_ways; way++) {
> +		raw_spin_lock_irqsave(&l2x0_lock, flags);
> +		for (set = 0; set < l2x0_sets; set++)
> +			writel_relaxed((way << 28) | (set << 5), reg);
> +		cache_sync();
> +		raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> +	}
> +}
> +#endif
> +
>  static void __l2x0_flush_all(void)
>  {
>  	debug_writel(0x03);
> @@ -143,6 +170,13 @@ static void l2x0_flush_all(void)
>  {
>  	unsigned long flags;
>  
> +#ifdef CONFIG_PL310_ERRATA_727915
> +	if (is_pl310_rev(REV_PL310_R2P0)) {
> +		l2x0_for_each_set_way(l2x0_base + L2X0_CLEAN_INV_LINE_IDX);
> +		return;
> +	}
> +#endif

If we're adding code like this to flush_all, maybe we'd be better off just
assigning a different function to outer_cache.flush_all if we detect that
the current outer cache is an affected PL310 variant. However, note that
__l2x0_flush_all is called on the disable path. Do we need to intercept that
too?

> @@ -153,11 +187,20 @@ static void l2x0_clean_all(void)
>  {
>  	unsigned long flags;
>  
> +#ifdef CONFIG_PL310_ERRATA_727915
> +	if (is_pl310_rev(REV_PL310_R2P0)) {
> +		l2x0_for_each_set_way(l2x0_base + L2X0_CLEAN_LINE_IDX);
> +		return;
> +	}
> +#endif

clean_all is only called as an optimisation when cleaning a large range.
Since the workaround resorts back to cleaning each set and way, it's
questionable whether the optimisation pays off. I'd be inclined just to
predicate the optimisation on the erratum not being set.

>  	/* clean all ways */
>  	raw_spin_lock_irqsave(&l2x0_lock, flags);
> +	debug_writel(0x03);
>  	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_WAY);
>  	cache_wait_way(l2x0_base + L2X0_CLEAN_WAY, l2x0_way_mask);
>  	cache_sync();
> +	debug_writel(0x00);
>  	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
>  }

What are these new debug writes for? I thought only clean and invalidate was
affected?

Will
