From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Mar 2011 19:17:44 +0000
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <alpine.LFD.2.00.1103021015110.2701@localhost6.localdomain6>
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
Message-ID: <20110302191744.GA13179@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 10:25:02AM +0100, Thomas Gleixner wrote:
> On Wed, 2 Mar 2011, Russell King - ARM Linux wrote:
> > On Tue, Mar 01, 2011 at 10:29:37PM +0100, Thomas Gleixner wrote:
> > > Errm. I did never say that we disable the parent interrupt by any
> > > means except when the chained handler explicitely wants to do that,
> > > which is pretty much pointlesss nowadays, as we run all interrupt
> > > handlers with interrupts disabled.
> > 
> > And that's now why some platforms struggle to work, and we're having
> > to bodge around this - like the ARM platforms with MMC support.  Like
> 
> Whats the problem for MMC?

The FIFO interrupt gets completely buggered by USB interrupts such that
we can't read data fast enough.  With the old IRQF_DISABLED system,
the FIFO interrupt was marked IRQF_DISABLED as it was *fast* and needed
not to be interrupted.  Other interrupts didn't have IRQF_DISABLED set.

That means such interrupts can be handled while other longer interrupts
are in progress.  All that's gone out of the window now that all IRQ
handlers are run with IRQs permanently disabled.

And when this kind of behaviour becomes system specific (eg, the USB
device driver doesn't have this problem on x86 so why should it change)
then it all becomes impossible.  There's hardware modifications in
progress to add deeper FIFOs (which need to be extended to something
idiotic like 512 32-bit words to work around the problem) and adaptive
clocking schemes which retry transfers at slower clock rates in the hope
that the IRQ handler can keep up.

It's a complete mess.

Another example - a platform I've worked on requires tight timings from
I2C in order for the CPU not to be spontaneously rebooted.  A timeout
on I2C will cause this.  We managed to get this platform to work reliably
by using IRQF_DISABLED and having the standard behaviour (IRQs enabled
during other interrupts).  Now - god knows if it'll work reliably anymore,
my guess is that with latest kernels it'll be impossibly unreliable.

> > some other platforms where having IRQs disabled during IDE prevents
> > interrupts being recevied for long periods of time (longer than the
> > 100Hz tick period).
> 
> That was discussed to death already and the general agreement was that
> those handlers should either enable interrupts themself, when it's
> required, or being converted to threaded handlers. An interrupt
> handler or any other code section which runs more than 10ms with
> interrupts disabled is a bug by definition.

I haven't noticed PATA getting this support.  So how do platforms force
device drivers which turn out to be problematical to conform to their
timing issues when there wasn't a problem with previous kernels?

> > I *violently* disagree with the direction that genirq is heading.  It's
> > *actively* breaking stuff.  What's really annoying is that problems like
> > the above I did point out, but you seem happy to completely ignore them.
> > The result is that more and more ARM platforms *are* becoming utterly
> > useless, or requiring additional complexity being shoved into subsystems
> > to cope with this crap.
> > 
> > What we need is a *decent* IRQ support system.  Not something created out
> > of religious arguments which is what we have now.
>  
> I'm not religious about it, at least not more than you with your total
> refusement to distinguish between special case oddball FPGA demux and
> bog standard functional irq chips.

Clearly you don't want to know about the problems all this stuff is
causing.  Maybe you like being responsible for breaking the most ARM
platforms with your changes - are you trying for an entry in the
Guiness Book of World Records for this, because I think that's where
you're heading.

I don't agree with the distinction that you're trying to make.  It only
works for a simple subset of cases - but it seems you're overall attitude
is that you only care about a small subset of easy cases and to hell
with everything else.
