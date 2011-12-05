From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 5 Dec 2011 19:10:03 +0900
Subject: [PATCH] backlight: add regulator support for platform_lcd driver
In-Reply-To: <1323074921-29291-1-git-send-email-thomas.abraham@linaro.org>
References: <1323074921-29291-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAH9JG2XJ4TCEaN1rMRjMZNRn5Wx6jcTRC_DmyN4Qyf2zztWSsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/5/11, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> The power source to the lcd panel or the lcd interface such as lvds
> transmitters could be controlled by a regulator supply. Add support
> for enabling/disabling the regulator when switching power to lcd.
>
> Two new elements 'min_uV' and 'max_uV' in the platform data are added
> to allow platform code to specifiy the desired output voltage from the
> regulator.
>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/video/backlight/platform_lcd.c |   29 +++++++++++++++++++++++++++++
>  include/video/platform_lcd.h           |    7 +++++++
>  2 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/backlight/platform_lcd.c
> b/drivers/video/backlight/platform_lcd.c
> index 302330a..ffa8108 100644
> --- a/drivers/video/backlight/platform_lcd.c
> +++ b/drivers/video/backlight/platform_lcd.c
> @@ -17,6 +17,8 @@
>  #include <linux/backlight.h>
>  #include <linux/lcd.h>
>  #include <linux/slab.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/regulator/machine.h>
>
>  #include <video/platform_lcd.h>
>
> @@ -44,11 +46,38 @@ static int platform_lcd_get_power(struct lcd_device
> *lcd)
>  static int platform_lcd_set_power(struct lcd_device *lcd, int power)
>  {
>  	struct platform_lcd *plcd = to_our_lcd(lcd);
> +	struct regulator *lcd_regulator;
>  	int lcd_power = 1;
>
>  	if (power == FB_BLANK_POWERDOWN || plcd->suspended)
>  		lcd_power = 0;
>
> +	/*
> +	 * If power to lcd and/or lcd interface is controlled using a regulator,
> +	 * enable or disable the regulator based in the power setting.
> +	 */
> +	lcd_regulator = regulator_get(plcd->us, "vcc_lcd");
> +	if (IS_ERR(lcd_regulator)) {
> +		dev_info(plcd->us, "could not get regulator\n");
> +		goto set_power;
> +	}

Recent regulator discussion. it should be failed instead fall through
gracefully.
> +
> +	if (lcd_power) {
> +		if (plcd->pdata->min_uV || plcd->pdata->max_uV)
> +			if (regulator_set_voltage(lcd_regulator,
> +				plcd->pdata->min_uV, plcd->pdata->max_uV))
> +				dev_info(plcd->us,
> +					"regulator voltage set failed\n");
Are there case to change the voltage? Doesn't it easy to set the
voltage at board file? I mean don't need to setup at drivers?

Thank you,
Kyungmin Park
> +
> +		if (regulator_enable(lcd_regulator))
> +			dev_info(plcd->us, "failed to enable regulator\n");
> +	} else {
> +		regulator_disable(lcd_regulator);
> +	}
> +
> +	regulator_put(lcd_regulator);
> +
> +set_power:
>  	plcd->pdata->set_power(plcd->pdata, lcd_power);
>  	plcd->power = power;
>
> diff --git a/include/video/platform_lcd.h b/include/video/platform_lcd.h
> index ad3bdfe..acd5d21 100644
> --- a/include/video/platform_lcd.h
> +++ b/include/video/platform_lcd.h
> @@ -14,8 +14,15 @@
>  struct plat_lcd_data;
>  struct fb_info;
>
> +/**
> + * struct plat_lcd_data - platform data for platform_lcd driver.
> + * @min_uV: Minimum required voltage output from the regulator.
> + * @max_uV: Maximum acceptable voltage output from the regulator.
> + */
>  struct plat_lcd_data {
>  	void	(*set_power)(struct plat_lcd_data *, unsigned int power);
>  	int	(*match_fb)(struct plat_lcd_data *, struct fb_info *);
> +	int	min_uV;
> +	int	max_uV;
>  };
>
> --
> 1.6.6.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
