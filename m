From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 14 Mar 2012 07:02:38 +0200
Subject: [PATCH v8] ARM : mx35: 3ds-board: add framebuffer device
In-Reply-To: <1331691054-6442-1-git-send-email-b39297@freescale.com>
References: <1331691054-6442-1-git-send-email-b39297@freescale.com>
Message-ID: <20120314050238.GA15933@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wu,

On Wed, Mar 14, 2012 at 10:10:54AM +0800, Wu Guoxing wrote:
> From: wu guoxing <b39297@freescale.com>
> 
> This patch adds framebuffer support for freescale mx35 3ds board
> 
> Signed-off-by: Wu Guoxing <b39297@freescale.com>
> ---

[snip]

> +static int lcd_power_gpio = -ENXIO;

Since this is only used in mx35_3ds_lcd_set_power() below, can't it be local 
to that routine?

> +
> +static int mc9s08dz60_gpiochip_match(struct gpio_chip *chip,
> +						     void *data)
> +{
> +	return !strcmp(chip->label, data);
> +}
> +
> +static void mx35_3ds_lcd_set_power(
> +				struct plat_lcd_data *pd, unsigned int power)
> +{
> +	struct gpio_chip *chip;
> +
> +	if (!gpio_is_valid(lcd_power_gpio)) {
> +		chip = gpiochip_find(
> +				"mc9s08dz60", mc9s08dz60_gpiochip_match);
> +		if (chip) {
> +			lcd_power_gpio =
> +				chip->base + GPIO_MC9S08DZ60_LCD_ENABLE;
> +			if (gpio_request(lcd_power_gpio, "lcd_power") < 0) {
> +				pr_err("error: gpio already requested!\n");
> +				lcd_power_gpio = -ENXIO;
> +			}
> +		} else {
> +			pr_err("error: didn't find mc9s08dz60 gpio chip\n");
> +		}
> +	}
> +
> +	if (gpio_is_valid(lcd_power_gpio))
> +		gpio_set_value_cansleep(lcd_power_gpio, power);
> +}

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
