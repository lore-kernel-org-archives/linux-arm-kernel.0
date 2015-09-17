From: architt@codeaurora.org (Archit Taneja)
Date: Thu, 17 Sep 2015 17:09:37 +0530
Subject: [PATCH RFC 5/8] drm: hisilicon: fill interface function of
 encoder\connector part
In-Reply-To: <1442309834-21420-6-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1442309834-21420-6-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <55FAA679.2030902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/15/2015 3:07 PM, Xinwei Kong wrote:
> This patch enables the adv7533 module which is connecting hisilicon SOC
> by dsi module. while using DSI module and adv7533 module to implement the
> encoder/connector interface of DRM\KMS.
>
> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
> Signed-off-by: Yu Gong <gongyu@hisilicon.com>
> ---
>   drivers/gpu/drm/hisilicon/Kconfig              |  10 +
>   drivers/gpu/drm/hisilicon/hisi_drm_connector.c |  34 ++
>   drivers/gpu/drm/hisilicon/hisi_drm_connector.h |   8 +
>   drivers/gpu/drm/hisilicon/hisi_drm_dsi.c       | 670 +++++++++++++++++++++++++
>   drivers/gpu/drm/hisilicon/hisi_drm_encoder.c   |  52 ++
>   drivers/gpu/drm/hisilicon/hisi_drm_encoder.h   |  19 +
>   drivers/gpu/drm/hisilicon/hisi_dsi_reg.h       |  91 ++++
>   7 files changed, 884 insertions(+)
>   create mode 100644 drivers/gpu/drm/hisilicon/hisi_dsi_reg.h
>

<snip>

> +struct hisi_connector_funcs hisi_dsi_connector_ops = {
> +	.get_modes = dsi_connector_get_modes,
> +};
> +
> +struct hisi_encoder_funcs hisi_dsi_encoder_ops = {
> +	.mode_set = dsi_encoder_mode_set,
> +	.enable = dsi_encoder_enable,
> +	.disable = dsi_encoder_disable,
> +};
> +
>   static int hisi_dsi_bind(struct device *dev, struct device *master,
>   			 void *data)
>   {
> @@ -52,8 +682,23 @@ static int hisi_dsi_bind(struct device *dev, struct device *master,
>
>   	hisi_drm_encoder_init(ctx->dev, &ctx->dsi.hisi_encoder.base.base);
>
> +#ifdef CONFIG_DRM_HISI_HAS_SLAVE_ENCODER
> +	ret = ctx->drm_i2c_driver->encoder_init(ctx->client, ctx->dev,
> +						&ctx->dsi.hisi_encoder.base);
> +	if (ret) {
> +		DRM_ERROR("fail to init drm i2c encoder\n");
> +		return ret;
> +	}
> +
> +	if (!ctx->dsi.hisi_encoder.base.slave_funcs) {
> +		DRM_ERROR("failed check encoder function\n");
> +		return -ENODEV;
> +	}
> +#endif

A slave encoder isn't supposed to be used this way. A slave encoder is
supposed to register itself to drm as an encoder object. A slave
encoder connects directly to a crtc, and operate like a normal encoder.
In other words, a slave encoder isn't something that attaches to a
'master' encoder as the driver does here. 'Slave encoder' here means
that the encoder is a part of a different bus (like i2c etc).

Currently, the driver is directly calling slave encoder ops in 
hisi_drm_encoder.c.


> +
>   	hisi_drm_connector_init(ctx->dev, &ctx->dsi.hisi_encoder.base.base,
>   				&ctx->dsi.hisi_connector.connector);
> +
>   	return ret;
>   }
>
> @@ -102,6 +747,27 @@ static int hisi_dsi_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>
> +#ifdef CONFIG_DRM_HISI_HAS_SLAVE_ENCODER
> +	ctx->client = of_find_i2c_device_by_node(slave_node);
> +	of_node_put(slave_node);
> +	if (!ctx->client) {
> +		DRM_ERROR("failed to find slave encoder i2c client\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	if (!ctx->client->dev.driver) {
> +		DRM_ERROR("%s: NULL client driver\n", __func__);
> +		return -EPROBE_DEFER;
> +	}
> +
> +	ctx->drm_i2c_driver = to_drm_i2c_encoder_driver(
> +		to_i2c_driver(ctx->client->dev.driver));
> +	if (IS_ERR(ctx->drm_i2c_driver)) {
> +		DRM_ERROR("failed to initialize encoder driver");
> +		return -EPROBE_DEFER;
> +	}
> +#endif
> +
>   	dsi = &ctx->dsi;
>   	dsi->ctx = ctx;
>   	dsi->lanes = 3;
> @@ -110,6 +776,10 @@ static int hisi_dsi_probe(struct platform_device *pdev)
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
>
> +	dsi->hisi_encoder.ops = &hisi_dsi_encoder_ops;
> +	dsi->hisi_connector.encoder = &dsi->hisi_encoder.base.base;
> +	dsi->hisi_connector.ops = &hisi_dsi_connector_ops;
> +
>   	return component_add(&pdev->dev, &hisi_dsi_ops);
>   }
>
> diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_encoder.c b/drivers/gpu/drm/hisilicon/hisi_drm_encoder.c
> index 89fc73d..acd73d8 100644
> --- a/drivers/gpu/drm/hisilicon/hisi_drm_encoder.c
> +++ b/drivers/gpu/drm/hisilicon/hisi_drm_encoder.c
> @@ -15,18 +15,49 @@
>
>   #include "hisi_drm_encoder.h"
>
> +#define to_hisi_encoder(encoder) \
> +	container_of(encoder, struct hisi_encoder, base.base)
> +
>   void hisi_drm_encoder_disable(struct drm_encoder *encoder)
>   {
> +	struct hisi_encoder *hencoder = to_hisi_encoder(encoder);
> +	struct hisi_encoder_funcs *ops = hencoder->ops;
> +	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
> +
> +	if (ops->enable)
> +		ops->disable(encoder);
> +
> +	if (sfuncs && sfuncs->dpms)
> +		sfuncs->dpms(encoder, DRM_MODE_DPMS_OFF);
>   }
>

The encoder should represent only the DSI encoder hardware here. It
shouldn't be calling slave encoder ops.

What you want is to have the encoder connect to a bridge. Something
like:

crtc(ade)->encoder(dsi)->bridge(adv7533)->connector

Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
