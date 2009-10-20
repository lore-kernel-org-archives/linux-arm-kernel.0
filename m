From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 20 Oct 2009 10:19:12 +0200
Subject: [PATCH] Make MIPS dynamic clocksource/clockevent clock code
	generic
In-Reply-To: <alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
References: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
Message-ID: <19165.29312.300540.500942@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner writes:
 > > +static inline void clockevent_set_clock(struct clock_event_device *dev, u32 hz)
 > > +{
 > > +	u64 temp;
 > > +	u32 shift;
 > > +
 > > +	/* Find a shift value */
 > > +	for (shift = 32; shift > 0; shift--) {
 > > +		temp = (u64) hz << shift;
 > > +		do_div(temp, NSEC_PER_SEC);
 > > +		if ((temp >> 32) == 0)
 > > +			break;
 > > +	}
 > > +	dev->shift = shift;
 > > +	dev->mult = (u32) temp;
 > > +}
 > > +
 > > +
 > > +static inline void clocksource_set_clock(struct clocksource *cs, u32 hz)
 > > +{
 > > +	u64 temp;
 > > +	u32 shift;
 > > +
 > > +	/* Find a shift value */
 > > +	for (shift = 32; shift > 0; shift--) {
 > > +		temp = (u64) NSEC_PER_SEC << shift;
 > > +		do_div(temp, hz);
 > > +		if ((temp >> 32) == 0)
 > > +			break;
 > > +	}
 > > +	cs->shift = shift;
 > > +	cs->mult = (u32) temp;
 > > +}
 > > +
 > 
 > So that's the same function twice, right ?

They are similar but not identical:

 > > +		temp = (u64) hz << shift;
 > > +		do_div(temp, NSEC_PER_SEC);

vs

 > > +		temp = (u64) NSEC_PER_SEC << shift;
 > > +		do_div(temp, hz);

I suppose both functions could be implemented by a suitably
parametric third function, but IMO that would just obscure things.

Making them non-inline I fully agree with.
