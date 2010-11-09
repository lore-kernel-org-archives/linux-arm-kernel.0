From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 08 Nov 2010 21:07:50 -0500 (EST)
Subject: One quick quenstion about PXA sched_clock resolution?
In-Reply-To: <1f408c.28b5.12c2e554f1b.Coremail.bill_carson@126.com>
References: <alpine.LFD.2.00.1011080930280.18581@xanadu.home>
	<3f0ffa72.f9b4.12c2ab386e4.Coremail.bill_carson@126.com>
	<20101108100119.GR16938@pengutronix.de>
	<1f408c.28b5.12c2e554f1b.Coremail.bill_carson@126.com>
Message-ID: <alpine.LFD.2.00.1011082058390.18581@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Nov 2010, rocky wrote:

> 
> 
> 
> 
> At 2010-11-08 22:42:56?"Nicolas Pitre" <nicolas.pitre@linaro.org> wrote:
> 
> >On Mon, 8 Nov 2010, Uwe Kleine-K?nig wrote:
> >
> >> [added Nico to Cc:]
> >> 
> >> On Mon, Nov 08, 2010 at 04:56:37PM +0800, rocky wrote:
> >> > Hi
> >> > 
> >> > I'am working on an ARM linux porting project, which need to implement sched_clock of our own.
> >> > have a glance at PXA sched_clock timplementation, puzzled about the following notes.
> >> > 
> >> > 
> >> > /*
> >> >  * This is PXA's sched_clock implementation. This has a resolution
> >> >  * of at least 308 ns and a maximum value of 208 days.
> >> >  *
> >> >  * The return value is guaranteed to be monotonic in that range as
> >> >  * long as there is always less than 582 seconds between successive
> >> >  * calls to sched_clock() which should always be the case in practice.
> >> >  */
> >> > 
> >> > 
> >> > 
> >> > 
> >> > PXA series chips have system clock in 3250000/3249600/3686400 HZ.
> >> > I do the math like this:
> >> > 
> >> > ####Where does 308 ns come from?
> >> > 
> >> > 
> >> > ns of one clcok cycle:
> >> > 307.69     (10^9/3250000);
> >> > 307.73     (10^9/3249600);
> >> > 271.26     (10^9/3686400 )
> >> > this is the highest resolution mentioned in above notes;
> >> Seems correct.  I think "at least" above means 308 ns or better (i.e.
> >> shorter).
> >> > 
> >> > 
> >> > ####Where does 582 seconds come from?
> >> > 
> >> > 660.76(0x80000000/3250000);
> >> > 660.84(0x80000000/3249600); 
> >> > 582.54(0x80000000/3686400 );
> >> Seems correct, too.
> >> 
> >> > Question is how does 208 days pop out?
> >> > Can anyone give me some hints?
> >> > thanks
> >> I didn't check it, but I guess after 208 days sched_clock overflows.
> >
> >Yes.  And the maximum range is bounded by OSCR2NS_SCALE_FACTOR limiting 
> >the returned ns value to 64 - OSCR2NS_SCALE_FACTOR = 54 bits.  Hence:
> >
> >	2^54 / 10^9 / 60 / 60 / 24 = 208 days
> >
> >This means that, once every 208 days, you may experience a slight hickup 
> >in process scheduling which no one is likely to notice.
> >
> >
> >Nicolas
> 
> Hi, nicolas
> Thanks for your kindly replay  :)
> #############################################################
> unsigned long long sched_clock(void)
> {
> 	unsigned long long v = cnt32_to_63(OSCR);
> 	return (v * oscr2ns_scale) >> OSCR2NS_SCALE_FACTOR;
> }
> #############################################################
>  v * oscr2ns_scale is unsigned long long type, 
> but BIT63 can never be set,  because oscr2ns_scale whill round it up.

No, you misunderstood the code.

By definition, cnt32_to_63() returns 63 valid bits.  The 64th bit (the 
top bit) should be discarded.  So to discard that bit automatically, we 
make sure that the value in oscr2ns_scale is even.

But once you compute v * oscr2ns_scale then you have a full 64 bit range 
value, not a 63-bit one..  And then the bottom 10 bits are discarded.  
Therefore 54 bits remain.


Nicolas
