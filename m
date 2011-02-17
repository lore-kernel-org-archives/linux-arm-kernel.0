From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Feb 2011 10:56:11 +0000
Subject: [PATCH] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <alpine.LFD.2.00.1102171136550.2701@localhost6.localdomain6>
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
Message-ID: <20110217105611.GE24627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 11:43:38AM +0100, Thomas Gleixner wrote:
> On Thu, 17 Feb 2011, Russell King - ARM Linux wrote:
> > On Thu, Feb 17, 2011 at 10:38:08AM +0100, Thomas Gleixner wrote:
> > > Why should that drop more interrupt? The only difference is that you
> > > make the demux handler oblivious of the underlying primary chip and
> > > let the chip chose the appropriate flow handler which issues the right
> > > chip methods.
> > 
> > The difference is that properly implemented chained handlers do *not*
> > mask the interrupt on the parent IRQ controller, thereby allowing
> > other interrupts to be serviced as appropriate.
> > 
> > The issue that this whole implementation was designed in the first place
> > to fix was lost IDE interrupts for CF cards connected to the PCMCIA/CF
> > interfaces of SA1111 devices.  These were lost because the CF interrupt
> > output is a level-based output, but the SA11xx interrupt inputs are all
> > edge based.
> > 
> > When the CF interrupt is connected to a SA1111 GPIO, and using the old
> > interrupt system, edge transitions were _often_ missed resulting in
> > frequent 'lost interrupt' complaints from the IDE layer.  Exactly why
> > this was could never be ascertained (probably because the hardware
> > combination I had at the time did not allow me to setup this scenario.)
> > 
> > With the chained interrupt handler implementation, things were setup to
> > ensure that as much of the interrupt levels were left enabled so that
> > there was symetrical handling across the entire interrupt tree, and the
> > result of that was no more lost interrupts.
> > 
> > There is a lot of difference between using a conventional 'flow' handler
> > which does masking/unmasking of the parent interrupt and a properly
> > written chained handler which avoids that masking.
> 
> Depends on the underlying flow handler. fasteoi does not mask, but I
> can see your point. If you have that oddball SA11xx thing, you are
> forced to do that, but that is tied into SA11xx and confined.

It isn't - what I highlight above is the correct way to deal with
chained interrupts - which is to leave the parent interrupt enabled
_unless_ there is a good reason not to.

It also needs to be symetrical otherwise you unbalance the interrupt
handling such that those interrupts which are downstream of the primary
controller become less likely to be handled, and you end up with some
interrupts being soo pessimistic its untrue.  This commonly happens
when people don't think and just throw loop after loop into their
flow handlers.

The last reason for this is to ensure that IRQ handling is *fast* and
*efficient*.  Using the standard handlers adds a hell of a lot of
unnecessary overhead which just isn't required.

Look, I put a lot of time and effort into giving ARM an interrupt handling
subsystem which actually _works_ for the hardware that we commonly have,
and I'm not having all that thrown out in the name of 'generalization'.
If genirq can't cope with it, then ARM needs to avoid genirq.

Chained flow handlers are here to stay on ARM.
