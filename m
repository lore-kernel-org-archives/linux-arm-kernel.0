From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 10:45:26 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <87y432iylr.fsf@linux.intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <6739240.VDAnDBppH0@wuerfel> <87y432iylr.fsf@linux.intel.com>
Message-ID: <2733202.7lpFC7RnDm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 11:29:04 AM CEST Felipe Balbi wrote:
> > If we do that, we have to put child devices of the dwc3 devices into
> > the platform glue, and it also breaks those dwc3 devices that don't
> > have a parent driver.
> 
> Well, this is easy to fix:
> 
>         if (dwc->dev->parent) {
>                 dwc->sysdev = dwc->dev->parent;
>         } else {
>                 dev_info(dwc->dev, "Please provide a glue layer!\n");
>                 dwc->sysdev = dwc->dev;
>         }

I don't understand. Do you mean we should have an extra level of
stacking and splitting "static struct platform_driver dwc3_driver"
in two so instead of

	"qcom,dwc3" -> "snps,dwc3" (usb_bus.sysdev) -> "xhci" (usb_bus.dev)

we do this?

	"qcom,dwc3" -> "snps,dwc3" (usb_bus.sysdev) -> "dwc3-glue" -> "xhci" (usb_bus.dev)

That sounds a bit clumsy for the sake of consistency with PCI.
The advantage is that xhci can always use the grandparent device
as sysdev whenever it isn't probed through PCI or firmware
itself, but the purpose of the dwc3-glue is otherwise questionable.

How about adding a 'compatible="snps,dwc3-pci"' property for the dwc3
device when that is created from the PCI driver and checking for that
with the device property interface instead? If it's "snps,dwc3"
we use the device itself while for "snps,dwc3-pci", we use the parent?

	Arnd
