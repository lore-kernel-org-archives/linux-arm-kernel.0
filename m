From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 5 Apr 2011 11:41:03 -0500
Subject: [PATCH v2 1/2] ARM: mxc: Introduce imx_add_gpio_leds
In-Reply-To: <20110405073030.GI13963@pengutronix.de>
References: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
	<20110404171927.GG7285@pengutronix.de>
	<20110404174244.GH13963@pengutronix.de>
	<20110404175240.GF22480@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B027084269764D1C13BB8@AUSP01VMBX24.collaborationhost.net>
	<20110404181759.GG22480@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B027084269764D1C89CC6@AUSP01VMBX24.collaborationhost.net>
	<20110405073030.GI13963@pengutronix.de>
Message-ID: <0D753D10438DA54287A00B027084269764D1C8A7C5@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 05, 2011 12:31 AM, Uwe Kleine-K?nig wrote:
> I like my approach better, without using mxc specific functions it would
> look as follows:
>
> struct platform_device *__init gpio_led_register_device(
> 		const gpio_led_platform_data *pdata)
> {
> 	struct platform_device *ret = ERR_PTR(-ENOMEM);
> 	struct gpio_led_platform_data *_pdata = *pdata;
> 	_pdata->leds = kmemdup(pdata->leds,
> 			 pdata->num_leds * sizeof(*pdata->leds), GFP_KERNEL);
> 
> 	if (!_pdata->leds)
> 		return ERR_PTR(-ENOMEM);
> 
> 	ret = platform_device_register_resndata(NULL, "leds-gpio", -1,
> 		NULL, 0, _pdata, sizeof(_pdata));
> 
> 	if (IS_ERR(ret))
> 		kfree(_pdata->leds);
> 
> 	return ret;
> }
>
> Compared to your approach with mine
>  - gpio_leds could be const __initconst;
>  - uses only a single parameter which AFAIK saves a few bytes to call
>    the function;
>  - you don't have control about the .id member (which IMHO is OK but
>    might be changed easily);
>  - you have to call a function with a different name;

Your approach is fine with me.

I think you should pass the .id number.  I noticed a couple platforms that
register more than one leds-gpio platform device and some that currently
use and id of 0.

Regards,
Hartley
