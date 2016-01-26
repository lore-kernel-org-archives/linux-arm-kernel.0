From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Jan 2016 16:52:40 +0100
Subject: [PATCH 2/4] irqchip: irq-armada-370-xp: use the generic MSI
 infrastructure
In-Reply-To: <56A77EB6.3030907@arm.com>
References: <1450707546-15060-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1450707546-15060-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <56A77EB6.3030907@arm.com>
Message-ID: <20160126165240.5436c514@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Tue, 26 Jan 2016 14:12:06 +0000, Marc Zyngier wrote:

> I finally found some bandwidth to have a look at this. A few comments below:

Great, thanks! Since 4.5-rc1 is out, I was about to resend this patch
series, so your review comes exactly at the right time. Some comments
below.

> > +static struct irq_chip armada_370_xp_msi_irq_chip = {
> > +	.name = "armada_370_xp_msi_irq",
> > +	.irq_enable = pci_msi_unmask_irq,
> > +	.irq_disable = pci_msi_mask_irq,
> > +	.irq_mask = pci_msi_mask_irq,
> > +	.irq_unmask = pci_msi_unmask_irq,
> 
> Having only mask/unmask ought to be enough.

OK, will fix.

> > -	return hwirq;
> > -}
> > +static struct msi_domain_info armada_370_xp_msi_domain_info = {
> > +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > +		   MSI_FLAG_MULTI_PCI_MSI),
> 
> And not MSI-X? That seems rather strange (I'm pretty sure it just works).

See commit 830cbe4b7a918613276aa3d3b28d24410623f92c ("irqchip:
armada-370-xp: implement the ->check_device() msi_chip operation") in
which we changed the driver to explicitly disable MSI-X support. The HW
does support it, but we haven't enabled it yet in the irqchip driver,
and we a PCI device driver tries to use MSI-X, it fails badly.

So, I'd like to keep the enabling of MSI-X as a separate exercise, if
you don't mind :-)

> > -	msg.address_lo = msi_doorbell_addr;
> > -	msg.address_hi = 0;
> > -	msg.data = 0xf00 | (hwirq + 16);
> > +	irq_domain_set_info(domain, virq, hwirq, &armada_370_xp_msi_bottom_irq_chip,
> > +			    domain->host_data, handle_simple_irq,
> > +			    NULL, NULL);
> >  
> > -	pci_write_msi_msg(virq, &msg);
> > -	return 0;
> > +	return hwirq;
> 
> So you are allocating one bit at a time, irrespective of nr_irqs. This
> implies that you can't support MULTI_MSI here (you'd need to guarantee a
> contiguous allocation of nr_irqs bits). So either you amend your
> allocator to deal with those (pretty easy), or you drop MULTI_MSI from
> your msi_domain_info.

Correct. Since the patch is already a bit complicated, I'm going to
drop MULTI_MSI from this patch, and then add another patch which adds
MULTI_MSI support (after adapting the alloc/free functions accordingly).


> > +	armada_370_xp_msi_inner_domain =
> > +		irq_domain_add_linear(NULL, PCI_MSI_DOORBELL_NR,
> > +				      &armada_370_xp_msi_domain_ops, NULL);
> 
> nit: Please keep the assignment on a single line.

Unfortunately, due to the long name of the variable and the function,
keeping the assignment on a single line quickly reaches the 80 columns
limit, and each argument has to be put on its own line, making the
thing even less pretty. I tend to prefer splitting the assignment on
several lines like done here in such cases, but if you really don't
like, then I don't mind changing that.

> > @@ -604,6 +580,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
> >  	armada_370_xp_mpic_domain =
> >  		irq_domain_add_linear(node, nr_irqs,
> >  				&armada_370_xp_mpic_irq_ops, NULL);
> > +	armada_370_xp_mpic_domain->bus_token = DOMAIN_BUS_WIRED;
> >  
> >  	BUG_ON(!armada_370_xp_mpic_domain);
> 
> Given the assignment just above, this BUG_ON has become pretty useless...

Absolutely. I've changed the BUG_ON() location to make it somewhat more
useful.

Thanks again for the review!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
