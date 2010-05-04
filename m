From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 May 2010 10:10:06 +0100
Subject: [PATCH] [arm l2x0] Extend cache-l2x0 to support the 16-way PL310
In-Reply-To: <1272654785-12779-2-git-send-email-jason.mcmullan@netronome.com>
References: <1272654785-12779-1-git-send-email-jason.mcmullan@netronome.com>
	<1272654785-12779-2-git-send-email-jason.mcmullan@netronome.com>
Message-ID: <000001caeb69$9713a160$c53ae420$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

This is looking good. Some pedantry:

> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 21ad68b..88c6131 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -27,6 +27,7 @@
> 
>  static void __iomem *l2x0_base;
>  static DEFINE_SPINLOCK(l2x0_lock);
> +static uint32_t l2x0_way_mask;	/* Bitmask of active ways */
> 
>  static inline void cache_wait(void __iomem *reg, unsigned long mask)
>  {
> @@ -106,10 +107,9 @@ static inline void l2x0_inv_all(void)
>  {
>  	unsigned long flags;
> 
> -	/* invalidate all ways */
>  	spin_lock_irqsave(&l2x0_lock, flags);
> -	writel(0xff, l2x0_base + L2X0_INV_WAY);
> -	cache_wait(l2x0_base + L2X0_INV_WAY, 0xff);
> +	writel(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
> +	cache_wait(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
>  	cache_sync();
>  	spin_unlock_irqrestore(&l2x0_lock, flags);
>  }

I think the comment can stay in the code as it's actually true now!

> @@ -217,10 +217,32 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
>  	 * accessing the below registers will fault.
>  	 */
>  	if (!(readl(l2x0_base + L2X0_CTRL) & 1)) {
> +		int ways;
> +		uint32_t cache_id;

These declarations should probably be at the top of the function. Actually,
you could just assign to l2x0_way_mask directly. Also, l2x0.c appears to use
the __u32 datatype instead of uint32_t or u32, so it's probably best just to
follow suit.

>  		/* l2x0 controller is disabled */
> -
> +		cache_id = readl(l2x0_base + L2X0_CACHE_ID);
>  		aux = readl(l2x0_base + L2X0_AUX_CTRL);
> +
> +		/* Determine the number of ways */
> +		switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
> +		case L2X0_CACHE_ID_PART_L310:
> +			if (aux & (1 << 16))
> +				ways = 16;
> +			else
> +				ways = 8;
> +			break;
> +		case L2X0_CACHE_ID_PART_L210:
> +			ways = (aux >> 13) & 0xf;
> +			break;
> +		default:
> +			/* Assume unknown chips have 8 ways */
> +			ways = 8;
> +			break;
> +		}
> +
> +		l2x0_way_mask = (1 << ways) - 1;
> +
>  		aux &= aux_mask;
>  		aux |= aux_val;
>  		writel(aux, l2x0_base + L2X0_AUX_CTRL);

As Russell pointed out, it would be helpful to print out a message here [instead
of "L2X0 cache controller enabled"], particularly if the chip is unknown and we
assume an 8-way configuration. Printing out the part, number of ways and perhaps
the auxiliary ctrl register would be useful.

Cheers,

Will
