From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 4 Sep 2017 09:52:55 +0200
Subject: [PATCH v2] drm/tve200: Replace custom connector with panel bridge
In-Reply-To: <20170902200711.29298-1-linus.walleij@linaro.org>
References: <20170902200711.29298-1-linus.walleij@linaro.org>
Message-ID: <20170904075255.oy5gc5ggxpjhbisk@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 02, 2017 at 10:07:11PM +0200, Linus Walleij wrote:
> This replaces the custom connector in the TVE200 with the
> panel bridge helper. As long as we're just using panels
> and no other bridges, this works just fine.
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Drop a few surplus #includes
> - Collect Eric's review tag
> ---
>  drivers/gpu/drm/tve200/Kconfig            |   3 +-
>  drivers/gpu/drm/tve200/Makefile           |   3 +-
>  drivers/gpu/drm/tve200/tve200_connector.c | 125 ------------------------------
>  drivers/gpu/drm/tve200/tve200_display.c   |  15 ++--
>  drivers/gpu/drm/tve200/tve200_drm.h       |  10 +--
>  drivers/gpu/drm/tve200/tve200_drv.c       |  66 +++++++++++-----
>  6 files changed, 59 insertions(+), 163 deletions(-)
>  delete mode 100644 drivers/gpu/drm/tve200/tve200_connector.c
> 
> diff --git a/drivers/gpu/drm/tve200/Kconfig b/drivers/gpu/drm/tve200/Kconfig
> index 21d9841ddb88..c5f03bf4570c 100644
> --- a/drivers/gpu/drm/tve200/Kconfig
> +++ b/drivers/gpu/drm/tve200/Kconfig
> @@ -4,7 +4,8 @@ config DRM_TVE200
>  	depends on CMA
>  	depends on ARM || COMPILE_TEST
>  	depends on OF
> -	select DRM_PANEL
> +	select DRM_BRIDGE
> +	select DRM_PANEL_BRIDGE
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_CMA_HELPER
>  	select DRM_GEM_CMA_HELPER
> diff --git a/drivers/gpu/drm/tve200/Makefile b/drivers/gpu/drm/tve200/Makefile
> index a9dba54f7ee5..6b7a6a1dcbf8 100644
> --- a/drivers/gpu/drm/tve200/Makefile
> +++ b/drivers/gpu/drm/tve200/Makefile
> @@ -1,5 +1,4 @@
> -tve200_drm-y +=	tve200_connector.o \
> -		tve200_display.o \
> +tve200_drm-y +=	tve200_display.o \
>  		tve200_drv.o
>  
>  obj-$(CONFIG_DRM_TVE200) += tve200_drm.o
> diff --git a/drivers/gpu/drm/tve200/tve200_connector.c b/drivers/gpu/drm/tve200/tve200_connector.c
> deleted file mode 100644
> index 5e6c20b57d6d..000000000000
> --- a/drivers/gpu/drm/tve200/tve200_connector.c
> +++ /dev/null
> @@ -1,125 +0,0 @@
> -/*
> - * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
> - * Parts of this file were based on sources as follows:
> - *
> - * Copyright (C) 2006-2008 Intel Corporation
> - * Copyright (C) 2007 Amos Lee <amos_lee@storlinksemi.com>
> - * Copyright (C) 2007 Dave Airlie <airlied@linux.ie>
> - * Copyright (C) 2011 Texas Instruments
> - * Copyright (C) 2017 Eric Anholt
> - *
> - * This program is free software and is provided to you under the terms of the
> - * GNU General Public License version 2 as published by the Free Software
> - * Foundation, and any use by you of this program is subject to the terms of
> - * such GNU licence.
> - */
> -
> -/**
> - * tve200_drm_connector.c
> - * Implementation of the connector functions for the Faraday TV Encoder
> - */
> -#include <linux/version.h>
> -#include <linux/shmem_fs.h>
> -#include <linux/dma-buf.h>
> -
> -#include <drm/drmP.h>
> -#include <drm/drm_atomic_helper.h>
> -#include <drm/drm_crtc_helper.h>
> -#include <drm/drm_of.h>
> -#include <drm/drm_panel.h>
> -
> -#include "tve200_drm.h"
> -
> -static void tve200_connector_destroy(struct drm_connector *connector)
> -{
> -	struct tve200_drm_connector *tve200con =
> -		to_tve200_connector(connector);
> -
> -	if (tve200con->panel)
> -		drm_panel_detach(tve200con->panel);
> -
> -	drm_connector_unregister(connector);
> -	drm_connector_cleanup(connector);
> -}
> -
> -static enum drm_connector_status tve200_connector_detect(struct drm_connector
> -							*connector, bool force)
> -{
> -	struct tve200_drm_connector *tve200con =
> -		to_tve200_connector(connector);
> -
> -	return (tve200con->panel ?
> -		connector_status_connected :
> -		connector_status_disconnected);
> -}
> -
> -static int tve200_connector_helper_get_modes(struct drm_connector *connector)
> -{
> -	struct tve200_drm_connector *tve200con =
> -		to_tve200_connector(connector);
> -
> -	if (!tve200con->panel)
> -		return 0;
> -
> -	return drm_panel_get_modes(tve200con->panel);
> -}
> -
> -static const struct drm_connector_funcs connector_funcs = {
> -	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.destroy = tve200_connector_destroy,
> -	.detect = tve200_connector_detect,
> -	.reset = drm_atomic_helper_connector_reset,
> -	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> -	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> -};
> -
> -static const struct drm_connector_helper_funcs connector_helper_funcs = {
> -	.get_modes = tve200_connector_helper_get_modes,
> -};
> -
> -/*
> - * Walks the OF graph to find the panel node and then asks DRM to look
> - * up the panel.
> - */
> -static struct drm_panel *tve200_get_panel(struct device *dev)
> -{
> -	struct device_node *endpoint, *panel_node;
> -	struct device_node *np = dev->of_node;
> -	struct drm_panel *panel;
> -
> -	endpoint = of_graph_get_next_endpoint(np, NULL);
> -	if (!endpoint) {
> -		dev_err(dev, "no endpoint to fetch panel\n");
> -		return NULL;
> -	}
> -
> -	/* Don't proceed if we have an endpoint but no panel_node tied to it */
> -	panel_node = of_graph_get_remote_port_parent(endpoint);
> -	of_node_put(endpoint);
> -	if (!panel_node) {
> -		dev_err(dev, "no valid panel node\n");
> -		return NULL;
> -	}
> -
> -	panel = of_drm_find_panel(panel_node);
> -	of_node_put(panel_node);
> -
> -	return panel;
> -}
> -
> -int tve200_connector_init(struct drm_device *dev)
> -{
> -	struct tve200_drm_dev_private *priv = dev->dev_private;
> -	struct tve200_drm_connector *tve200con = &priv->connector;
> -	struct drm_connector *connector = &tve200con->connector;
> -
> -	drm_connector_init(dev, connector, &connector_funcs,
> -			   DRM_MODE_CONNECTOR_DPI);
> -	drm_connector_helper_add(connector, &connector_helper_funcs);
> -
> -	tve200con->panel = tve200_get_panel(dev->dev);
> -	if (tve200con->panel)
> -		drm_panel_attach(tve200con->panel, connector);
> -
> -	return 0;
> -}
> diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/tve200/tve200_display.c
> index 37fb333331f3..cfdffc15a2ce 100644
> --- a/drivers/gpu/drm/tve200/tve200_display.c
> +++ b/drivers/gpu/drm/tve200/tve200_display.c
> @@ -127,7 +127,7 @@ static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
>  	struct tve200_drm_dev_private *priv = drm->dev_private;
>  	const struct drm_display_mode *mode = &cstate->mode;
>  	struct drm_framebuffer *fb = plane->state->fb;
> -	struct drm_connector *connector = &priv->connector.connector;
> +	struct drm_connector *connector = priv->connector;
>  	u32 format = fb->format->format;
>  	u32 ctrl1 = 0;
>  
> @@ -215,13 +215,9 @@ static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
>  
>  	ctrl1 |= TVE200_TVEEN;
>  
> -	drm_panel_prepare(priv->connector.panel);
> -
>  	/* Turn it on */
>  	writel(ctrl1, priv->regs + TVE200_CTRL);
>  
> -	drm_panel_enable(priv->connector.panel);
> -
>  	drm_crtc_vblank_on(crtc);
>  }
>  
> @@ -233,13 +229,9 @@ void tve200_display_disable(struct drm_simple_display_pipe *pipe)
>  
>  	drm_crtc_vblank_off(crtc);
>  
> -	drm_panel_disable(priv->connector.panel);
> -
>  	/* Disable and Power Down */
>  	writel(0, priv->regs + TVE200_CTRL);
>  
> -	drm_panel_unprepare(priv->connector.panel);
> -
>  	clk_disable_unprepare(priv->clk);
>  }
>  
> @@ -336,9 +328,12 @@ int tve200_display_init(struct drm_device *drm)
>  	ret = drm_simple_display_pipe_init(drm, &priv->pipe,
>  					   &tve200_display_funcs,
>  					   formats, ARRAY_SIZE(formats),
> -					   &priv->connector.connector);
> +					   priv->connector);
>  	if (ret)
>  		return ret;
>  
> +	/* We need the encoder to attach the bridge */
> +	priv->encoder = &priv->pipe.encoder;

