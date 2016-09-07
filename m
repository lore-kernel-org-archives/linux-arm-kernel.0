From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 10:48:06 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160907063313.GA13903@b29397-desktop>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <5844875.KucAoPMrXi@wuerfel> <20160907063313.GA13903@b29397-desktop>
Message-ID: <12021424.cItk3A7CfE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 2:33:13 PM CEST Peter Chen wrote:
> > 
> > Right, that should make it work with iommu as well. However, it does
> > not solve the other issue I mentioned above, with boards that have
> > USB devices hardwired to a chipidea host controller that need
> > configuration from DT. For that, we still need to come up with another
> > way to associate the DT hierarchy in the host bridge node with
> > the Linux platform_device.
> > 
> 
> Why? The DMA configuration is for host controller, not for USB device.
> No matter there is hardwired or hotplug devices, the DMA configuration
> for host controller are both inherited from glue layer platform devices,
> current implementation is at function ci_hdrc_add_device,
> drivers/usb/chipidea/core.c.

I wasn't referring to DMA configuration there, but only to how we
set the of_node pointer in register_root_hub, which you added in
dc5878abf49 ("usb: core: move root hub's device node assignment after
it is added to bus") as:

	usb_dev->dev.of_node = parent_dev->of_node;

As I understand, parent_dev (aka hcd->self.controller) here
refers to the device that you add in ci_hdrc_add_device(),
which does not have an of_node pointer, so we actually
want parent_dev->parent->of_node.

I'm sure you understand that code better than me, so let me
know what my mistake is if this indeed works correctly.



Regarding the DMA configuration that you mention in ci_hdrc_add_device(),
I think we should replace 

        pdev->dev.dma_mask = dev->dma_mask;
        pdev->dev.dma_parms = dev->dma_parms;
        dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);

with of_dma_configure(), which has the chance to configure more than
just those three, as the dma API might look into different aspects:

- iommu specific configuration
- cache coherency information
- bus type
- dma offset
- dma_map_ops pointer

We try to handle everything in of_dma_configure() at configuration
time, and that would be the place to add anything else that we might
need in the future.

	Arnd
