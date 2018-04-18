From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Wed, 18 Apr 2018 06:21:46 +0000
Subject: [PATCH 2/6 v2] iommu: of: make of_pci_map_rid() available for
 other devices too
In-Reply-To: <41b32766-e21a-e946-6c8f-440e5c87d0ee@arm.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-3-git-send-email-nipun.gupta@nxp.com>
 <41b32766-e21a-e946-6c8f-440e5c87d0ee@arm.com>
Message-ID: <HE1PR0401MB2425A73A3BFF84B15B764FC6E6B60@HE1PR0401MB2425.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Tuesday, April 17, 2018 10:23 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>; robh+dt at kernel.org;
> frowand.list at gmail.com
> Cc: will.deacon at arm.com; mark.rutland at arm.com; catalin.marinas at arm.com;
> hch at lst.de; gregkh at linuxfoundation.org; joro at 8bytes.org;
> m.szyprowski at samsung.com; shawnguo at kernel.org; bhelgaas at google.com;
> iommu at lists.linux-foundation.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linuxppc-
> dev at lists.ozlabs.org; linux-pci at vger.kernel.org; Bharat Bhushan
> <bharat.bhushan@nxp.com>; stuyoder at gmail.com; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 2/6 v2] iommu: of: make of_pci_map_rid() available for
> other devices too
> 
> On 17/04/18 11:21, Nipun Gupta wrote:
> > iommu-map property is also used by devices with fsl-mc. This patch
> > moves the of_pci_map_rid to generic location, so that it can be used
> > by other busses too.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> >   drivers/iommu/of_iommu.c | 106
> > +++++++++++++++++++++++++++++++++++++++++++++--
> 
> Doesn't this break "msi-parent" parsing for !CONFIG_OF_IOMMU? I guess you
> don't want fsl-mc to have to depend on PCI, but this looks like a step in the
> wrong direction.

Thanks for pointing out.
Agree, this will break "msi-parent" parsing for !CONFIG_OF_IOMMU case.

> 
> I'm not entirely sure where of_map_rid() fits best, but from a quick look around
> the least-worst option might be drivers/of/of_address.c, unless Rob and Frank
> have a better idea of where generic DT-based ID translation routines could live?
> 
> >   drivers/of/irq.c         |   6 +--
> >   drivers/pci/of.c         | 101 --------------------------------------------
> >   include/linux/of_iommu.h |  11 +++++
> >   include/linux/of_pci.h   |  10 -----
> >   5 files changed, 117 insertions(+), 117 deletions(-)
> >

[...]

> >   struct of_pci_iommu_alias_info {
> >   	struct device *dev;
> >   	struct device_node *np;
> > @@ -149,9 +249,9 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16
> alias, void *data)
> >   	struct of_phandle_args iommu_spec = { .args_count = 1 };
> >   	int err;
> >
> > -	err = of_pci_map_rid(info->np, alias, "iommu-map",
> > -			     "iommu-map-mask", &iommu_spec.np,
> > -			     iommu_spec.args);
> > +	err = of_map_rid(info->np, alias, "iommu-map",
> > +			 "iommu-map-mask", &iommu_spec.np,
> > +			 iommu_spec.args);
> 
> Super-nit: Apparently I missed rewrapping this to 2 lines in d87beb749281, but if
> it's being touched again, that would be nice ;)

Sure.. I'll take care of this in the next version :)

Regards,
Nipun
