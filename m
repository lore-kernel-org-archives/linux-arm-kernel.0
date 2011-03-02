From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 2 Mar 2011 21:44:13 +0100 (CET)
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <20110302191744.GA13179@n2100.arm.linux.org.uk>
References: <1298900022-21516-7-git-send-email-will.deacon@arm.com>
	<20110228140327.GA1937@n2100.arm.linux.org.uk>
	<001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
	<alpine.LFD.2.00.1102281949050.2701@localhost6.localdomain6>
	<20110228214445.GD1937@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103011140560.2701@localhost6.localdomain6>
	<20110301201904.GA27107@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103012133530.2701@localhost6.localdomain6>
	<20110302085356.GB4493@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103021015110.2701@localhost6.localdomain6>
	<20110302191744.GA13179@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1103022032530.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Mar 2011, Russell King - ARM Linux wrote:
> On Wed, Mar 02, 2011 at 10:25:02AM +0100, Thomas Gleixner wrote:
> > On Wed, 2 Mar 2011, Russell King - ARM Linux wrote:
> > > On Tue, Mar 01, 2011 at 10:29:37PM +0100, Thomas Gleixner wrote:
> > > > Errm. I did never say that we disable the parent interrupt by any
> > > > means except when the chained handler explicitely wants to do that,
> > > > which is pretty much pointlesss nowadays, as we run all interrupt
> > > > handlers with interrupts disabled.
> > > 
> > > And that's now why some platforms struggle to work, and we're having
> > > to bodge around this - like the ARM platforms with MMC support.  Like
> > 
> > Whats the problem for MMC?
> 
> The FIFO interrupt gets completely buggered by USB interrupts such that
> we can't read data fast enough.  With the old IRQF_DISABLED system,
> the FIFO interrupt was marked IRQF_DISABLED as it was *fast* and needed
> not to be interrupted.  Other interrupts didn't have IRQF_DISABLED set.
> 
> That means such interrupts can be handled while other longer interrupts
> are in progress.  All that's gone out of the window now that all IRQ
> handlers are run with IRQs permanently disabled.
> 
> And when this kind of behaviour becomes system specific (eg, the USB
> device driver doesn't have this problem on x86 so why should it change)

I wouldn't say that. USB is known to be a trouble spot even on
x86. And Linus argued for enforcing IRQ_DISABLED to weed out such
crap. Anything which runs longer than a few micro seconds in the hard
interrupt context needs to be fixed.

> I haven't noticed PATA getting this support.  So how do platforms force
> device drivers which turn out to be problematical to conform to their
> timing issues when there wasn't a problem with previous kernels?

As I said above. PATA was talked about going threaded for years, but
nobody cared as the irq enabled vs. IRQ_DISABLED mode made things
magically work most of the time, except when you added some other
random driver, which required IRQ_DISABLED as well and spent a
millisecond and more in its handler. I know that pain and I wasted
enough time with the wreckage caused by long running handlers.

So at some point we had to make a decision:

Either let the status quo, which is not satisfying at all and causes
headache left and right, or create a situation which enforces that
shit gets cleaned up.

The general consensus was that enforcing the shit to be cleaned up is
the better long term strategy even when it causes some short term
irritation.

If that hits ARM full force, sorry, but it's not my lonely decision in
order to get an Guinness Book entry.

I assume, you know which drivers are responsible for this kind of
wreckage. Could you provide a list?

> > > I *violently* disagree with the direction that genirq is heading.  It's
> > > *actively* breaking stuff.  What's really annoying is that problems like
> > > the above I did point out, but you seem happy to completely ignore them.
> > > The result is that more and more ARM platforms *are* becoming utterly
> > > useless, or requiring additional complexity being shoved into subsystems
> > > to cope with this crap.
> > > 
> > > What we need is a *decent* IRQ support system.  Not something created out
> > > of religious arguments which is what we have now.
> >  
> > I'm not religious about it, at least not more than you with your total
> > refusement to distinguish between special case oddball FPGA demux and
> > bog standard functional irq chips.
> 
> Clearly you don't want to know about the problems all this stuff is
> causing.  Maybe you like being responsible for breaking the most ARM

I want to hear about problems and I'm the least person who refuses to
help. And you are very well aware of that.

Let's take it the other way around. Do you want to know about the pain
of maintaining generic infrastructure like this and being blocked to
change a few things in the core code just because nobody is talking to
you and takes it for granted, that fiddling in the guts of the generic
code by circumventing it (and I'm not talking about chained handlers
here) is a good idea, just because the header files are public
accessible via include/linux ?

> platforms with your changes - are you trying for an entry in the
> Guiness Book of World Records for this, because I think that's where
> you're heading.

Didn't know that they have a category for that. Can you point me to
the website where to apply?

> I don't agree with the distinction that you're trying to make.  It only
> works for a simple subset of cases - but it seems you're overall attitude
> is that you only care about a small subset of easy cases and to hell
> with everything else.

That's not true at all. I said more than once that I understand why
you want to keep the original concept of those chained handlers and
I'm not going to change anything about them. I saw it a bit too
simplistic at the beginning of the discussion and admitted that and
corrected my POV right away.

I'm merily trying to help and provide infrastructure for repeating
patterns. If those patterns happen to be the simple ones, then we
still want to avoid copied and duplicated code all over the place.

Again, I'm not trying to kill the current chained handlers at all
neither do I believe that everything is nail because we have a
hammer. I'm trying to understand the problems instead of being fixated
on a method which turned out to solve one of them.

Thanks,

	tglx
