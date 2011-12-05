From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Dec 2011 10:52:28 +0200
Subject: [PATCH] backlight: add regulator support for platform_lcd driver
In-Reply-To: <1323074921-29291-1-git-send-email-thomas.abraham@linaro.org>
References: <1323074921-29291-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20111205085228.GF9900@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 05, 2011 at 02:18:41PM +0530, Thomas Abraham wrote:
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
> diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
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
> @@ -44,11 +46,38 @@ static int platform_lcd_get_power(struct lcd_device *lcd)
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
> +
> +	if (lcd_power) {
> +		if (plcd->pdata->min_uV || plcd->pdata->max_uV)
> +			if (regulator_set_voltage(lcd_regulator,
> +				plcd->pdata->min_uV, plcd->pdata->max_uV))
> +				dev_info(plcd->us,
> +					"regulator voltage set failed\n");
> +
> +		if (regulator_enable(lcd_regulator))
> +			dev_info(plcd->us, "failed to enable regulator\n");
> +	} else {
> +		regulator_disable(lcd_regulator);
> +	}
> +
> +	regulator_put(lcd_regulator);

I wonder why you ->get() and ->put() everytime here. Wouldn't it be
enough to ->get() on probe() and ->put() on remove() ??

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111205/7fceaaed/attachment.sig>
