From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 9 Dec 2015 16:14:01 +0800
Subject: [PATCH 1/3] usb: misc: generic_onboard_hub: add generic onboard
 USB HUB driver
In-Reply-To: <2642877.CRz9VDfcGT@wuerfel>
References: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
 <1449538670-7954-2-git-send-email-peter.chen@freescale.com>
 <2642877.CRz9VDfcGT@wuerfel>
Message-ID: <20151209081400.GC941@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 10:48:28AM +0100, Arnd Bergmann wrote:
> On Tuesday 08 December 2015 09:37:48 Peter Chen wrote:
> 
> > +struct usb_hub_generic_data {
> > +	struct clk *clk;
> > +};
> > +
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
> 
> Let's not worry about the !DT case until someone adds a board file
> that needs it. Just remove the if() here along and the whole else
> block.
> 
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
> 
> Build error when CONFIG_OF is disabled: Please remove the #ifdef around the device
> table.
> 
> > diff --git a/include/linux/usb/generic_onboard_hub.h b/include/linux/usb/generic_onboard_hub.h
> > new file mode 100644
> > index 0000000..1b70ccc
> > --- /dev/null
> > +++ b/include/linux/usb/generic_onboard_hub.h
> > @@ -0,0 +1,11 @@
> > +#ifndef __LINUX_USB_GENERIC_HUB_H
> > +#define __LINUX_USB_GENERIC_HUB_H
> > +
> > +struct usb_hub_generic_platform_data {
> > +	int gpio_reset;
> > +	int gpio_reset_polarity;
> > +	int gpio_reset_duration_us;
> > +	struct clk *ext_clk;
> > +};
> 
> Merge this structure into struct usb_hub_generic_data and remove the header.
> 
> 	ARnd

Agree.

-- 

Best Regards,
Peter Chen
