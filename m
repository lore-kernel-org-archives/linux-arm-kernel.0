From: w@1wt.eu (Willy Tarreau)
Date: Fri, 10 Apr 2015 13:42:53 +0200
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <5527B331.5000205@free.fr>
References: <5527B331.5000205@free.fr>
Message-ID: <20150410114253.GA18645@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 10, 2015 at 01:25:37PM +0200, Mason wrote:
> Hello everyone,
> 
> This is take 2 of my tiny delay.c patch
> 
> Problem statement
> 
> When converting microseconds to timer cycles in __timer_udelay() and
> __timer_const_udelay(), the result is rounded down(*), which means the
> system will not spin as long as requested (specifically, between
> epsilon and 1 cycle shorter).
> 
> If I understand correctly, most drivers expect udelay(N) to spin for
> at least N ?s. Is that correct? In that use case, spinning less might
> introduce subtle heisenbugs.
> 
> 
> Typical example
> 
> timer->freq = 90 kHz && HZ = 100
> (thus UDELAY_MULT = 107374 && ticks_per_jiffy = 900)
> 
> udelay(10) => __timer_const_udelay(10*107374)
>            => __timer_delay((1073740*900) >> 30)
>            => __timer_delay(0)
> 
> So udelay(10) resolves to no delay at all.
> 
> 
> (*) 2^41 / 10^6 = 2199023,255552
> 2199023 < 2^41 / 10^6
> UDELAY_MULT = 2199023*HZ / 2^11 < 2^30*HZ / 10^6
> 
> cycles = N * UDELAY_MULT * freq/HZ / 2^30
>        < N * 2^30*HZ / 10^6 * freq/HZ / 2^30
>        < N / 10^6 * freq
> 
> 
> Proposed fix
> 
> Since results are always rounded down, all we need is to increment
> the result by 1 to round it up.
> 
> Would someone ACK the patch below?
> 
> Regards.
> 
> 
> Patch against 4.0-rc4
> 
> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> index 312d43e..3cfbd07 100644
> --- a/arch/arm/lib/delay.c
> +++ b/arch/arm/lib/delay.c
> @@ -66,7 +66,7 @@ static void __timer_const_udelay(unsigned long xloops)
>  {
>         unsigned long long loops = xloops;
>         loops *= arm_delay_ops.ticks_per_jiffy;
> -       __timer_delay(loops >> UDELAY_SHIFT);
> +       __timer_delay((loops >> UDELAY_SHIFT) + 1);
>  }

If loops is a multiple of 2 ^ UDELAY_SHIFT, then your result is too
high by one. The proper way to round by excess is the following :

    __timer_delay((loops + (1 << UDELAY_SHIFT) - 1) >> UDELAY_SHIFT);

That way it does +1 for every value of loop not an exact multiple
of 2^UDELAY_SHIFT.

Regards,
willy
