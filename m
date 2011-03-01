From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Mar 2011 20:19:04 +0000
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <alpine.LFD.2.00.1103011140560.2701@localhost6.localdomain6>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
	<1298900022-21516-7-git-send-email-will.deacon@arm.com>
	<20110228140327.GA1937@n2100.arm.linux.org.uk>
	<001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
	<alpine.LFD.2.00.1102281949050.2701@localhost6.localdomain6>
	<20110228214445.GD1937@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103011140560.2701@localhost6.localdomain6>
Message-ID: <20110301201904.GA27107@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 11:57:48AM +0100, Thomas Gleixner wrote:
> On Mon, 28 Feb 2011, Russell King - ARM Linux wrote:
> 
> > On Mon, Feb 28, 2011 at 08:16:25PM +0100, Thomas Gleixner wrote:
> > > So what's the gain of a barebone chained handler over a regular
> > > interrupt:
> > > 
> > >  - 100 instructions less
> > >  - lack of statistics
> > 
> > We don't want statistics.  Don't care how many times we go to look
> > at the interrupt controller - and actually it's really wrong to count
> > them in the first place.  Counting them means that you double-count
> > these interrupt events, and the more layers of interrupt controllers
> > there are the worse that problem gets.
> > 
> > So no, that's a definite argument *for* chained handers.
> 
> Errm, why do you double account them ? The accounting goes to
> different irq numbers, but we could exclude them from accounting and
> showing up in proc/interrupts easily.

We don't want the parent interrupt counted because the interrupt sum
which is exported from the kernel via the various statistics interface
will be screwed by this.  For N levels of classical interrupt handlers,
causing I interrupts, you end up with I*N interrupts reported.

So if you have a 100Hz interrupt coming from a timer on a 2nd level IRQ
controller, you'll end up seeing a 200Hz interrupt rate, which is quite
obviously wrong.

> > Don't want affinity for them, as setting their affinity means that
> > you then end up forcing the affinity for the sub-interrupts too.
> > How you do cope with the high-level interrupt having affinity to
> > CPU0 but a lower level interrupt being affine to CPU1 only?
> > 
> > It's non-sensible, and is broken.  So no, again this isn't an
> > argument for not using chained handlers.  It's an argument *for*
> > them.
> 
> Well, moving the whole group to a particular cpu is sensible and the
> sub interrupts don't have a set_affinity function anyway as they are
> always called on the cpu on which the primary interrupt is handled.

Not quite correct - there's systems with two GICs chained one after each
other.  The second GIC will not have a NULL set_affinity function.
However, it is meaningless to set the affinity for the second GIC as it
is not multi-CPU aware.

> > Sorry, but I think this stuff is right, and chained handlers like
> > these have their place.
> 
> I'm not against chained handlers per se. I'm against creating a
> necessarity to make a chained handler deal with various different
> underlying primary irq chips and their oddities. That's simply wrong
> and broken.

That wasn't a problem before genirq came along and invented many more
different ways for 'flow' handlers to call into the lower level IRQ
specific code.

> I don't say you have to use the existing flow handlers, if they are
> too heavy weight for your purpose, but pushing conditional flow
> handling into the chained handler is violating all principles of
> layering.

Chained handlers *are* a *direct* replacement for flow handlers because
the normal flow handler is *meaningless* for chained handlers.  Trying
to separate them into different layers is a mistake in itself.

Chained handlers require the parent to behave differently.  Eg, in the
case of a level IRQ input, you don't want IRQs to be masked just because
we're in the middle of servicing a down-stream interrupt.  You want it
left enabled so that if the ultimate device handler decides it needs to
have IRQs enabled, then all interrupts are serviced in a fair manner.

If you mask the parent interrupt, then only primary level interrupts
get serviced and fairness goes out the window.

Maybe you never got that point when you decided to create genirq from
my work, but that's *your* problem, not mine.  And it seems you're
hell bent on breaking this for ARM.  So, I say again - if you persist
with this, I'll replace the ARM IRQ implementation and stop using genirq
because you're taking it in a direction which will cause problems for
ARM.  And I *really* mean that.
