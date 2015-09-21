From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 21 Sep 2015 18:07:56 +0100
Subject: [PATCH 2/2] irqchip/gicv3-its:  Handle OF device tree "msi-map"
 properties.
In-Reply-To: <560031E7.1060307@caviumnetworks.com>
References: <1442512859-31633-1-git-send-email-ddaney.cavm@gmail.com>
 <1442512859-31633-3-git-send-email-ddaney.cavm@gmail.com>
 <20150918095109.144c22ed@arm.com>
 <55FC4FBA.1010306@caviumnetworks.com>
 <20150921165814.01967eaf@arm.com>
 <560031E7.1060307@caviumnetworks.com>
Message-ID: <20150921180756.13f505f3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Sep 2015 09:35:51 -0700
David Daney <ddaney@caviumnetworks.com> wrote:

> On 09/21/2015 08:58 AM, Marc Zyngier wrote:
> > On Fri, 18 Sep 2015 10:54:02 -0700
> > David Daney <ddaney@caviumnetworks.com> wrote:
> >
> >> On 09/18/2015 01:51 AM, Marc Zyngier wrote:
> >>> On Thu, 17 Sep 2015 11:00:59 -0700
> >>> David Daney <ddaney.cavm@gmail.com> wrote:
> >>>
> >>> Hi David,
> >>>
> >>>> From: David Daney <david.daney@cavium.com>
> >>>>
> >>>> Search up the device hierarchy to find devices with a "msi-map"
> >>>> property, if found apply the mapping to the GIC device id.
> >>>>
> >>>> Signed-off-by: David Daney <david.daney@cavium.com>
> >>>> ---
> >>>>    drivers/irqchip/irq-gic-v3-its-pci-msi.c | 73 ++++++++++++++++++++++++++++++++
> >>>>    1 file changed, 73 insertions(+)
> >>>>
> >>>> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> >>>> index cf351c6..aa61cef 100644
> >>>> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> >>>> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> >>>> @@ -73,6 +73,8 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
> >>>>    	struct pci_dev *pdev;
> >>>>    	struct its_pci_alias dev_alias;
> >>>>    	struct msi_domain_info *msi_info;
> >>>> +	struct device *parent_dev;
> >>>> +	struct device_node *msi_controller_node = NULL;
> >>>>
> >>>>    	if (!dev_is_pci(dev))
> >>>>    		return -EINVAL;
> >>>> @@ -84,6 +86,77 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
> >>>>    	dev_alias.count = nvec;
> >>>>
> >>>>    	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
> >>>> +	/*
> >>>> +	 * Walk up the device parent links looking for one with a
> >>>> +	 * "msi-map" property.
> >>>> +	 */
> >>>
> >>> My first objection is the location of this parsing. It shouldn't be
> >>> driver specific, but instead be part of the generic OF handling
> >>> (nothing in these properties is GICv3 specific, even if the ITS is the
> >>> only user so far).
> >>
> >> OK, I agree that this should eventually end up in generic OF handling
> >> code.  I just wanted to get something out to initiate discussion.
> >>
> >> The next patch revision will move this to a more generic home.
> >>
> >>>
> >>>> +	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
> >>>
> >>> Is there a limit how far we should go up the parent chain to find a
> >>> msi-map? My hunch is that you should stop at the first device that does
> >>> have an of_node, as it is the one that should contain the msi-map
> >>> property.
> >>
> >> I think there is the possibility of finding something like a bridge that
> >> has an of_node, but does not have the "msi-map" property.  I currently
> >> have exactly this configuration, as some of the on-SoC devices sit
> >> behind a bridge, but need an of_node to obtain unprobable properties and
> >> children (the MDIO bus devices are like this).
> >>
> >> So if we want to abort the walk early, we should at least go up until we
> >> find "msi-map" in the of_node.
> >
> > I don't really see a case where we would traverse a series of nodes
> > where the msi-map property wouldn't be in the first node. Could you
> > please give me an example?
> >
> 
> OK, how about this:

[...]

> The "msi-map" is specified in the PICe host controller node, but there
> is a bridge between the device generating interrupts "bgx0" and the
> host controller.

OK, I can now see why you're doing that, thanks.


> >> The PCI host may have many MSI controllers, but I think a given PCI
> >> device will have only one (based on bus:devfn) that is looked up in the map.
> >
> > A PCI device will only be configured to talk to a single MSI
> > controller, but here you stop parsing the msi-map on the first match,
> > and assume that you must have found the right MSI controller:
> >
> > I think this should read:
> >
> > +			if (masked_devid < rid_base ||
> > +			    masked_devid >= rid_base + rid_len ||
> > 			    domain->of_node != of_find_node_by_phandle(phandle)) {
> > +				msi_map_len -= 4 * sizeof(__be32);
> > +				msi_map += 4;
> > +				continue;
> > +			}
> > +			matched = true;
> > +			break;
> >
> 
> Good, I will incorporate that too.
> 
> In practice, I don't know if we would ever find a system with multiple 
> "msi-map" on a path from the device to the root, but we should probably 
> attempt to handle it "just in case".

There are systems in the wild with exactly that kind of topology, and
I'd like to support them out of the box.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
