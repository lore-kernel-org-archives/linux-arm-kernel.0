From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2011 23:58:26 +0100
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <20110530084307.GA28953@riccoc20.at.omicron.at>
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
Message-ID: <20110601225826.GR3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 10:43:07AM +0200, Richard Cochran wrote:
> Commit 234b6ceddb4fc2a4bc5b9a7670f070f6e69e0868
> 
>    clocksource: convert ARM 32-bit up counting clocksources
> 
> broke the build for ixp4xx and made big endian operation impossible.
> This commit restores the original behaviour.

I'm really not happy about using the MMIO clocksource stuff with random
other read functions like this - it defeats the entire purpose of the
MMIO clocksource stuff.  Maybe we should just undo the change for IXP4xx
and treat it as "special" for the time being.

Thomas - do you have any other views?

> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
> ---
>  arch/arm/mach-ixp4xx/common.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
> index 74ed81a..0777257 100644
> --- a/arch/arm/mach-ixp4xx/common.c
> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -419,14 +419,20 @@ static void notrace ixp4xx_update_sched_clock(void)
>  /*
>   * clocksource
>   */
> +
> +static cycle_t ixp4xx_clocksource_read(struct clocksource *c)
> +{
> +	return *IXP4XX_OSTS;
> +}
> +
>  unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
>  EXPORT_SYMBOL(ixp4xx_timer_freq);
>  static void __init ixp4xx_clocksource_init(void)
>  {
>  	init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq);
>  
> -	clocksource_mmio_init(&IXP4XX_OSTS, "OSTS", ixp4xx_timer_freq, 200, 32,
> -			clocksource_mmio_readl_up);
> +	clocksource_mmio_init(NULL, "OSTS", ixp4xx_timer_freq, 200, 32,
> +			ixp4xx_clocksource_read);
>  }
>  
>  /*
> -- 
> 1.7.0.4
> 
