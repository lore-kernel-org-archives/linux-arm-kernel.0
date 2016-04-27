From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2016 23:05:44 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <8737q6stpl.fsf@ti.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <13248156.8VXoeOzRlg@wuerfel> <8737q6stpl.fsf@ti.com>
Message-ID: <5129992.Q57qoSDEqC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2016 23:05:42 Felipe Balbi wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Wednesday 27 April 2016 13:59:13 Alan Stern wrote:
> >> On Wed, 27 Apr 2016, Arnd Bergmann wrote:
> >> 
> >> > I've looked at the usb HCD code now and see this:
> >> > 
> >> > struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
> >> >                 struct device *dev, const char *bus_name,
> >> >                 struct usb_hcd *primary_hcd)
> >> > {
> >> >       ...
> >> >         hcd->self.controller = dev;
> >> >         hcd->self.uses_dma = (dev->dma_mask != NULL);
> >> >       ...
> >> > }
> >> > 
> >> > What I think we need to do here is ensure that the device that gets
> >> > passed here and assigned to hcd->self.controller is the actual DMA
> >> > master device, i.e. the pci_device or platform_device that was created
> >> > from outside of the xhci stack. This is after all the pointer that
> >> > gets passed into all the dma_map_*/dma_sync_*/dma_alloc_*/...
> >> > functions.
> >> 
> >> It would be better to add a new field, since self.controller is also
> >> used for lots of other purposes.  Something like hcd->self.dma_dev.
> >
> > Ok, fair enough. I only took a brief look and all uses I found were
> > either for the DMA mapping API or some printk logging.
> 
> I have a feeling you guys are not considering how the patch to implement
> this will look like.
> 
> How are you expecting dwc3 to pass a pointer to the DMA device from
> dwc3.ko to xhci-plat ? platform_data ? That's gonna be horrible 

Not any worse than it already is really. It already uses platform_data
for the exact case that is causing the problem here.

> Also, remember that the DMA device for dwc3 is not always
> dwc3->dev->parent. It might be dwc3->dev itself. How are you expecting
> us to figure that one out ?

Do you have an example for this? The ones I found here either
create the dwc3 device from PCI or from a platform glue driver.

> I still think dma_inherit() (or something along those lines) is
> necessary. Specially when you consider that, as I said previously,
> that's pretty much what of_dma_configure() does.

As I said, this is not an API that can work in general, because
it makes the assumption that everything related to DMA in a
device can be set in that device itself.

The simplest case where this does not work is a PCI device behind
an IOMMU: when you call dma_map_single() or dma_alloc_coherent(),
the dma_map_ops implementation for the IOMMU has to look at the
PCI device to find out the association with an IOMMU context,
and on most architectures you cannot bind an IOMMU context to
a platform device at all.

> Anyway, I'd really like to see a patch implementing this
> hcd->self.dma_dev logic. Consider all the duplication with this
> approach, btw. struct dwc3 will *also* need a dwc->dma_dev of its
> own. Will that be passed to dwc3 as platform_data from glue layer ? What
> about platforms which don't even use a glue layer ?

Let's separate the three problems here.

a) dwc3 creating a "xhci-hcd" platform_device that is not connected
   to any proper bus. We can work around that by adding the "self.dma_dev"
   pointer and pass that in platform_data. This is really easy, it's
   actually less code (and less iffy) than the current implementation of
   copying the parent dma mask.
   In the long run, this could be solved by doing away with the extra
   platform_device, by calling a variant of xhci_probe() from
   xhci_plat_probe() like we do for the normal *HCI drivers.

b) dwc3-pci creating a "dwc3" platform_device under the covers. This
   is pretty much the exact same problem as a) on another layer. In
   the short run, we can pass the device pointer as part of
   struct dwc3_platform_data (dwc3-pci is the only such user anway),
   and in the long run, it should be easy enough to get rid of the
   extra platform device by just calling a variant of dwc3_probe,
   which will again simplify the driver

c) some SoCs that have two separate device nodes to describe their
   dwc3 xhci. I don't think this is causing any additional problems,
   but if we want to make this behave more like other drivers in the
   long run or deal with machines that are missing a "dma-ranges"
   property in the parent node, we can kill off the
   of_platform_populate() hack and instead call dwc3_probe()
   directly from the glue drivers as in b), and have that
   do for_each_child_of_node() or similar to find the child node.

	Arnd
