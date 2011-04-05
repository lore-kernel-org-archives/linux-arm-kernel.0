From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Apr 2011 09:30:30 +0200
Subject: [PATCH v2 1/2] ARM: mxc: Introduce imx_add_gpio_leds
In-Reply-To: <0D753D10438DA54287A00B027084269764D1C89CC6@AUSP01VMBX24.collaborationhost.net>
References: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
	<20110404171927.GG7285@pengutronix.de>
	<20110404174244.GH13963@pengutronix.de>
	<20110404175240.GF22480@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B027084269764D1C13BB8@AUSP01VMBX24.collaborationhost.net>
	<20110404181759.GG22480@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B027084269764D1C89CC6@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110405073030.GI13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Apr 04, 2011 at 04:52:43PM -0500, H Hartley Sweeten wrote:
> On Monday, April 04, 2011 11:18 AM, Russell King wrote:
> >>> If you go to the effort of making it _that_ generic, then it shouldn't
> >>> even be in plat-mxc, but somewhere *everyone* can benefit from it.  See
> >>> Linus' complaints in the OMAP pull request thread about the amount of
> >>> largely similar arch/arm code.
> >> 
> >> If it's made generic, mach-ep93xx/core.c could use it to register it's two
> >> platform leds.  Please keep me in the loop if this is done.
> >
> > In which case we don't want "if it's made generic", we *require* it to be
> > generic.

Yeah, definitely. I already tried once to make the device registration
that we use on mxc globally available.

> > As I say, we *must* get away from the idea that something in mach-xyz has
> > nothing to do with our own development in mach-abc, and start taking an
> > interest in consolidating some of this stuff.  Otherwise we may get to
> > the point where further arch/arm development is barred from the mainline
> > kernel.
> 
> How about something like this:
> 
> int __init gpio_led_platform_register(int id, struct gpio_led *leds, int nr)
> {
> 	struct gpio_led_platform_data *pdata;
> 	struct platform_device *pdev;
> 	int ret;
> 
> 	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> 	if (!pdata)
> 		return -ENOMEM;
> 
> 	pdev = platform_device_alloc("leds-gpio", id);
> 	if (!pdev) {
> 		ret = -ENOMEM;
> 		goto out_free;
> 	}
> 
> 	pdata->leds = leds;
> 	pdata->num_leds = nr;
> 	pdev->dev.platform_data = pdata;
> 	ret = platform_device_add(pdev);
> 	if (ret)
> 		goto out_pdev;
> 	return 0;
> 
> out_pdev:
> 	platform_device_put(pdev);
> out_free:
> 	kfree(pdata);
> 	return ret;
> }
I like my approach better, without using mxc specific functions it would
look as follows:

struct platform_device *__init gpio_led_register_device(
		const gpio_led_platform_data *pdata)
{
	struct platform_device *ret = ERR_PTR(-ENOMEM);
	struct gpio_led_platform_data *_pdata = *pdata;
	_pdata->leds = kmemdup(pdata->leds,
			 pdata->num_leds * sizeof(*pdata->leds), GFP_KERNEL);

	if (!_pdata->leds)
		return ERR_PTR(-ENOMEM);

	ret = platform_device_register_resndata(NULL, "leds-gpio", -1,
		NULL, 0, _pdata, sizeof(_pdata));

	if (IS_ERR(ret))
		kfree(_pdata->leds);

	return ret;
}

> The the mach-xyz init code just has to:
> 
> static struct gpio_led gpio_leds[] = {
> 	{
> 		.name	= "foo:fooclr",
> 		.gpio	= FOO_GPIO_NUM,
> 	}, {
> 		.name	= "bar:barclr",
> 		.gpio	= BAR_LED_NUM,
> 	},
> 	/* etc. */
> };
> 
> 
> 	gpio_led_platform_register(-1, gpio_leds, ARRAY_SIZE(gpio_leds));
Compared to your approach with mine
 - gpio_leds could be const __initconst;
 - uses only a single parameter which AFAIK saves a few bytes to call
   the function;
 - you don't have control about the .id member (which IMHO is OK but
   might be changed easily);
 - you have to call a function with a different name;

(Note all of these are no hard requirements for me, just my thoughts.)

> If some one could suggest a good place for the gpio_led_platform_register function
> I can create a proper patch.  Maybe just add it to the end of the leds-gpio.c driver?
mxc uses a central place to register all devices
(arch/arm/plat-mxc/devices).  I think for a global approach this won't
scale (e.g. because a single header file is used for all devices), so a
place near the driver is the right thing to do. leds-gpio.c doesn't work
though because then it might end in a module.

I'll send a patch as a reply to this mail.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
