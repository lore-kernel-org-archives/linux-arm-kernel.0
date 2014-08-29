From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Aug 2014 17:04:28 +0200
Subject: [PATCH v4 3/5] ARM: tegra: Initialize interrupt controller from DT
In-Reply-To: <20140829142408.GA31264@ulmo>
References: <1409239879-12376-1-git-send-email-thierry.reding@gmail.com>
 <1409239879-12376-3-git-send-email-thierry.reding@gmail.com>
 <3056623.fB9uqpleQ5@wuerfel> <20140829073139.GG13106@ulmo>
 <20140829142408.GA31264@ulmo>
Message-ID: <20140829150422.GA11035@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 04:24:10PM +0200, Thierry Reding wrote:
> On Fri, Aug 29, 2014 at 09:31:40AM +0200, Thierry Reding wrote:
> > On Thu, Aug 28, 2014 at 06:10:55PM +0200, Arnd Bergmann wrote:
> > > On Thursday 28 August 2014 17:31:17 Thierry Reding wrote:
> > > 
> > > >  void __init tegra_init_irq(void)
> > > >  {
> > > > -	int i;
> > > > -	void __iomem *distbase;
> > > > +	unsigned int max_ictlrs = ARRAY_SIZE(ictlr_regs), i;
> > > > +	const struct of_device_id *match;
> > > > +	struct device_node *np;
> > > > +	struct resource res;
> > > > +
> > > > +	np = of_find_matching_node_and_match(NULL, ictlr_matches, &match);
> > > > +	if (np) {
> > > > +		const struct tegra_ictlr_soc *soc = match->data;
> > > > +
> > > > +		for (i = 0; i < soc->num_ictlrs; i++) {
> > > > +			if (of_address_to_resource(np, i, &res) < 0)
> > > > +				break;
> > > > +
> > > > +			ictlr_regs[i] = res;
> > > > +		}
> > > > +
> > > > +		WARN(i != soc->num_ictlrs,
> > > > +		     "Found %u interrupt controllers in DT; expected %u.\n",
> > > > +		     i, soc->num_ictlrs);
> > > > +
> > > > +		max_ictlrs = soc->num_ictlrs;
> > > > +		of_node_put(np);
> > > > +	} else {
> > > > +		/*
> > > > +		 * If no matching device node was found, fall back to using
> > > > +		 * the chip ID.
> > > > +		 */
> > > > +
> > > > +		/* Tegra30 and later have five interrupt controllers, ... */
> > > > +		max_ictlrs = ARRAY_SIZE(ictlr_regs);
> > > > +
> > > > +		/* ..., but Tegra20 only has four. */
> > > > +		if (of_machine_is_compatible("nvidia,tegra20"))
> > > > +			max_ictlrs--;
> > > > +	}
> > > 
> > > How about moving the entire file to drivers/irqchip and using the
> > > IRQCHIP_DECLARE() helper for the DT case?
> > > 
> > > For the fallback, you can have an entry into that file that just takes
> > > the address and number, which you can call from platform code here.
> > 
> > I think I did try that at some point, but there were issues that I don't
> > remember. I'll give it another shot.
> 
> So I got pretty far with this and the system still boots. But for some
> reason suspend/resume is now broken. The difference seems to be that
> earlier the legacy interrupt controller would be registered first, and
> the GIC second. When the legacy interrupt controller is initialized
> after the GIC (which happens when I use IRQCHIP_DECLARE), then suspend
> and resume won't work (for some yet unknown reason). Unfortunately the
> of_irq_init() code is too clever, so I can't even work around it by
> changing link order or device tree order.
> 
> I'll see if I can find out what causes this combination to malfunction
> when initialized in the opposite order.

The reason for why ordering matters is this line from the GIC driver
(see drivers/irqchip/irq-gic.c):

	static int gic_init_bases(...)
	{
		...
		gic_chip.flags |= gic_arch_extn.flags;
		...
	}

So there's an implicit dependency on having the architecture-specific
extension initialized before the GIC.

If I manually add in the flags set by the LIC (IRQCHIP_MASK_ON_SUSPEND)
the suspend/resume issue that I observed goes away.

Perhaps a better way to handle this would be to add an API that GIC IRQ
extensions can use to register with the GIC independent of the
initialization order?

In this particular case something like:

	void gic_arch_register(unsigned long flags)
	{
		gic_chip.flags |= flags;
	}

would work irrespective of the ordering. But perhaps something more
elaborate would be more futureproof:

	void gic_arch_register(const struct irqchip *extn)
	{
		gic_chip.flags |= extn->flags;
		gic_arch_extn = *extn;
	}

Or perhaps gic_arch_extn could be turned into a pointer so that checks
for already registered extension drivers can be more easily done. That
is:

	static struct irq_chip *extn;

	void gic_arch_register(const struct irqchip *chip)
	{
		if (WARN(extn != NULL))
			return;

		gic_chip.flags |= chip->flags;
		extn = chip;
	}

Any preferences, or other ideas? Adding Thomas and Jason, perhaps they
can provide more input on how to solve this.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/1ed9c444/attachment-0001.sig>
