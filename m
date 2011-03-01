From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 1 Mar 2011 11:57:48 +0100 (CET)
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <20110228214445.GD1937@n2100.arm.linux.org.uk>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
	<1298900022-21516-7-git-send-email-will.deacon@arm.com>
	<20110228140327.GA1937@n2100.arm.linux.org.uk>
	<001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
	<alpine.LFD.2.00.1102281949050.2701@localhost6.localdomain6>
	<20110228214445.GD1937@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1103011140560.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Feb 2011, Russell King - ARM Linux wrote:

> On Mon, Feb 28, 2011 at 08:16:25PM +0100, Thomas Gleixner wrote:
> > So what's the gain of a barebone chained handler over a regular
> > interrupt:
> > 
> >  - 100 instructions less
> >  - lack of statistics
> 
> We don't want statistics.  Don't care how many times we go to look
> at the interrupt controller - and actually it's really wrong to count
> them in the first place.  Counting them means that you double-count
> these interrupt events, and the more layers of interrupt controllers
> there are the worse that problem gets.
> 
> So no, that's a definite argument *for* chained handers.

Errm, why do you double account them ? The accounting goes to
different irq numbers, but we could exclude them from accounting and
showing up in proc/interrupts easily.
 
> >  - lack of affinity setting via standard interfaces
> 
> Don't want affinity for them, as setting their affinity means that
> you then end up forcing the affinity for the sub-interrupts too.
> How you do cope with the high-level interrupt having affinity to
> CPU0 but a lower level interrupt being affine to CPU1 only?
> 
> It's non-sensible, and is broken.  So no, again this isn't an
> argument for not using chained handlers.  It's an argument *for*
> them.

Well, moving the whole group to a particular cpu is sensible and the
sub interrupts don't have a set_affinity function anyway as they are
always called on the cpu on which the primary interrupt is handled.

> Sorry, but I think this stuff is right, and chained handlers like
> these have their place.

I'm not against chained handlers per se. I'm against creating a
necessarity to make a chained handler deal with various different
underlying primary irq chips and their oddities. That's simply wrong
and broken.

I don't say you have to use the existing flow handlers, if they are
too heavy weight for your purpose, but pushing conditional flow
handling into the chained handler is violating all principles of
layering.

The underlying primary chip implementation knows about the flow
requirements, so it should install the correct handler so the chained
handler just needs to deal with the sub interrupts which it knows how
to handle.

So if you don't want accounting and affinity setting (which I think is
bad), then we still can solve it in an elegant and simple way.

1) Primary chip installs a rudimentary flow handler which deals with
   the requirements of the chip.

   primary_handler_eoi()
   {
	if (desc->action)
		action();
	chip->irq_eoi();
   }

   primary_handler_level()
   {
	chip->irq_mask();
	if (desc->action)
		action();
	chip->irq_unmask();
   }

   The interupt descriptor is marked IRQ_PRIMARY or whatever

2) Demux handler is installed via:

   setup_irq(PRIMARY_IRQ, IRQ_DEMUX, demux_handler);

That's a few lines in the core code to make this work with the same
functionality than your current solution, but avoiding to touch any
demux handler when you change the underlying irq chip
implementation. It simply just works because the demux handler is
agnostic of the primary chip.

Thanks,

	tglx
