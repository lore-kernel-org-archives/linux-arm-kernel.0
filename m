From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 13:02:33 +0100
Subject: [PATCH] optimize ktime_divns for constant divisors
In-Reply-To: <alpine.LFD.2.11.1412040143260.470@knanqh.ubzr>
References: <alpine.LFD.2.11.1412031424150.470@knanqh.ubzr>
 <3913269.qTFsa05Ysv@wuerfel> <alpine.LFD.2.11.1412040143260.470@knanqh.ubzr>
Message-ID: <2165831.DQoLFmGhIf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 02:23:37 Nicolas Pitre wrote:
> On Wed, 3 Dec 2014, Arnd Bergmann wrote:
> 
> > On Wednesday 03 December 2014 14:43:06 Nicolas Pitre wrote:
> > > At least on ARM, do_div() is optimized to turn constant divisors into
> > > an inline multiplication by the reciprocal value at compile time. 
> > > However this optimization is missed entirely whenever ktime_divns() is
> > > used and the slow out-of-line division code is used all the time.
> > > 
> > > Let ktime_divns() use do_div() inline whenever the divisor is constant
> > > and small enough.  This will make things like ktime_to_us() and 
> > > ktime_to_ms() much faster.
> > > 
> > > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > 
> > Very cool. I've been thinking about doing something similar for the
> > general case but couldn't get the math to work.
> > 
> > Can you think of an architecture-independent way to ktime_to_sec,
> > ktime_to_ms, and ktime_to_us efficiently based on what you did for
> > the ARM do_div implementation?
> 
> Sure.  gcc generates rather shitty code on ARM compared to the output 
> from my do_div() implementation. But here it is:
> 
> u64 ktime_to_us(ktime_t kt)
> {
>         u64 ns = ktime_to_ns(kt);
>         u32 x_lo, x_hi, y_lo, y_hi;
>         u64 res, carry;
> 
>         x_hi = ns >> 32;
>         x_lo = ns;
>         y_hi = 0x83126e97;
>         y_lo = 0x8d4fdf3b;
> 
>         res = (u64)x_lo * y_lo;
>         carry = (u64)(u32)res + y_lo;
>         res = (res >> 32) + (carry >> 32);
> 
>         res += (u64)x_lo * y_hi;
>         carry = (u64)(u32)res + (u64)x_hi * y_lo;
>         res = (res >> 32) + (carry >> 32);
> 
>         res += (u64)x_hi * y_hi;
>         return res >> 9;
> }

Ok, I see, thanks for the example. I also tried this on x86, and it takes
about twice as long as do_div on my Opteron, so it wouldn't be as helpful
as I hoped.

On a related note, I wonder if we can come up with a more efficient
implementation for do_div on ARMv7ve, and I think we should add the
Makefile logic to build with -march=armv7ve when we know that we do
not need to support processors without idiv.

	Arnd
