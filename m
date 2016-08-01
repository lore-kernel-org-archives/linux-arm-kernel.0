From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 01 Aug 2016 12:21:10 +0200
Subject: [PATCH V3 1/5] drm/imx-ldb: Add support to drm-bridge
In-Reply-To: <5d55969a1509de751dc550d9a02bd5070455f99b.1469993472.git.peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <cover.1469993472.git.peter.senna@collabora.com>
 <5d55969a1509de751dc550d9a02bd5070455f99b.1469993472.git.peter.senna@collabora.com>
Message-ID: <1470046870.3025.36.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, den 31.07.2016, 21:55 +0200 schrieb Peter Senna Tschudin:
> Add support to attach a drm_bridge to imx-ldb in addition to
> existing support to attach a LVDS panel.
> 
> This patch does a simple code refactoring by moving code
> from for_each_child_of_node iterator to a new function named
> imx_ldb_panel_ddc(). This was necessary to allow the panel ddc
> code to run only when the imx_ldb is not attached to a bridge.
> 
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> ---
> Changes from V2:
>  - Updated to be aplied on top of Liu Ying changes that made imx-ldb atomic.
>  - Tested on next-20160729.
[...]
> @@ -469,19 +473,28 @@ static int imx_ldb_register(struct drm_device *drm,
>  	drm_encoder_init(drm, encoder, &imx_ldb_encoder_funcs,
>  			 DRM_MODE_ENCODER_LVDS, NULL);
>  
> -	drm_connector_helper_add(&imx_ldb_ch->connector,
> -			&imx_ldb_connector_helper_funcs);
> -	drm_connector_init(drm, &imx_ldb_ch->connector,
> -			   &imx_ldb_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
> -
>  	if (imx_ldb_ch->panel) {
> +		drm_connector_helper_add(&imx_ldb_ch->connector,
> +				&imx_ldb_connector_helper_funcs);
> +		drm_connector_init(drm, &imx_ldb_ch->connector,
> +				&imx_ldb_connector_funcs,
> +				DRM_MODE_CONNECTOR_LVDS);

This is still not right. We want to add the connector whenever there is
no bridge that brings its own, not only when there is a panel. For
historical reasons, the ldb driver can also work without a panel.

>  		ret = drm_panel_attach(imx_ldb_ch->panel,
> -				       &imx_ldb_ch->connector);
> +				&imx_ldb_ch->connector);

What is the purpose of this change?

>  		if (ret)
>  			return ret;
>  	}
>  
> -	drm_mode_connector_attach_encoder(&imx_ldb_ch->connector, encoder);

Where is this gone?

> +	if (imx_ldb_ch->bridge) {
> +		imx_ldb_ch->bridge->encoder = encoder;
> +
> +		imx_ldb_ch->encoder.bridge = imx_ldb_ch->bridge;
> +		ret = drm_bridge_attach(drm, imx_ldb_ch->bridge);
> +		if (ret) {
> +			DRM_ERROR("Failed to initialize bridge with drm\n");
> +			return ret;
> +		}
> +	}
>  
>  	return 0;
>  }

regards
Philipp
