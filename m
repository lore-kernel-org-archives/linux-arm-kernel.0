From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 6 Oct 2016 00:02:39 -0400 (EDT)
Subject: [PATCH] ARM: fix delays
In-Reply-To: <E1brv6h-0003j7-7J@rmk-PC.armlinux.org.uk>
References: <E1brv6h-0003j7-7J@rmk-PC.armlinux.org.uk>
Message-ID: <alpine.LFD.2.20.1610052258480.4520@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Oct 2016, Russell King wrote:

> Commit 215e362dafed ("ARM: 8306/1: loop_udelay: remove bogomips value
> limitation") tried to increase the bogomips limitation, but in doing
> so messed up udelay such that it always gives about a 5% error in the
> delay, even if we use a timer.
> 
> The calculation is:
> 
> 	loops = UDELAY_MULT * us_delay * ticks_per_jiffy >> UDELAY_SHIFT
> 
> Originally, UDELAY_MULT was ((UL(2199023) * HZ) >> 11) and UDELAY_SHIFT
> 30.  Assuming HZ=100, us_delay of 1000 and ticks_per_jiffy of 1660000
> (eg, 166MHz timer, 1ms delay) this would calculate:
> 
> 	((UL(2199023) * HZ) >> 11) * 1000 * 1660000 >> 30
> 		=> 165999
> 
> With the new values of 2047 * HZ + 483648 * HZ / 1000000 and 31, we get:
> 
> 	(2047 * HZ + 483648 * HZ / 1000000) * 1000 * 1660000 >> 31
> 		=> 158269
> 
> which is incorrect.  This is due to a typo - correcting it gives:
> 
> 	(2147 * HZ + 483648 * HZ / 1000000) * 1000 * 1660000 >> 31
> 		=> 165999
> 
> i.o.w, the original value.

WTF!

I don't know what kind of drugs I was on to make such a typo. It's not 
like if the 0 and 1 keys were close together.

For those who might wonder where the UDELAY_MULT magic value comes from:

	loops = loops_per_jiffy * jiffies_per_sec * us_delay / us_per_sec

where:

	jiffies_per_sec = HZ
	us_per_sec = 1000000

therefore the constant part is HZ / 1000000 which is a small fractional 
number.  To make this usable with integer math, we scale up this 
constant by 2^31, do the actual multiplication, and scale the result 
back down by 2^31 with a simple shift.  That means:

	UDELAY_MULT = 2^31 * HZ / 1000000
	            = (2^31 / 1000000) * HZ
	            = 2147.483648 * HZ
	            = 2147 * HZ + 483648 * HZ / 1000000

Maybe I should make a patch documenting this directly in the code.

While at it, why 2^31?  Because we assume HZ <= 1000 and us_delay <= 
2000. The result of UDELAY_MULT * us_delay must not overflow 32 bits as 
we let loops_per_jiffy span the whole 32 bits range and the final 
product must fit in 64 bits. Therefore:

	2000 * (2^31 * 1000 / 1000000) = 4294966000

This could be optimized even further by assuming that lpj will never 
reach 32 bits of magnitude, limiting it to 31 bits. In this case the 
scale factor could be 2^32, making a down shift by 32 bits even faster 
than a shift by 31 bits.

> Fixes: 215e362dafed ("ARM: 8306/1: loop_udelay: remove bogomips value limitation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/delay.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
> index b7a428154355..b1ce037e4380 100644
> --- a/arch/arm/include/asm/delay.h
> +++ b/arch/arm/include/asm/delay.h
> @@ -10,7 +10,7 @@
>  #include <asm/param.h>	/* HZ */
>  
>  #define MAX_UDELAY_MS	2
> -#define UDELAY_MULT	UL(2047 * HZ + 483648 * HZ / 1000000)
> +#define UDELAY_MULT	UL(2147 * HZ + 483648 * HZ / 1000000)
>  #define UDELAY_SHIFT	31
>  
>  #ifndef __ASSEMBLY__
> -- 
> 2.1.0
> 
> 
