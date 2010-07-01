From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Jul 2010 10:33:58 +0200
Subject: [PATCH] imxfb: add the possibility to control PWMR
In-Reply-To: <1277452400-6032-1-git-send-email-eric@eukrea.com>
References: <1277452400-6032-1-git-send-email-eric@eukrea.com>
Message-ID: <20100701083358.GC12115@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

I think the right way to do this is via backlight_device_register().

Sascha

On Fri, Jun 25, 2010 at 09:53:20AM +0200, Eric B?nard wrote:
> this adds the possibility to enable/disable the backlight through
> the PWMR register, as offered in mx3fb.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/plat-mxc/include/mach/imxfb.h |    1 +
>  drivers/video/imxfb.c                  |   14 ++++++++++++++
>  2 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/imxfb.h b/arch/arm/plat-mxc/include/mach/imxfb.h
> index 5263506..3c24778 100644
> --- a/arch/arm/plat-mxc/include/mach/imxfb.h
> +++ b/arch/arm/plat-mxc/include/mach/imxfb.h
> @@ -67,6 +67,7 @@ struct imx_fb_platform_data {
>  	u_int		pwmr;
>  	u_int		lscr1;
>  	u_int		dmacr;
> +	u_int		backlight_level;
>  
>  	u_char * fixed_screen_cpu;
>  	dma_addr_t fixed_screen_dma;
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index b4b6dec..9451200 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -169,6 +169,7 @@ struct imxfb_info {
>  	u_int			pwmr;
>  	u_int			lscr1;
>  	u_int			dmacr;
> +	u_int			backlight_level;
>  	u_int			cmap_inverse:1,
>  				cmap_static:1,
>  				unused:30;
> @@ -302,6 +303,14 @@ static int imxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
>  	return ret;
>  }
>  
> +static void imx_fb_set_brightness(struct imxfb_info *fbi, uint8_t value)
> +{
> +	pr_debug("%s: value = %d\n", __func__, value);
> +	/* This might be board-specific */
> +	writel((fbi->pwmr & ~0xFF) | value, fbi->regs + LCDC_PWMR);
> +	return;
> +}
> +
>  static const struct imx_fb_videomode *imxfb_find_mode(struct imxfb_info *fbi)
>  {
>  	struct imx_fb_videomode *m;
> @@ -470,12 +479,16 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
>  		fbi->backlight_power(1);
>  	if (fbi->lcd_power)
>  		fbi->lcd_power(1);
> +	if (fbi->backlight_level)
> +		imx_fb_set_brightness(fbi, fbi->backlight_level);
>  }
>  
>  static void imxfb_disable_controller(struct imxfb_info *fbi)
>  {
>  	pr_debug("Disabling LCD controller\n");
>  
> +	if (fbi->backlight_level)
> +		imx_fb_set_brightness(fbi, 0);
>  	if (fbi->backlight_power)
>  		fbi->backlight_power(0);
>  	if (fbi->lcd_power)
> @@ -660,6 +673,7 @@ static int __init imxfb_init_fbinfo(struct platform_device *pdev)
>  	fbi->pwmr			= pdata->pwmr;
>  	fbi->lcd_power			= pdata->lcd_power;
>  	fbi->backlight_power		= pdata->backlight_power;
> +	fbi->backlight_level		= pdata->backlight_level;
>  
>  	for (i = 0, m = &pdata->mode[0]; i < pdata->num_modes; i++, m++)
>  		info->fix.smem_len = max_t(size_t, info->fix.smem_len,
> -- 
> 1.6.3.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
