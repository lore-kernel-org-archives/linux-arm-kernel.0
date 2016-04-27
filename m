From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 27 Apr 2016 23:05:42 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <13248156.8VXoeOzRlg@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <13248156.8VXoeOzRlg@wuerfel>
Message-ID: <8737q6stpl.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> On Wednesday 27 April 2016 13:59:13 Alan Stern wrote:
>> On Wed, 27 Apr 2016, Arnd Bergmann wrote:
>> 
>> > I've looked at the usb HCD code now and see this:
>> > 
>> > struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
>> >                 struct device *dev, const char *bus_name,
>> >                 struct usb_hcd *primary_hcd)
>> > {
>> >       ...
>> >         hcd->self.controller = dev;
>> >         hcd->self.uses_dma = (dev->dma_mask != NULL);
>> >       ...
>> > }
>> > 
>> > What I think we need to do here is ensure that the device that gets
>> > passed here and assigned to hcd->self.controller is the actual DMA
>> > master device, i.e. the pci_device or platform_device that was created
>> > from outside of the xhci stack. This is after all the pointer that
>> > gets passed into all the dma_map_*/dma_sync_*/dma_alloc_*/...
>> > functions.
>> 
>> It would be better to add a new field, since self.controller is also
>> used for lots of other purposes.  Something like hcd->self.dma_dev.
>
> Ok, fair enough. I only took a brief look and all uses I found were
> either for the DMA mapping API or some printk logging.

I have a feeling you guys are not considering how the patch to implement
this will look like.

How are you expecting dwc3 to pass a pointer to the DMA device from
dwc3.ko to xhci-plat ? platform_data ? That's gonna be horrible :-)

Also, remember that the DMA device for dwc3 is not always
dwc3->dev->parent. It might be dwc3->dev itself. How are you expecting
us to figure that one out ?

I still think dma_inherit() (or something along those lines) is
necessary. Specially when you consider that, as I said previously,
that's pretty much what of_dma_configure() does.

Anyway, I'd really like to see a patch implementing this
hcd->self.dma_dev logic. Consider all the duplication with this
approach, btw. struct dwc3 will *also* need a dwc->dma_dev of its
own. Will that be passed to dwc3 as platform_data from glue layer ? What
about platforms which don't even use a glue layer ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/4c9d86a6/attachment.sig>
