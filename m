From: johnstul@us.ibm.com (john stultz)
Date: Tue, 16 Nov 2010 12:53:49 -0800
Subject: [PATCH] nomadik: prevent sched_clock() wraparound
In-Reply-To: <1289898690-29910-1-git-send-email-linus.walleij@stericsson.com>
References: <1289898690-29910-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1289940829.3860.22.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-11-16 at 10:11 +0100, Linus Walleij wrote:
> +unsigned long long sched_clock(void)
> +{
> +	unsigned long long v;
> +
> +	if (unlikely(!mtu_base))
> +		return 0;
> +
> +	v = cnt32_to_63(-readl(mtu_base + MTU_VAL(0)));
> +	/* The highest bit is not valid */
> +	v &= 0x7FFFFFFFFFFFFFFFLLU;
> +	return clocksource_cyc2ns(v, nmdk_clksrc.mult, nmdk_clksrc.shift);


I suspect this will still break. 

The cycle value being passed as v is likely to be large, and the
clocksource mult and shift are calculated to be as large as possible
without overflowing when given only a few seconds worth of cycles.

So its very likely that after a few seconds of running (or even less,
with the 32_to_63 conversion), the cyc2ns function will overflow, as
v*mult will be greater then 64bits.

So I'd advise *not* using the mult/shift pair calculated for
timekeeping, and possibly not using the clocksource_cyc2ns function (as
I'm likely to make that private to timekeeping at somepoint in the
future). Instead calculate a mult/shift pair using a smaller shift
value, so the overflow point will be much more rare.

For instance, on x86, the TSC based sched_clock uses a shift value of
10, but the TSC clocksource uses a shift value of ~30.

> +}
> +
> +/* Just kick sched_clock every so often */
> +static void cnt32_to_63_keepwarm(unsigned long data)
>  {
> -	return clocksource_cyc2ns(nmdk_clksrc.read(
> -				  &nmdk_clksrc),
> -				  nmdk_clksrc.mult,
> -				  nmdk_clksrc.shift);
> +	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
> +	(void) sched_clock();
> +}

Also, just FYI: This can be problematic on PREEMPT_RT systems, where
timers can be delayed by high priority processes hogging the cpu.

thanks
-john
