From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 10:26:05 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <8737lakedd.fsf@linux.intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <3189648.KnWLgq0lTY@wuerfel> <8737lakedd.fsf@linux.intel.com>
Message-ID: <6739240.VDAnDBppH0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 11:03:10 AM CEST Felipe Balbi wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> >> Arnd Bergmann <arnd@arndb.de> writes:
> just look at the history of the file, you'll see that an Intel employee
> was a maintainer of chipidea driver. Also:
> 
> $ git ls-files drivers/usb/chipidea/ | grep pci
> drivers/usb/chipidea/ci_hdrc_pci.c

Right, Peter pointed that one out too.

> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 35d092456bec..08db66c64c66 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pci.h>
> 
> actually, we don't want the core to know what it's attached to.

Agreed. This was just a first draft and I couldn't come up with
a better way to detect the case in which the parent device is
probed from another HW bus and the child is not known to the
firmware.

> >  #include <linux/pm_runtime.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/ioport.h>
> > @@ -178,7 +179,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
> >  static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
> >  		struct dwc3_event_buffer *evt)
> >  {
> > -	dma_free_coherent(dwc->dev, evt->length, evt->buf, evt->dma);
> > +	dma_free_coherent(dwc->sysdev, evt->length, evt->buf, evt->dma);
> 
> how about "dma_dev" instead? Is this used for anything other than DMA?

The two other things we have discussed in this thread are:

- connecting of_node pointers to usb_device structures for children
  of sysdev->of_node. Note that this can happen even for PCI devices
  in case you have a USB ethernet device hardwired to a PCI-USB bridge
  and put the mac address in DT.

- finding the PHY device for a HCD

There might be others. Basically sysdev here is what the USB core code
can use for looking up any kind of properties provided by the firmware.

> > @@ -846,6 +847,13 @@ static int dwc3_probe(struct platform_device *pdev)
> >  	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
> >  	dwc->mem = mem;
> >  	dwc->dev = dev;
> > +#ifdef CONFIG_PCI
> > +	/* TODO: or some other way of detecting this? */
> > +	if (dwc->dev->parent && dwc->dev->parent->bus == &pci_bus_type)
> > +		dwc->sysdev = dwc->dev->parent;
> > +	else
> > +#endif
> > +		dwc->sysdev = dwc->dev;
> 
> Well, we can remove this ifdef and *always* use the parent. We will just
> require that dwc3 users provide a glue layer. In that case, your check
> becomes:
> 
> 	if (dwc->dev->parent)
>         	dwc->sysdev = dwc->dev->parent;
> 	else
>         	dev_info(dwc->dev, "Please provide a glue layer!\n");

If we do that, we have to put child devices of the dwc3 devices into
the platform glue, and it also breaks those dwc3 devices that don't
have a parent driver.

> > diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> > index 2f1fb7e7aa54..e27899bb5706 100644
> > --- a/drivers/usb/dwc3/dwc3-exynos.c
> > +++ b/drivers/usb/dwc3/dwc3-exynos.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/dma-mapping.h>
> >  #include <linux/clk.h>
> >  #include <linux/usb/otg.h>
> >  #include <linux/usb/usb_phy_generic.h>
> > @@ -117,15 +116,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
> >  	if (!exynos)
> >  		return -ENOMEM;
> >  
> > -	/*
> > -	 * Right now device-tree probed devices don't get dma_mask set.
> > -	 * Since shared usb code relies on it, set it here for now.
> > -	 * Once we move to full device tree support this will vanish off.
> > -	 */
> > -	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > -	if (ret)
> > -		return ret;
> 
> this is a separate patch, right?

Yes, this is probably just a cleanup that we can apply regardless.
We have not needed this in a long time.

> > diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> > index 89a2f712fdfe..4d7439cb8cd8 100644
> > --- a/drivers/usb/dwc3/dwc3-st.c
> > +++ b/drivers/usb/dwc3/dwc3-st.c
> > @@ -218,7 +218,6 @@ static int st_dwc3_probe(struct platform_device *pdev)
> >  	if (IS_ERR(regmap))
> >  		return PTR_ERR(regmap);
> >  
> > -	dma_set_coherent_mask(dev, dev->coherent_dma_mask);
> 
> so is this.
> 
> All in all, I like where you're going with this, we just need a matching
> acpi_dma_configure() and problems will be sorted out.

With this patch, I don't think we even need that any more, as the device
that we use the dma-mapping API is the one that already gets configured
correctly by the platform code for all cases: PCI, OF, ACPI and combinations
of those.

	Arnd
