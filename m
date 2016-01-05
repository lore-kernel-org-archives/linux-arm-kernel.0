From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 5 Jan 2016 08:36:31 -0600
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <CAL411-qKE=12VZAN9=tUWPqkC5BfSgpQb9aNgCU6rmPLasXNHQ@mail.gmail.com>
References: <CAL411-rK6qfkbQsSjvXH5VPAQAm4tMyD6fVTEgFQrpLHNGMXeA@mail.gmail.com>
 <Pine.LNX.4.44L0.1512181030590.1682-100000@iolanthe.rowland.org>
 <CAL411-qKE=12VZAN9=tUWPqkC5BfSgpQb9aNgCU6rmPLasXNHQ@mail.gmail.com>
Message-ID: <CAL_Jsq+P8SBmWzNURrmNgz8soCn4QPOPid4SXF0a3TYL_SH27A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 2:33 AM, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Fri, Dec 18, 2015 at 11:38 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> On Fri, 18 Dec 2015, Peter Chen wrote:
>>
>>> On Fri, Dec 18, 2015 at 12:13 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>>
>>> > It's not clear (to me, anyway) how this is meant to work.  USB is a
>>> > completely discoverable bus: There is no way to represent devices
>>> > statically; they have to be discovered.  But a device can't be
>>> > discovered unless it is functional, so if an onboard hub (or any other
>>> > sort of USB device) requires power, clocks, or something similar in
>>> > order to function, it won't be discovered.  There won't be any device
>>> > structure to probe, and "forcing driver probe" won't accomplish
>>> > anything.
>>> >
>>> > It seems to me that the only way something like this could be made to
>>> > work is if the necessary actions are keyed off the host controller (and
>>> > in particular, _not_ the hub driver), presumably at the time the
>>> > controller is probed.

The problem with putting this in the the host controller driver is it
assumes the initialization sequence is generic enough to be described
in DT and that initialization is the only time we need DT data. The
MFD example is a perfect example of another case. Suspend/resume also
comes to mind. Even if we could put the control in both places, that
is poor design IMO. I'd rather just make it a requirement that the
bootloader do enough setup that devices can be discovered.

[...]

>>> +static int hub_of_children_register(struct usb_device *hdev)
>>> +{
>>> +     struct device *dev;
>>> +
>>> +     if (hdev->parent)
>>> +             dev = &hdev->dev;
>>> +     else
>>> +             dev = bus_to_hcd(hdev->bus)->self.controller;
>>> +
>>> +     if (!dev->of_node)
>>> +             return 0;
>>
>> Suppose hdev->parent is not NULL (hdev isn't the root hub -- maybe it's
>> a 2nd-level hub).  Then how did hdev->dev->of_node get set?
>>
>
> Yes, the USB device doesn't know device node.

That should be a solvable problem...


> There are two problems which needs device tree to support, I have
> below solutions for them, please help to see if it is reasonable.
>
> 1. The USB device can't work without external clock, power, reset operation.
> At device tree, we have a node to describe external signals like clocks, gpios
> for all onboard devices under this controller. And this node is as phandle for
> host controller, see below:
>
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -108,6 +108,21 @@
>                 default-brightness-level = <7>;
>                 status = "okay";
>         };
> +
> +       usbh1_pre_operation: usbh1_pre_operation {
> +               clocks = <&clks IMX6QDL_CLK_1>,
> +                        <&clks IMX6QDL_CLK_2>,
> +                        <&clks IMX6QDL_CLK_3>,
> +                        <&clks IMX6QDL_CLK_4>,
> +                        <&clks IMX6QDL_CLK_5>,
> +                        <&clks IMX6QDL_CLK_6>;
> +               reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>,
> +                             <&gpio4 7 GPIO_ACTIVE_LOW>,
> +                             <&gpio3 25 GPIO_ACTIVE_LOW>,
> +                             <&gpio3 27 GPIO_ACTIVE_LOW>,
> +                             <&gpio4 4 GPIO_ACTIVE_LOW>,
> +                             <&gpio4 6 GPIO_ACTIVE_LOW>;
> +       };
>  };
>
>  &clks {
> @@ -590,6 +605,8 @@
>  &usbh1 {
>         vbus-supply = <&reg_usb_h1_vbus>;
>         status = "okay";
> +
> +       devices-pre-operation = <&usbh1_pre_operation>
>  };

No. The binding should reflect the hardware connections. The hub is a
child of the USB controller/root hub. so the hub node had better be a
child of the controller in the DT. The clocks and reset are
connections to the hub, so they had better be in the hub's DT node.
There is really nothing more to discuss on the binding. Anything else
you are coming up with is working around kernel issues.


> At code, we add one API of_usb_pre_operation to get clocks and gpios through
> host controller's device node, and this API is called at usb_add_hcd,
> and opposite
> operation is called at usb_remove_hcd.
>
> This solution is almost the same with MMC power sequence solution.
> (see drivers/mmc/core/pwrseq.c)
>
> 2. There are MFD USB devices, which includes several interfaces under
> USB device,
> like i2c, gpios, etc. Due to lack of device tree support, USB
> class/device driver doesn't know
> which kinds of interfaces are needed for this board.

Are you talking about a device hard wired on the same board or
something like GPIOs on FTDI chip which could be hot-plugged in any
host (including non-DT based)?

For the hotplug case, we will need a way to associate a DT overlay
with the USB device and there may not even be a base DT to map the
overlay into. In this case, the USB device's driver will need to load
the overlay and trigger enumerating the child devices. Anyway, this is
a separate issue from your problem.

Rob
