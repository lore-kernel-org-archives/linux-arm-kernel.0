From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 17 Oct 2017 14:02:55 -0400
Subject: [RFC PATCH v4 3/8] drm/rockchip: dw-mipi-dsi: Fix error handling
 path
In-Reply-To: <20171017101624.12506-4-jeffy.chen@rock-chips.com>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
 <20171017101624.12506-4-jeffy.chen@rock-chips.com>
Message-ID: <20171017180255.qdoonirsy6xyhhru@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 06:16:19PM +0800, Jeffy Chen wrote:
> Add missing pm_runtime_disable() in bind()'s error handling path.
> 
> Also cleanup encoder & connector in unbind().
> 
> Fixes: 80a9a059d4e4 ("drm/rockchip/dsi: add dw-mipi power domain support")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index b15755b6129c..a17ff0f6f489 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -1282,7 +1282,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>  	ret = dw_mipi_dsi_register(drm, dsi);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "Failed to register mipi_dsi: %d\n", ret);
> -		goto err_pllref;
> +		goto err_disable_pllref;
>  	}
>  
>  	pm_runtime_enable(dev);
> @@ -1292,23 +1292,24 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>  	ret = mipi_dsi_host_register(&dsi->dsi_host);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "Failed to register MIPI host: %d\n", ret);
> -		goto err_cleanup;
> +		goto err_disable_pm_runtime;
>  	}
>  
>  	if (!dsi->panel) {
>  		ret = -EPROBE_DEFER;
> -		goto err_mipi_dsi_host;
> +		goto err_unreg_mipi_dsi_host;
>  	}
>  
>  	dev_set_drvdata(dev, dsi);
>  	return 0;
>  
> -err_mipi_dsi_host:
> +err_unreg_mipi_dsi_host:
>  	mipi_dsi_host_unregister(&dsi->dsi_host);
> -err_cleanup:
> +err_disable_pm_runtime:
> +	pm_runtime_disable(dev);
>  	drm_encoder_cleanup(&dsi->encoder);
>  	drm_connector_cleanup(&dsi->connector);

Should you update these to call the destroy hook like in unbind()?

Sean

> -err_pllref:
> +err_disable_pllref:
>  	clk_disable_unprepare(dsi->pllref_clk);
>  	return ret;
>  }
> @@ -1320,6 +1321,10 @@ static void dw_mipi_dsi_unbind(struct device *dev, struct device *master,
>  
>  	mipi_dsi_host_unregister(&dsi->dsi_host);
>  	pm_runtime_disable(dev);
> +
> +	dsi->connector.funcs->destroy(&dsi->connector);
> +	dsi->encoder.funcs->destroy(&dsi->encoder);
> +
>  	clk_disable_unprepare(dsi->pllref_clk);
>  }
>  
> -- 
> 2.11.0
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
