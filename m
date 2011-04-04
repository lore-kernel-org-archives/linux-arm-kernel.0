From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Apr 2011 18:52:40 +0100
Subject: [PATCH v2 1/2] ARM: mxc: Introduce imx_add_gpio_leds
In-Reply-To: <20110404174244.GH13963@pengutronix.de>
References: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
	<20110404171927.GG7285@pengutronix.de>
	<20110404174244.GH13963@pengutronix.de>
Message-ID: <20110404175240.GF22480@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 07:42:44PM +0200, Uwe Kleine-K?nig wrote:
> The mechanims could be made a bit more aggressive by something like
> that:
> 
> 	struct gpio_led_platform_data *_pdata = *pdata;
> 	_pdata->leds = kmemdup(pdata->leds, pdata->num_leds * sizeof(*pdata->leds), GFP_KERNEL)
> 	if (!_pdata->leds)
> 		return ...
> 
> 	ret = imx_add_platform_device("leds-gpio", -1, NULL, 0, _pdata, sizeof(_pdata));
> 	if (IS_ERR(ret))
> 		kfree(_pdata->leds);
> 
> 	return PTR_RET(ret);
> 
> This would allow to have the struct gpio_led array in init memory, too.

If you go to the effort of making it _that_ generic, then it shouldn't
even be in plat-mxc, but somewhere *everyone* can benefit from it.  See
Linus' complaints in the OMAP pull request thread about the amount of
largely similar arch/arm code.
