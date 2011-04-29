From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 29 Apr 2011 16:19:25 +0200 (CEST)
Subject: [patch 07/16] arm: omap: Use clocksource based sched_clock
In-Reply-To: <20110429125155.GA3755@atomide.com>
References: <20110423205036.795894921@linutronix.de>
	<20110423205132.221790438@linutronix.de>
	<20110429115744.GZ3755@atomide.com>
	<alpine.LFD.2.02.1104291420240.3005@ionos>
	<20110429125155.GA3755@atomide.com>
Message-ID: <alpine.LFD.2.02.1104291616160.3005@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011, Tony Lindgren wrote:
> * Thomas Gleixner <tglx@linutronix.de> [110429 05:25]:
> > 
> > The generic sched_clock implementation returns a jiffies based value
> > as long as there is no clocksource registered. But the above does not
> > fail in sched_clock() it fails in read_persistent_clock() which does
> > 
> >         last_cycles = cycles;
> >         cycles = clocksource_32k.read(&clocksource_32k);
> > 
> > So the following change causes this:
> > 
> > -     .read           = omap_32k_read_dummy,
> 
> Ah right.
>  
> > Which leads to the question why you have a read_persistent_clock() at
> > all if it always reads 0 via omap_32k_read_dummy ? Or is this meant
> > just for the resume case? Then the above and the removal of
> > omap_32k_read_dummy() needs to be undone.
> 
> The omap_32k_read_dummy needs to return 0 until the clocks are
> enabled and the right read function is selected. The .read gets
> then set in omap_init_clocksource_32k.
> 
> It would be nice to handle that in a generic way though,
> I would assume the same issue exists for other platforms too.

static inline cycles_t clocksource_read_safe(struct clocksource *c)
{
	return c->read ? c->read(c) : 0;
}

For the core timekeeping code that's a non issue as nothing should
register a clocksource with an invalid read function pointer :)

Thanks,

	tglx
