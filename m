From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Dec 2009 10:28:39 +0000
Subject: [RFC PATCH 2/2] ARM: cache-l2x0: make better use of background
	cache handling
In-Reply-To: <E1NJVx6-0006um-Do@rmk-PC.arm.linux.org.uk>
References: <E1NJVx6-0006um-Do@rmk-PC.arm.linux.org.uk>
Message-ID: <1260786519.17159.19.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-12-12 at 17:40 +0000, Russell King - ARM Linux wrote:
> There's no point having the hardware support background operations
> if we issue a cache operation, and then wait for it to complete
> before calculating the address of the next operation.  We gain no
> advantage in the cache controller stalling the bus until completion.
> 
> What we should be doing is using the 'wait' time productively by
> calculating the address of the next operation, and only then waiting
> for the previous operation to complete.  This means that cache
> operations can occur in parallel with the CPU calculating the next
> address.
[...] 
>  static void l2x0_inv_range(unsigned long start, unsigned long end)
>  {
> +	void __iomem *base = l2x0_base;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&l2x0_lock, flags);
>  	if (start & (CACHE_LINE_SIZE - 1)) {
>  		start &= ~(CACHE_LINE_SIZE - 1);
> -		sync_writel(start, L2X0_CLEAN_INV_LINE_PA, 1);
> +		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> +		writel(start, base + L2X0_CLEAN_INV_LINE_PA);
>  		start += CACHE_LINE_SIZE;
>  	}
>  
>  	if (end & (CACHE_LINE_SIZE - 1)) {
>  		end &= ~(CACHE_LINE_SIZE - 1);
> -		sync_writel(end, L2X0_CLEAN_INV_LINE_PA, 1);
> +		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> +		writel(end, base + L2X0_CLEAN_INV_LINE_PA);
>  	}

Do we need a cache_wait() on L2X0_CLEAN_INV_LINE_PA here? Actually, do
we need the cache_wait() before writel()? Can we have it after?

>  	while (start < end) {
>  		unsigned long blk_end = start + min(end - start, 4096UL);
>  
>  		while (start < blk_end) {
> -			sync_writel(start, L2X0_INV_LINE_PA, 1);
> +			cache_wait(base + L2X0_INV_LINE_PA, 1);
> +			writel(start, base + L2X0_INV_LINE_PA);
>  			start += CACHE_LINE_SIZE;

This one waits on a different register than the one written above.

-- 
Catalin
