From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 7 Sep 2016 17:55:49 +0800
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <12021424.cItk3A7CfE@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <5844875.KucAoPMrXi@wuerfel>
 <20160907063313.GA13903@b29397-desktop>
 <12021424.cItk3A7CfE@wuerfel>
Message-ID: <20160907095549.GD13903@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 10:48:06AM +0200, Arnd Bergmann wrote:
> On Wednesday, September 7, 2016 2:33:13 PM CEST Peter Chen wrote:
> > > 
> > > Right, that should make it work with iommu as well. However, it does
> > > not solve the other issue I mentioned above, with boards that have
> > > USB devices hardwired to a chipidea host controller that need
> > > configuration from DT. For that, we still need to come up with another
> > > way to associate the DT hierarchy in the host bridge node with
> > > the Linux platform_device.
> > > 
> > 
> > Why? The DMA configuration is for host controller, not for USB device.
> > No matter there is hardwired or hotplug devices, the DMA configuration
> > for host controller are both inherited from glue layer platform devices,
> > current implementation is at function ci_hdrc_add_device,
> > drivers/usb/chipidea/core.c.
> 
> I wasn't referring to DMA configuration there, but only to how we
> set the of_node pointer in register_root_hub, which you added in
> dc5878abf49 ("usb: core: move root hub's device node assignment after
> it is added to bus") as:
> 
> 	usb_dev->dev.of_node = parent_dev->of_node;
> 
> As I understand, parent_dev (aka hcd->self.controller) here
> refers to the device that you add in ci_hdrc_add_device(),
> which does not have an of_node pointer, so we actually
> want parent_dev->parent->of_node.

For platform devices, like chipidea and dwc3, it is correct, since
they don't have of_node. If the host controller has of_node, it
is controller's of_node. In order to let USB HCD core life be easy,
we need to let hcd->self.controller own of_node when it is added
to HCD core, no matter it has from the dts or get it dynamically.

> 
> I'm sure you understand that code better than me, so let me
> know what my mistake is if this indeed works correctly.
> 

Your understanding is correct, just some have of_node from dts, some
(chipidea/dwc3) need to have assignment at its driver.

> 
> 
> Regarding the DMA configuration that you mention in ci_hdrc_add_device(),
> I think we should replace 
> 
>         pdev->dev.dma_mask = dev->dma_mask;
>         pdev->dev.dma_parms = dev->dma_parms;
>         dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
> 
> with of_dma_configure(), which has the chance to configure more than
> just those three, as the dma API might look into different aspects:
> 
> - iommu specific configuration
> - cache coherency information
> - bus type
> - dma offset
> - dma_map_ops pointer
> 
> We try to handle everything in of_dma_configure() at configuration
> time, and that would be the place to add anything else that we might
> need in the future.
> 

Yes, I agree with you, but just like Felipe mentioned, we also need to
consider PCI device, can we do something like gpiod_get_index does? Are
there any similar APIs like of_dma_configure for ACPI?

-- 

Best Regards,
Peter Chen
