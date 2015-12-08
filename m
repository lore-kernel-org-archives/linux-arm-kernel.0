From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 8 Dec 2015 07:19:05 +0100
Subject: [PATCH 1/3] usb: misc: generic_onboard_hub: add generic onboard
 USB HUB driver
In-Reply-To: <1449538670-7954-2-git-send-email-peter.chen@freescale.com>
References: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
 <1449538670-7954-2-git-send-email-peter.chen@freescale.com>
Message-ID: <20151208061905.GM11966@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 09:37:48AM +0800, Peter Chen wrote:
> Current USB HUB driver lacks of platform interfaces to configure
> external signal on HUB chip, eg, the PHY input clock and gpio reset
> pin for HUB, these kinds of HUBs are usually soldered at the board,
> and they are not hot-plug USB devices.
> 
> With this patch, the user can configure the HUB's pins at platform
> part (through dts or platform), and these configuration will be
> effective before the USB bus can be used, we use subsys_initcall
> for this driver.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  MAINTAINERS                             |   7 ++
>  drivers/usb/misc/Kconfig                |   9 ++
>  drivers/usb/misc/Makefile               |   1 +
>  drivers/usb/misc/generic_onboard_hub.c  | 162 ++++++++++++++++++++++++++++++++
>  include/linux/usb/generic_onboard_hub.h |  11 +++
>  5 files changed, 190 insertions(+)
>  create mode 100644 drivers/usb/misc/generic_onboard_hub.c
>  create mode 100644 include/linux/usb/generic_onboard_hub.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9caa4b..cc1981e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11121,6 +11121,13 @@ S:	Maintained
>  F:	Documentation/usb/ohci.txt
>  F:	drivers/usb/host/ohci*
>  
> +USB Generic Onboard HUB Driver
> +M:	Peter Chen <Peter.Chen@freescale.com>
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
> +L:	linux-usb at vger.kernel.org
> +S:	Maintained
> +F:	drivers/usb/misc/generic_onboard_hub.c
> +
>  USB OTG FSM (Finite State Machine)
>  M:	Peter Chen <Peter.Chen@freescale.com>
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index f7a7fc2..8921cae 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -268,3 +268,12 @@ config USB_CHAOSKEY
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called chaoskey.
> +
> +config USB_ONBOARD_HUB
> +	tristate "Generic USB Onboard HUB"
> +	help
> +	  Say Y here if your board has an onboard HUB, and this hub needs
> +	  to control its PHY clock and reset pin through external signals.
> +	  If you are not sure, say N.
> +
> +	  To compile this driver as a module, choose M here.
> diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> index 45fd4ac..da52e9a 100644
> --- a/drivers/usb/misc/Makefile
> +++ b/drivers/usb/misc/Makefile
> @@ -29,3 +29,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
>  
>  obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
>  obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
> +obj-$(CONFIG_USB_ONBOARD_HUB)		+= generic_onboard_hub.o
> diff --git a/drivers/usb/misc/generic_onboard_hub.c b/drivers/usb/misc/generic_onboard_hub.c
> new file mode 100644
> index 0000000..df722a0
> --- /dev/null
> +++ b/drivers/usb/misc/generic_onboard_hub.c
> @@ -0,0 +1,162 @@
> +/*
> + * usb_hub_generic.c	The generic onboard USB HUB driver
> + *
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
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
> +/*
> + * This driver is only for the USB HUB devices which need to control
> + * their external pins(clock, reset, etc), and these USB HUB devices
> + * are soldered at the board.
> + */
> +
> +#define DEBUG
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/usb/generic_onboard_hub.h>
> +
> +struct usb_hub_generic_data {
> +	struct clk *clk;
> +};
> +
> +static int usb_hub_generic_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct usb_hub_generic_platform_data *pdata = dev->platform_data;
> +	struct usb_hub_generic_data *hub_data;
> +	int reset_pol = 0, duration_us = 50, ret = 0;
> +	struct gpio_desc *gpiod_reset = NULL;
> +
> +	hub_data = devm_kzalloc(dev, sizeof(*hub_data), GFP_KERNEL);
> +	if (!hub_data)
> +		return -ENOMEM;
> +
> +	if (dev->of_node) {
> +		struct device_node *node = dev->of_node;
> +
> +		hub_data->clk = devm_clk_get(dev, "external_clk");

Please drop such _clk suffixes. The context already makes it clear that
it's a clock.

> +		if (IS_ERR(hub_data->clk)) {
> +			dev_dbg(dev, "Can't get external clock: %ld\n",
> +					PTR_ERR(hub_data->clk));
> +		}
> +
> +		/*
> +		 * Try to get the information for HUB reset, the
> +		 * default setting like below:
> +		 *
> +		 * - Reset state is low
> +		 * - The duration is 50us
> +		 */
> +		if (of_find_property(node, "hub-reset-active-high", NULL))
> +			reset_pol = 1;
> +
> +		of_property_read_u32(node, "hub-reset-duration-us",
> +			&duration_us);
> +
> +		gpiod_reset = devm_gpiod_get_optional(dev, "hub-reset",
> +			reset_pol ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
> +		ret = PTR_ERR_OR_ZERO(gpiod_reset);
> +		if (ret) {
> +			dev_err(dev, "Failed to get reset gpio, err = %d\n",
> +				ret);
> +			return ret;
> +		}
> +	} else if (pdata) {
> +		hub_data->clk = pdata->ext_clk;

Passing clocks in platform_data is a no go. clocks must always be
retrieved with clk_get.

> +		duration_us = pdata->gpio_reset_duration_us;
> +		reset_pol = pdata->gpio_reset_polarity;
> +
> +		if (gpio_is_valid(pdata->gpio_reset)) {
> +			ret = devm_gpio_request_one(
> +				dev, pdata->gpio_reset, reset_pol
> +				? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
> +				dev_name(dev));
> +			if (!ret)
> +				gpiod_reset = gpio_to_desc(pdata->gpio_reset);

If the gpio is valid then being unable to get it is an error.

Do you need this platform_data stuff at all?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
