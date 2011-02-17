From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Feb 2011 09:17:41 +0000
Subject: [PATCH] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <alpine.LFD.2.00.1102162008490.2701@localhost6.localdomain6>
References: <1297697188-5206-1-git-send-email-will.deacon@arm.com>
	<AANLkTik-0SaVbtiXZ-iefvvgLq=7KqRTGi7XPLPEKx85@mail.gmail.com>
	<-4413647205110644369@unknownmsgid>
	<AANLkTikaZkRMHH1bUmO0pWYT1FgTC+83F5KxPySasG-S@mail.gmail.com>
	<146267380211262372@unknownmsgid>
	<AANLkTimPDNv+2n2-QHtBq0X+Vkj21yQCPh8iKZkYjfqG@mail.gmail.com>
	<alpine.LFD.2.00.1102162008490.2701@localhost6.localdomain6>
Message-ID: <20110217091741.GA24627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 08:20:17PM +0100, Thomas Gleixner wrote:
> On Wed, 16 Feb 2011, Rabin Vincent wrote:
> > On Wed, Feb 16, 2011 at 21:47, Will Deacon <will.deacon@arm.com> wrote:
> > > Ah yes, thanks for the explanation. After looking at the plat-omap code
> > > I finally understand what's going on and I can't help but feel that the
> > > chained GPIO handlers are terminally broken! The generic irq chip high-level
> > > handlers (handle_{edge,level}_irq for example) at least check to see if
> > > the irq_chip functions are non-NULL before calling them.
> > >
> > > Ideally, the chained handler would be able to query the irq_chip to find
> > > out what types of IRQ flow-control it supports and then assume that behaviour.
> > 
> > Thomas, suggestions on how best to handle this?  (Some of these chained
> > handlers are the ones in plat-omap/gpio.c, plat-nomadik/gpio.c, and
> > mach-s5pv310/irq-combiner.c.)
> 
> I'm not much of a fan of those chained handlers. They work fine, when
> they are tied into the irq_chip implementation of a SoC where the
> chained handler code is 1:1 related to that irq_chip.
> 
> Once you start assigning those handlers somewhere else or even using
> the same handler for different underlying primary irq chips, then it's
> a lost case and wreckage like this is just lurking around the corner.

That's a result of genirq.  With the ARM non-genirq implementation
where we had just ack, mask and unmask, it all turned out much easier.
In fact, we hardly ever called any of these functions in chained
handlers (except ack) - the only time when mask and unmask were called
was when we had an IRQ multiplexer which didn't allow us to mask the
individual interrupts.

With the advent of genirq and its expansion of the irq chip methods it's
become much more complicated.  That's one of the faults of trying to
generalize this across different architectures.

You can't do without chained handlers on ARM - we used to do it without
them and it was proven to be a complete disaster.  Dropped interrupts
and various drivers just didn't work with chained interrupt controllers.

So getting rid of it is also a 'lost cause'.
