From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Fri, 25 May 2012 19:05:28 +0530
Subject: [RFC PATCH 07/11] mfd: omap: control: usb-phy: introduce the
 ctrl-module usb driver
In-Reply-To: <1337934361-1606-8-git-send-email-eduardo.valentin@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-8-git-send-email-eduardo.valentin@ti.com>
Message-ID: <CAM=Q2cviCqTLoPKeNrtMbJaiOKxovAM4KMw+jrsg0qWNsYm63w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Edurardo,
A few doubts,

On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> Created a new platform driver for the platform device created by the
> control module mfd core, wrt usb. This driver has API's to power on/off
> the phy and the API's to write to musb mailbox.
>
> (p.s. the mailbox for musb in omap4 is present in system control
> module)
>
> [kishon at ti.com: wrote the original API's related to USB functions]
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
> ?drivers/usb/otg/Kconfig ? ? ? ? ? | ? 13 ++++
> ?drivers/usb/otg/Makefile ? ? ? ? ?| ? ?1 +
> ?drivers/usb/otg/omap4-usb-phy.c ? | ?130 +++++++++++++++++++++++++++++++++++++
> ?include/linux/usb/omap4_usb_phy.h | ? 53 +++++++++++++++
> ?4 files changed, 197 insertions(+), 0 deletions(-)
> ?create mode 100644 drivers/usb/otg/omap4-usb-phy.c
> ?create mode 100644 include/linux/usb/omap4_usb_phy.h
>
> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
> index 5c87db0..e2840f1 100644
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -78,6 +78,19 @@ config TWL6030_USB
> ? ? ? ? ?are hooked to this driver through platform_data structure.
> ? ? ? ? ?The definition of internal PHY APIs are in the mach-omap2 layer.
>
> +config OMAP4_USB_PHY
> + ? ? ? tristate "Texas Instruments OMAP4+ USB pin control driver"
> + ? ? ? depends on MFD_OMAP_CONTROL
> + ? ? ? help
> + ? ? ? ? If you say yes here you get support for the Texas Instruments
> + ? ? ? ? OMAP4+ USB pin control driver. The register set is part of system
> + ? ? ? ? control module.
> +
> + ? ? ? ? USB phy in OMAP configures control module register for powering on
> + ? ? ? ? the phy, configuring VBUSVALID, AVALID, IDDIG and SESSEND. For
> + ? ? ? ? performing the above mentioned configuration, API's are added in
> + ? ? ? ? by this children of the control module driver.
> +
> ?config NOP_USB_XCEIV
> ? ? ? ?tristate "NOP USB Transceiver Driver"
> ? ? ? ?select USB_OTG_UTILS
> diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
> index 41aa509..60c8c83 100644
> --- a/drivers/usb/otg/Makefile
> +++ b/drivers/usb/otg/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_USB_GPIO_VBUS) ? += gpio_vbus.o
> ?obj-$(CONFIG_ISP1301_OMAP) ? ? += isp1301_omap.o
> ?obj-$(CONFIG_TWL4030_USB) ? ? ?+= twl4030-usb.o
> ?obj-$(CONFIG_TWL6030_USB) ? ? ?+= twl6030-usb.o
> +obj-$(CONFIG_OMAP4_USB_PHY) ? ?+= omap4-usb-phy.o
> ?obj-$(CONFIG_NOP_USB_XCEIV) ? ?+= nop-usb-xceiv.o
> ?obj-$(CONFIG_USB_ULPI) ? ? ? ? += ulpi.o
> ?obj-$(CONFIG_USB_ULPI_VIEWPORT) ? ? ? ?+= ulpi_viewport.o
> diff --git a/drivers/usb/otg/omap4-usb-phy.c b/drivers/usb/otg/omap4-usb-phy.c
> new file mode 100644
> index 0000000..a29ea45
> --- /dev/null
> +++ b/drivers/usb/otg/omap4-usb-phy.c
> @@ -0,0 +1,130 @@
> +/*
> + * OMAP4 system control module driver, USB control children
> + *
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * Contact:
> + * ? ?Kishon Vijay Abraham I <kishon@ti.com>
> + * ? ?Eduardo Valentin <eduardo.valentin@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/omap_control.h>
> +#include <linux/usb/omap4_usb_phy.h>
> +
> +/**
> + * omap4_usb_phy_power - power on/off the phy using control module reg
> + * @dev: struct device *
> + * @on: 0 or 1, based on powering on or off the PHY
Could it be bool ?

> + *
> + * omap_usb2 can call this API to power on or off the PHY.
> + */
> +int omap4_usb_phy_power(struct device *dev, int on)
> +{
> + ? ? ? u32 val;
> + ? ? ? int ret;
> +
> + ? ? ? if (on) {
> + ? ? ? ? ? ? ? ret = omap_control_readl(dev, CONTROL_DEV_CONF, &val);
> + ? ? ? ? ? ? ? if (!ret && (val & PHY_PD)) {
> + ? ? ? ? ? ? ? ? ? ? ? ret = omap_control_writel(dev, ~PHY_PD,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? CONTROL_DEV_CONF);
> + ? ? ? ? ? ? ? ? ? ? ? /* XXX: add proper documentation for this delay */
> + ? ? ? ? ? ? ? ? ? ? ? mdelay(200);
Also  does it have to be a busy one?
