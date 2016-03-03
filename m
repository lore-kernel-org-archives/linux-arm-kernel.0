From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 14:08:19 +0100
Subject: [PATCH 02/17] irqchip: Add PLX Technology RPS IRQ Controller
In-Reply-To: <56D83599.2030400@arm.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-3-git-send-email-narmstrong@baylibre.com>
 <56D83599.2030400@arm.com>
Message-ID: <7673826.decBlDRz96@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 13:01:13 Marc Zyngier wrote:
> > +/* Routines to acknowledge, disable and enable interrupts */
> > +static void rps_mask_irq(struct irq_data *d)
> > +{
> > +     u32 mask = BIT(d->hwirq);
> > +
> > +     iowrite32(mask, rps_data.base + RPS_MASK);
> 
> I do question the use of iowrite32 here (and its ioread32 pendent
> anywhere else), as it actually translates in a writel, which contains a
> memory barrier. Do you have any case that requires the use of such a
> barrier? if not, consider switching to relaxed accessors (which are the
> 

I really ask everyone to do the opposite: we have seen several drivers
blindlessly using the relaxed accessors and actually introducing bugs
that way, so I'd rather see the readl/writel ones used by default.

In any performance critical code, it's reasonable to take a closer
look and use the relaxed version with an added comment explaining
why it's safe there.

	Arnd
