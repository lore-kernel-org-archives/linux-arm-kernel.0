From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Oct 2010 22:20:32 +0200
Subject: [patch 00/12] arm: raw_spinlock annotations
In-Reply-To: <alpine.LFD.2.00.1010192158440.6815@localhost6.localdomain6>
References: <20100217125328.791176536@linutronix.de>
	<20101019184433.GA10325@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010192158440.6815@localhost6.localdomain6>
Message-ID: <201010192220.33738.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 October 2010 22:03:32 Thomas Gleixner wrote:
> On Tue, 19 Oct 2010, Russell King - ARM Linux wrote:
> 
> > On Tue, Oct 19, 2010 at 05:26:45PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 19 October 2010, Uwe Kleine-K?nig wrote:
> > > > While cleaning up my repo I refound the patches and rebased them on top
> > > > of today's Linus' tree and only needed to fix up the l2x0_lock patch as
> > > > in the meantime a new usage hit mainline.
> > > 
> > > The patches all look harmless, but none of them has any information on
> > > why the particular locks need to be raw_spin_lock. Ideally a raw spinlock
> > > should be the absolute exception, and IMHO should have a comment in front
> > > of it why it is special.
> > 
> > Or at least explained in the patch description.
> > 
> > For instance, can someone explain why the lock for leds and gpio stuff
> > on Footbridge needs to be converted?  What is the original problem?
> > More importantly, what is the criteria for using a raw spinlock instead
> > of a normal spinlock?
> 
> raw_spinlock is still a spinlock when PREEMPT_RT is enabled, mere
> spinlocks become magically "sleeping" spinlocks (aka. PI aware
> rtmutexes)

I think we all understood that part of the series description.

> Vs. the patches: IIRC, it was all fallout from running -rt, but that
> needs to be looked at case by case. Some of those are obvious as they
> are called deep down in atomic irq disabled code, but others might be
> just due to laziness reasons.

Not as obvious as you'd think. The explanation "called in atomic irq
disabled code" makes sense, but I hadn't thought of that before -- I had
expected all that code to use IRQ threads in case of PREEMPT_RT.

Requiring a comment there would probably eliminate the laziness issues,
adding a comment that you can't be bothered to do the right fix won't
help getting a patch merged, so ideally you'd end up with a better
solution getting merged.

	Arnd
