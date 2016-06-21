From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 21 Jun 2016 10:39:02 +0200
Subject: [PATCH] drm/rockchip: Finish initialization before registering
 DRM device
In-Reply-To: <1466483254-35373-1-git-send-email-tfiga@chromium.org>
References: <1466483254-35373-1-git-send-email-tfiga@chromium.org>
Message-ID: <20160621083901.GT23520@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 01:27:34PM +0900, Tomasz Figa wrote:
> Currently the driver calls drm_dev_register() directly after allocating
> the DRM device and then continues with further initialization. This is
> incorrect, because drm_dev_register() is supposed to be called after all
> initialization is done. This problem was masked by the fact that
> drm_dev_register() did not use to do anything special before, but
> recently it started to call drm_connector_register_all(), which leads to
> a crash if the driver is not fully initialized.
> 
> This patch fixes the problem by moving the call to drm_dev_register() to
> the end of the initialization sequence and also removing the, now
> unnecessary, call to drm_connector_register_all() from driver code.
> 
> Fixes: f706974a69b6 ("drm/rockchip: Drop drm_driver.load/unload callbacks")
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

Oops, more fallout from the regiseter/unregister cleanup. Sorry about
that, applied to drm-misc.
-Daniel

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 0d28455..e2c31d3 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -146,16 +146,12 @@ static int rockchip_drm_bind(struct device *dev)
>  	if (!drm_dev)
>  		return -ENOMEM;
>  
> -	ret = drm_dev_register(drm_dev, 0);
> -	if (ret)
> -		goto err_free;
> -
>  	dev_set_drvdata(dev, drm_dev);
>  
>  	private = devm_kzalloc(drm_dev->dev, sizeof(*private), GFP_KERNEL);
>  	if (!private) {
>  		ret = -ENOMEM;
> -		goto err_unregister;
> +		goto err_free;
>  	}
>  
>  	drm_dev->dev_private = private;
> @@ -197,12 +193,6 @@ static int rockchip_drm_bind(struct device *dev)
>  	if (ret)
>  		goto err_detach_device;
>  
> -	ret = drm_connector_register_all(drm_dev);
> -	if (ret) {
> -		dev_err(dev, "failed to register connectors\n");
> -		goto err_unbind;
> -	}
> -
>  	/* init kms poll for handling hpd */
>  	drm_kms_helper_poll_init(drm_dev);
>  
> @@ -222,9 +212,15 @@ static int rockchip_drm_bind(struct device *dev)
>  	if (ret)
>  		goto err_vblank_cleanup;
>  
> +	ret = drm_dev_register(drm_dev, 0);
> +	if (ret)
> +		goto err_fbdev_fini;
> +
>  	if (is_support_iommu)
>  		arm_iommu_release_mapping(mapping);
>  	return 0;
> +err_fbdev_fini:
> +	rockchip_drm_fbdev_fini(drm_dev);
>  err_vblank_cleanup:
>  	drm_vblank_cleanup(drm_dev);
>  err_kms_helper_poll_fini:
> -- 
> 2.8.0.rc3.226.g39d4020
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
