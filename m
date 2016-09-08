From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 8 Sep 2016 20:28:10 +0800
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <4934737.egJZVdaLZs@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <2733202.7lpFC7RnDm@wuerfel> <87lgz2iv6d.fsf@linux.intel.com>
 <4934737.egJZVdaLZs@wuerfel>
Message-ID: <20160908122810.GA14132@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 12:17:21PM +0200, Arnd Bergmann wrote:
> On Thursday, September 8, 2016 12:43:06 PM CEST Felipe Balbi wrote:
> > Arnd Bergmann <arnd@arndb.de> writes:
> > > On Thursday, September 8, 2016 11:29:04 AM CEST Felipe Balbi wrote:
> > >> > If we do that, we have to put child devices of the dwc3 devices into
> > >> > the platform glue, and it also breaks those dwc3 devices that don't
> > >> > have a parent driver.
> > >> 
> > >> Well, this is easy to fix:
> > >> 
> > >>         if (dwc->dev->parent) {
> > >>                 dwc->sysdev = dwc->dev->parent;
> > >>         } else {
> > >>                 dev_info(dwc->dev, "Please provide a glue layer!\n");
> > >>                 dwc->sysdev = dwc->dev;
> > >>         }
> > >
> > > I don't understand. Do you mean we should have an extra level of
> > > stacking and splitting "static struct platform_driver dwc3_driver"
> > > in two so instead of
> > >
> > >       "qcom,dwc3" -> "snps,dwc3" (usb_bus.sysdev) -> "xhci" (usb_bus.dev)
> > >
> > > we do this?
> > >
> > >       "qcom,dwc3" -> "snps,dwc3" (usb_bus.sysdev) -> "dwc3-glue" -> "xhci" (usb_bus.dev)
> > 
> > no 
> > 
> > If we have a parent device, use that as sysdev, otherwise use self as
> > sysdev.
> 
> But there is often a parent device in DT, as the xhci device is
> attached to some internal bus that gets turned into a platform_device
> as well, so checking whether there is a parent will get the wrong
> device node.

>From my point, all platform and firmware information at dwc3 are
correct, so we don't need to change dwc3/core.c, only changing for
xhci-plat.c is ok.

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index ed56bf9..fd57c0d 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -145,6 +145,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	struct clk              *clk;
 	int			ret;
 	int			irq;
+	struct device *dev = &pdev->dev, *sysdev;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -155,6 +156,12 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENODEV;
 
+	if (dev->parent) {
+		sysdev = dev->parent;
+	} else {
+        	sysdev = dev;
+	}
+
 	/* Try to set 64-bit DMA first */
 	if (WARN_ON(!pdev->dev.dma_mask))
 		/* Platform did not initialize dma_mask */
@@ -170,7 +177,8 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
+	hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
+			dev_name(&pdev->dev), NULL);
 	if (!hcd)
 		return -ENOMEM;
 
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index d2e3f65..563600b 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1118,7 +1118,7 @@ static int register_root_hub(struct usb_hcd *hcd)
 		/* Did the HC die before the root hub was registered? */
 		if (HCD_DEAD(hcd))
 			usb_hc_died (hcd);	/* This time clean up */
-		usb_dev->dev.of_node = parent_dev->of_node;
+		usb_dev->dev.of_node = parent_dev->sysdev->of_node;
 	}
 	mutex_unlock(&usb_bus_idr_lock);

At above changes, the root hub's of_node equals to xhci-hcd sysdev's
of_node, which is from firmware or from its parent (it is dwc3 core
device).

> 
> > > That sounds a bit clumsy for the sake of consistency with PCI.
> > > The advantage is that xhci can always use the grandparent device
> > > as sysdev whenever it isn't probed through PCI or firmware
> > > itself, but the purpose of the dwc3-glue is otherwise questionable.
> > >
> > > How about adding a 'compatible="snps,dwc3-pci"' property for the dwc3
> > > device when that is created from the PCI driver and checking for that
> > > with the device property interface instead? If it's "snps,dwc3"
> > > we use the device itself while for "snps,dwc3-pci", we use the parent?
> > 

For pci glue device, it is always the parent for dwc3 core device.
In your patch, you may not need to split pci or non-pci, just using
if (dev->parent).

> > Any reason why we wouldn't use e.g. dwc3-omap.dev as sysdev?
> 
> That would be incompatible with the USB binding, as the sysdev
> is assumed to be a USB host controller with #address-cells=<1>
> and #size-cells=<0> in order to hold the child devices, for
> example:
> 
> / {
>      omap_dwc3_1: omap_dwc3_1 at 48880000 {
>         compatible = "ti,dwc3";
>         #address-cells = <1>;
>         #size-cells = <1>;
>         ranges;
>         usb1: usb at 48890000 {
>                 compatible = "snps,dwc3";
>                 reg = <0x48890000 0x17000>;
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>                 interrupt-names = "peripheral",
>                                   "host",
>                                   "otg";
>                 phys = <&usb2_phy1>, <&usb3_phy1>;
>                 phy-names = "usb2-phy", "usb3-phy";
> 
>                 hub at 1 {
>                         compatible = "usb5e3,608";
>                         reg = <1>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> 
>                         ethernet at 1 {
>                                 compatible = "usb424,ec00";
>                                 mac-address = [00 11 22 33 44 55];
>                                 reg = <1>;
>                         };
>                 };
>         };
> };
> 

With my above changes, the hub of_node should be found since it is
child of root hub's of_node which is the dwc3's of_node.

> It's also the node that contains the "phys" properties and
> presumably other properties like "otg-rev", "maximum-speed"
> etc.
> 

This information is described at dwc3 core device of_node, and be
handled at dwc3/core.c

-- 

Best Regards,
Peter Chen
