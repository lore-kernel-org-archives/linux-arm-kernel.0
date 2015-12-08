From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 8 Dec 2015 17:18:55 +0800
Subject: [PATCH 1/3] usb: misc: generic_onboard_hub: add generic onboard
 USB HUB driver
In-Reply-To: <87poyhmyrc.fsf@saruman.tx.rr.com>
References: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
 <1449538670-7954-2-git-send-email-peter.chen@freescale.com>
 <87poyhmyrc.fsf@saruman.tx.rr.com>
Message-ID: <20151208091854.GA16881@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 08:59:19PM -0600, Felipe Balbi wrote:
> 
> Hi,
> 
> Peter Chen <peter.chen@freescale.com> writes:
> > diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> > index 45fd4ac..da52e9a 100644
> > --- a/drivers/usb/misc/Makefile
> > +++ b/drivers/usb/misc/Makefile
> > @@ -29,3 +29,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
> >  
> >  obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
> >  obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
> > +obj-$(CONFIG_USB_ONBOARD_HUB)		+= generic_onboard_hub.o
> > diff --git a/drivers/usb/misc/generic_onboard_hub.c b/drivers/usb/misc/generic_onboard_hub.c
> > new file mode 100644
> > index 0000000..df722a0
> > --- /dev/null
> > +++ b/drivers/usb/misc/generic_onboard_hub.c
> > @@ -0,0 +1,162 @@
> > +/*
> > + * usb_hub_generic.c	The generic onboard USB HUB driver
> > + *
> > + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> > + * Author: Peter Chen <peter.chen@freescale.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2  of
> > + * the License as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +/*
> > + * This driver is only for the USB HUB devices which need to control
> > + * their external pins(clock, reset, etc), and these USB HUB devices
> > + * are soldered at the board.
> > + */
> > +
> > +#define DEBUG
> 
> nope
> 

Will change.

> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +#include <linux/usb/generic_onboard_hub.h>
> 
> <linux/platform_data/generic_onboard_hub.h> ?
> 

Yes, you are right, I did not know it

