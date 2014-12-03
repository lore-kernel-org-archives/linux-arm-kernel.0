From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 21:03:48 +0100
Subject: [PATCH] optimize ktime_divns for constant divisors
In-Reply-To: <alpine.LFD.2.11.1412031424150.470@knanqh.ubzr>
References: <alpine.LFD.2.11.1412031424150.470@knanqh.ubzr>
Message-ID: <3913269.qTFsa05Ysv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 14:43:06 Nicolas Pitre wrote:
> At least on ARM, do_div() is optimized to turn constant divisors into
> an inline multiplication by the reciprocal value at compile time. 
> However this optimization is missed entirely whenever ktime_divns() is
> used and the slow out-of-line division code is used all the time.
> 
> Let ktime_divns() use do_div() inline whenever the divisor is constant
> and small enough.  This will make things like ktime_to_us() and 
> ktime_to_ms() much faster.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Very cool. I've been thinking about doing something similar for the
general case but couldn't get the math to work.

Can you think of an architecture-independent way to ktime_to_sec,
ktime_to_ms, and ktime_to_us efficiently based on what you did for
the ARM do_div implementation?

	Arnd
