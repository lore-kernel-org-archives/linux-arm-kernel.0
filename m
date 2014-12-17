From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Dec 2014 15:15:12 +0100
Subject: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <20141217120948.GB870@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <2447060.c0PHi7y3cP@wuerfel> <20141217120948.GB870@arm.com>
Message-ID: <3099591.NlcSS8Qjlv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 December 2014 12:09:49 Will Deacon wrote:
> On Tue, Dec 16, 2014 at 12:08:15PM +0000, Arnd Bergmann wrote:
> > On Monday 15 December 2014 18:09:33 Will Deacon wrote:
> > > > Using a single domain is a bit of a waste of resources in my case, so an 
> > > > evolution would be to create four domains and assign devices to them based on 
> > > > a policy. The policy could be fixed (round-robin for instance), or 
> > > > configurable (possibly through DT, although it's really a policy, not a 
> > > > hardware description).
> > 
> > I think in case of the ARM SMMU, we concluded that the grouping is indeed
> > best done in DT, because of there is no good algorithmic way to come
> > up with a set of bitmasks that make up a proper grouping into domains.
> 
> I think that's a slightly different case. The `grouping' in the DT, is on a
> per-master basis where a master may have a set of StreamIDs, which can be
> expressed in a more efficient (per-IOMMU) manner that cannot easily be
> determined at runtime.
> 
> For iommu_group creation, that could be done in the of code by treating the
> master IDs as bus IDs on a per-IOMMU bus; when a new device is probed, we
> can look at the set of devices with intersecting IDs and create a group
> containing those. This is similar to walking a PCI topology to establish DMA
> aliases.
> 
> The problem with all of this is how we distinguish the different ID formats
> in the `iommus' device-tree property. For the ARM SMMU, we could have:
> 
>   (1) [easy case] A device has a list of StreamIDs
> 
>   (2) A device has a list of SMR mask/value pairs

I was under the impression that using the format from (2), we could
describe all devices that fall into (1). In the worst case, we would
create an iommu group that is somewhat larger than one using discrete
StreamID values, but I would hope that this does not cause actual
troubles.

If all devices on each iommu fall into either 1 or 2, but you never mix
the two on one iommu, this could be handled by supporting either
#iommu-cells=<1> or <2> in the smmu driver. That way, the xlate function
will know which method to apply by looking at the iommu's #iommu-cells
property.

>   (3) A (bus) device has a range translation for a downstream bus (e.g.
>       a PCI host controller which needs to convert RequesterID to StreamID).
> 
> From the SMMU driver's perspective, they will all look like of_xlate calls
> unless we augment the generic IOMMU bindings with extra properties to
> identify the format. It also makes it difficult to pick a sensible value for
> #iommu-cells, as it depends on the format.

I would hope that PCI is the only case we need to worry about for a while.
This means we just need to come up with another property or a set of properties
that we can put into a PCI host controller device node in order to describe
the mapping. These properties could be iommu-specific, so we add something
to the PCI core that calls a new iommu callback function that takes the
device node of the PCI host and the bus/device/function number as inputs.

In arm_setup_iommu_dma_ops(), we can then do something like

	if (dev_is_pci(dev)) {
		struct pci_dev *pdev = to_pci_dev(dev);
		struct device_node *node;
		unsigned int bdf;

		node = find_pci_host_bridge(pdev->bus)->parent->of_node;
		bdf = PCI_DEVID(pdev->bus->number, dev->devfn);

		iommu_setup_pci_dev(pdev, node, bdf);
	}

	Arnd
