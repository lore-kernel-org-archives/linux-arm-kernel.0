From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 08 Jan 2011 22:21:10 -0500 (EST)
Subject: [PATCH] ARM: sched_clock: improve mult/shift accuracy with high
	frequency clocks
In-Reply-To: <alpine.LFD.2.00.1012202014500.10437@xanadu.home>
References: <alpine.LFD.2.00.1012202014500.10437@xanadu.home>
Message-ID: <alpine.LFD.2.00.1101082208090.22191@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Ping.

I think this patch is needed independently of what happens to 
__clocksource_updatefreq_scale().  We must cover at least the full hw 
clock range because of update_sched_clock().  But no more than the full 
hw clock range otherwise we lose precision in the mult factor.  Without 
this patch we lose two bits of precision on Kirkwood.

On Mon, 20 Dec 2010, Nicolas Pitre wrote:

> 
> The minsec argument to clocks_calc_mult_shift() [ which appears to be
> misnamed by the way ] is used to clamp the magnitude of the mult factor
> so that the given range won't overflow a 64 bit result.  The mult factor
> is itself already limited to a maximum of 32 bits.  Given that the largest
> clock tick range we may have is also 32 bits, there is no way our usage of
> any computed mult factor would ever overflow 64 bits.
> 
> The choice of 60 seconds here for minsec is rather arbitrary.  If the
> mult factor wasn't already limited to 32 bits, this value of 60 would
> create overflows for clocks which take more than 60 seconds to wrap.
> 
> And for clocks which take less than 60 seconds to wrap then we do lose
> precision as the mult factor is made smaller (fewer bits) to be adjusted
> to a range which is larger than what we actually use.  This currently
> affects clocks faster than 71MHz.
> 
> We could use minsec = 0 instead of 60 and a good 32-bit mult factor would
> be computed in all cases.  But let's be formal and provide the actual
> range to clocks_calc_mult_shift(). None of the cyc_to_fixed_sched_clock()
> users are affected as they all are using clocks < 71MHz.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
> index 2cdcc92..f7a0f93 100644
> --- a/arch/arm/kernel/sched_clock.c
> +++ b/arch/arm/kernel/sched_clock.c
> @@ -30,11 +30,13 @@ void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
>  	unsigned long r, w;
>  	u64 res, wrap;
>  	char r_unit;
> +	u32 mask = (1ULL << clock_bits) - 1;
>  
>  	sched_clock_update_fn = update;
>  
>  	/* calculate the mult/shift to convert counter ticks to ns. */
> -	clocks_calc_mult_shift(&cd->mult, &cd->shift, rate, NSEC_PER_SEC, 60);
> +	clocks_calc_mult_shift(&cd->mult, &cd->shift, rate, NSEC_PER_SEC,
> +			       mask/rate);
>  
>  	r = rate;
>  	if (r >= 4000000) {
> @@ -46,7 +48,7 @@ void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
>  	}
>  
>  	/* calculate how many ns until we wrap */
> -	wrap = cyc_to_ns((1ULL << clock_bits) - 1, cd->mult, cd->shift);
> +	wrap = cyc_to_ns(mask, cd->mult, cd->shift);
>  	do_div(wrap, NSEC_PER_MSEC);
>  	w = wrap;
>  
> @@ -54,6 +56,7 @@ void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
>  	res = cyc_to_ns(1ULL, cd->mult, cd->shift);
>  	pr_info("sched_clock: %u bits at %lu%cHz, resolution %lluns, wraps every %lums\n",
>  		clock_bits, r, r_unit, res, w);
> +	pr_debug("sched_clock: mult=0x%08x shift=%u)\n", cd->mult, cd->shift);
>  
>  	/*
>  	 * Start the timer to keep sched_clock() properly updated and
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
