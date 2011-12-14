From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 14 Dec 2011 10:39:07 +0200
Subject: [PATCH v2] ARM: OMAP3LOGIC: Adding DSS support
In-Reply-To: <1323762769-25045-1-git-send-email-alexg@meprolight.com>
References: <1323762769-25045-1-git-send-email-alexg@meprolight.com>
Message-ID: <1323851947.1873.95.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

> +	gpio_set_value(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 0);
> +	gpio_set_value(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 0);
> +	gpio_set_value(OMAP3_TORPEDO_LCD_PWM_GPIO, 0);

These are already set to 0 in gpio_request_array, as you've defined the
flag "GPIOF_OUT_INIT_LOW".

> +
> +	msleep(50);
> +	gpio_set_value(OMAP3_TORPEDO_LCD_PWM_GPIO, 1);

What does this do, and why do you need msleep(50)? I understand
LCD_ENABLE gpio enables the LCD panel, but what exactly do LCD_BACKLIGHT
and LCD_PWM gpios do? Why don't you set/unset LCD_PWM in the panel
enable/disable functions like the other gpios?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111214/49107df2/attachment.sig>
