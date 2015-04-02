From: slash.tmp@free.fr (Mason)
Date: Thu, 02 Apr 2015 14:12:05 +0200
Subject: __timer_udelay(1) may return immediately
In-Reply-To: <551D0C71.8050707@free.fr>
References: <551D0C71.8050707@free.fr>
Message-ID: <551D3215.6030102@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2015 11:31, Mason wrote:

> I'm using timer-based delays from arch/arm/lib/delay.c
>
> Consider the following configuration:
> HZ=100
> timer->freq = 1000000
>
> Thus
> UDELAY_MULT = 107374
> ticks_per_jiffy = 10000
>
> Thus __timer_udelay(1) =>
> __timer_const_udelay(107374) =>
> __timer_delay(0) => calls get_cycles() twice then returns prematurely
>
> The issue comes from a tiny rounding error as
> 107374 * ticks_per_jiffy >> UDELAY_SHIFT = 0,9999983
> which is rounded down to 0.
>
> The root of the issue is that mathematically,
> UDELAY_MULT = 2199023 * HZ / 2048 = 107374,169921875
> which is rounded down to 107374.
>
> It seems to me that a simple solution would be to round
> UDELAY_MULT up instead of down.
>
> Thus UDELAY_MULT = 107375
> 107375 * ticks_per_jiffy >> UDELAY_SHIFT = 1,0000076
>
> We might end up sleeping one cycle more than necessary, but I don't
> think spinning a bit longer would be a problem?
>
> Patch provided for illustration purposes.
>
> What do you think?
>
> Regards.
>
>
> diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
> index dff714d..873a43e 100644
> --- a/arch/arm/include/asm/delay.h
> +++ b/arch/arm/include/asm/delay.h
> @@ -10,7 +10,7 @@
>   #include <asm/param.h> /* HZ */
>
>   #define MAX_UDELAY_MS  2
> -#define UDELAY_MULT    ((UL(2199023) * HZ) >> 11)
> +#define UDELAY_MULT    (((UL(2199023) * HZ) >> 11) + 1)
>   #define UDELAY_SHIFT   30
>
>   #ifndef __ASSEMBLY__

Come to think of it, a closely related issue is: what to do when the
user requests a delay which resolves to a cycle count with a non-zero
fractional part? (e.g. delay for 7.2 cycles)

I think we should round up these values (delay for 8 cycles in the
example). So forget the first patch, keep the rounded down value
for UDELAY_MULT, and round up the cycle count.

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 5306de3..a9b3c75 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -59,7 +59,7 @@ static void __timer_const_udelay(unsigned long xloops)
  {
         unsigned long long loops = xloops;
         loops *= arm_delay_ops.ticks_per_jiffy;
-       __timer_delay(loops >> UDELAY_SHIFT);
+       __timer_delay((loops >> UDELAY_SHIFT) + 1);
  }
  
  static void __timer_udelay(unsigned long usecs)


Also, I was thinking of implementing ndelay() in delay.h

Would it make sense to define

#define NSDELAY_MULT	((UL(281475) * HZ) >> 18) // or perhaps 281474?
and have ndelay(ns) resolve __const_udelay((ns) * NSDELAY_MULT))

Or should I just keep that in platform-specific headers?

Regards.
