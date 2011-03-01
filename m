From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 1 Mar 2011 22:29:37 +0100 (CET)
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <20110301201904.GA27107@n2100.arm.linux.org.uk>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
	<1298900022-21516-7-git-send-email-will.deacon@arm.com>
	<20110228140327.GA1937@n2100.arm.linux.org.uk>
	<001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
	<alpine.LFD.2.00.1102281949050.2701@localhost6.localdomain6>
	<20110228214445.GD1937@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103011140560.2701@localhost6.localdomain6>
	<20110301201904.GA27107@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1103012133530.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Mar 2011, Russell King - ARM Linux wrote:
> On Tue, Mar 01, 2011 at 11:57:48AM +0100, Thomas Gleixner wrote:
> > On Mon, 28 Feb 2011, Russell King - ARM Linux wrote:
> > 
> > > On Mon, Feb 28, 2011 at 08:16:25PM +0100, Thomas Gleixner wrote:
> > > > So what's the gain of a barebone chained handler over a regular
> > > > interrupt:
> > > > 
> > > >  - 100 instructions less
> > > >  - lack of statistics
> > > 
> > > We don't want statistics.  Don't care how many times we go to look
> > > at the interrupt controller - and actually it's really wrong to count
> > > them in the first place.  Counting them means that you double-count
> > > these interrupt events, and the more layers of interrupt controllers
> > > there are the worse that problem gets.
> > > 
> > > So no, that's a definite argument *for* chained handers.
> > 
> > Errm, why do you double account them ? The accounting goes to
> > different irq numbers, but we could exclude them from accounting and
> > showing up in proc/interrupts easily.
> 
> We don't want the parent interrupt counted because the interrupt sum
> which is exported from the kernel via the various statistics interface
> will be screwed by this.  For N levels of classical interrupt handlers,
> causing I interrupts, you end up with I*N interrupts reported.
> 
> So if you have a 100Hz interrupt coming from a timer on a 2nd level IRQ
> controller, you'll end up seeing a 200Hz interrupt rate, which is quite
> obviously wrong.

Fair enough.
 
> > > Don't want affinity for them, as setting their affinity means that
> > > you then end up forcing the affinity for the sub-interrupts too.
> > > How you do cope with the high-level interrupt having affinity to
> > > CPU0 but a lower level interrupt being affine to CPU1 only?
> > > 
> > > It's non-sensible, and is broken.  So no, again this isn't an
> > > argument for not using chained handlers.  It's an argument *for*
> > > them.
> > 
> > Well, moving the whole group to a particular cpu is sensible and the
> > sub interrupts don't have a set_affinity function anyway as they are
> > always called on the cpu on which the primary interrupt is handled.
> 
> Not quite correct - there's systems with two GICs chained one after each
> other.  The second GIC will not have a NULL set_affinity function.
> However, it is meaningless to set the affinity for the second GIC as it
> is not multi-CPU aware.

Right. It's pointless for the secondary chip, but seeting the affinity
of the primary interrupt can be still useful..
 
> > > Sorry, but I think this stuff is right, and chained handlers like
> > > these have their place.
> > 
> > I'm not against chained handlers per se. I'm against creating a
> > necessarity to make a chained handler deal with various different
> > underlying primary irq chips and their oddities. That's simply wrong
> > and broken.
> 
> That wasn't a problem before genirq came along and invented many more
> different ways for 'flow' handlers to call into the lower level IRQ
> specific code.

It added merily two new flow handlers. One of them is fasteoi, which
was not necessary in the original ARM implementation. So where is the
point?

> > I don't say you have to use the existing flow handlers, if they are
> > too heavy weight for your purpose, but pushing conditional flow
> > handling into the chained handler is violating all principles of
> > layering.
> 
> Chained handlers *are* a *direct* replacement for flow handlers because
> the normal flow handler is *meaningless* for chained handlers.  Trying
> to separate them into different layers is a mistake in itself.

Did you even look at the separation I suggested?
 
> Chained handlers require the parent to behave differently.  Eg, in the
> case of a level IRQ input, you don't want IRQs to be masked just because
> we're in the middle of servicing a down-stream interrupt.  You want it
> left enabled so that if the ultimate device handler decides it needs to
> have IRQs enabled, then all interrupts are serviced in a fair manner.
> 
> If you mask the parent interrupt, then only primary level interrupts
> get serviced and fairness goes out the window.

Errm. I did never say that we disable the parent interrupt by any
means except when the chained handler explicitely wants to do that,
which is pretty much pointlesss nowadays, as we run all interrupt
handlers with interrupts disabled.

