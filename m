From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 4 Apr 2011 16:52:43 -0500
Subject: [PATCH v2 1/2] ARM: mxc: Introduce imx_add_gpio_leds
In-Reply-To: <20110404181759.GG22480@n2100.arm.linux.org.uk>
References: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
	<20110404171927.GG7285@pengutronix.de>
	<20110404174244.GH13963@pengutronix.de>
	<20110404175240.GF22480@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B027084269764D1C13BB8@AUSP01VMBX24.collaborationhost.net>
	<20110404181759.GG22480@n2100.arm.linux.org.uk>
Message-ID: <0D753D10438DA54287A00B027084269764D1C89CC6@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 04, 2011 11:18 AM, Russell King wrote:
>>> If you go to the effort of making it _that_ generic, then it shouldn't
>>> even be in plat-mxc, but somewhere *everyone* can benefit from it.  See
>>> Linus' complaints in the OMAP pull request thread about the amount of
>>> largely similar arch/arm code.
>> 
>> If it's made generic, mach-ep93xx/core.c could use it to register it's two
>> platform leds.  Please keep me in the loop if this is done.
>
> In which case we don't want "if it's made generic", we *require* it to be
> generic.
>
> As I say, we *must* get away from the idea that something in mach-xyz has
> nothing to do with our own development in mach-abc, and start taking an
> interest in consolidating some of this stuff.  Otherwise we may get to
> the point where further arch/arm development is barred from the mainline
> kernel.

How about something like this:

int __init gpio_led_platform_register(int id, struct gpio_led *leds, int nr)
{
	struct gpio_led_platform_data *pdata;
	struct platform_device *pdev;
	int ret;

	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
	if (!pdata)
		return -ENOMEM;

	pdev = platform_device_alloc("leds-gpio", id);
	if (!pdev) {
		ret = -ENOMEM;
		goto out_free;
	}

	pdata->leds = leds;
	pdata->num_leds = nr;
	pdev->dev.platform_data = pdata;
	ret = platform_device_add(pdev);
	if (ret)
		goto out_pdev;
	return 0;

out_pdev:
	platform_device_put(pdev);
out_free:
	kfree(pdata);
	return ret;
}

The the mach-xyz init code just has to:

static struct gpio_led gpio_leds[] = {
	{
		.name	= "foo:fooclr",
		.gpio	= FOO_GPIO_NUM,
	}, {
		.name	= "bar:barclr",
		.gpio	= BAR_LED_NUM,
	},
	/* etc. */
};


	gpio_led_platform_register(-1, gpio_leds, ARRAY_SIZE(gpio_leds));

If some one could suggest a good place for the gpio_led_platform_register function
I can create a proper patch.  Maybe just add it to the end of the leds-gpio.c driver?

Regards,
Hartley
