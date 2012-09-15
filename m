From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Sep 2012 21:42:57 +0100
Subject: [PATCH V3 3/6] arm: cache-l2x0: add support for Aurora L2
 cache ctrl
In-Reply-To: <1346852677-5381-4-git-send-email-gregory.clement@free-electrons.com>
References: <1346852677-5381-1-git-send-email-gregory.clement@free-electrons.com>
 <1346852677-5381-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120915204257.GL12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 03:44:34PM +0200, Gregory CLEMENT wrote:
> @@ -275,6 +281,112 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
>  	cache_sync();
>  	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
>  }
> +/*

Where's the blank line?

> + * Note that the end addresses passed to Linux primitives are
> + * noninclusive, while the hardware cache range operations use
> + * inclusive start and end addresses.
> + */
> +static unsigned long calc_range_end(unsigned long start, unsigned long end)
> +{
> +	if (!IS_ALIGNED(start, CACHE_LINE_SIZE)) {
> +		pr_warn("%s: start address not align on a cache line size\n",
> +			__func__);
> +		start &= ~(CACHE_LINE_SIZE-1);
> +	};

No semicolon here.  But why is this check even here?

> +
> +	if (!IS_ALIGNED(end, CACHE_LINE_SIZE)) {
> +		pr_warn("%s: end address not align on a cache line size\n",
> +			__func__);
> +		end = (PAGE_ALIGN(end));
> +	}

And this one - and why when it fails do you align to a page not a cache
line?

> +static void aurora_inv_range(unsigned long start, unsigned long end)
> +{
> +	/*
> +	 * round start and end adresses up to cache line size
> +	 */
> +	start &= ~(CACHE_LINE_SIZE - 1);
> +	end = ALIGN(end, CACHE_LINE_SIZE);
> +
> +	/*
> +	 * Invalidate all full cache lines between 'start' and 'end'.
> +	 */
> +	while (start < end) {
> +		unsigned long range_end = calc_range_end(start, end);

And note that you (above) guarantee that the start/end addresses are
cache line aligned.  It only goes wrong if your calc_range_end()
fails - but isn't that a matter of internal proving that your code is
correct, rather than lumbering all kernels with such checking?
