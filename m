From: alexg@meprolight.com (Alex Gershgorin)
Date: Wed, 14 Dec 2011 14:08:21 +0200
Subject: [PATCH v2] ARM: OMAP3LOGIC: Adding DSS support
In-Reply-To: <1323851947.1873.95.camel@deskari>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2C8966B269@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,


On Tue, 2011-12-13 at 09:52 +0200, Alex wrote:
> This patch adds DSS2 support to the LogicPD OMAP 35x Torpedo boardfile. LCD and
> TV-out are supported.
> 
> Signed-off-by: Alex Gershgorin <alexg@meprolight.com>

Overall looks fine. A few questions below about the GPIOs, though.

<snip>

> +static void __init omap3logic_display_init(void)
> +{
> +	int r;
> +
> +	r = gpio_request_array(omap3logic_dss_gpios,
> +			       ARRAY_SIZE(omap3logic_dss_gpios));
> +	if (r) {
> +		printk(KERN_ERR "failed to get lcd_panel_* gpios\n");
> +		return;
> +	}
> +
> +	gpio_export(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 0);
> +	gpio_export(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 0);
> +	gpio_export(OMAP3_TORPEDO_LCD_PWM_GPIO, 0);

Why do you want to export these GPIOs? They are handled here in the
board file, and I don't think there's any reason the userspace would
need to touch them.

Ok I can remove it from the kernel, if someone wants to use them,
It can be done from userspace.

> +	gpio_set_value(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 0);
> +	gpio_set_value(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 0);
> +	gpio_set_value(OMAP3_TORPEDO_LCD_PWM_GPIO, 0);

These are already set to 0 in gpio_request_array, as you've defined the
flag "GPIOF_OUT_INIT_LOW".

Thanks, I will correct it.

> +
> +	msleep(50);
> +	gpio_set_value(OMAP3_TORPEDO_LCD_PWM_GPIO, 1);

What does this do, and why do you need msleep(50)? I understand
LCD_ENABLE gpio enables the LCD panel, but what exactly do LCD_BACKLIGHT
and LCD_PWM gpios do? Why don't you set/unset LCD_PWM in the panel
enable/disable functions like the other gpios?


LCD_BACKLIGHT supply's power to LED Driver and LCD_PWM used to 
Control the backlight level. 
I'll check your suggestion and if it suits, I'll update the patch accordingly.

 

Thanks,
Alex

 
