From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 28 Sep 2018 18:38:06 +0200
Subject: [PATCH v5 07/14] irqchip/irq-mvebu-sei: add new driver for
 Marvell SEI
In-Reply-To: <9a0de5ac-8cef-0950-e218-0368167ecff8@arm.com>
References: <20180830073535.10710-1-miquel.raynal@bootlin.com>
 <20180830073535.10710-8-miquel.raynal@bootlin.com>
 <86pnx7x5pz.wl-marc.zyngier@arm.com>
 <20180924180133.2ea93762@xps13>
 <9a0de5ac-8cef-0950-e218-0368167ecff8@arm.com>
Message-ID: <20180928183806.176ca084@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Marc Zyngier <marc.zyngier@arm.com> wrote on Fri, 28 Sep 2018 11:25:32
+0100:

> On 24/09/18 17:01, Miquel Raynal wrote:
> 
> Hi Miquel,
> 
> [...]
> 
> > The difference is that at this stage, the irq_data->chip pointer of the
> > SEI controller _parent_ (ie. the GIC's chip pointer) is not valid. I
> > digged a lot in this direction during your vacations to find out what I
> > missed, and I ended up calling back irq_alloc_irqs_parent().
> > 
> > If you have an idea of how to handle this properly, I am all ears!  
> 
> The most glaring problem is that you create a hierarchy that encompasses
> the GIC, which is just wrong. The hierarchy cannot point to the GIC,
> because it end-up as a multiplexer.
> 
> This code sequence in the probe function is the root of all evil:
> 
> 	/* Get a reference to the parent domain */
> 	parent = of_irq_find_parent(node);
> 	if (!parent) {
> 		dev_err(sei->dev, "Failed to find parent IRQ node\n");
> 		ret = -ENODEV;
> 		goto dispose_irq;
> 	}
> 
> This is a GIC interrupt, which is the output line for the SEI block.
> 
> 	parent_domain = irq_find_host(parent);
> 	if (!parent_domain) {
> 		dev_err(sei->dev, "Failed to find parent IRQ domain\n");
> 		ret = -ENODEV;
> 		goto dispose_irq;
> 	}
> 
> That's the GIC domain.
> 
> 	/* Create the 'wired' domain */
> 	sei->ap_domain = irq_domain_create_hierarchy(parent_domain, 0,
> 						     sei->caps->ap_range.size,
> 						     of_node_to_fwnode(node),
> 						     &mvebu_sei_ap_domain_ops,
> 						     sei);
> 	if (!sei->ap_domain) {
> 		dev_err(sei->dev, "Failed to create AP IRQ domain\n");
> 		ret = -ENOMEM;
> 		goto dispose_irq;
> 	}
> 
> And here, you're saying "each and every AP SEI interrupt is directly
> linked to a unique GIC interrupt". Nothing could be further from the
> truth, since all SEI interrupts are funnelled through a *single*
> GIC interrupt. So you cannot create it as a hierarchy parented at
> the GIC.
> 
> 	/* Create the 'MSI' domain */
> 	sei->cp_domain = irq_domain_create_hierarchy(parent_domain, 0,
> 						     sei->caps->cp_range.size,
> 						     of_node_to_fwnode(node),
> 						     &mvebu_sei_cp_domain_ops,
> 						     sei);
> 
> 
> Same thing here.
> 
> The issue here is that you're using the GIC domain as the way to root
> the two distinct SEI domains, while they should be rooted at an internal,
> SEI-specific domain. I'd suggest a topology like this:
> 
>                   AP-SEI ---> S
>                               E
>     Plat-MSI ---> CP-SEI ---> I
> 
> CP-SEI and AP-SEI use SEI as a parent. SEI does not have a parent, but is
> a chained irqchip.

Thanks you very much for this detailed explanation. The above is what I
intended to do, but maybe what I achieved is more something like:

                   AP-SEI ---> G
                               I
     Plat-MSI ---> CP-SEI ---> C

And now I understand better what is bothering you since the beginning.

> 
> I'm happy to help you reworking this piece of code if you tell me how to
> plug a driver that can use it on an mcbin system.

Next week I'll have another look at the driver, but it could be great
if you could show me the big lines of how you imagine the rework. I
prepared a branch based on 4.19-rc1 with:
* The ICU/SEI series
* The series adding support for thermal interrupts in the
  armada_thermal.c driver (it triggers a wired SEI when the AP is too
  hot or an MSI SEI when it is a CP).
* The needed DT changes.

https://github.com/miquelraynal/linux/tree/marvell/4.19-rc1/icu-sei


Thanks,
Miqu?l
