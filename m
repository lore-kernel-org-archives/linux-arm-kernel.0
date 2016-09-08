From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 13:39:58 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <871t0uiqn9.fsf@linux.intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <3757738.rjzYG3yq8e@wuerfel> <871t0uiqn9.fsf@linux.intel.com>
Message-ID: <12394164.0mceYlJJBD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 2:20:58 PM CEST Felipe Balbi wrote:
> >> It's quite a hack, though. I still think that inheriting DMA (or
> >> manually initializing a child with parent's DMA bits and pieces) is the
> >> best way to go. So we're back to of_dma_configure() and
> >> acpi_dma_configure(), right?
> >
> > That won't solve the problems with the DT properties or the
> > dma configuration for PCI devices though.
> 
> acpi_dma_configure() is supposed to pass along DMA bits from PCI to
> child devices, no?

I don't know, haven't looked at that code.

> >> But this needs to be done before dwc3_probe() executes. For dwc3-pci
> >> that's easy, but for DT devices, seems like it should be in of
> >> core. Below is, clearly, not enough but should show the idea:
> >> 
> >> diff --git a/drivers/of/device.c b/drivers/of/device.c
> >> index fd5cfad7c403..a54610198946 100644
> >> --- a/drivers/of/device.c
> >> +++ b/drivers/of/device.c
> >> @@ -94,8 +94,12 @@ void of_dma_configure(struct device *dev, struct device_node *np)
> >>          * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> >>          * setup the correct supported mask.
> >>          */
> >> -       if (!dev->coherent_dma_mask)
> >> -               dev->coherent_dma_mask = DMA_BIT_MASK(32);
> >> +       if (!dev->coherent_dma_mask) {
> >> +               if (!dev->parent->coherent_dma_mask)
> >> +                       dev->coherent_dma_mask = DMA_BIT_MASK(32);
> >> +               else
> >> +                       dev->coherent_dma_mask = dev->parent->coherent_dma_mask;
> >> +       }
> >>  
> >
> > As the comment above that code says, the default 32-bit mask is intentional,
> > and you need the driver to ask for the mask it wants using
> > dma_set_mask_and_coherent(), while the platform code should be able to use
> > dev->of_node to figure out whether that mask is supported.
> >
> > Just setting the initial mask to something else based on what the parent
> > supports will not do the right thing elsewhere.
> 
> oh man, it gets more and more complex. Seems like either path we take
> will cause problems somewhere 
> 
> If we make dwc3.ko a library which glue calls directly then all these
> problems are solved but we break all current DTs and fall into the trap
> of having another MUSB.

I don't see how we'd break the current DTs, I'm fairly sure we could turn dwc3
into a library without changing the DT representation. However the parts
that I think would change are

- The sysfs representation for dwc3-pci, as we would no longer have
  a parent-child relationship there.
- The power management handling might need a rework, since you currently
  rely on the hierarchy between dwc3-pci, dwc3 and xhci for turning
  power on and off
- turning dwc3 into a library probably implies also turning xhci into
  a library, in part for consistency.
- if we don't do the whole usb_bus->sysdev thing, we need to not just
  do this for dwc3 but also chipidea and maybe a couple of others.

There should not be any show-stoppers here, but it's a lot of work.

> If we try to pass DMA bits from parent to child, then we have the fact
> that DT ends up, in practice, always having a parent device.

I don't understand what you mean here, but I agree that the various ways
we discussed for copying the DMA flags from one 'struct device' to another
all turned out to be flawed in at least one way.

Do you see any problems with the patch I posted other than the ugliness
of the dwc3 and xhci drivers finding out which pointer to use for
usb_bus->sysdev? If we can solve this, we shouldn't need any new
of_dma_configure/acpi_dma_configure calls and we won't have to
turn the drivers into a library, so maybe let's try to come up with
better ideas for that sub-problem.

	Arnd
