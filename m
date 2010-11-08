From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 8 Nov 2010 09:42:56 -0500 (EST)
Subject: One quick quenstion about PXA sched_clock resolution?
In-Reply-To: <20101108100119.GR16938@pengutronix.de>
References: <3f0ffa72.f9b4.12c2ab386e4.Coremail.bill_carson@126.com>
	<20101108100119.GR16938@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1011080930280.18581@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Nov 2010, Uwe Kleine-K?nig wrote:

> [added Nico to Cc:]
> 
> On Mon, Nov 08, 2010 at 04:56:37PM +0800, rocky wrote:
> > Hi
> > 
> > I'am working on an ARM linux porting project, which need to implement sched_clock of our own.
> > have a glance at PXA sched_clock timplementation, puzzled about the following notes.
> > 
> > 
> > /*
> >  * This is PXA's sched_clock implementation. This has a resolution
> >  * of at least 308 ns and a maximum value of 208 days.
> >  *
> >  * The return value is guaranteed to be monotonic in that range as
> >  * long as there is always less than 582 seconds between successive
> >  * calls to sched_clock() which should always be the case in practice.
> >  */
> > 
> > 
> > 
> > 
> > PXA series chips have system clock in 3250000/3249600/3686400 HZ.
> > I do the math like this:
> > 
> > ####Where does 308 ns come from?
> > 
> > 
> > ns of one clcok cycle:
> > 307.69     (10^9/3250000);
> > 307.73     (10^9/3249600);
> > 271.26     (10^9/3686400 )
> > this is the highest resolution mentioned in above notes;
> Seems correct.  I think "at least" above means 308 ns or better (i.e.
> shorter).
> > 
> > 
> > ####Where does 582 seconds come from?
> > 
> > 660.76(0x80000000/3250000);
> > 660.84(0x80000000/3249600); 
> > 582.54(0x80000000/3686400 );
> Seems correct, too.
> 
> > Question is how does 208 days pop out?
> > Can anyone give me some hints?
> > thanks
> I didn't check it, but I guess after 208 days sched_clock overflows.

Yes.  And the maximum range is bounded by OSCR2NS_SCALE_FACTOR limiting 
the returned ns value to 64 - OSCR2NS_SCALE_FACTOR = 54 bits.  Hence:

	2^54 / 10^9 / 60 / 60 / 24 = 208 days

This means that, once every 208 days, you may experience a slight hickup 
in process scheduling which no one is likely to notice.


Nicolas
