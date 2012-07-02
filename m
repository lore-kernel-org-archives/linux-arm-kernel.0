From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 2 Jul 2012 15:03:17 +0200
Subject: [PATCH 1/9] clocksource: time-armada-370-xp: Marvell Armada
 370/XP SoC timer driver
In-Reply-To: <alpine.LFD.2.02.1207021424570.2793@ionos>
References: <1341228809-17824-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341228809-17824-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <alpine.LFD.2.02.1207021424570.2793@ionos>
Message-ID: <20120702150317.0c7e91aa@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

Le Mon, 2 Jul 2012 14:29:53 +0200 (CEST),
Thomas Gleixner <tglx@linutronix.de> a ?crit :

> > +{
> > +	unsigned long flags;
> > +	u32 u;
> > +
> > +	if (delta == 0)
> > +		return -ETIME;
> 
> If you have a proper min_delta_ns value set up, then delta will never
> be 0. SO that check is pointless.
> 
> > +	local_irq_save(flags);
> 
> That code is guaranteed to be called with interrupts disabled. No need
> for disabling them again.
> > +	/*
> > +	 * Setup clockevent timer (interrupt-driven).
> > +	 */
> > +	setup_irq(timer_irq, &armada_370_xp_timer_irq);
> > +	armada_370_xp_clkevt.mult = div_sc(timer_clk, NSEC_PER_SEC,
> > +					   armada_370_xp_clkevt.shift);
> > +	armada_370_xp_clkevt.max_delta_ns = clockevent_delta2ns(0xfffffffe,
> > +							&armada_370_xp_clkevt);
> > +	armada_370_xp_clkevt.min_delta_ns =
> > +	    clockevent_delta2ns(1, &armada_370_xp_clkevt);
> 
> clockevents_config_and_register() please.

Thanks a lot for all those comments. I have fixed those in our tree,
will be part of the next v7 posting. We'll just wait a bit more time
in case other comments show up before posting this v7.

Thanks again for the review,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
