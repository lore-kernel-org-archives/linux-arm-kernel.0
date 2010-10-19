From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 19 Oct 2010 22:03:32 +0200 (CEST)
Subject: [patch 00/12] arm: raw_spinlock annotations
In-Reply-To: <20101019184433.GA10325@n2100.arm.linux.org.uk>
References: <20100217125328.791176536@linutronix.de>
	<20101019143717.GH11713@pengutronix.de>
	<201010191726.45879.arnd@arndb.de>
	<20101019184433.GA10325@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1010192158440.6815@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Oct 2010, Russell King - ARM Linux wrote:

> On Tue, Oct 19, 2010 at 05:26:45PM +0200, Arnd Bergmann wrote:
> > On Tuesday 19 October 2010, Uwe Kleine-K?nig wrote:
> > > While cleaning up my repo I refound the patches and rebased them on top
> > > of today's Linus' tree and only needed to fix up the l2x0_lock patch as
> > > in the meantime a new usage hit mainline.
> > 
> > The patches all look harmless, but none of them has any information on
> > why the particular locks need to be raw_spin_lock. Ideally a raw spinlock
> > should be the absolute exception, and IMHO should have a comment in front
> > of it why it is special.
> 
> Or at least explained in the patch description.
> 
> For instance, can someone explain why the lock for leds and gpio stuff
> on Footbridge needs to be converted?  What is the original problem?
> More importantly, what is the criteria for using a raw spinlock instead
> of a normal spinlock?

raw_spinlock is still a spinlock when PREEMPT_RT is enabled, mere
spinlocks become magically "sleeping" spinlocks (aka. PI aware
rtmutexes)

Vs. the patches: IIRC, it was all fallout from running -rt, but that
needs to be looked at case by case. Some of those are obvious as they
are called deep down in atomic irq disabled code, but others might be
just due to laziness reasons.

There is no urgency to get them merged right now.

Thanks,

	tglx
