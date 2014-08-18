From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 18 Aug 2014 09:43:19 +0200
Subject: [PATCH v2] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <1406269240-24622-1-git-send-email-shawn.guo@freescale.com>
References: <1406269240-24622-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <53F1AE97.8090807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,


On 07/25/2014 08:20 AM, Shawn Guo wrote:
> HDMI currently stops working after a system suspend/resume cycle.  The
> cause is that the mode setting states in hardware gets lost and isn't
> restored across the suspend/resume cycle.
> 
> The patch adds a very basic suspend/resume support to imx-drm driver,
> and calls drm_helper_resume_force_mode() in .resume hook to restore the
> mode setting states, so that HDMI can continue working after a system
> suspend/resume cycle.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changs since v1:
>  - Do not walk through connector->funcs->dpms() but only call
>    drm_helper_resume_force_mode() in .resume.
> 
>  drivers/staging/imx-drm/imx-drm-core.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
> index def8280d7ee6..ab41152089a3 100644
> --- a/drivers/staging/imx-drm/imx-drm-core.c
> +++ b/drivers/staging/imx-drm/imx-drm-core.c
> @@ -696,6 +696,29 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int imx_drm_suspend(struct device *dev)
> +{
> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +
> +	drm_kms_helper_poll_disable(drm_dev);

drm_dev can be NULL here. You should add check before.

> +
> +	return 0;
> +}
> +
> +static int imx_drm_resume(struct device *dev)
> +{
> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +
> +	drm_helper_resume_force_mode(drm_dev);

ditto

Regards
Andrzej

> +	drm_kms_helper_poll_enable(drm_dev);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(imx_drm_pm_ops, imx_drm_suspend, imx_drm_resume);
> +
>  static const struct of_device_id imx_drm_dt_ids[] = {
>  	{ .compatible = "fsl,imx-display-subsystem", },
>  	{ /* sentinel */ },
> @@ -708,6 +731,7 @@ static struct platform_driver imx_drm_pdrv = {
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "imx-drm",
> +		.pm	= &imx_drm_pm_ops,
>  		.of_match_table = imx_drm_dt_ids,
>  	},
>  };
> 
