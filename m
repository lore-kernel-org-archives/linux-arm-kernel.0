From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 18:32:52 +0100
Subject: [PATCH 02/17] irqchip: Add PLX Technology RPS IRQ Controller
In-Reply-To: <20160303133649.GX19428@n2100.arm.linux.org.uk>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <7673826.decBlDRz96@wuerfel> <20160303133649.GX19428@n2100.arm.linux.org.uk>
Message-ID: <1592236.k0nfM7OxLV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 13:36:49 Russell King - ARM Linux wrote:
> On Thu, Mar 03, 2016 at 02:08:19PM +0100, Arnd Bergmann wrote:
> > On Thursday 03 March 2016 13:01:13 Marc Zyngier wrote:
> > > > +/* Routines to acknowledge, disable and enable interrupts */
> > > > +static void rps_mask_irq(struct irq_data *d)
> > > > +{
> > > > +     u32 mask = BIT(d->hwirq);
> > > > +
> > > > +     iowrite32(mask, rps_data.base + RPS_MASK);
> > > 
> > > I do question the use of iowrite32 here (and its ioread32 pendent
> > > anywhere else), as it actually translates in a writel, which contains a
> > > memory barrier. Do you have any case that requires the use of such a
> > > barrier? if not, consider switching to relaxed accessors (which are the
> > > 
> > 
> > I really ask everyone to do the opposite: we have seen several drivers
> > blindlessly using the relaxed accessors and actually introducing bugs
> > that way, so I'd rather see the readl/writel ones used by default.
> 
> I actually agree with Marc - we have far too many drivers using the
> barriered IO accessors, which are really very expensive on 32-bit
> ARM.
> 
> For most ARM systems, the rules are quite simple: a write which causes
> DMA memory to be accessed by the device must be using the barriered
> IO accessor, and a read from a DMA status register must be too.
> Everything else need not be.  Barriered IO accessors are only about
> access ordering.

My main worry is really about code getting copied from drivers that
are fine with just relaxed accessors into other drivers by developers
that have never heard about the difference and just want to follow
best practices.

	Arnd
