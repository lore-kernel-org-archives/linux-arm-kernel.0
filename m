From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 15 Jan 2016 18:07:10 +0100
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <1452849447-25025-1-git-send-email-peter.chen@freescale.com>
References: <1452849447-25025-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1452877630.6067.97.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 15.01.2016, 17:17 +0800 schrieb Peter Chen:
> Although most of USB devices are hot-plug's, there are still some devices
> are hard wired on the board, eg, for HSIC and SSIC interface USB devices.
> If these kinds of USB devices are multiple functions, and they can supply
> other interfaces like i2c, gpios for other devices, we may need to
> describe these at device tree.
> 
> In this commit, it uses "reg" in dts as port number to match the port
> number decided by USB core, if they are the same, then the device node
> is for the device we are creating for USB core.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
> Changes for v3:
> - typo: s/descirbe/describe/
> 
> Changes for v2:
> - Fix build error reported by kbuild robot, lack of "static" for
>   inline usb_of_get_child_node  
> - Fix typo, "devcie_node" -> "device_node"
> - Add kernel-doc for of_node at struct usb_device
> 
> Changes from RFC:
> - Fix the error address for binding doc, and add compatible for binding doc
> - Change get child node API from "usb_of_find_node" to
>     "usb_of_get_child_node"
> - Delete unecessary header files
> - One typo
> 
>  .../devicetree/bindings/usb/usb-device.txt         | 17 ++++++++
>  drivers/usb/core/Makefile                          |  2 +-
>  drivers/usb/core/of.c                              | 47 ++++++++++++++++++++++
>  drivers/usb/core/usb.c                             |  8 +++-
>  include/linux/usb.h                                |  3 ++
>  include/linux/usb/of.h                             |  7 ++++
>  6 files changed, 81 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-device.txt
>  create mode 100644 drivers/usb/core/of.c
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
> new file mode 100644
> index 0000000..0468834
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> @@ -0,0 +1,17 @@
> +Generic USB Device Properties
> +
> +Usually, we only use device tree for hard wired USB device.
> +The reference binding doc is from:
> +http://www.firmware.org/1275/bindings/usb/usb-1_0.ps
> +
> +Required properties:
> +- compatible: usbVID,PID

According to the binding doc that could be any of:
1) usbVID,PID.REV.configCN
2) usbVID,PID.REV
3) usbVID,PID.configCN
4) usbVID,PID
5) usbVID,classDC.DSC.DPROTO
6) usbVID,classDC.DSC
7) usbVID,classDC
8) usb,classDC.DSC.DPROTO
9) usb,classDC.DSC
10) usb,classDC
11) usb,device

> +- reg: the port number which this device is connecting to.

Should it be noted here that the port number range is 1-255?

> +
> +
> +Example:
> +
> +hub: genesys at 01 {

According to the referenced document, the address representation should
be "hexadecimal with leading zeroes suppressed".

> +	compatible = "usb05e3,0608";
> +	reg = <0x01>;
> +};
> diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
> index 2f6f932..9780877 100644
> --- a/drivers/usb/core/Makefile
> +++ b/drivers/usb/core/Makefile
> @@ -5,7 +5,7 @@
>  usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
>  usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
>  usbcore-y += devio.o notify.o generic.o quirks.o devices.o
> -usbcore-y += port.o
> +usbcore-y += port.o of.o
>  
>  usbcore-$(CONFIG_PCI)		+= hcd-pci.o
>  usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
> diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
> new file mode 100644
> index 0000000..2289700
> --- /dev/null
> +++ b/drivers/usb/core/of.c
> @@ -0,0 +1,47 @@
> +/*
> + * of.c		The helpers for hcd device tree support
> + *
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Author: Peter Chen <peter.chen@freescale.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2  of
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/of.h>
> +
> +/**
> + * usb_of_get_child_node - Find the device node match port number
> + * @parent: the parent device node
> + * @portnum: the port number which device is connecting
> + *
> + * Find the node from device tree according to its port number.
> + *
> + * Return: On success, a pointer to the device node, %NULL on failure.
> + */
> +struct device_node *usb_of_get_child_node(struct device_node *parent,
> +					int portnum)
> +{
> +	struct device_node *node;
> +	u32 port;
> +
> +	for_each_child_of_node(parent, node) {
> +		if (!of_property_read_u32(node, "reg", &port)) {
> +			if (port == portnum)
> +				return node;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(usb_of_get_child_node);
> +
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 77e4c9b..64c094e 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -36,6 +36,7 @@
>  #include <linux/mutex.h>
>  #include <linux/workqueue.h>
>  #include <linux/debugfs.h>
> +#include <linux/usb/of.h>
>  
>  #include <asm/io.h>
>  #include <linux/scatterlist.h>
> @@ -502,11 +503,14 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
>  	dev->connect_time = jiffies;
>  	dev->active_duration = -jiffies;
>  #endif
> -	if (root_hub)	/* Root hub always ok [and always wired] */
> +	if (root_hub) {	/* Root hub always ok [and always wired] */
>  		dev->authorized = 1;
> -	else {
> +		dev->of_node = bus->controller->of_node;

Why can't the root_hub reuse dev->dev.of_node?

regards
Philipp