> > +struct usb_hub_generic_data {
> > +	struct clk *clk;
> 
> seriously ? Is this really all ? What about that reset line below ?

The clock is PHY input clock on the HUB, this clock may from SoC's PLL.
> 
> In fact, that reset line should be using a generic reset-gpio.c instead
> of a raw gpio.
> 

This reset gpio is not at mainline, I don't know what's reason

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186693.html

Philipp, do you know the reason?

> > +static int usb_hub_generic_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct usb_hub_generic_platform_data *pdata = dev->platform_data;
> > +	struct usb_hub_generic_data *hub_data;
> > +	int reset_pol = 0, duration_us = 50, ret = 0;
> > +	struct gpio_desc *gpiod_reset = NULL;
> > +
> > +	hub_data = devm_kzalloc(dev, sizeof(*hub_data), GFP_KERNEL);
> > +	if (!hub_data)
> > +		return -ENOMEM;
> > +
> > +	if (dev->of_node) {
> > +		struct device_node *node = dev->of_node;
> > +
> > +		hub_data->clk = devm_clk_get(dev, "external_clk");
> > +		if (IS_ERR(hub_data->clk)) {
> > +			dev_dbg(dev, "Can't get external clock: %ld\n",
> > +					PTR_ERR(hub_data->clk));
> 
> how about setting clock to NULL to here ? then you don't need IS_ERR()
> checks anywhere else.
> 
> > +		}
> 
> braces shouldn't be used here, if you add NULL trick above,
> however... then you can keep them.
> 

Braces aren't needed, it may not too much useful to using NULL
as a indicator for error pointer.

> > +		/*
> > +		 * Try to get the information for HUB reset, the
> > +		 * default setting like below:
> > +		 *
> > +		 * - Reset state is low
> > +		 * - The duration is 50us
> > +		 */
> > +		if (of_find_property(node, "hub-reset-active-high", NULL))
> > +			reset_pol = 1;
> 
> you see, this is definitely *not* generic. You should write a generic
> reset-gpio.c reset controller and describe the polarity on the gpio
> binding. This driver *always* uses reset_assert(); reset_deassert(); and
> reset-gpio implements though by gpiod_set_value() correctly.
> 
> Polarity _must_ be described elsewhere in DT.
> 
> > +		of_property_read_u32(node, "hub-reset-duration-us",
> > +			&duration_us);
> 
> likewise, this should be described as a debounce time for the GPIO.
> 

Yes, if we are a reset gpio driver.

> > +		gpiod_reset = devm_gpiod_get_optional(dev, "hub-reset",
> > +			reset_pol ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
> > +		ret = PTR_ERR_OR_ZERO(gpiod_reset);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to get reset gpio, err = %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +	} else if (pdata) {
> > +		hub_data->clk = pdata->ext_clk;
> > +		duration_us = pdata->gpio_reset_duration_us;
> > +		reset_pol = pdata->gpio_reset_polarity;
> > +
> > +		if (gpio_is_valid(pdata->gpio_reset)) {
> > +			ret = devm_gpio_request_one(
> > +				dev, pdata->gpio_reset, reset_pol
> > +				? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
> > +				dev_name(dev));
> > +			if (!ret)
> > +				gpiod_reset = gpio_to_desc(pdata->gpio_reset);
> > +		}
> > +	}
> > +
> > +	if (!IS_ERR(hub_data->clk)) {
> > +		ret = clk_prepare_enable(hub_data->clk);
> > +		if (ret) {
> > +			dev_err(dev,
> > +				"Can't enable external clock: %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	if (gpiod_reset) {
> > +		/* Sanity check */
> > +		if (duration_us > 1000000)
> > +			duration_us = 50;
> 
> this check makes no sense whatsoever. What I *really* need over 1s of
> debounce ?

Ok, I will delete this check.

> 
> > +		usleep_range(duration_us, duration_us + 100);
> > +		gpiod_set_value(gpiod_reset, reset_pol ? 0 : 1);
> 
> wrong. You should _not_ have polarity checks here. You should have
> already initialized the gpio as ACTIVE_HIGH or ACTIVE_LOW and gpiolib
> will handle the polarity for you.

Yes, you are right. I did not understand ACTIVE_LOW for gpio flag
before.

> 
> > +	}
> > +
> > +	dev_set_drvdata(dev, hub_data);
> > +	return ret;
> > +}
> > +
> > +static int usb_hub_generic_remove(struct platform_device *pdev)
> > +{
> > +	struct usb_hub_generic_data *hub_data = platform_get_drvdata(pdev);
> > +
> > +	if (!IS_ERR(hub_data->clk))
> > +		clk_disable_unprepare(hub_data->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id usb_hub_generic_dt_ids[] = {
> > +	{.compatible = "generic-onboard-hub"},
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, usb_hub_generic_dt_ids);
> > +#endif
> > +
> > +static struct platform_driver usb_hub_generic_driver = {
> > +	.probe = usb_hub_generic_probe,
> > +	.remove = usb_hub_generic_remove,
> > +	.driver = {
> > +		.name = "usb_hub_generic_onboard",
> > +		.of_match_table = usb_hub_generic_dt_ids,
> > +	 },
> > +};
> > +
> > +static int __init usb_hub_generic_init(void)
> > +{
> > +	return platform_driver_register(&usb_hub_generic_driver);
> > +}
> > +subsys_initcall(usb_hub_generic_init);
> > +
> > +static void __exit usb_hub_generic_exit(void)
> > +{
> > +	platform_driver_unregister(&usb_hub_generic_driver);
> > +}
> > +module_exit(usb_hub_generic_exit);
> 
> module_platform_driver();

I want this driver to be called before module init's.

> 
> > +MODULE_AUTHOR("Peter Chen <peter.chen@freescale.com>");
> > +MODULE_DESCRIPTION("Generic Onboard USB HUB driver");
> > +MODULE_LICENSE("GPL");
> 
> comment header says GPL v2 only, this is GPL v2+. Which is correct ?
> 

I will change it to GPL v2, thanks.


-- 

Best Regards,
Peter Chen
