From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Sep 2016 15:27:43 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <87d1khmhdj.fsf@linux.intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <4416687.vUjZzKWZG6@wuerfel> <87d1khmhdj.fsf@linux.intel.com>
Message-ID: <20562703.Glp77l1PBf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 6, 2016 1:50:48 PM CEST Felipe Balbi wrote:
> Hi,
> 
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Tuesday, September 6, 2016 9:40:19 AM CEST Felipe Balbi wrote:
> >> 
> >> this only solves the problem for DT devices. Legacy devices and
> >> PCI-based systems will still suffer from the same problem. At least for
> >> dwc3, I will only be taking patches that solve the problem for all
> >> users, not a subset of them.
> >
> > I don't think legacy devices are a worry, because they wouldn't
> > have this problem. For the PCI case, you are right that it cannot
> > work, in particular for machines that have complex IOMMU setup.
> >
> > Some architectures (at least arm64 and sparc) check the bus_type of
> > a device in order to find the correct set of dma_map_ops for that
> > device, so there is no real way to handle this as long as you
> > pass a platform_device into an API that expects a pci_device.
> 
> Then I guess we're left with adding a "struct device *dma_dev" to struct
> dwc3 and trying to figure out if we should use parent or self. Does
> anybody see any problems with that?

I think we actually need the device pointer in the usb_hcd structure,
so it can be passed in these API calls from the USB core

drivers/usb/core/buffer.c:      return dma_alloc_coherent(hcd->self.controller, size, dma, mem_flags);
drivers/usb/core/buffer.c:      dma_free_coherent(hcd->self.controller, size, addr, dma);
drivers/usb/core/buffer.c:          (!hcd->self.controller->dma_mask &&
drivers/usb/core/buffer.c:              hcd->pool[i] = dma_pool_create(name, hcd->self.controller,
drivers/usb/core/hcd.c:                 urb->setup_dma = dma_map_single(
drivers/usb/core/hcd.c:                 if (dma_mapping_error(hcd->self.controller,
drivers/usb/core/hcd.c:                         n = dma_map_sg(
drivers/usb/core/hcd.c:                         urb->transfer_dma = dma_map_page(
drivers/usb/core/hcd.c:                         if (dma_mapping_error(hcd->self.controller,
drivers/usb/core/hcd.c:                         urb->transfer_dma = dma_map_single(
drivers/usb/core/hcd.c:                         if (dma_mapping_error(hcd->self.controller,
drivers/usb/core/usb.c:         urb->transfer_dma = dma_map_single(controller,
drivers/usb/core/usb.c: return dma_map_sg(controller, sg, nents,
drivers/usb/core/usb.c:         dma_sync_single_for_cpu(controller,
drivers/usb/core/usb.c:                 dma_sync_single_for_cpu(controller,
drivers/usb/core/usb.c: dma_sync_sg_for_cpu(controller, sg, n_hw_ents,

as these are all called on behalf of the host controller node.
Looking for more instances of hcd->self.controller, I find this
instance:

drivers/usb/core/hcd.c:         struct usb_phy *phy = usb_get_phy_dev(hcd->self.controller, 0);
drivers/usb/core/hcd.c:         struct phy *phy = phy_get(hcd->self.controller, "usb");

I'm unsure which device pointer we want here, but I suspect this also
needs to be the one that has the device node in order to make the lookup
of the phy structure by device node work right. Can you clarify how
this works today?

We probably also need to add the of_node of the host controller device
to struct usb_hcd in order to make usb_of_get_child_node() work
in the case where the hcd itself is not device that is listed
in DT. It might be a good idea to use 'struct fwnode_handle' for that,
so we can in the future also allow ACPI platforms to specify 

> Note, we would NOT be passing device pointers are platform_data, we
> would have dwc3.ko figure out if it should use self or its parent device
> for dma.

Ok, sounds good.

	Arnd