drm_simple_display_pipe_attach_bridge(). Fairly new addition, would be
great if you can also fix up wherever you copy-pasted this from :-)

I didn't check all the details, but lgtm otherwise. With this nit
addressed:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> +
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/tve200/tve200_drm.h b/drivers/gpu/drm/tve200/tve200_drm.h
> index f00fc47a6bd1..b463624c1f29 100644
> --- a/drivers/gpu/drm/tve200/tve200_drm.h
> +++ b/drivers/gpu/drm/tve200/tve200_drm.h
> @@ -96,15 +96,13 @@
>  #include <drm/drm_gem.h>
>  #include <drm/drm_simple_kms_helper.h>
>  
> -struct tve200_drm_connector {
> -	struct drm_connector connector;
> -	struct drm_panel *panel;
> -};
> -
>  struct tve200_drm_dev_private {
>  	struct drm_device *drm;
>  
> -	struct tve200_drm_connector connector;
> +	struct drm_connector *connector;
> +	struct drm_encoder *encoder;
> +	struct drm_panel *panel;
> +	struct drm_bridge *bridge;
>  	struct drm_simple_display_pipe pipe;
>  	struct drm_fbdev_cma *fbdev;
>  
> diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
> index fe742106db4e..c22644692a88 100644
> --- a/drivers/gpu/drm/tve200/tve200_drv.c
> +++ b/drivers/gpu/drm/tve200/tve200_drv.c
> @@ -47,6 +47,8 @@
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_panel.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_bridge.h>
>  
>  #include "tve200_drm.h"
>  
> @@ -62,6 +64,8 @@ static int tve200_modeset_init(struct drm_device *dev)
>  {
>  	struct drm_mode_config *mode_config;
>  	struct tve200_drm_dev_private *priv = dev->dev_private;
> +	struct drm_panel *panel;
> +	struct drm_bridge *bridge;
>  	int ret = 0;
>  
>  	drm_mode_config_init(dev);
> @@ -72,35 +76,51 @@ static int tve200_modeset_init(struct drm_device *dev)
>  	mode_config->min_height = 240;
>  	mode_config->max_height = 576;
>  
> -	ret = tve200_connector_init(dev);
> +	ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
> +					  0, 0, &panel, &bridge);
> +	if (ret && ret != -ENODEV)
> +		return ret;
> +	if (panel) {
> +		bridge = drm_panel_bridge_add(panel,
> +					      DRM_MODE_CONNECTOR_Unknown);
> +		if (IS_ERR(bridge)) {
> +			ret = PTR_ERR(bridge);
> +			goto out_bridge;
> +		}
> +	}
> +
> +	ret = tve200_display_init(dev);
>  	if (ret) {
> -		dev_err(dev->dev, "Failed to create tve200_drm_connector\n");
> -		goto out_config;
> +		dev_err(dev->dev, "failed to init display\n");
> +		goto out_bridge;
> +	}
> +
> +	if (bridge) {
> +		ret = drm_bridge_attach(priv->encoder, bridge, NULL);
> +		if (ret)
> +			goto out_bridge;
>  	}
>  
>  	/*
> -	 * Don't actually attach if we didn't find a drm_panel
> -	 * attached to us.
> +	 * TODO: when we are using a different bridge than a panel
> +	 * (such as a dumb VGA connector) we need to devise a different
> +	 * method to get the connector out of the bridge.
>  	 */
> -	if (!priv->connector.panel) {
> -		dev_info(dev->dev,
> -			 "deferring due to lack of DRM panel device\n");
> -		ret = -EPROBE_DEFER;
> -		goto out_config;
> +	if (!panel) {
> +		dev_err(dev->dev, "the bridge is not a panel\n");
> +		goto out_bridge;
>  	}
> -	dev_info(dev->dev, "attached to panel %s\n",
> -		 dev_name(priv->connector.panel->dev));
> +	priv->panel = panel;
> +	priv->connector = panel->connector;
> +	priv->bridge = bridge;
>  
> -	ret = tve200_display_init(dev);
> -	if (ret) {
> -		dev_err(dev->dev, "failed to init display\n");
> -		goto out_config;
> -	}
> +	dev_info(dev->dev, "attached to panel %s\n",
> +		 dev_name(panel->dev));
>  
>  	ret = drm_vblank_init(dev, 1);
>  	if (ret) {
>  		dev_err(dev->dev, "failed to init vblank\n");
> -		goto out_config;
> +		goto out_bridge;
>  	}
>  
>  	drm_mode_config_reset(dev);
> @@ -115,7 +135,11 @@ static int tve200_modeset_init(struct drm_device *dev)
>  
>  	goto finish;
>  
> -out_config:
> +out_bridge:
> +	if (panel)
> +		drm_panel_bridge_remove(bridge);
> +	else
> +		drm_bridge_remove(bridge);
>  	drm_mode_config_cleanup(dev);
>  finish:
>  	return ret;
> @@ -249,6 +273,10 @@ static int tve200_remove(struct platform_device *pdev)
>  	drm_dev_unregister(drm);
>  	if (priv->fbdev)
>  		drm_fbdev_cma_fini(priv->fbdev);
> +	if (priv->panel)
> +		drm_panel_bridge_remove(priv->bridge);
> +	else
> +		drm_bridge_remove(priv->bridge);
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
