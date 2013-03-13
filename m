From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 13 Mar 2013 17:43:31 +0800
Subject: [PATCH 3/9] USB: add devicetree helpers for determining
 dr_mode and phy_type
In-Reply-To: <1359984275-24646-4-git-send-email-s.hauer@pengutronix.de>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130313094330.GC18168@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 02:24:29PM +0100, Sascha Hauer wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> This adds two little devicetree helper functions for determining the
> dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
> the devicetree.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/usb/phy/Makefile |    1 +
>  drivers/usb/phy/of.c     |   47 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/usb-common.c |   36 +++++++++++++++++++++++++++++++++++
>  include/linux/usb/of.h   |   27 ++++++++++++++++++++++++++
>  include/linux/usb/otg.h  |    7 +++++++
>  include/linux/usb/phy.h  |    9 +++++++++
>  6 files changed, 127 insertions(+)
>  create mode 100644 drivers/usb/phy/of.c
>  create mode 100644 include/linux/usb/of.h
> 
> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
> index 9fa6327..e1be1e8 100644
> --- a/drivers/usb/phy/Makefile
> +++ b/drivers/usb/phy/Makefile
> @@ -5,6 +5,7 @@
>  ccflags-$(CONFIG_USB_DEBUG) := -DDEBUG
>  
>  obj-$(CONFIG_USB_OTG_UTILS)		+= phy.o
> +obj-$(CONFIG_OF)			+= of.o
>  obj-$(CONFIG_OMAP_USB2)			+= omap-usb2.o
>  obj-$(CONFIG_OMAP_USB3)			+= omap-usb3.o
>  obj-$(CONFIG_OMAP_CONTROL_USB)		+= omap-control-usb.o
> diff --git a/drivers/usb/phy/of.c b/drivers/usb/phy/of.c
> new file mode 100644
> index 0000000..e6f3b74
> --- /dev/null
> +++ b/drivers/usb/phy/of.c
> @@ -0,0 +1,47 @@
> +/*
> + * USB of helper code
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/usb/of.h>
> +#include <linux/usb/otg.h>
> +
> +static const char *usbphy_modes[] = {
> +	[USBPHY_INTERFACE_MODE_UNKNOWN]	= "",
> +	[USBPHY_INTERFACE_MODE_UTMI]	= "utmi",
> +	[USBPHY_INTERFACE_MODE_UTMIW]	= "utmi_wide",
> +	[USBPHY_INTERFACE_MODE_ULPI]	= "ulpi",
> +	[USBPHY_INTERFACE_MODE_SERIAL]	= "serial",
> +	[USBPHY_INTERFACE_MODE_HSIC]	= "hsic",
> +};
> +
> +/**
> + * of_usb_get_phy_mode - Get phy mode for given device_node
> + * @np:	Pointer to the given device_node
> + *
> + * The function gets phy interface string from property 'phy_type',
> + * and returns the correspondig enum usb_phy_interface
> + */
> +enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np)
> +{
> +	const char *phy_type;
> +	int err, i;
> +
> +	err = of_property_read_string(np, "phy_type", &phy_type);
> +	if (err < 0)
> +		return USBPHY_INTERFACE_MODE_UNKNOWN;
> +
> +	for (i = 0; i < ARRAY_SIZE(usbphy_modes); i++)
> +		if (!strcmp(phy_type, usbphy_modes[i]))
> +			return i;
> +
> +	return USBPHY_INTERFACE_MODE_UNKNOWN;
> +}
> +EXPORT_SYMBOL_GPL(of_usb_get_phy_mode);
> diff --git a/drivers/usb/usb-common.c b/drivers/usb/usb-common.c
> index d29503e..ad4d87d 100644
> --- a/drivers/usb/usb-common.c
> +++ b/drivers/usb/usb-common.c
> @@ -14,6 +14,9 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/usb/ch9.h>
> +#include <linux/of.h>
> +#include <linux/usb/of.h>
> +#include <linux/usb/otg.h>
>  
>  const char *usb_speed_string(enum usb_device_speed speed)
>  {
> @@ -32,4 +35,37 @@ const char *usb_speed_string(enum usb_device_speed speed)
>  }
>  EXPORT_SYMBOL_GPL(usb_speed_string);
>  
> +#ifdef CONFIG_OF
> +static const char *usb_dr_modes[] = {
> +	[USB_DR_MODE_UNKNOWN]		= "",
> +	[USB_DR_MODE_HOST]		= "host",
> +	[USB_DR_MODE_PERIPHERAL]	= "peripheral",
> +	[USB_DR_MODE_OTG]		= "otg",
> +};
> +
> +/**
> + * of_usb_get_dr_mode - Get dual role mode for given device_node
> + * @np:	Pointer to the given device_node
> + *
> + * The function gets phy interface string from property 'dr_mode',
> + * and returns the correspondig enum usb_dr_mode
> + */
> +enum usb_dr_mode of_usb_get_dr_mode(struct device_node *np)
> +{
> +	const char *dr_mode;
> +	int err, i;
> +
> +	err = of_property_read_string(np, "dr_mode", &dr_mode);
> +	if (err < 0)
> +		return USB_DR_MODE_UNKNOWN;
> +
> +	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
> +		if (!strcmp(dr_mode, usb_dr_modes[i]))
> +			return i;
> +
> +	return USB_DR_MODE_UNKNOWN;
> +}
> +EXPORT_SYMBOL_GPL(of_usb_get_dr_mode);
> +#endif
> +
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
> new file mode 100644
> index 0000000..4681a20
> --- /dev/null
> +++ b/include/linux/usb/of.h
> @@ -0,0 +1,27 @@
> +/*
> + * OF helpers for usb devices.
> + *
> + * This file is released under the GPLv2
> + */
> +
> +#ifndef __LINUX_USB_OF_H
> +#define __LINUX_USB_OF_H
> +
> +#include <linux/usb/phy.h>

