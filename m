From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 8 Sep 2017 08:35:29 +0200
Subject: [PATCH] drm/tve200: Clean up panel bridging
In-Reply-To: <20170907211933.8308-1-linus.walleij@linaro.org>
References: <20170907211933.8308-1-linus.walleij@linaro.org>
Message-ID: <20170908063529.rtvzmlflwhytuujo@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 07, 2017 at 11:19:33PM +0200, Linus Walleij wrote:
> This makes use of the drm_simple_display_pipe_attach_bridge()
> call and removes the two calls removing the bridge, which were
> erroneous: they unregister the bridge which is not what
> we want, we just want to unreference it and that is already
> handled by the core.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/tve200/tve200_display.c |  3 ---
>  drivers/gpu/drm/tve200/tve200_drv.c     | 30 +++++++++++++-----------------
>  2 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/tve200/tve200_display.c
> index cfdffc15a2ce..fd193377c3c0 100644
> --- a/drivers/gpu/drm/tve200/tve200_display.c
> +++ b/drivers/gpu/drm/tve200/tve200_display.c
> @@ -332,8 +332,5 @@ int tve200_display_init(struct drm_device *drm)
>  	if (ret)
>  		return ret;
>  
> -	/* We need the encoder to attach the bridge */
> -	priv->encoder = &priv->pipe.encoder;
> -
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
> index c22644692a88..eae38b669f0a 100644
> --- a/drivers/gpu/drm/tve200/tve200_drv.c
> +++ b/drivers/gpu/drm/tve200/tve200_drv.c
> @@ -87,6 +87,14 @@ static int tve200_modeset_init(struct drm_device *dev)
>  			ret = PTR_ERR(bridge);
>  			goto out_bridge;
>  		}
> +	} else {
> +		/*
> +		 * TODO: when we are using a different bridge than a panel
> +		 * (such as a dumb VGA connector) we need to devise a different
> +		 * method to get the connector out of the bridge.
> +		 */
> +		dev_err(dev->dev, "the bridge is not a panel\n");
> +		goto out_bridge;
>  	}
>  
>  	ret = tve200_display_init(dev);
> @@ -95,21 +103,13 @@ static int tve200_modeset_init(struct drm_device *dev)
>  		goto out_bridge;
>  	}
>  
> -	if (bridge) {
> -		ret = drm_bridge_attach(priv->encoder, bridge, NULL);
> -		if (ret)
> -			goto out_bridge;
> -	}
> -
> -	/*
> -	 * TODO: when we are using a different bridge than a panel
> -	 * (such as a dumb VGA connector) we need to devise a different
> -	 * method to get the connector out of the bridge.
> -	 */
> -	if (!panel) {
> -		dev_err(dev->dev, "the bridge is not a panel\n");
> +	ret = drm_simple_display_pipe_attach_bridge(&priv->pipe,
> +						    bridge);
> +	if (ret) {
> +		dev_err(dev->dev, "failed to attach bridge\n");
>  		goto out_bridge;
>  	}
> +
>  	priv->panel = panel;
>  	priv->connector = panel->connector;
>  	priv->bridge = bridge;
> @@ -138,8 +138,6 @@ static int tve200_modeset_init(struct drm_device *dev)
>  out_bridge:
>  	if (panel)
>  		drm_panel_bridge_remove(bridge);
> -	else
> -		drm_bridge_remove(bridge);
>  	drm_mode_config_cleanup(dev);
>  finish:
>  	return ret;
> @@ -275,8 +273,6 @@ static int tve200_remove(struct platform_device *pdev)
>  		drm_fbdev_cma_fini(priv->fbdev);
>  	if (priv->panel)
>  		drm_panel_bridge_remove(priv->bridge);
> -	else
> -		drm_bridge_remove(priv->bridge);
>  	drm_mode_config_cleanup(drm);
>  	clk_disable_unprepare(priv->pclk);
>  	drm_dev_unref(drm);
> -- 
> 2.13.5
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
