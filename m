From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 21 Dec 2015 14:40:42 -0500 (EST)
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <CAL411-qKE=12VZAN9=tUWPqkC5BfSgpQb9aNgCU6rmPLasXNHQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1512211436030.1618-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Dec 2015, Peter Chen wrote:

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
> 
> At code, we add one API of_usb_pre_operation to get clocks and gpios through
> host controller's device node, and this API is called at usb_add_hcd,
> and opposite
> operation is called at usb_remove_hcd.
> 
> This solution is almost the same with MMC power sequence solution.
> (see drivers/mmc/core/pwrseq.c)

That seems reasonable to me.

> 2. There are MFD USB devices, which includes several interfaces under
> USB device,
> like i2c, gpios, etc. Due to lack of device tree support, USB
> class/device driver doesn't know
> which kinds of interfaces are needed for this board.
> 
> This problem is hard to handle, I have a solution, but it can't cover
> two same devices
> under the same HUB ports. My solution is let USB know device node, the main idea
> is similar with PCIi's (see drivers/of/of_pci.c, drivers/pci/of.c),
> the most difficulty is
> find correct node for USB device after bus enumeration. Once the
> device is recognized,
> the USB core will create a USB device for it, since we know its parent
> device, and its parent
> device  (eg, the host controller) has device node, and we can find all
> children nodes under
> this node, if the child's {vid, pid} is the same with {vid, pid} the
> device descriptor we read, we
> assign this node as usb device's node.

I don't really understand this.  However, you can always specify a USB 
device by giving its port number on the parent hub, and the hub's port 
number on _its_ parent hub, and so on back to the root hub and host 
controller.  That works even if you're not using DT or OF or ACPI.

Alan Stern

> At USB class/device driver, we can get the properties/phandles under
> this device node, and register
> them.
> 
> At device tree, we need to describe the bus topology for this USB device.
