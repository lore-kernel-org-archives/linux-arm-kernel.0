From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 30 Jan 2012 08:49:45 +0000
Subject: [RFC PATCH 1/5] arm:omap1/2/3/4:Convert 32k-Sync clocksource
 driver to platform_driver
In-Reply-To: <1327535610.2141.15.camel@localhost>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
 <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
 <1327535610.2141.15.camel@localhost>
Message-ID: <79CD15C6BA57404B839C016229A409A8317B7306@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 05:23:30, john stultz wrote:
> On Wed, 2012-01-18 at 16:58 +0530, Vaibhav Hiremath wrote:
> > +/**
> > + * read_persistent_clock -  Return time from a persistent clock.
> > + *
> > + * Reads the time from a source which isn't disabled during PM, the
> > + * 32k sync timer.  Convert the cycles elapsed since last read into
> > + * nsecs and adds to a monotonically increasing timespec.
> > + */
> > +void read_persistent_clock(struct timespec *ts)
> > +{
> > +	cycles_t delta;
> > +	struct timespec *tsp;
> > +	unsigned long long nsecs;
> > +	struct omap_counter_32k_device  *omap = cs;
> > +
> > +	if (!omap) {
> > +		ts->tv_sec = 0;
> > +		ts->tv_nsec = 0;
> > +		return;
> > +	}
> > +	tsp = &omap->persistent_ts;
> > +
> > +	omap->last_cycles = omap->cycles;
> > +	omap->cycles = omap->cs.read(&omap->cs);
> > +	delta = omap->cycles - omap->last_cycles;
> > +
> > +	nsecs = clocksource_cyc2ns(delta,
> > +			omap->cs.mult, omap->cs.shift);
> > +
> > +	timespec_add_ns(tsp, nsecs);
> > +	*ts = *tsp;
> > +}
> 
> Hrm. So read_persistent_clock should probably be defined once per arch.
> So I'm not sure if it makes sense to include this implementation into
> the generic drivers/clocksource directory, as if some other arch tried
> to include this clocksource (say if they had the same hardware) they
> might have collisions w/ their read_persistent_clock implementation.
> 
> 
> I'm all for being able to re-use clocksource drivers. But this is the
> sort of thing that makes me worry we're maybe being too aggressive in
> pushing clocksources that really are fairly arch/platform specific into
> drivers/clocksource/
> 

John,

Sorry for delayed response and thanks for your comments.

Just FYI, we had already aligned on the list that, this is not going
to work, and after discussion I have already submitted newer version
of the omap timer cleanup code -

http://marc.info/?l=linux-omap&m=132730863303625&w=2


Thanks,
Vaibhav

> thanks
> -john
> 
> 
> 