> Maybe you never got that point when you decided to create genirq from
> my work, but that's *your* problem, not mine.  And it seems you're

I pretty well understand the reasoning behind it and you know that.

Sigh, I explained it more than once: The chained handlers as they are,
are completely fine and not going away.

The only point where we disagree is an implementation detail:

The problem at hand which started this discussion wants to have
chained handlers which are able to deal with different underlying
primary irq chips.

My point is that having a chained handler which does:

   if (chip->irq_ack)
	chip->irq_ack();

   demux_interrupts();

   if (chip->irq_eoi)
	chip->irq_eoi();

or whatever abnominations you come up with is wrong.

Such a demux handler should be agnostic of the underlying chip to
avoid wreckage like the one which is currently discussed which is
caused by a change to the underlying primary chip.

So my take on this is to have very simplistic primary flow handlers
which are selected by the primary chip implementation to allow the
underlying demux handler to be agnostic of the primary chip. They
don't have anything to do with the normal handle_irq_* flow handlers
and should be explicitely named different. They even should be
implemented in the arch/ chip implmentation and not be part of the
generic handlers as long as they are not identified as repeated
patterns.

Can you please take the time and explain me the difference of the
following:

irqchip1.c

struct irq_chip1;

handle_primary_irq(int irq, struct irq_desc *desc)
{
	chip->irq_ack();
	desc->demux();
}

init()
{
	irq_set_chip(PRIMARY_IRQ, &irq_chip1);
	irq_set_primary_handler(PRIMARY_IRQ, handle_primary_irq);
}

irqchip2.c

struct irq_chip2;

handle_primary_irq(int irq, struct irq_desc *desc)
{
	desc->demux();
	chip->irq_eoi();
}

init()
{
	irq_set_chip(PRIMARY_IRQ, &irq_chip2);
	irq_set_primary_handler(PRIMARY_IRQ, handle_primary_irq);
}

demux.c

demux_handler(...)
{
	for_each_secondary_irq(irq)
		generic_handle_irq(irq);
}

init()
{
	irq_set_demux_handler(PRIMARY_IRQ, demux_handler);
}

versus:

irqchip1.c

struct irq_chip1;

init()
{
	irq_set_chip(PRIMARY_IRQ, &irq_chip1);
}

irqchip2.c

struct irq_chip2;

init()
{
	irq_set_chip(PRIMARY_IRQ, &irq_chip2);
}

demux.c

demux_handler(...)
{
	if (chip->irq_ack())
		chip->irq_ack();

	for_each_secondary_irq(irq)
		generic_handle_irq(irq);

	if (chip->irq_eoi())
		chip->irq_eoi();
}

init()
{
	irq_set_chained_handler(PRIMARY_IRQ, demux_handler);
}

Both are functionally equivivalent except that

     - my solution adds an indirect call

     - your solution requires explicit knowledge about the underlying
       possible primary irq chips

Now go to the above examples and add irq_chip3.c which requires
another different method of treating the primary interrupt. Lets
assume irq_chip3 is some oddball hardware.

My solution will look like this:

irqchip3.c

struct irq_chip3;

handle_primary_irq(int irq, struct irq_desc *desc)
{
	fiddle_with_some_special_register();
	desc->demux();
	chip->irq_eoi();
}

init()
{
	irq_set_chip(PRIMARY_IRQ, &irq_chip3);
	irq_set_primary_handler(PRIMARY_IRQ, handle_primary_irq);
}

Yours will look like:

irqchip3.c

struct irq_chip3;

init()
{
	irq_set_chip(PRIMARY_IRQ, &irq_chip3);
}

And change all affected demux handlers to:

demux_handler(...)
{
	if (running_on_irq_chip3)
		fiddle_with_some_special_register();
		
	if (chip->irq_ack())
		chip->irq_ack();

	for_each_secondary_irq(irq)
		generic_handle_irq(irq);

	if (chip->irq_eoi())
		chip->irq_eoi();
}

If you are still convinced that adding that extra stuff to the demux
handlers is the right way to go, I'm not in the way. I merily tried to
provide a generic solution to this, which avoid adding all this extra
knowledge into the demux handlers.

> hell bent on breaking this for ARM.  So, I say again - if you persist
> with this, I'll replace the ARM IRQ implementation and stop using genirq
> because you're taking it in a direction which will cause problems for
> ARM.  And I *really* mean that.

You are not threatening me with that. You are threatening your ARM
users as they rely on much more than the f*cking chained handler
details.

Thanks,

	tglx
