From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Apr 2011 19:42:44 +0200
Subject: [PATCH v2 1/2] ARM: mxc: Introduce imx_add_gpio_leds
In-Reply-To: <20110404171927.GG7285@pengutronix.de>
References: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
	<20110404171927.GG7285@pengutronix.de>
Message-ID: <20110404174244.GH13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 07:19:27PM +0200, Sascha Hauer wrote:
> On Mon, Apr 04, 2011 at 02:06:45PM -0300, Fabio Estevam wrote:
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >  arch/arm/plat-mxc/devices/Kconfig               |    3 +++
> >  arch/arm/plat-mxc/devices/Makefile              |    1 +
> >  arch/arm/plat-mxc/devices/platform-gpio_leds.c  |   22 ++++++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/devices-common.h |    4 ++++
> >  4 files changed, 30 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/plat-mxc/devices/platform-gpio_leds.c
> > 
> > diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
> > index b9ab1d5..3d4f63c 100644
> > --- a/arch/arm/plat-mxc/devices/Kconfig
> > +++ b/arch/arm/plat-mxc/devices/Kconfig
> > @@ -13,6 +13,9 @@ config IMX_HAVE_PLATFORM_GPIO_KEYS
> >  	bool
> >  	default y if SOC_IMX51
> >  
> > +config IMX_HAVE_PLATFORM_GPIO_LEDS
> > +	bool
> > +
> >  config IMX_HAVE_PLATFORM_IMX21_HCD
> >  	bool
> >  	
> > diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
> > index 75cd2ec..ceefca6 100644
> > --- a/arch/arm/plat-mxc/devices/Makefile
> > +++ b/arch/arm/plat-mxc/devices/Makefile
> > @@ -2,6 +2,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
> >  obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
> >  obj-$(CONFIG_IMX_HAVE_PLATFORM_FSL_USB2_UDC) += platform-fsl-usb2-udc.o
> >  obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS) += platform-gpio_keys.o
> > +obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_LEDS) += platform-gpio_leds.o
> >  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX21_HCD) += platform-imx21-hcd.o
> >  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
> >  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMXDI_RTC) += platform-imxdi_rtc.o
> > diff --git a/arch/arm/plat-mxc/devices/platform-gpio_leds.c b/arch/arm/plat-mxc/devices/platform-gpio_leds.c
> > new file mode 100644
> > index 0000000..a430213
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/devices/platform-gpio_leds.c
> > @@ -0,0 +1,22 @@
> > +/*
> > + * Copyright (C) 2011 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version 2
> > + * of the License, or (at your option) any later version.
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +#include <asm/sizes.h>
> > +#include <mach/hardware.h>
> > +#include <mach/devices-common.h>
> > +
> > +struct platform_device *__init imx_add_gpio_leds(
> > +		 const struct gpio_led_platform_data *pdata)
> > +{
> > +	return imx_add_platform_device("leds-gpio", -1, NULL,
> > +		 0, pdata, sizeof(*pdata));
> > +}
> 
> Does this really make sense? There's nothing imx specific in this
> function, so it shouldn't be named imx_* and it shouldn't be under
> plat-mxc. Also, any user of imx_add_gpio_leds could call
> platform_device_register_resndata instead.
hmm, as long as the function lives in plat-mxc it's IMHO even required
to be named imx_*. But other than that, you're obivously right.
(Well, the central approach would assert that only one instance of
"leds-gpio" is used. But that alone probably isn't worth the
optimisation.)

The mechanims could be made a bit more aggressive by something like
that:

	struct gpio_led_platform_data *_pdata = *pdata;
	_pdata->leds = kmemdup(pdata->leds, pdata->num_leds * sizeof(*pdata->leds), GFP_KERNEL)
	if (!_pdata->leds)
		return ...

	ret = imx_add_platform_device("leds-gpio", -1, NULL, 0, _pdata, sizeof(_pdata));
	if (IS_ERR(ret))
		kfree(_pdata->leds);

	return PTR_RET(ret);

This would allow to have the struct gpio_led array in init memory, too.

Is it worth the effort?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
