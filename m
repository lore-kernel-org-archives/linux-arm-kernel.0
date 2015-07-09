From: will.deacon@arm.com (Will Deacon)
Date: Thu, 9 Jul 2015 12:27:20 +0100
Subject: [PATCH v2 6/9] iommu/arm-smmu: to support probe deferral
In-Reply-To: <559E5693.9060709@huawei.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
 <1436239822-14132-7-git-send-email-thunder.leizhen@huawei.com>
 <559D21F0.3080202@arm.com> <559E5693.9060709@huawei.com>
Message-ID: <20150709112243.GA20778@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 12:10:11PM +0100, leizhen wrote:
> On 2015/7/8 21:13, Robin Murphy wrote:
> > On 07/07/15 04:30, Zhen Lei wrote:
> >> For pci devices, only the root nodes have "iommus" property. So we
> >> should traverse all of its sub nodes in of_xlate.
> > 
> > I don't really follow this description; only the host controller is
> > described in DT - the devices behind it are probed dynamically and don't
> > have nodes to traverse.
> 
> The devices behind host controller may have nodes, but have no "iommus" property.

No, the PCI masters won't have nodes in the DT on arm/arm64 systems (it
makes hotplug difficult).

> I got this conclusion base on the original code as below:
> 
> 	struct pci_bus *bus = pdev->bus;
> 
> 	/* Walk up to the root bus */
> 	while (!pci_is_root_bus(bus))
> 		bus = bus->parent;

So this walks up the PCI topology, created by probing the bus, until we
get to the top-level bus...

> 	/* Follow the "iommus" phandle from the host controller */
> 	of_node = of_parse_phandle(bus->bridge->parent->of_node, "iommus", 0);
> 	if (!of_node)
> 		return NULL;

... then we find the host controller device, which *does* have a
device-tree node and use *that* to find out the IOMMU corresponding to
the PCI device.

Will
