From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 Mar 2012 12:06:14 +0100
Subject: [PATCH v6] ARM : mx35: 3ds-board: add framebuffer device
In-Reply-To: <1331269521-20784-1-git-send-email-b39297@freescale.com>
References: <1331269521-20784-1-git-send-email-b39297@freescale.com>
Message-ID: <20120309110614.GC3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 01:05:21PM +0800, Wu Guoxing wrote:
> From: wu guoxing <b39297@freescale.com>
> 
> This patch adds framebuffer support for freescale mx35 3ds board
> 
> Signed-off-by: Wu Guoxing <b39297@freescale.com>
> 
>  arch/arm/mach-imx/mach-mx35_3ds.c |  121 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 121 insertions(+), 0 deletions(-)
> 
> +static int lcd_power_gpio = -ENXIO;
> +
> +static int mc9s08dz60_gpiochip_match(struct gpio_chip *chip,
> +						     void *data)
> +{
> +	return !strcmp(chip->label, data);
> +}
> +
> +static int mc9s08dz60_lcd_gpio_get(void)
> +{
> +	struct gpio_chip *chip;
> +
> +	if (!gpio_is_valid(lcd_power_gpio)) {
> +		chip = gpiochip_find(
> +				"mc9s08dz60", mc9s08dz60_gpiochip_match);
> +		if (chip) {
> +			lcd_power_gpio = chip->base + 6;
> +			if (gpio_request(lcd_power_gpio, "lcd_power") < 0) {
> +				pr_err("error: gpio already requested by other!\n");
> +				lcd_power_gpio = -ENXIO;
> +			}
> +		} else {
> +			pr_err("error: didn't find mc9s08dz60 gpio chip\n");
> +			lcd_power_gpio = -ENXIO;
> +		}
> +	}
> +
> +	return lcd_power_gpio;
> +}
> +
> +static void mx35_3ds_lcd_set_power(struct plat_lcd_data *pd, unsigned int power)
> +{
> +	int gpio;
> +
> +	gpio = mc9s08dz60_lcd_gpio_get();
> +	if (gpio_is_valid(gpio))
> +		gpio_set_value_cansleep(gpio, power);
> +}

This looks unnecessary complicated. Please fold mc9s08dz60_lcd_gpio_get
into mx35_3ds_lcd_set_power:

	if (!gpio_is_valid()) {
		request()
	}

	if (gpio_is_valid()) {
		set_value()
	}

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
