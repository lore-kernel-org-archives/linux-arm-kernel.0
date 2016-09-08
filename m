From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 14:52:29 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160908122810.GA14132@b29397-desktop>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <4934737.egJZVdaLZs@wuerfel> <20160908122810.GA14132@b29397-desktop>
Message-ID: <6547614.50rx8ya9lj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 8:28:10 PM CEST Peter Chen wrote:
> On Thu, Sep 08, 2016 at 12:17:21PM +0200, Arnd Bergmann wrote:
> > On Thursday, September 8, 2016 12:43:06 PM CEST Felipe Balbi wrote:
> > > Arnd Bergmann <arnd@arndb.de> writes:
> > > > On Thursday, September 8, 2016 11:29:04 AM CEST Felipe Balbi wrote:
> > > If we have a parent device, use that as sysdev, otherwise use self as
> > > sysdev.
> > 
> > But there is often a parent device in DT, as the xhci device is
> > attached to some internal bus that gets turned into a platform_device
> > as well, so checking whether there is a parent will get the wrong
> > device node.
> 
> From my point, all platform and firmware information at dwc3 are
> correct, so we don't need to change dwc3/core.c, only changing for
> xhci-plat.c is ok.

Ok, thanks. That leaves the PCI glue, right?

> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index d2e3f65..563600b 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1118,7 +1118,7 @@ static int register_root_hub(struct usb_hcd *hcd)
>  		/* Did the HC die before the root hub was registered? */
>  		if (HCD_DEAD(hcd))
>  			usb_hc_died (hcd);	/* This time clean up */
> -		usb_dev->dev.of_node = parent_dev->of_node;
> +		usb_dev->dev.of_node = parent_dev->sysdev->of_node;
>  	}
>  	mutex_unlock(&usb_bus_idr_lock);
> 
> At above changes, the root hub's of_node equals to xhci-hcd sysdev's
> of_node, which is from firmware or from its parent (it is dwc3 core
> device).

Just to make sure I understand you right:

in the qcom,dwc3 -> dwc3 -> xhci hierarchy, this would be the
dwc3 device, not the qcom,dwc3 device.

> > > > That sounds a bit clumsy for the sake of consistency with PCI.
> > > > The advantage is that xhci can always use the grandparent device
> > > > as sysdev whenever it isn't probed through PCI or firmware
> > > > itself, but the purpose of the dwc3-glue is otherwise questionable.
> > > >
> > > > How about adding a 'compatible="snps,dwc3-pci"' property for the dwc3
> > > > device when that is created from the PCI driver and checking for that
> > > > with the device property interface instead? If it's "snps,dwc3"
> > > > we use the device itself while for "snps,dwc3-pci", we use the parent?
> > > 
> 
> For pci glue device, it is always the parent for dwc3 core device.
> In your patch, you may not need to split pci or non-pci, just using
> if (dev->parent).

Here we have the pci-dwc3 -> dwc3 -> xhci hierarchy, and we want
sysdev to point to pci-dwc3, not dwc3!

The point is that the pci_dev is where we have the dma settings
and (optionally) additional DT or ACPI data for that device.

	Arnd
