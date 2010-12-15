From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 14 Dec 2010 21:44:14 -0500 (EST)
Subject: [PATCH 01/16] ARM: Remove dependency of plat-orion time code on
	mach directory includes.
In-Reply-To: <20101215020228.GT15575@mail.wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
	<20101215020228.GT15575@mail.wantstofly.org>
Message-ID: <alpine.LFD.2.00.1012142121560.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Dec 2010, Lennert Buytenhek wrote:

> This patch makes the various mach dirs that use the plat-orion time
> code pass in timer and bridge addresses explicitly, instead of having
> plat-orion get those values by including a mach dir include file --
> the latter mechanism is problematic if you want to support multiple
> ARM platforms in the same kernel image.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
[...]
> @@ -57,8 +71,11 @@ static unsigned long tclk2ns_scale;
>  
>  unsigned long long sched_clock(void)
>  {
> -	unsigned long long v = cnt32_to_63(0xffffffff - readl(TIMER0_VAL));
> -	return (v * tclk2ns_scale) >> TCLK2NS_SCALE_FACTOR;
> +	unsigned long val;
> +
> +	val = ~readl(timer_base + TIMER0_VAL_OFF);
> +
> +	return (cnt32_to_63(val) * tclk2ns_scale) >> TCLK2NS_SCALE_FACTOR;
>  }

This is wrong.

The implementation of cnt32_to_63() looks like this:

#define cnt32_to_63(cnt_lo) \
({ \
        static u32 __m_cnt_hi; \
        union cnt32_to_63 __x; \
        __x.hi = __m_cnt_hi; \
        smp_rmb(); \
        __x.lo = (cnt_lo); \
[...]

Notice the smp_rmb() _before_ the cnt_lo argument is evaluated, and 
_after_ __m_cnt_hi is retrieved. Tthis ordering is important for the 
lockless algorithm used here, otherwise a racing thread could make the 
hardware counter look like it went backward, or that it actually jumped 
ahead almost one full period.  If you are caching the hardware counter 
value in a variable then you are defeating the algorithm.

I realize that this constraint is not properly documented in 
cnt32_to_63.h so I should fix that.


Nicolas
