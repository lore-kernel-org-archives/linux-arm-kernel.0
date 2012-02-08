From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 8 Feb 2012 11:38:18 +0100 (CET)
Subject: [PATCH] genirq: Fix race condition in ONESHOT irq handler
In-Reply-To: <20274.4237.63380.338503@ipc1.ka-ro>
References: <4F31220A.2050708@metafoo.de>
 <1328621921-17404-1-git-send-email-LW@KARO-electronics.de>
 <alpine.LFD.2.02.1202071719340.2794@ionos>
 <20274.4237.63380.338503@ipc1.ka-ro>
Message-ID: <alpine.LFD.2.02.1202081123390.2794@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Feb 2012, Lothar Wa?mann wrote:
> > So it looks like driver developers decided that the oneshot mode might
> > be interesting with a primary handler as well. I can see the reason
> > why the tsc2007 driver uses it, but that does not make it a bug in the
> > core code in the first place.
> > 
> Then maybe the core code should not check the return value
> of the primary handler for IRQ_WAKE_THREAD but call the secondary
> handler unconditionally for ONESHOT interrupts.
> Or it should be at least documented somewhere that primary handlers
> have to return IRQ_WAKE_THREAD in any case for oneshot interrupts.

Well, you know how good we are with documentation :)
 
> > > The problem arises also with interrupt controllers that latch a level
> > > triggered IRQ until it is acknowledged (like the i.MX28 does).
> > > In this case the IRQ status bit will remain asserted after the
> > > soft-irq finishes and retrigger the interrupt while the interrupt line
> > > is already deasserted.
> > 
> > This does not make sense. We acknowledge interrupts via mask_ack_irq()
> > right on entry of handle_level_irq(). So either the interrupt
> > 
> That's right. But at that point the IRQ line is still asserted and
> since it is a level IRQ this will not actually clear the interrupt
> status bit. Normally the IRQ status bit would self-clear when the IRQ
> line is being deasserted (in this case by removing the finger from the
> touch panel). But the i.MX28 leaves the IRQ status bit set and it
> takes another write to the IRQ status register to remove the bogus IRQ
> status.

So the question is whether the imx irq chip implementation should
write to the status register on unmask for level type irqs to avoid
spurious interrupts being generated in the first place. This is not
only an optimization for threaded interrupts, afaict this spurious
effect should happen with non threaded interrupts as well.

Did my patch work for you ?

Thanks,

	tglx
