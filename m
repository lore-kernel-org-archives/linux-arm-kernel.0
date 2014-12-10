From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Dec 2014 17:06:24 +0100
Subject: [RFC PATCH] ARM64: PCI: inherit root controller's dma-coherent
In-Reply-To: <CACVXFVOfyQNGw+w_GTx1VmN89RKcvykh7DaFm=OcFGJ1f-EYxg@mail.gmail.com>
References: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
 <7705416.b49xSXIHeP@wuerfel>
 <CACVXFVOfyQNGw+w_GTx1VmN89RKcvykh7DaFm=OcFGJ1f-EYxg@mail.gmail.com>
Message-ID: <1664127.pT3ZlYms89@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 December 2014 10:53:26 Ming Lei wrote:
> On Sat, Dec 6, 2014 at 12:05 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 05 December 2014 15:26:27 Grygorii Strashko wrote:
> >> ---
> >> From 5e078b1ba148aa280181c4f695e567875a0f4ae9 Mon Sep 17 00:00:00 2001
> >> From: Grygorii Strashko <grygorii.strashko@ti.com>
> >> Date: Fri, 28 Feb 2014 19:11:39 +0200
> >> Subject: [RFC PATCH] common: dma-mapping: introduce dma_init_dev_from_parent() helper
> >>
> >> Now, in Kernel, Parent device's DMA configuration has to by applied
> >> to the child as is, to enable DMA support for this device. Usually, this
> >> is happened in places where child device is manually instantiated by
> >> Parent device device using Platform APIs
> >> (see drivers/usb/dwc3/host.c or drivers/pci/probe.c:pci_device_add()
> >>  for example).
> >>
> >> The DMA configuration is represented in Device data structure was
> >> extended recently (dma_pfn_offset was added) and going to extended
> >> in future to support IOMMU. Therefore, the code used by drivers to
> >> copy DMA configuration from parent to child device isn't working
> >> properly, for example:
> >> (drivers/usb/dwc3/host.c)
> >>       dma_set_coherent_mask(&xhci->dev, dwc->dev->coherent_dma_mask);
> >>
> >>       xhci->dev.parent        = dwc->dev;
> >>       xhci->dev.dma_mask      = dwc->dev->dma_mask;
> >>       xhci->dev.dma_parms     = dwc->dev->dma_parms;
> >> above code will miss to copy dma_pfn_offset.
> >
> >
> > I'm not too thrilled about this implementation either. It immediately
> > breaks as soon as we have IOMMU support, as the IOMMU configuration
> > is by definition device dependent, and you have introduced a few bugs
> > by copying the pointers to dma_mask and dma_parms.
> 
> Using devm_kmalloc() for allocating dma_mask might be helpful for
> the issue, but still need to support the default setting to be overrided
> by IOMMU code, which is related with the timing of calling
> dma_init_dev_from_parent()> 

struct pci_dev actually contains a place to store both dma_mask and
dma_parms, so no need for that.

> >> +     struct device *parent_dev = parent;
> >
> > One of these two is not needed.
> >
> >> +     /* if parent is NULL assume, dev->parent is the one to use */
> >> +     if (!parent_dev)
> >> +             parent_dev = dev->parent;
> >> +
> >> +     if (is_device_dma_capable(parent_dev)) {
> >> +             dev->dma_mask   = parent_dev->dma_mask;
> >
> > This is always wrong: dev->dma_mask is a pointer!
> >
> >> +             dev->coherent_dma_mask = parent_dev->coherent_dma_mask;
> >
> > What if someone has already set a mask that is greater than 32-bit?
> 
> Yes, that is a bit complicated because there may be default
> dma_mask which was setup before creating the device.

PCI devices should generally start out with a 32-bit mask, which can
be modified by the driver as needed. The only case you need to be
worried about is when the PCI host controller has a mask that is
smaller than 32-bit (e.g. on some shmobile rcar implementations),
and in that case you need to set the same mask there. We also need the
same change for platform devices, which start out with a 32-bit mask
at the moment, even when the parent bus has a smaller address width.

> >
> >> +             dev->dma_parms  = parent_dev->dma_parms;
> >
> > same  problem here.
> >
> >> +             dev->dma_pfn_offset = parent_dev->dma_pfn_offset;
> >> +             set_dma_ops(dev, get_dma_ops(parent_dev));
> >> +     }
> >> +}
> >> +EXPORT_SYMBOL(dma_init_dev_from_parent);
> 
> Arnd, given it isn't easy to figure out one good solution for moving
> dma configuration into generic code(driver core, pci, .) now, could
> the issue be fixed first?

We have just merged a new arch_setup_dma_ops callback based on patches
from Will Deacon, and this is required to get iommu drivers to work
properly. The callback is used correctly by of_dma_configure, and we
just need to hook it up on arm64 (I think Robin already has a patch,
if Will doesn't) and call it from the PCI core. There really isn't
any magic involved here.

	Arnd
