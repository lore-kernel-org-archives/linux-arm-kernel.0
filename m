From: sam@ravnborg.org (Sam Ravnborg)
Date: Mon, 17 Sep 2018 21:37:48 +0200
Subject: [RESEND 4/5] drm/mxsfb: Add PM_SLEEP support
In-Reply-To: <7d661819825a36f4aebe412e7bed8fe24c7292ae.1535367027.git.leonard.crestez@nxp.com>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
 <7d661819825a36f4aebe412e7bed8fe24c7292ae.1535367027.git.leonard.crestez@nxp.com>
Message-ID: <20180917193748.GA13165@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard.

On Mon, Aug 27, 2018 at 02:10:40PM +0300, Leonard Crestez wrote:
> Since power to the lcdif block can be lost on suspend implement
> PM_SLEEP_OPS using drm_mode_config_helper_suspend/resume to save/restore
> the current mode.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 68d79f5dc0d3..d797dfd40d98 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -416,17 +416,38 @@ static int mxsfb_remove(struct platform_device *pdev)
>  	drm_dev_unref(drm);
>  
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int mxsfb_suspend(struct device *dev)
> +{
> +       struct drm_device *drm = dev_get_drvdata(dev);
> +
> +       return drm_mode_config_helper_suspend(drm);
> +}
> +
> +static int mxsfb_resume(struct device *dev)
> +{
> +       struct drm_device *drm = dev_get_drvdata(dev);
> +
> +       return drm_mode_config_helper_resume(drm);
> +}
> +#endif

Other suspend/resume users skip the #ifdef and declare
the functions __maybe_unused
See for example arm/hdlcd_drv.c.

The resulting code is a bit simpler to read and you
have the added benefit that the suspend/resume functions
are always compiled so bit-rotting is less likely.

	Sam
