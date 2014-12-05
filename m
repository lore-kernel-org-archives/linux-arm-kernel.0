From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 5 Dec 2014 12:15:58 -0500 (EST)
Subject: [PATCH] optimize ktime_divns for constant divisors
In-Reply-To: <2145860.PBxl6kLNRF@wuerfel>
References: <alpine.LFD.2.11.1412031424150.470@knanqh.ubzr>
 <OF0EDEDB1C.C03829F7-ON48257DA5.00062083-48257DA5.0007628B@zte.com.cn>
 <alpine.LFD.2.11.1412042056240.470@knanqh.ubzr> <2145860.PBxl6kLNRF@wuerfel>
Message-ID: <alpine.LFD.2.11.1412051052090.470@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Dec 2014, Arnd Bergmann wrote:


> > 
> > That, too, risk overflowing.
> > 
> > Let's say x_lo = 0xffffffff and x_hi = 0xffffffff.  You get:
> > 
> >         0xffffffff * 0x83126e97 ->  0x83126e967ced9169
> >         0xffffffff * 0x8d4fdf3b ->  0x8d4fdf3a72b020c5
> >                                    -------------------
> >                                    0x110624dd0ef9db22e
> > 
> > Therefore the sum doesn't fit into a u64 variable.
> > 
> > It is possible to skip carry handling but only when the MSB of both 
> > constants are zero.  Here it is not the case.
> 
> If I understand this right, there are two possible optimizations to
> avoid the overflow:
> 
> - for anything using monotonic time, or elapsed time, we can guarantee
>   that the upper bits are zero. Relying on monotonic time is a bit
>   dangerous, because that would mean introducing an API that works
>   with ktime_get() but not ktime_get_real(), and risk introducing
>   subtle bugs.
>   However, ktime_us_delta() could be optimized, and we can introduce
>   similar ktime_sec_delta() and ktime_ms_delta() functions with
>   the same properties.

Well, as Pang mentioned, ktime_t.tv64 is signed.  So if a negative value 
were to be passed to the current version of ktime_divns() you wouldn't 
get the expected answer as the first thing it does is

	u64 dclc = ktime_to_ns(kt);

And do_div() works with unsigned values.

So to say that we can assume that currently and for the forseeable 
future, the top bit of ktime_t will never be set.  And if it does due to 
a negative value then the code is already buggy.

With that assumption in mind, we now have a maximum value of 
0x7fffffffffffffff to divide i.e. 63 rather than 64 bits.  That means we 
don't need the initial bias anymore to get correct results.  And the 
constant looses its MSB too, removing the possibility for overflows in 
the cross product.

Therefore the code becomes:

u64 ktime_to_us(ktime_t kt)
{
        u64 ns = ktime_to_ns(kt);
        u32 x_lo, x_hi, y_lo, y_hi;
        u64 res;

        x_hi = ns >> 32;
        x_lo = ns;
        y_hi = 0x4189374b;
        y_lo = 0xc6a7ef9e;

        res =  (u64)x_lo * y_lo;
        res >>= 32;
        res += (u64)x_lo * y_hi;
        res += (u64)x_hi * y_lo;
        res >>= 32;
        res += (u64)x_hi * y_hi;

        return res >> 8;
}

This is probably the best that can be done portably.

> - one could always pre-shift the ktime_t value. For a division by
>   1000, we can shift right by 3 bits first, then do the multiplication
>   and then do another shift. Not sure if that helps at all or if
>   the extra shift operation makes this counterproductive.

It could help in the full 64-bit range case as the remaining dividend 
doesn't require a full 64-bit reciprocal constant, avoiding once again 
the need for the initial bias and the carry handling.  Depending on the 
actual reciprocal bit pattern this may not always be necessary.  It also 
depends how cheap shifting a 64-bit value is (on ARM this requires 3 
instructions and 3 registers).

But in the specific case above this provides no gain.


Nicolas
