From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 22 Dec 2015 10:48:52 -0500 (EST)
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <CAL411-oVEbh1cDnUugs0Rxrt1opvH-NeffjcmeMy-OuZS38CbA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1512221039580.1539-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Dec 2015, Peter Chen wrote:

> > I don't really understand this.  However, you can always specify a USB
> > device by giving its port number on the parent hub, and the hub's port
> > number on _its_ parent hub, and so on back to the root hub and host
> > controller.  That works even if you're not using DT or OF or ACPI.
> >
> 
> Thanks, so the HUB's physical port number is the same with its logical port
> number which reported at its descriptor?

There's no distinction between logical and physical port numbers in
USB.  (However, there can be an issue with USB-3 root hubs, because
they may assign two different port numbers to the same physical port:
One is the port number on the LS/FS/HS bus and the other is the port
number on the SS bus.  This shouldn't cause any problems.)

>  If we assumed all HUBs follow it,
> then we can use port number to align the devices which we described at
> DT and detected by USB bus.

Yes.

> If the host controller has DT supported, and there are two ports connects
> two different onboard devices. When the device is found by the bus,
> we will know its portnum and parent (see usb_alloc_dev), and we know parent's
> device node, so we will know two children node by iterate its parent,
> and match its port number
> (property "reg" at below dts node) with udev->portnum we assigned at
> usb_alloc_dev.
> Then we can let the device know DT.
> 
> After USB device knows DT, it can handle DT properties at its driver.
> 
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -494,6 +494,8 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
>         dev->portnum = port1;
>         dev->bus = bus;
>         dev->parent = parent;
> +       if (parent->of_node)
> +               dev->dev->of_node = find_node_by_bus(parent->of_node,
> dev->portnum);

That's right, except you should also handle the case where parent is 
NULL (a root hub).

>         INIT_LIST_HEAD(&dev->filelist);
> 
> 
> &usbh1 {
>         vbus-supply = <&reg_usb_h1_vbus>;
>         status = "okay";
> 
>         devices-pre-operation = <&usbh1_pre_operation>
> 
>         #address-cells = <1>;
>         #size-cells = <0>;
>         usb: usb_mfd2415 at 01 {
>                 compatible = "usb multi-device";
>                 reg = <0x01>;
>                 clocks = <&clks IMX6QDL_CLK_CKO>;
>                 reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
>                 reset-duration-us = <3000>;
>                 gpio-controller;
>                 #gpio-cells = <2>;
>         };
> 
>         usb: usb_mfd2415 at 02 {
>                 compatible = "usb multi-device";
>                 reg = <0x02>;
>                 clocks = <&clks IMX6QDL_CLK_CKO2>;
>                 reset-gpios = <&gpio7 13 GPIO_ACTIVE_LOW>;
>                 reset-duration-us = <3000>;
>                 gpio-controller;
>                 #gpio-cells = <2>;
>         };
> };

I'll leave this for the DT experts to discuss.  However, it's worth 
pointing out that a similar scheme should work for ACPI.

Alan Stern
