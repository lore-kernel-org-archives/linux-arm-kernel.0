From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2016 19:42:13 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <877ffjro0w.fsf@ti.com>
References: <1461612094-30939-1-git-send-email-grygorii.strashko@ti.com>
 <4985498.GT33RtioOA@wuerfel> <877ffjro0w.fsf@ti.com>
Message-ID: <6148633.0YXW4XnX4b@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2016 19:53:51 Felipe Balbi wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Wednesday 27 April 2016 16:50:19 Catalin Marinas wrote:
> >> On Wed, Apr 27, 2016 at 04:11:17PM +0200, Arnd Bergmann wrote:
> >> > On Wednesday 27 April 2016 14:59:00 Catalin Marinas wrote:
> >> > > 
> >> > > I would be in favour of a dma_inherit() function as well. We could hack
> >> > > something up in the arch code (like below) but I would rather prefer an
> >> > > explicit dma_inherit() call by drivers creating such devices.
> >> > > 
> >> > > diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> >> > > index ba437f090a74..ea6fb9b0e8fa 100644
> >> > > --- a/arch/arm64/include/asm/dma-mapping.h
> >> > > +++ b/arch/arm64/include/asm/dma-mapping.h
> >> > > @@ -29,8 +29,11 @@ extern struct dma_map_ops dummy_dma_ops;
> >> > >  
> >> > >  static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
> >> > >  {
> >> > > -       if (dev && dev->archdata.dma_ops)
> >> > > -               return dev->archdata.dma_ops;
> >> > > +       while (dev) {
> >> > > +               if (dev->archdata.dma_ops)
> >> > > +                       return dev->archdata.dma_ops;
> >> > > +               dev = dev->parent;
> >> > > +       }
> >> > 
> >> > I think this would be a very bad idea: we don't want to have random
> >> > devices be able to perform DMA just because their parent devices
> >> > have been set up that way.
> >> 
> >> I agree, it's a big hack. It would be nice to have a simpler way to do
> >> this in driver code rather than explicitly calling
> >> of_dma_configure/arch_setup_dma_ops as per the original patch in this
> >> thread.
> >
> > I haven't followed the entire discussion, but what's wrong with passing
> > around a pointer to a 'struct device *hwdev' that represents the physical
> > device that does the DMA?
> 
> that will likely create duplicated solutions in several drivers and
> it'll be a pain to maintain. There's another complication, dwc3 can be
> integrated in many different ways. See the device child-parent tree
> representations below:
> 
> a) with a parent PCI device:
> 
> pci_bus_type
>  - dwc3-pci
>    - dwc3
>      - xhci-plat
> 
> b) with a parent platform_device (OF):
> 
> platform_bus_type
>  - dwc3-${omap,st,of-simple,exynos,keystone}
>    - dwc3
>      - xhci-plat
> 
> c) without a parent at all (thanks Grygorii):
> 
> platform_bus_type
>  - dwc3
>    - xhci-plat
> 
> (a) and (b) above are the common cases. The DMA-capable device is
> clearly dwc3-${pci,omap,st,of-simple,exynos,keystone} with dwc3 only
> having proper DMA configuration in OF platforms (because of the
> unconditional of_dma_configure() during OF device creation) and
> xhci-plat not knowing about DMA at all and hardcoding some crappy
> defaults.
> 
> (c) is the uncommon case which creates some problems. In this case, dwc3
> itself is the DMA-capable device and dwc3->dev->parent is the
> platform_bus_type itself. Now consider the problem this creates:
> 
> i. the patch that I wrote [1] becomes invalid for (c), thanks to
> Grygorii for pointing this out before it was too late.
> 
> ii. xhci-plat can also be described directly in DT (and is in some
> cases). This means that assuming xhci-plat's parent's parent to be the
> DMA-capable device is also an invalid assumption.
> 
> iii. one might argue that for DT-based platforms *with* a glue layer
> ((b) above), OF already "copies" some sensible DMA defaults during
> device creation.

But that is exactly the point I was trying to make: instead of copying
all the data into the xhci-plat device, just assign one pointer
inside the xhci-plat device from whoever creates it.

> The only clean way to fix this up is with a dma_inherit()-like API which
> would allow dwc3's glue layers ((a) and (b) above) to initialize child's
> (dwc3) DMA configuration during child's creation. Something like below:
> 
> diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
> index adc1e8a624cb..74b599269e2c 100644
> --- a/drivers/usb/dwc3/dwc3-pci.c
> +++ b/drivers/usb/dwc3/dwc3-pci.c
> @@ -152,6 +152,8 @@ static int dwc3_pci_probe(struct pci_dev *pci,
>  		return -ENOMEM;
>  	}
>  
> +	dma_inherit(&dwc->dev, dev);
> +
>  	memset(res, 0x00, sizeof(struct resource) * ARRAY_SIZE(res));
>  
>  	res[0].start	= pci_resource_start(pci, 0);
> 
> that's all I'm asking for :-) dma_inherit() should, probably, be
> arch-specific to handle details like IOMMU (which today sits under
> archdata).

It's still wrong: the archdata in the device can contain all sorts of
additional information about how to do DMA, and some of that information
is bus specific, e.g. when your dma_map_ops look like the on sparc:

static inline struct dma_map_ops *get_dma_ops(struct device *dev)
{
#ifdef CONFIG_SPARC_LEON
        if (sparc_cpu_model == sparc_leon)
                return leon_dma_ops;
#endif
#if defined(CONFIG_SPARC32) && defined(CONFIG_PCI)
        if (dev->bus == &pci_bus_type)
                return &pci32_dma_ops;
#endif
        return dma_ops;
}

There is no way for a device to "inherit" the bus_type of its parent,
so it becomes an architecture specific hack. However, if you change
all the dma operations to work on the actual device that the dma
mapping API knows about, it just works.

I've looked at the usb HCD code now and see this:

struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
                struct device *dev, const char *bus_name,
                struct usb_hcd *primary_hcd)
{
	...
        hcd->self.controller = dev;
        hcd->self.uses_dma = (dev->dma_mask != NULL);
	...
}

What I think we need to do here is ensure that the device that gets
passed here and assigned to hcd->self.controller is the actual DMA
master device, i.e. the pci_device or platform_device that was created
from outside of the xhci stack. This is after all the pointer that
gets passed into all the dma_map_*/dma_sync_*/dma_alloc_*/...
functions.

	Arnd
