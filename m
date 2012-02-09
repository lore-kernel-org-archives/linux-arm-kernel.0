From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 9 Feb 2012 09:40:09 +0100
Subject: [PATCH] genirq: Fix race condition in ONESHOT irq handler
In-Reply-To: <alpine.LFD.2.02.1202081123390.2794@ionos>
References: <4F31220A.2050708@metafoo.de>
 <1328621921-17404-1-git-send-email-LW@KARO-electronics.de>
 <alpine.LFD.2.02.1202071719340.2794@ionos>
 <20274.4237.63380.338503@ipc1.ka-ro>
 <alpine.LFD.2.02.1202081123390.2794@ionos>
Message-ID: <20275.34409.978854.416870@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thomas Gleixner writes:
> On Wed, 8 Feb 2012, Lothar Wa?mann wrote:
> > > > The problem arises also with interrupt controllers that latch a level
> > > > triggered IRQ until it is acknowledged (like the i.MX28 does).
> > > > In this case the IRQ status bit will remain asserted after the
> > > > soft-irq finishes and retrigger the interrupt while the interrupt line
> > > > is already deasserted.
> > > 
> > > This does not make sense. We acknowledge interrupts via mask_ack_irq()
> > > right on entry of handle_level_irq(). So either the interrupt
> > > 
> > That's right. But at that point the IRQ line is still asserted and
> > since it is a level IRQ this will not actually clear the interrupt
> > status bit. Normally the IRQ status bit would self-clear when the IRQ
> > line is being deasserted (in this case by removing the finger from the
> > touch panel). But the i.MX28 leaves the IRQ status bit set and it
> > takes another write to the IRQ status register to remove the bogus IRQ
> > status.
> 
> So the question is whether the imx irq chip implementation should
> write to the status register on unmask for level type irqs to avoid
> spurious interrupts being generated in the first place. This is not
> only an optimization for threaded interrupts, afaict this spurious
> effect should happen with non threaded interrupts as well.
> 
> Did my patch work for you ?
> 
Sorry, I couldn't test it earlier. Yes, it works.

Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
