From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Jun 2014 08:16:11 +0200
Subject: [PATCH v2 2/2] video: imxfb: Fix lcd_ops .set_power and
 .get_power on/off inversion
In-Reply-To: <1403528839-31901-2-git-send-email-denis@eukrea.com>
References: <1403528839-31901-1-git-send-email-denis@eukrea.com>
 <1403528839-31901-2-git-send-email-denis@eukrea.com>
Message-ID: <20140625061611.GF15686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 03:07:19PM +0200, Denis Carikli wrote:
> .set_power takes the blank level as argument instead
> of an on/off parameter:
> fb_blank calls fb_notifier_call_chain with the blank
> level encoded in its parameters, which is then sent
> as-is to the set_power callback.
> 
> imxfb_lcd_set_power was expecting an on/off parameter
> instead.
> This resulted in the inversion of the on/off behaviour.
> 
> .get_power was also fixed in the same way.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> Changelog v1->v2:
> - get_power which has the same issue, was also fixed as requested.
> - The commit message was updated to reflect that.
> ---
>  drivers/video/fbdev/imxfb.c |   27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index 121cbd7..f734757 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -758,21 +758,32 @@ static int imxfb_lcd_get_power(struct lcd_device *lcddev)
>  {
>  	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
>  
> -	if (!IS_ERR(fbi->lcd_pwr))
> -		return regulator_is_enabled(fbi->lcd_pwr);
> +	if (!IS_ERR_OR_NULL(fbi->lcd_pwr))
> +		if (!regulator_is_enabled(fbi->lcd_pwr))
> +			return FB_BLANK_NORMAL;

You use IS_ERR_OR_NULL() here. imxfb_lcd_set_power uses IS_ERR(). One of
both must be wrong.

>  
> -	return 1;
> +	return FB_BLANK_UNBLANK;
>  }
>  
> -static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
> +static int imxfb_lcd_set_power(struct lcd_device *lcddev, int blank)
>  {
>  	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
>  
>  	if (!IS_ERR(fbi->lcd_pwr)) {
> -		if (power && !regulator_is_enabled(fbi->lcd_pwr))
> -			return regulator_enable(fbi->lcd_pwr);
> -		else if (regulator_is_enabled(fbi->lcd_pwr))
> -			return regulator_disable(fbi->lcd_pwr);
> +		switch (blank) {
> +		case FB_BLANK_VSYNC_SUSPEND:
> +		case FB_BLANK_HSYNC_SUSPEND:
> +		case FB_BLANK_NORMAL:
> +		case FB_BLANK_POWERDOWN:
> +			if (regulator_is_enabled(fbi->lcd_pwr))
> +				return regulator_disable(fbi->lcd_pwr);
> +			break;
> +
> +		case FB_BLANK_UNBLANK:
> +			if (!regulator_is_enabled(fbi->lcd_pwr))
> +				return regulator_enable(fbi->lcd_pwr);
> +			break;
> +		}
>  	}

You could reduce indentation by bailing out early:

	if (IS_ERR(fbi->lcd_pwr))
		return 0;

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
