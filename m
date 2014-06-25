From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Jun 2014 08:08:48 +0200
Subject: [PATCH v2 1/2] video: imxfb: Fix unbalanced regulators
In-Reply-To: <1403528839-31901-1-git-send-email-denis@eukrea.com>
References: <1403528839-31901-1-git-send-email-denis@eukrea.com>
Message-ID: <20140625060848.GE15686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 03:07:18PM +0200, Denis Carikli wrote:
> Both regulator_enable and regulator_disable's comments
> say that they must be balanced with its counterpart
> enable/disable function.
> 
> Not doing it result in kernel warnings each time
> the lcd is powered off twice, for instance trough sysfs.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> Changelog v1->v2:
>  - None
> ---
>  drivers/video/fbdev/imxfb.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index f6e6216..121cbd7 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -769,9 +769,9 @@ static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
>  	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
>  
>  	if (!IS_ERR(fbi->lcd_pwr)) {
> -		if (power)
> +		if (power && !regulator_is_enabled(fbi->lcd_pwr))
>  			return regulator_enable(fbi->lcd_pwr);
> -		else
> +		else if (regulator_is_enabled(fbi->lcd_pwr))
>  			return regulator_disable(fbi->lcd_pwr);

It's a shame that the LCD controller doesn't do the reference counting.
I really think it should be fixed there and not in the drivers. If for
whatever reason this is not acceptable then it should be done in the
imxfb driver instead of shifting it further to the regulator core.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
