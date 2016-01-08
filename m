From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 8 Jan 2016 08:32:45 -0600
Subject: [RFC PATCH 1/2] USB: core: let USB device know device node
In-Reply-To: <1452231864-11171-2-git-send-email-peter.chen@freescale.com>
References: <1452231864-11171-1-git-send-email-peter.chen@freescale.com>
 <1452231864-11171-2-git-send-email-peter.chen@freescale.com>
Message-ID: <CAL_JsqKwATxGiqJ_MNV6_pur1dUEVOzH+iB8yY+kWA0y2gWbNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 11:44 PM, Peter Chen <peter.chen@freescale.com> wrote:
> Although most of USB devices are hot-plug's, there are still some devices
> are hard wired on the board, eg, for HSIC and SSIC interface USB devices.
> If these kinds of USB devices are multiple functions, and they can supply
> other interfaces like i2c, gpios for other devices, we may need to
> descirbe these at device tree.
>
> In this commit, it uses "reg" in dts as port number to match the port
> number decided by USB core, if they are the same, then the device node
> is for the device we are creating for USB core.
>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  .../devicetree/bindings/usb/usb-device.txt         |  8 ++++
>  drivers/usb/core/Makefile                          |  2 +-
>  drivers/usb/core/of.c                              | 48 ++++++++++++++++++++++
>  drivers/usb/core/usb.c                             |  8 +++-
>  include/linux/usb.h                                |  2 +
>  include/linux/usb/of.h                             |  6 +++
>  6 files changed, 71 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-device.txt
>  create mode 100644 drivers/usb/core/of.c
>
> diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
> new file mode 100644
> index 0000000..d35facd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> @@ -0,0 +1,8 @@
> +Generic USB Device Properties
> +
> +Usually, we only use device tree for hard wired USB device.
> +The reference binding doc is from:
> +http://playground.sun.com/1275/bindings/usb/usb-1_0.ps.

This path doesn't exist anymore. Use
http://www.firmware.org/1275/bindings/usb/usb-1_0.ps

> +
> +Required properties:
> +- reg: the port number which this device is connecting to.

At least compatible should also be here.

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
>  usbcore-$(CONFIG_PCI)          += hcd-pci.o
>  usbcore-$(CONFIG_ACPI)         += usb-acpi.o
> diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
> new file mode 100644
> index 0000000..008ae6a
> --- /dev/null
> +++ b/drivers/usb/core/of.c
> @@ -0,0 +1,48 @@
> +/*
> + * of.c                The helpers for hcd device tree support
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
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/of.h>
> +
> +/**
> + * usb_of_find_node - Find the device node match port number
> + * @dev: the parent device node
> + * @portnum: the port number which device is connecting
> + *
> + * Find the node from device tree according to its port number.
> + *
> + * Return: On success, a pointer to the device node, %NULL on failure.
> + */
> +struct device_node *usb_of_find_node(struct device_node *parent, int portnum)
> +{
> +       struct device_node *node;
> +       u32 port;
> +
> +       for_each_child_of_node(parent, node) {
> +               if (!of_property_read_u32(node, "reg", &port)) {
> +                       if (port == portnum)
> +                               return node;

This needs to match on the compatible string too. Otherwise, this
could match in lots of cases.

> +               }
> +       }
> +
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(usb_of_find_node);
> +
