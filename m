From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 13 Jan 2015 14:48:51 +0800
Subject: CFT: move outer_cache_sync() out of line
In-Reply-To: <20150112163648.GL12302@n2100.arm.linux.org.uk>
References: <20150112163648.GL12302@n2100.arm.linux.org.uk>
Message-ID: <20150113144851.1944cf0d@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, 12 Jan 2015 08:36:48 -0800
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> The theory is that moving outer_cache_sync() out of line moves the
> conditional test from multiple sites to a single location, which
> in turn means that the branch predictor stands a better chance of
> making the correct decision.
> 
> However, I'm a hardware pauper - I have the choice of testing this
> on iMX6 (which seems to have bus limitations, and seems to produce
> a wide variation on measured performance which makes it hard to
> evaluate any differences) or the Versatile Express, which really is
> not suitable for making IO performance measurements.
> 
> So, without help from people with "good" hardware, I can't evaluate
> the performance impact of this change.  Anyone willing to do some
> performance testing on this and feedback any numbers?

I applied your patch into marvell internal bsp tree, then did a basic emmc
performance test via. dd cmd, the performance is improved by 0.13%
the sdhc host driver is drivers/mmc/host/sdhci-pxav3.c, I'm not sure
it make use of a lot of non-relaxed IO accessors.

> 
> Obviously, drivers which make use of a lot of non-relaxed IO accessors
> will be most affected by this - so you really have to know your
> drivers when deciding how to evaluate this (sorry, I can't say "measure
> network bandwidth" or "measure SSD sata performance" is a good test.)
> 
> Theoretically, this should help overall system performance, since the
> branch predictor should be able to predict this better, but it's entirely
> possible that trying to benchmark a single workload won't be measurably
> different.
> 
> In terms of kernel size figures, this change alone saves almost 17K of
> 10MB of kernel text on my iMX6 kernels - which is bordering on
> insignificant since that's not quite a 0.2% saving.
> 
> So... right now I can't justify this change, but I'm hoping some can come
> up with some figures which shows that it benefits their workload without
> causing a performance regression for others.
> 
> diff --git a/arch/arm/include/asm/outercache.h
> b/arch/arm/include/asm/outercache.h index 891a56b35bcf..807e4e71c8e7 100644
> --- a/arch/arm/include/asm/outercache.h
> +++ b/arch/arm/include/asm/outercache.h
> @@ -133,11 +133,7 @@ static inline void outer_resume(void) { }
>   * Ensure that all outer cache operations are complete and any store
>   * buffers are drained.
>   */
> -static inline void outer_sync(void)
> -{
> -	if (outer_cache.sync)
> -		outer_cache.sync();
> -}
> +extern void outer_sync(void);
>  #else
>  static inline void outer_sync(void)
>  { }
> diff --git a/arch/arm/mm/l2c-common.c b/arch/arm/mm/l2c-common.c
> index 10a3cf28c362..b1c24c8c1eb9 100644
> --- a/arch/arm/mm/l2c-common.c
> +++ b/arch/arm/mm/l2c-common.c
> @@ -7,9 +7,17 @@
>   * published by the Free Software Foundation.
>   */
>  #include <linux/bug.h>
> +#include <linux/export.h>
>  #include <linux/smp.h>
>  #include <asm/outercache.h>
>  
> +void outer_sync(void)
> +{
> +	if (outer_cache.sync)
> +		outer_cache.sync();
> +}
> +EXPORT_SYMBOL(outer_sync);
> +
>  void outer_disable(void)
>  {
>  	WARN_ON(!irqs_disabled());
> 
> 
