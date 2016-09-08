From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 12:17:21 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <87lgz2iv6d.fsf@linux.intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <2733202.7lpFC7RnDm@wuerfel> <87lgz2iv6d.fsf@linux.intel.com>
Message-ID: <4934737.egJZVdaLZs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 12:43:06 PM CEST Felipe Balbi wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Thursday, September 8, 2016 11:29:04 AM CEST Felipe Balbi wrote:
> >> > If we do that, we have to put child devices of the dwc3 devices into
> >> > the platform glue, and it also breaks those dwc3 devices that don't
> >> > have a parent driver.
> >> 
> >> Well, this is easy to fix:
> >> 
> >>         if (dwc->dev->parent) {
> >>                 dwc->sysdev = dwc->dev->parent;
> >>         } else {
> >>                 dev_info(dwc->dev, "Please provide a glue layer!\n");
> >>                 dwc->sysdev = dwc->dev;
> >>         }
> >
> > I don't understand. Do you mean we should have an extra level of
> > stacking and splitting "static struct platform_driver dwc3_driver"
> > in two so instead of
> >
> >       "qcom,dwc3" -> "snps,dwc3" (usb_bus.sysdev) -> "xhci" (usb_bus.dev)
> >
> > we do this?
> >
> >       "qcom,dwc3" -> "snps,dwc3" (usb_bus.sysdev) -> "dwc3-glue" -> "xhci" (usb_bus.dev)
> 
> no 
> 
> If we have a parent device, use that as sysdev, otherwise use self as
> sysdev.

But there is often a parent device in DT, as the xhci device is
attached to some internal bus that gets turned into a platform_device
as well, so checking whether there is a parent will get the wrong
device node.

> > That sounds a bit clumsy for the sake of consistency with PCI.
> > The advantage is that xhci can always use the grandparent device
> > as sysdev whenever it isn't probed through PCI or firmware
> > itself, but the purpose of the dwc3-glue is otherwise questionable.
> >
> > How about adding a 'compatible="snps,dwc3-pci"' property for the dwc3
> > device when that is created from the PCI driver and checking for that
> > with the device property interface instead? If it's "snps,dwc3"
> > we use the device itself while for "snps,dwc3-pci", we use the parent?
> 
> Any reason why we wouldn't use e.g. dwc3-omap.dev as sysdev?

That would be incompatible with the USB binding, as the sysdev
is assumed to be a USB host controller with #address-cells=<1>
and #size-cells=<0> in order to hold the child devices, for
example:

/ {
     omap_dwc3_1: omap_dwc3_1 at 48880000 {
        compatible = "ti,dwc3";
        #address-cells = <1>;
        #size-cells = <1>;
        ranges;
        usb1: usb at 48890000 {
                compatible = "snps,dwc3";
                reg = <0x48890000 0x17000>;
                #address-cells = <1>;
                #size-cells = <0>;
                interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
                             <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
                             <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
                interrupt-names = "peripheral",
                                  "host",
                                  "otg";
                phys = <&usb2_phy1>, <&usb3_phy1>;
                phy-names = "usb2-phy", "usb3-phy";

                hub at 1 {
                        compatible = "usb5e3,608";
                        reg = <1>;
                        #address-cells = <1>;
                        #size-cells = <0>;

                        ethernet at 1 {
                                compatible = "usb424,ec00";
                                mac-address = [00 11 22 33 44 55];
                                reg = <1>;
                        };
                };
        };
};

It's also the node that contains the "phys" properties and
presumably other properties like "otg-rev", "maximum-speed"
etc.

If we make the sysdev point to the parent, then we can no longer
look up those properties and child devices from the USB core code
by looking at "sysdev->of_node".

	Arnd
