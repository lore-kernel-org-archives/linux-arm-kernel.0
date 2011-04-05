From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Apr 2011 09:43:15 +0200
Subject: [PATCH v2 1/2] ARM: mxc: Introduce imx_add_gpio_leds
In-Reply-To: <20110405074017.GA4633@n2100.arm.linux.org.uk>
References: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
	<20110404171927.GG7285@pengutronix.de>
	<20110404174244.GH13963@pengutronix.de>
	<20110404175240.GF22480@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B027084269764D1C13BB8@AUSP01VMBX24.collaborationhost.net>
	<20110404181759.GG22480@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B027084269764D1C89CC6@AUSP01VMBX24.collaborationhost.net>
	<20110405073030.GI13963@pengutronix.de>
	<20110405074017.GA4633@n2100.arm.linux.org.uk>
Message-ID: <20110405074315.GL13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 08:40:17AM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 05, 2011 at 09:30:30AM +0200, Uwe Kleine-K?nig wrote:
> > I like my approach better, without using mxc specific functions it would
> > look as follows:
> > 
> > struct platform_device *__init gpio_led_register_device(
> > 		const gpio_led_platform_data *pdata)
> > {
> > 	struct platform_device *ret = ERR_PTR(-ENOMEM);
> > 	struct gpio_led_platform_data *_pdata = *pdata;
> > 	_pdata->leds = kmemdup(pdata->leds,
> > 			 pdata->num_leds * sizeof(*pdata->leds), GFP_KERNEL);
> > 
> > 	if (!_pdata->leds)
> > 		return ERR_PTR(-ENOMEM);
> > 
> > 	ret = platform_device_register_resndata(NULL, "leds-gpio", -1,
> > 		NULL, 0, _pdata, sizeof(_pdata));
> > 
> > 	if (IS_ERR(ret))
> > 		kfree(_pdata->leds);
> > 
> > 	return ret;
> > }
> 
> But this is inconsistent.  The gpio_led_platform_data isn't copied,
> but a sub-structure is - which makes this a candidate for people adding
> __initdata to the wrong thing.  Also marking the LEDs array as __initdata
> but leaving the gpio_led_platform_data without __initdata will lead to
> warnings.
platform_device_register_resndata does the copying.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
