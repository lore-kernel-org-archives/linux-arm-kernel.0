From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 20 Sep 2013 23:30:20 +0200 (CEST)
Subject: [PATCH] clockevents: Sanitize ticks to nsec conversion
In-Reply-To: <20130920204125.GB16106@pengutronix.de>
References: <20130918085627.GN24802@pengutronix.de>
 <alpine.DEB.2.02.1309181058470.4089@ionos.tec.linutronix.de>
 <20130918150958.GO24802@pengutronix.de>
 <alpine.DEB.2.02.1309182201000.4089@ionos.tec.linutronix.de>
 <20130919100239.GS24802@pengutronix.de>
 <alpine.DEB.2.02.1309191207460.4089@ionos.tec.linutronix.de>
 <20130919124805.GU24802@pengutronix.de>
 <alpine.DEB.2.02.1309191629040.4089@ionos.tec.linutronix.de>
 <20130919200343.GV24802@pengutronix.de>
 <alpine.DEB.2.02.1309201127400.4089@ionos.tec.linutronix.de>
 <20130920204125.GB16106@pengutronix.de>
Message-ID: <alpine.DEB.2.02.1309202304280.4089@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Sep 2013, Uwe Kleine-K?nig wrote:
> On Fri, Sep 20, 2013 at 11:56:27AM +0200, Thomas Gleixner wrote:
> > On Thu, 19 Sep 2013, Uwe Kleine-K?nig wrote:
> > > > +	 * from nsec to device ticks will be correct.
> > > > +	 *
> > > > +	 * For mult > (1 << shift), i.e. device frequency is > 1GHz we
> > > > +	 * need to be careful. Adding mult - 1 will result in a value
> > > > +	 * which when converted back to device ticks will be larger
> > > s/will/can/
> > 
> > No, it will always be larger.
> Hmm, consider a 1.25 GHz clock with shift = 2 and mult = 5. Then
> ns2clc(clc2ns(1000)) = 1000. So it's not always larger!
> In the fast-clock-case we have:
> With x << shift = n * mult - k for k in [0 .. mult-1] and an integer n:
> 
> 	  ns2clc(clc2ns(x))
> 	= ns2clc(((x << shift) + mult - 1) / mult)
> 	= ((((x << shift) + mult - 1) / mult) * mult) >> shift
> 	= n * mult >> shift
> 	= ((x << shift) + k) >> shift
> 	= x + (k >> shift)
> 
> So ns2clc(clc2ns(x)) = x for all x > 0 that have
> 
> 	k = mult - ((x << shift) - 1) % mult - 1 < 1 << shift
> 
> So my correction still stands.

Fair enough.  

> > 1) We cannot add if we'd overflow
> > 
> > 2) For mult <= 1 << shift it's always correct
> > 
> > 3) for mult > 1 << shift we only apply it to the min value not the max
> 
> Yeah, I didn't say your code is wrong *here*. I just think that my
> easier (and so probably faster) code is good enough.

Granted. I was stuck in the correctness discussion. So yeah, it does
not matter if we steal 30 usec of maximum idle sleep time from a 32kHz
clock. OTOH it does not matter much in the setup slow path to take
another conditional. :)

> Best regards and thanks for the nice discussion,
  
Ditto! You saved me from actually sitting down and using the pencil to
do the proper math.

Thanks,

	tglx
