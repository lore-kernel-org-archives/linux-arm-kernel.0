From: mingo@elte.hu (Ingo Molnar)
Date: Thu, 19 May 2011 20:10:22 +0200
Subject: [patch 4/7] clockevents: Provide combined configure and register
	function
In-Reply-To: <alpine.LFD.2.02.1105191155170.3078@ionos>
References: <20110518205713.947614271@linutronix.de>
	<20110518210136.331975870@linutronix.de>
	<20110519090849.GA6251@elte.hu>
	<alpine.LFD.2.02.1105191155170.3078@ionos>
Message-ID: <20110519181022.GE6139@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 19 May 2011, Ingo Molnar wrote:
> 
> > 
> > * Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > +extern void clockevents_config_and_register(struct clock_event_device *dev,
> > > +					    u32 freq, unsigned long min_delta,
> > > +					    unsigned long max_delta);
> > 
> > might be worth collecting these fields into a clocksource_params structure:
> > 
> > struct clocksource_params {
> > 	u32		freq;
> > 	unsigned long	min_delta;
> > 	unsigned long	max_delta;
> > };
> > 
> > That way the initialization API looks even more streamlined:
> > 
> > extern void
> > clockevents_config_and_register(struct clock_event_device *dev,
> > 				struct clocksource_params params);
> > 
> > and could be extended in the future, without having to update every single 
> > clocksource driver again.
> 
> Though it's unlikely that we have more params int the foreseeable
> future and it's more code in the clock events registration sites as
> you have to do:
> 
>     struct param par;
> 
>     par.freq = f;
>     par.min_delta = x;
>     par.max_delta = y;
>     clockevents_config_and_register(&dev, &p);
> 
> instead of having a single line.

Indeed that looks uglish.

> When the need arises we still can do
> 
> __clockevents_config_and_register(struct clock_event_device *dev,
>    	                          struct clocksource_params params);
> 
> and have the current function as a wrapper around it.

Okay, you are right.

Thanks,

	Ingo
