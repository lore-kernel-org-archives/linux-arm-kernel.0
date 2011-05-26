From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 26 May 2011 10:32:01 +0200
Subject: [PATCH 07/13] clocksource: convert ARM 32-bit up counting
	clocksources
In-Reply-To: <E1QJhNy-0000yl-V0@rmk-PC.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhNy-0000yl-V0@rmk-PC.arm.linux.org.uk>
Message-ID: <20110526083201.GA27095@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Just noticed in the 2.6.40 (aka 3.0) merge window that this doesn't
work for big endian ixp, see below.

On Tue, May 10, 2011 at 08:29:38AM +0100, Russell King - ARM Linux wrote:
> Convert ixp4xx, lpc32xx, mxc, netx, pxa, sa1100, tcc8k, tegra and u300
> to use the generic mmio clocksource recently introduced.

...

> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
> index ed19bc3..74ed81a 100644
> --- a/arch/arm/mach-ixp4xx/common.c
> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -419,26 +419,14 @@ static void notrace ixp4xx_update_sched_clock(void)
>  /*
>   * clocksource
>   */
> -static cycle_t ixp4xx_get_cycles(struct clocksource *cs)
> -{
> -	return *IXP4XX_OSTS;
> -}
> -
> -static struct clocksource clocksource_ixp4xx = {
> -	.name 		= "OSTS",
> -	.rating		= 200,
> -	.read		= ixp4xx_get_cycles,
> -	.mask		= CLOCKSOURCE_MASK(32),
> -	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> -};
> -
>  unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
>  EXPORT_SYMBOL(ixp4xx_timer_freq);
>  static void __init ixp4xx_clocksource_init(void)
>  {
>  	init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq);
>  
> -	clocksource_register_hz(&clocksource_ixp4xx, ixp4xx_timer_freq);
> +	clocksource_mmio_init(&IXP4XX_OSTS, "OSTS", ixp4xx_timer_freq, 200, 32,
> +			clocksource_mmio_readl_up);
>  }

This does not compile. I think it should be:

    clocksource_mmio_init( /* delete me - & */ IXP4XX_OSTS, "OSTS", ...)

since IXP4XX_OSTS is 

    #define IXP4XX_TIMER_REG(x) ((volatile u32 *)(IXP4XX_TIMER_BASE_VIRT+(x)))
    #define IXP4XX_OSTS         IXP4XX_TIMER_REG(IXP4XX_OSTS_OFFSET)


However, still it doesn't work at run time using a big endian kernel.
The clocksource_mmio_readl_up() function uses readl_relaxed() which
uses le32_to_cpu(), and mixes up the counter value.

How can I fix this for big endian IXP?

Thanks,

Richard
