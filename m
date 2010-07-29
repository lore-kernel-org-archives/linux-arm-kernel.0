From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 29 Jul 2010 14:45:34 +0200
Subject: [PATCH v2] video/imxfb.c: allow usage without
	BACKLIGHT_CLASS_DEVICE
In-Reply-To: <1280396856-4884-1-git-send-email-eric@eukrea.com>
References: <20100729091138.GA6268@pengutronix.de>
	<1280396856-4884-1-git-send-email-eric@eukrea.com>
Message-ID: <20100729124534.GB6268@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 11:47:36AM +0200, Eric B?nard wrote:
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
> v2:	handle CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE
> 
>  drivers/video/imxfb.c |   18 ++++++++++++++++--
>  1 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 43f0639..a6f0d3f 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -175,7 +175,10 @@ struct imxfb_info {
>  
>  	struct imx_fb_videomode *mode;
>  	int			num_modes;
> +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
> +	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
>  	struct backlight_device *bl;
> +#endif
I suspect this fails to build with
	CONFIG_BACKLIGHT_CLASS_DEVICE=m 
	CONFIG_FB_IMX=y

Maybe do the following:

#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
	(defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE) == defined(CONFIG_FB_IMX_MODULE))
#define BACKLIGHT_AVAILABLE
#endif

and use #ifdef BACKLIGHT_AVAILABLE to guard the backlight code?

I didn't test this though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
