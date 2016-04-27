From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2016 20:08:16 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
Message-ID: <13248156.8VXoeOzRlg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2016 13:59:13 Alan Stern wrote:
> On Wed, 27 Apr 2016, Arnd Bergmann wrote:
> 
> > I've looked at the usb HCD code now and see this:
> > 
> > struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
> >                 struct device *dev, const char *bus_name,
> >                 struct usb_hcd *primary_hcd)
> > {
> >       ...
> >         hcd->self.controller = dev;
> >         hcd->self.uses_dma = (dev->dma_mask != NULL);
> >       ...
> > }
> > 
> > What I think we need to do here is ensure that the device that gets
> > passed here and assigned to hcd->self.controller is the actual DMA
> > master device, i.e. the pci_device or platform_device that was created
> > from outside of the xhci stack. This is after all the pointer that
> > gets passed into all the dma_map_*/dma_sync_*/dma_alloc_*/...
> > functions.
> 
> It would be better to add a new field, since self.controller is also
> used for lots of other purposes.  Something like hcd->self.dma_dev.
> 

Ok, fair enough. I only took a brief look and all uses I found were
either for the DMA mapping API or some printk logging.

	Arnd
