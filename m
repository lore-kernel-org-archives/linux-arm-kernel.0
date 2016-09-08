From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 13:11:01 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <87d1keirlu.fsf@linux.intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <4934737.egJZVdaLZs@wuerfel> <87d1keirlu.fsf@linux.intel.com>
Message-ID: <3757738.rjzYG3yq8e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 2:00:13 PM CEST Felipe Balbi wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Thursday, September 8, 2016 12:43:06 PM CEST Felipe Balbi wrote:
> >> Arnd Bergmann <arnd@arndb.de> writes:
> >> > That sounds a bit clumsy for the sake of consistency with PCI.
> >> > The advantage is that xhci can always use the grandparent device
> >> > as sysdev whenever it isn't probed through PCI or firmware
> >> > itself, but the purpose of the dwc3-glue is otherwise questionable.
> >> >
> >> > How about adding a 'compatible="snps,dwc3-pci"' property for the dwc3
> >> > device when that is created from the PCI driver and checking for that
> >> > with the device property interface instead? If it's "snps,dwc3"
> >> > we use the device itself while for "snps,dwc3-pci", we use the parent?
> >> 
> >> Any reason why we wouldn't use e.g. dwc3-omap.dev as sysdev?
> >
> > That would be incompatible with the USB binding, as the sysdev
> > is assumed to be a USB host controller with #address-cells=<1>
> > and #size-cells=<0> in order to hold the child devices, for
> > example:
> >
> > / {
> >      omap_dwc3_1: omap_dwc3_1 at 48880000 {
> >         compatible = "ti,dwc3";
> >         #address-cells = <1>;
> >         #size-cells = <1>;
> >         ranges;
> >         usb1: usb at 48890000 {
> >                 compatible = "snps,dwc3";
> >                 reg = <0x48890000 0x17000>;
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >                 interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> >                              <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> >                              <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> >                 interrupt-names = "peripheral",
> >                                   "host",
> >                                   "otg";
> >                 phys = <&usb2_phy1>, <&usb3_phy1>;
> >                 phy-names = "usb2-phy", "usb3-phy";
> >
> >                 hub at 1 {
> >                         compatible = "usb5e3,608";
> >                         reg = <1>;
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >
> >                         ethernet at 1 {
> >                                 compatible = "usb424,ec00";
> >                                 mac-address = [00 11 22 33 44 55];
> >                                 reg = <1>;
> >                         };
> >                 };
> >         };
> > };
> >
> > It's also the node that contains the "phys" properties and
> > presumably other properties like "otg-rev", "maximum-speed"
> > etc.
> >
> > If we make the sysdev point to the parent, then we can no longer
> > look up those properties and child devices from the USB core code
> > by looking at "sysdev->of_node".
> 
> this also makes things more interesting. I can't of anything other than
> having some type of flag passed via e.g. device_properties by dwc3-pci.c
> :-s

Ok.

> It's quite a hack, though. I still think that inheriting DMA (or
> manually initializing a child with parent's DMA bits and pieces) is the
> best way to go. So we're back to of_dma_configure() and
> acpi_dma_configure(), right?

That won't solve the problems with the DT properties or the
dma configuration for PCI devices though.

> But this needs to be done before dwc3_probe() executes. For dwc3-pci
> that's easy, but for DT devices, seems like it should be in of
> core. Below is, clearly, not enough but should show the idea:
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index fd5cfad7c403..a54610198946 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -94,8 +94,12 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>          * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
>          * setup the correct supported mask.
>          */
> -       if (!dev->coherent_dma_mask)
> -               dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +       if (!dev->coherent_dma_mask) {
> +               if (!dev->parent->coherent_dma_mask)
> +                       dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +               else
> +                       dev->coherent_dma_mask = dev->parent->coherent_dma_mask;
> +       }
>  

As the comment above that code says, the default 32-bit mask is intentional,
and you need the driver to ask for the mask it wants using
dma_set_mask_and_coherent(), while the platform code should be able to use
dev->of_node to figure out whether that mask is supported.

Just setting the initial mask to something else based on what the parent
supports will not do the right thing elsewhere.

	Arnd
