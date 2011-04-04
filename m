From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Apr 2011 19:17:59 +0100
Subject: [PATCH v2 1/2] ARM: mxc: Introduce imx_add_gpio_leds
In-Reply-To: <0D753D10438DA54287A00B027084269764D1C13BB8@AUSP01VMBX24.collaborationhost.net>
References: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
	<20110404171927.GG7285@pengutronix.de>
	<20110404174244.GH13963@pengutronix.de>
	<20110404175240.GF22480@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B027084269764D1C13BB8@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110404181759.GG22480@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 01:06:52PM -0500, H Hartley Sweeten wrote:
> On Monday, April 04, 2011 10:53 AM, Russell King wrote:
> > On Mon, Apr 04, 2011 at 07:42:44PM +0200, Uwe Kleine-K?nig wrote:
> >> The mechanims could be made a bit more aggressive by something like
> >> that:
> >> 
> >> 	struct gpio_led_platform_data *_pdata = *pdata;
> >> 	_pdata->leds = kmemdup(pdata->leds, pdata->num_leds * sizeof(*pdata->leds), GFP_KERNEL)
> >> 	if (!_pdata->leds)
> >> 		return ...
> >> 
> >> 	ret = imx_add_platform_device("leds-gpio", -1, NULL, 0, _pdata, sizeof(_pdata));
> >> 	if (IS_ERR(ret))
> >> 		kfree(_pdata->leds);
> >> 
> >> 	return PTR_RET(ret);
> >> 
> >> This would allow to have the struct gpio_led array in init memory, too.
> >
> > If you go to the effort of making it _that_ generic, then it shouldn't
> > even be in plat-mxc, but somewhere *everyone* can benefit from it.  See
> > Linus' complaints in the OMAP pull request thread about the amount of
> > largely similar arch/arm code.
> 
> If it's made generic, mach-ep93xx/core.c could use it to register it's two
> platform leds.  Please keep me in the loop if this is done.

In which case we don't want "if it's made generic", we *require* it to be
generic.

As I say, we *must* get away from the idea that something in mach-xyz has
nothing to do with our own development in mach-abc, and start taking an
interest in consolidating some of this stuff.  Otherwise we may get to
the point where further arch/arm development is barred from the mainline
kernel.
