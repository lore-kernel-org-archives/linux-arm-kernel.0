From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 24 Jul 2014 11:47:55 +0200
Subject: [PATCH] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <1406193474-13695-1-git-send-email-shawn.guo@freescale.com>
References: <1406193474-13695-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1406195275.4590.18.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 24.07.2014, 17:17 +0800 schrieb Shawn Guo:
> HDMI currently stops working after a system suspend/resume cycle.  It
> turns out that the cause is the imx-hdmi encoder .dpms hook doesn't get
> called from anywhere across suspend/resume cycle.
> 
> The patch follows what exynos drm driver does to walk the list of
> connectors and call their .dpms function from suspend/resume hook.  And
> the connectors' .dpms function will in turn filter down to the .dpms
> hooks of encoders and CRTCs.
> 
> With this change, HDMI can continue working after a suspend/resume
> cycle.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Tested with HDMI and LVDS.  It'd be great if someone can help test TVE
> to ensure the patch doesn't break anything.
> 
>  drivers/staging/imx-drm/imx-drm-core.c | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
> index def8280d7ee6..b0ea1f0ed32f 100644
> --- a/drivers/staging/imx-drm/imx-drm-core.c
> +++ b/drivers/staging/imx-drm/imx-drm-core.c
> @@ -696,6 +696,44 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#if CONFIG_PM_SLEEP

use #ifdef

> +static int imx_drm_suspend(struct device *dev)
> +{
> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +	struct drm_connector *connector;
> +
> +	drm_kms_helper_poll_disable(drm_dev);
> +

That's ok.

> +	drm_modeset_lock_all(drm_dev);
> +	list_for_each_entry(connector, &drm_dev->mode_config.connector_list, head) {
> +		if (connector->funcs->dpms)
> +			connector->funcs->dpms(connector, DRM_MODE_DPMS_OFF);
> +	}

Don't touch DPMS state here. See below.

> +	drm_modeset_unlock_all(drm_dev);
> +
> +	return 0;
> +}
> +
> +static int imx_drm_resume(struct device *dev)
> +{
> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +	struct drm_connector *connector;
> +
> +	drm_modeset_lock_all(drm_dev);
> +	list_for_each_entry(connector, &drm_dev->mode_config.connector_list, head) {
> +		if (connector->funcs->dpms)
> +			connector->funcs->dpms(connector, DRM_MODE_DPMS_ON);
> +	}
> +	drm_modeset_unlock_all(drm_dev);
> +
This forcefully enables all connectors, which might not have been the
state before suspend. Have a look at simply using
drm_helper_resume_force_mode(), which should do the right thing.

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
> @@ -708,6 +746,7 @@ static struct platform_driver imx_drm_pdrv = {
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "imx-drm",
> +		.pm	= &imx_drm_pm_ops,
>  		.of_match_table = imx_drm_dt_ids,
>  	},
>  };

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
