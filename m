From: rabin@rab.in (Rabin Vincent)
Date: Thu, 18 Nov 2010 01:05:10 +0530
Subject: [PATCH] nomadik: prevent sched_clock() wraparound v3
In-Reply-To: <1290001517-17010-1-git-send-email-linus.walleij@stericsson.com>
References: <1290001517-17010-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTikk3aiUBbjf6YeXNQqymVmsYfgU4dVmQ2RsSOXx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 7:15 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> +unsigned long long sched_clock(void)
> +{
> + ? ? ? u64 cycles;
> +
> + ? ? ? if (unlikely(!mtu_base))
> + ? ? ? ? ? ? ? return 0;
> +
> + ? ? ? cycles = cnt32_to_63(-readl(mtu_base + MTU_VAL(0)));
> + ? ? ? cycles &= 0x7FFFFFFFFFFFFFFFLLU;
> + ? ? ? return (cycles * sched_mult) >> sched_shift;
> +}
> +
> +/* Just kick sched_clock every so often */
> +static void cnt32_to_63_keepwarm(unsigned long data)
> +{
> + ? ? ? mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
> + ? ? ? (void) sched_clock();
> +}
> +
> +/*
> + * Set up a timer to keep sched_clock():s 32_to_63 algorithm warm
> + * once in half a 32bit timer wrap interval.
> ?*/
> -unsigned long long notrace sched_clock(void)
> +static void __init nmdk_sched_clock_init(unsigned long rate)
> ?{
> - ? ? ? return clocksource_cyc2ns(nmdk_clksrc.read(
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &nmdk_clksrc),
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? nmdk_clksrc.mult,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? nmdk_clksrc.shift);
> + ? ? ? u32 v;
> + ? ? ? unsigned long delta;
> + ? ? ? u64 days;
> +
> + ? ? ? /* Find the apropriate mult and shift factors */
> + ? ? ? clocks_calc_mult_shift(&sched_mult, &sched_shift,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?rate, NSEC_PER_SEC, SCHED_CLOCK_MIN_WRAP);
> + ? ? ? /* We need to multiply by atleast 2 to get rid of bit 63 */
> + ? ? ? BUG_ON(sched_mult < 2);

No, you want to multiply by an even number, not "atleast 2".  Please
also drop the "cycles &= 0x7FFFFFFFFFFFFFFFLLU" in sched_clock().

> +
> + ? ? ? /* Let's see what we get, take max counter and scale it */
> + ? ? ? days = 0xFFFFFFFFFFFFFFFFLLU >> sched_shift;
> + ? ? ? do_div(days, rate);
> + ? ? ? do_div(days, (3600*24));
> +
> + ? ? ? pr_debug("sched_clock: using %d bits @ %lu Hz wrap in %lu days\n",
> + ? ? ? ? ? ? ? (64 - sched_shift), rate, (unsigned long) days);

This days calculation is wrong because you need to divide by
NSECS_PER_SEC, not rate.
