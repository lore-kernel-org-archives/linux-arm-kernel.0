From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 11:21:43 +0300
Subject: [PATCH v2 3/5] USB: OMAP1: OTG controller driver
In-Reply-To: <1371389712-29516-4-git-send-email-aaro.koskinen@iki.fi>
References: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
 <1371389712-29516-4-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20130618082143.GE5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 04:35:10PM +0300, Aaro Koskinen wrote:
> Transceivers need to manage OTG controller state on OMAP1 to enable
> switching between peripheral and host modes. Provide a driver for that.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/usb/phy/Kconfig        |  10 +++
>  drivers/usb/phy/Makefile       |   1 +
>  drivers/usb/phy/phy-omap-otg.c | 171 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 182 insertions(+)
>  create mode 100644 drivers/usb/phy/phy-omap-otg.c
> 
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index 7ef3eb8..14a50bd 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -135,6 +135,16 @@ config USB_GPIO_VBUS
>  	  optionally control of a D+ pullup GPIO as well as a VBUS
>  	  current limit regulator.
>  
> +config OMAP_OTG
> +	tristate "OMAP USB OTG controller driver"
> +	depends on ARCH_OMAP_OTG && EXTCON
> +	help
> +	  Enable this to support some transceivers on OMAP1 platforms. OTG
> +	  controller is needed to switch between host and peripheral modes.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called omap-otg.
> +
>  config USB_ISP1301
>  	tristate "NXP ISP1301 USB transceiver support"
>  	depends on USB || USB_GADGET
> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
> index a9169cb..c7f391b 100644
> --- a/drivers/usb/phy/Makefile
> +++ b/drivers/usb/phy/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ISP1301_OMAP)		+= phy-isp1301-omap.o
>  obj-$(CONFIG_MV_U3D_PHY)		+= phy-mv-u3d-usb.o
>  obj-$(CONFIG_NOP_USB_XCEIV)		+= phy-nop.o
>  obj-$(CONFIG_OMAP_CONTROL_USB)		+= phy-omap-control.o
> +obj-$(CONFIG_OMAP_OTG)			+= phy-omap-otg.o
>  obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
>  obj-$(CONFIG_OMAP_USB3)			+= phy-omap-usb3.o
>  obj-$(CONFIG_SAMSUNG_USBPHY)		+= phy-samsung-usb.o
> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
> new file mode 100644
> index 0000000..2a8c674
> --- /dev/null
> +++ b/drivers/usb/phy/phy-omap-otg.c
> @@ -0,0 +1,171 @@
> +/*
> + * OMAP OTG controller driver
> + *
> + * Based on code from tahvo-usb.c and isp1301_omap.c drivers.
> + *
> + * Copyright (C) 2005-2006 Nokia Corporation
> + * Copyright (C) 2004 Texas Instruments
> + * Copyright (C) 2004 David Brownell
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/extcon.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/usb-omap1.h>
> +
> +#include <mach/usb.h>

no mach/* includes under drivers/usb, sorry. It's a pain to fix those up
later.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/c0767acf/attachment.sig>
