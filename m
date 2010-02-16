From: gadiyar@ti.com (Gadiyar, Anand)
Date: Tue, 16 Feb 2010 14:21:48 +0530
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100216084442.GA3212@n2100.arm.linux.org.uk>
References: <20100208065519.GE1290@ucw.cz>
	<1265622676.4020.19.camel@pc1117.cambridge.arm.com>
	<20100208105209.GA31671@atrey.karlin.mff.cuni.cz>
	<1265628483.4020.63.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7D50@dbde02.ent.ti.com>
	<20100216084442.GA3212@n2100.arm.linux.org.uk>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03215B07FF@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Tue, Feb 16, 2010 at 01:27:53PM +0530, Shilimkar, Santosh wrote:
> > Continuing on the USB issue w.r.t cache coherency, the usb host
> > code is violating the buffer ownership rules of streaming APIs from
> > dma and non-dma transfers point if view.
> > 
> > We have a below temporary patch to get around the issue and probably it
> > needs to be fixed in the right way in the stack because some controllers
> > may not have PIO option even for control transfers. (e.g. Synopsis EHCI
> > controller)
> 
>         if (usb_endpoint_xfer_control(&urb->ep->desc)
>             && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
>                 if (hcd->self.uses_dma) {		<=================
>                         urb->setup_dma = dma_map_single(
>                                         hcd->self.controller,
>                                         urb->setup_packet,
>                                         sizeof(struct usb_ctrlrequest),
>                                         DMA_TO_DEVICE);
> 
> struct usb_hcd *usb_create_hcd (const struct hc_driver *driver,
>                 struct device *dev, const char *bus_name)
> {
> ...
>         hcd->self.uses_dma = (dev->dma_mask != NULL);
> 
> Is it easier to make sure that PIO devices don't have dev->dma_mask set?

Not really. For instance, in the case of the DMA engine in the MUSB
controller in OMAP3, we can only use DMA with endpoints other than
EP0, and EP0 is what is used for control transfers.

It's not PIO for all the endpoints or DMA for all of them.

- Anand
