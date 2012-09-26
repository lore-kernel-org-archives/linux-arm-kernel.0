From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Sep 2012 15:45:00 +0100
Subject: [PATCH V4 3/6] arm: cache-l2x0: add support for Aurora L2
 cache ctrl
In-Reply-To: <1348213574-18494-4-git-send-email-gregory.clement@free-electrons.com>
References: <1348213574-18494-1-git-send-email-gregory.clement@free-electrons.com>
 <1348213574-18494-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120926144500.GB30938@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 09:46:10AM +0200, Gregory CLEMENT wrote:
>  arch/arm/include/asm/hardware/cache-aurora-l2.h |   55 ++++++

Will anything apart from cache-l2x0.c make use of this header file?
If not, it should be in arch/arm/mm.  I've said this many a time on
list that header files containing private definitions should be
co-located with their users.

Apart from that, and a few cosmetic additional unnecessary blank
lines, I think this is fine.  Relevant bits of the patch are below.

> +static unsigned long calc_range_end(unsigned long start, unsigned long end)
> +{
> +	/*
> +	 * Limit the number of cache lines processed at once,
> +	 * since cache range operations stall the CPU pipeline
> +	 * until completion.
> +	 */
> +
> +	if (end > start + MAX_RANGE_SIZE)
...
> +static void aurora_flush_range(unsigned long start, unsigned long end)
> +{
> +	if (!l2_wt_override) {
> +		start &= ~(CACHE_LINE_SIZE - 1);
> +		end = ALIGN(end, CACHE_LINE_SIZE);
> +		while (start != end) {
> +			unsigned long range_end = calc_range_end(start, end);
> +			aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
> +					AURORA_FLUSH_RANGE_REG);
> +			start = range_end;
> +		}
> +	}
> +}
> +
> +
> +
>  static void l2x0_disable(void)
...
>  		if (data->setup)
>  			data->setup(np, &aux_val, &aux_mask);
> +
> +
> +		/* For aurora cache in no outer mode select the
