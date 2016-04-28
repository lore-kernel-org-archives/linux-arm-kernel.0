From: balbi@kernel.org (Felipe Balbi)
Date: Thu, 28 Apr 2016 09:37:08 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <5129992.Q57qoSDEqC@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <13248156.8VXoeOzRlg@wuerfel> <8737q6stpl.fsf@ti.com>
 <5129992.Q57qoSDEqC@wuerfel>
Message-ID: <87y47ykzmz.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> On Wednesday 27 April 2016 23:05:42 Felipe Balbi wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>> > On Wednesday 27 April 2016 13:59:13 Alan Stern wrote:
>> >> On Wed, 27 Apr 2016, Arnd Bergmann wrote:
>> >> 
>> >> > I've looked at the usb HCD code now and see this:
>> >> > 
>> >> > struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
>> >> >                 struct device *dev, const char *bus_name,
>> >> >                 struct usb_hcd *primary_hcd)
>> >> > {
>> >> >       ...
>> >> >         hcd->self.controller = dev;
>> >> >         hcd->self.uses_dma = (dev->dma_mask != NULL);
>> >> >       ...
>> >> > }
>> >> > 
>> >> > What I think we need to do here is ensure that the device that gets
>> >> > passed here and assigned to hcd->self.controller is the actual DMA
>> >> > master device, i.e. the pci_device or platform_device that was created
>> >> > from outside of the xhci stack. This is after all the pointer that
>> >> > gets passed into all the dma_map_*/dma_sync_*/dma_alloc_*/...
>> >> > functions.
>> >> 
>> >> It would be better to add a new field, since self.controller is also
>> >> used for lots of other purposes.  Something like hcd->self.dma_dev.
>> >
>> > Ok, fair enough. I only took a brief look and all uses I found were
>> > either for the DMA mapping API or some printk logging.
>> 
>> I have a feeling you guys are not considering how the patch to implement
>> this will look like.
>> 
>> How are you expecting dwc3 to pass a pointer to the DMA device from
>> dwc3.ko to xhci-plat ? platform_data ? That's gonna be horrible 
>
> Not any worse than it already is really. It already uses platform_data
> for the exact case that is causing the problem here.

there's no use of platform_data for passing around DMA configuration. By
platform_data I really mean platform_device_add_data().

>> Also, remember that the DMA device for dwc3 is not always
>> dwc3->dev->parent. It might be dwc3->dev itself. How are you expecting
>> us to figure that one out ?
>
> Do you have an example for this? The ones I found here either
> create the dwc3 device from PCI or from a platform glue driver.

arch/arm64/boot/dts/xilinx/zynqmp.dtsi

>> I still think dma_inherit() (or something along those lines) is
>> necessary. Specially when you consider that, as I said previously,
>> that's pretty much what of_dma_configure() does.
>
> As I said, this is not an API that can work in general, because
> it makes the assumption that everything related to DMA in a
> device can be set in that device itself.
>
> The simplest case where this does not work is a PCI device behind
> an IOMMU: when you call dma_map_single() or dma_alloc_coherent(),
> the dma_map_ops implementation for the IOMMU has to look at the
> PCI device to find out the association with an IOMMU context,
> and on most architectures you cannot bind an IOMMU context to
> a platform device at all.

no, it relies on dev->archdata for IOMMU. In fact, the first "patch"
(more of a hack) I wrote to fix IOMMU with dwc3 on Intel platforms was
to literally memcpy() pci's archdata to dwc3->dev and it worked just
fine with and without IOMMU enabled.

>> Anyway, I'd really like to see a patch implementing this
>> hcd->self.dma_dev logic. Consider all the duplication with this
>> approach, btw. struct dwc3 will *also* need a dwc->dma_dev of its
>> own. Will that be passed to dwc3 as platform_data from glue layer ? What
>> about platforms which don't even use a glue layer ?
>
> Let's separate the three problems here.
>
> a) dwc3 creating a "xhci-hcd" platform_device that is not connected
>    to any proper bus. We can work around that by adding the "self.dma_dev"

platform_bus_type *is* a proper bus.

>    pointer and pass that in platform_data. This is really easy, it's

Sorry but passing a struct device pointer in platform_data is
ridiculous. Not to mention that, as I said before, we can't assume which
device to pass to xhci_plat in the first place. It might be dwc->dev and
it might be dwc->dev->parent.

>    actually less code (and less iffy) than the current implementation of
>    copying the parent dma mask.
>    In the long run, this could be solved by doing away with the extra
>    platform_device, by calling a variant of xhci_probe() from
>    xhci_plat_probe() like we do for the normal *HCI drivers.

no, that's not something I'll do for dwc3. We have had this talk before
and I'm not giving up the benefits of splitting things to separate
devices.

> b) dwc3-pci creating a "dwc3" platform_device under the covers. This

it's not under the covers at all. It's pretty similar to what MFD
drivers do. It's just not wrapped in a nice API because there's no need
for that.

>    is pretty much the exact same problem as a) on another layer. In
>    the short run, we can pass the device pointer as part of
>    struct dwc3_platform_data (dwc3-pci is the only such user anway),

It's incredible that you'd even suggest this at all. Did we not have a
big trouble to solve on ARM land because of different mach-* passing
function pointers and other pointers from arch/arch/mach-* instead of
abstracting things away. Then came DT to the rescue, a setup where you
can't even pass code or kernel objects ;-)

>    and in the long run, it should be easy enough to get rid of the
>    extra platform device by just calling a variant of dwc3_probe,
>    which will again simplify the driver

also again definitely not something I'll do

> c) some SoCs that have two separate device nodes to describe their
>    dwc3 xhci. I don't think this is causing any additional problems,
>    but if we want to make this behave more like other drivers in the
>    long run or deal with machines that are missing a "dma-ranges"
>    property in the parent node, we can kill off the
>    of_platform_populate() hack and instead call dwc3_probe()
>    directly from the glue drivers as in b), and have that
>    do for_each_child_of_node() or similar to find the child node.

no, we cannot.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160428/e528cf76/attachment-0001.sig>
