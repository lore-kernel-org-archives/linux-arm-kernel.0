From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 4 Apr 2011 19:19:27 +0200
Subject: [PATCH v2 1/2] ARM: mxc: Introduce imx_add_gpio_leds
In-Reply-To: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
References: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110404171927.GG7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 02:06:45PM -0300, Fabio Estevam wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/plat-mxc/devices/Kconfig               |    3 +++
>  arch/arm/plat-mxc/devices/Makefile              |    1 +
>  arch/arm/plat-mxc/devices/platform-gpio_leds.c  |   22 ++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/devices-common.h |    4 ++++
>  4 files changed, 30 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/devices/platform-gpio_leds.c
> 
> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
> index b9ab1d5..3d4f63c 100644
> --- a/arch/arm/plat-mxc/devices/Kconfig
> +++ b/arch/arm/plat-mxc/devices/Kconfig
> @@ -13,6 +13,9 @@ config IMX_HAVE_PLATFORM_GPIO_KEYS
>  	bool
>  	default y if SOC_IMX51
>  
> +config IMX_HAVE_PLATFORM_GPIO_LEDS
> +	bool
> +
>  config IMX_HAVE_PLATFORM_IMX21_HCD
>  	bool
>  	
> diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
> index 75cd2ec..ceefca6 100644
> --- a/arch/arm/plat-mxc/devices/Makefile
> +++ b/arch/arm/plat-mxc/devices/Makefile
> @@ -2,6 +2,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_FSL_USB2_UDC) += platform-fsl-usb2-udc.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS) += platform-gpio_keys.o
> +obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_LEDS) += platform-gpio_leds.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX21_HCD) += platform-imx21-hcd.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMXDI_RTC) += platform-imxdi_rtc.o
> diff --git a/arch/arm/plat-mxc/devices/platform-gpio_leds.c b/arch/arm/plat-mxc/devices/platform-gpio_leds.c
> new file mode 100644
> index 0000000..a430213
> --- /dev/null
> +++ b/arch/arm/plat-mxc/devices/platform-gpio_leds.c
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <asm/sizes.h>
> +#include <mach/hardware.h>
> +#include <mach/devices-common.h>
> +
> +struct platform_device *__init imx_add_gpio_leds(
> +		 const struct gpio_led_platform_data *pdata)
> +{
> +	return imx_add_platform_device("leds-gpio", -1, NULL,
> +		 0, pdata, sizeof(*pdata));
> +}

Does this really make sense? There's nothing imx specific in this
function, so it shouldn't be named imx_* and it shouldn't be under
plat-mxc. Also, any user of imx_add_gpio_leds could call
platform_device_register_resndata instead.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
