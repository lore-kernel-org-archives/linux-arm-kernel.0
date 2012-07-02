From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 2 Jul 2012 14:29:53 +0200 (CEST)
Subject: [PATCH 1/9] clocksource: time-armada-370-xp: Marvell Armada
 370/XP SoC timer driver
In-Reply-To: <1341228809-17824-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341228809-17824-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341228809-17824-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <alpine.LFD.2.02.1207021424570.2793@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Jul 2012, Thomas Petazzoni wrote:
> From: Gregory Clement <gregory.clement@free-electrons.com>
> +/*
> + * Clockevent handling.
> + */
> +static int
> +armada_370_xp_clkevt_next_event(unsigned long delta,
> +				struct clock_event_device *dev)
> +{
> +	unsigned long flags;
> +	u32 u;
> +
> +	if (delta == 0)
> +		return -ETIME;

If you have a proper min_delta_ns value set up, then delta will never
be 0. SO that check is pointless.

> +	local_irq_save(flags);

That code is guaranteed to be called with interrupts disabled. No need
for disabling them again.

> +
> +static void
> +armada_370_xp_clkevt_mode(enum clock_event_mode mode,
> +			  struct clock_event_device *dev)
> +{
> +	unsigned long flags;
> +	u32 u;
> +
> +	local_irq_save(flags);

Ditto.

> +	/*
> +	 * Setup clockevent timer (interrupt-driven).
> +	 */
> +	setup_irq(timer_irq, &armada_370_xp_timer_irq);
> +	armada_370_xp_clkevt.mult = div_sc(timer_clk, NSEC_PER_SEC,
> +					   armada_370_xp_clkevt.shift);
> +	armada_370_xp_clkevt.max_delta_ns = clockevent_delta2ns(0xfffffffe,
> +							&armada_370_xp_clkevt);
> +	armada_370_xp_clkevt.min_delta_ns =
> +	    clockevent_delta2ns(1, &armada_370_xp_clkevt);

clockevents_config_and_register() please.

Thanks,

	tglx
