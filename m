From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 06 Jan 2016 09:48:08 +0800
Subject: [PATCH v6.3 4/6] drm: rockchip: Support Synopsys DW MIPI DSI
In-Reply-To: <1450842215-10883-1-git-send-email-zyw@rock-chips.com>
References: <1450260616-21160-5-git-send-email-zyw@rock-chips.com>
 <1450842215-10883-1-git-send-email-zyw@rock-chips.com>
Message-ID: <568C7258.3010104@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?12?23? 11:43, Chris Zhong wrote:
> +static int dw_mipi_dsi_register(struct drm_device *drm,
> +				      struct dw_mipi_dsi *dsi)
> +{
> +	struct drm_encoder *encoder = &dsi->encoder;
> +	struct drm_connector *connector = &dsi->connector;
> +	struct device *dev = dsi->dev;
> +	int ret;
> +
> +	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm,
> +							     dev->of_node);
> +	/*
> +	 * If we failed to find the CRTC(s) which this encoder is
> +	 * supposed to be connected to, it's because the CRTC has
> +	 * not been registered yet.  Defer probing, and hope that
> +	 * the required CRTC is added later.
> +	 */
> +	if (encoder->possible_crtcs == 0)
> +		return -EPROBE_DEFER;
> +
> +	drm_encoder_helper_add(&dsi->encoder,
> +			       &dw_mipi_dsi_encoder_helper_funcs);
> +	ret = drm_encoder_init(drm, &dsi->encoder, &dw_mipi_dsi_encoder_funcs,
> +			 DRM_MODE_ENCODER_DSI);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize encoder with drm\n");
> +		return ret;
> +	}
> +
> +	drm_connector_helper_add(connector,
> +			&dw_mipi_dsi_connector_helper_funcs);
> +
> +	drm_connector_init(drm, &dsi->connector,
> +			   &dw_mipi_dsi_atomic_connector_funcs,
> +			   DRM_MODE_CONNECTOR_DSI);
> +
Hi Chris

I try to pick your patches, but found following issues:

drivers/gpu/drm/rockchip/dw-mipi-dsi.c: ????dw_mipi_dsi_register??:
drivers/gpu/drm/rockchip/dw-mipi-dsi.c:1024:5: ??? ????? 
?drm_encoder_init??????
include/drm/drm_crtc.h:2220:5: ??? ????
make[4]: *** [drivers/gpu/drm/rockchip/dw-mipi-dsi.o] ?? 1

Can you rebase to newest Dave's drm-next and fix this problem?

Thanks.

-- 
?ark Yao