Hi Michael,

When I use allmodconfig to build all usb module, I meet below
error. After changing #include <linux/usb/otg.h>, below
error is disappeared.

 GEN     /home/b29397/work/code/git/linus/linux-2.6/outout/all/Makefile
 scripts/kconfig/conf --allmodconfig Kconfig
#
# configuration written to .config
#
 /home/b29397/work/code/git/linus/linux-2.6/arch/x86/Makefile:92: stack protector enabled but no compiler support
 /home/b29397/work/code/git/linus/linux-2.6/arch/x86/Makefile:107: CONFIG_X86_X32 enabled but no binutils support
   GEN     /home/b29397/work/code/git/linus/linux-2.6/outout/all/Makefile
   scripts/kconfig/conf --silentoldconfig Kconfig
   /home/b29397/work/code/git/linus/linux-2.6/arch/x86/Makefile:92: stack protector enabled but no compiler support
   /home/b29397/work/code/git/linus/linux-2.6/arch/x86/Makefile:107: CONFIG_X86_X32 enabled but no binutils support
   make[2]: Nothing to be done for `all'.
     GEN     /home/b29397/work/code/git/linus/linux-2.6/outout/all/Makefile
       CHK     include/generated/uapi/linux/version.h
       make[2]: Nothing to be done for `relocs'.
         Using /home/b29397/work/code/git/linus/linux-2.6 as source for kernel
	   CHK     include/generated/utsrelease.h
	     CALL    /home/b29397/work/code/git/linus/linux-2.6/scripts/checksyscalls.sh
	       CC [M]  drivers/usb/usb-common.o
	       In file included from /home/b29397/work/code/git/linus/linux-2.6/drivers/usb/usb-common.c:18:
	       /home/b29397/work/code/git/linus/linux-2.6/include/linux/usb/of.h:22: error: return type is an incomplete type
	       /home/b29397/work/code/git/linus/linux-2.6/include/linux/usb/of.h: In function ?of_usb_get_dr_mode?:
	       /home/b29397/work/code/git/linus/linux-2.6/include/linux/usb/of.h:23: error: ?USB_DR_MODE_UNKNOWN? undeclared (first use in this function)
	/home/b29397/work/code/git/linus/linux-2.6/include/linux/usb/of.h:23: error: (Each undeclared identifier is reported only once
			/home/b29397/work/code/git/linus/linux-2.6/include/linux/usb/of.h:23: error: for each function it appears in.)
	/home/b29397/work/code/git/linus/linux-2.6/include/linux/usb/of.h:23: warning: ?return? with a value, in function returning void
	make[2]: *** [drivers/usb/usb-common.o] Error 1
	make[2]: *** Waiting for unfinished jobs....
-- 

Best Regards,
Peter Chen
