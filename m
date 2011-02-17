From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 17 Feb 2011 12:21:32 +0100 (CET)
Subject: [PATCH] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <20110217105611.GE24627@n2100.arm.linux.org.uk>
References: <AANLkTik-0SaVbtiXZ-iefvvgLq=7KqRTGi7XPLPEKx85@mail.gmail.com>
	<-4413647205110644369@unknownmsgid>
	<AANLkTikaZkRMHH1bUmO0pWYT1FgTC+83F5KxPySasG-S@mail.gmail.com>
	<146267380211262372@unknownmsgid>
	<AANLkTimPDNv+2n2-QHtBq0X+Vkj21yQCPh8iKZkYjfqG@mail.gmail.com>
	<alpine.LFD.2.00.1102162008490.2701@localhost6.localdomain6>
	<20110217091741.GA24627@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102171032580.2701@localhost6.localdomain6>
	<20110217101957.GC24627@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102171136550.2701@localhost6.localdomain6>
	<20110217105611.GE24627@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102171203280.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Feb 2011, Russell King - ARM Linux wrote:
> On Thu, Feb 17, 2011 at 11:43:38AM +0100, Thomas Gleixner wrote:
> > > There is a lot of difference between using a conventional 'flow' handler
> > > which does masking/unmasking of the parent interrupt and a properly
> > > written chained handler which avoids that masking.
> > 
> > Depends on the underlying flow handler. fasteoi does not mask, but I
> > can see your point. If you have that oddball SA11xx thing, you are
> > forced to do that, but that is tied into SA11xx and confined.
> 
> It isn't - what I highlight above is the correct way to deal with
> chained interrupts - which is to leave the parent interrupt enabled
> _unless_ there is a good reason not to.
> 
> It also needs to be symetrical otherwise you unbalance the interrupt
> handling such that those interrupts which are downstream of the primary
> controller become less likely to be handled, and you end up with some
> interrupts being soo pessimistic its untrue.  This commonly happens
> when people don't think and just throw loop after loop into their
> flow handlers.
> 
> The last reason for this is to ensure that IRQ handling is *fast* and
> *efficient*.  Using the standard handlers adds a hell of a lot of
> unnecessary overhead which just isn't required.
> 
> Look, I put a lot of time and effort into giving ARM an interrupt handling
> subsystem which actually _works_ for the hardware that we commonly have,
> and I'm not having all that thrown out in the name of 'generalization'.
> If genirq can't cope with it, then ARM needs to avoid genirq.
> 
> Chained flow handlers are here to stay on ARM.

I have no intention to remove them. If they are done correct they are
not a problem at all. And correct means: tied to the underlying
primary chip.

The shit hits the fan when a chained handler implementation is trying
to be agnostic about the actual underlying primary chip. That won't
ever work and is broken. The only way to make a demux handler agnostic
is to use a regular requested interrupt handler. That's all what I'm
saying.

You have to actually use your brain when implementing a chained
handler. Looking through a bunch of implementations I found stuff,
which is basically a poorly implemented flow handler. Worst example:
fsl_msi_cascade().

ARM ones are mostly sane, but e.g. nmk_gpio_irq_handler() is not
really one which fits your description. It's trying to deal with
different underlying primary chips obviously, which is wrong in the
first place.

Thanks,

	tglx
