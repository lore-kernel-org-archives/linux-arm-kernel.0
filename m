From: architt@codeaurora.org (Archit Taneja)
Date: Thu, 17 Sep 2015 16:43:57 +0530
Subject: [PATCH RFC 2/8] drm: hisilicon: Add new DRM driver for hisilicon
 Soc
In-Reply-To: <1442309834-21420-3-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1442309834-21420-3-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <55FAA075.4090200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 9/15/2015 3:07 PM, Xinwei Kong wrote:
> This patch creates this driver itself and register all the sub-components
> which is from DTS inode, this driver uses components framework mechanism
> to bind all the sub-components.
>
> This patch also introduces a memory manager for hisilison drm. As cma
> framebuffer helpers can no more be used.
>
> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
> Signed-off-by: Yu Gong <gongyu@hisilicon.com>
> ---
>   arch/arm64/configs/defconfig             |   5 +
>   drivers/gpu/drm/Kconfig                  |   2 +
>   drivers/gpu/drm/Makefile                 |   1 +
>   drivers/gpu/drm/hisilicon/Kconfig        |   9 ++
>   drivers/gpu/drm/hisilicon/Makefile       |   7 ++
>   drivers/gpu/drm/hisilicon/hisi_ade.c     | 166 +++++++++++++++++++++++++
>   drivers/gpu/drm/hisilicon/hisi_drm_drv.c | 206 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/hisilicon/hisi_drm_dsi.c | 131 ++++++++++++++++++++
>   drivers/gpu/drm/hisilicon/hisi_drm_fb.c  | 156 +++++++++++++++++++++++
>   drivers/gpu/drm/hisilicon/hisi_drm_fb.h  |  26 ++++
>   10 files changed, 709 insertions(+)
>   create mode 100644 drivers/gpu/drm/hisilicon/Kconfig
>   create mode 100644 drivers/gpu/drm/hisilicon/Makefile
>   create mode 100644 drivers/gpu/drm/hisilicon/hisi_ade.c
>   create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_drv.c
>   create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
>   create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fb.c
>   create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fb.h
>

<snip>

> diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
> new file mode 100644
> index 0000000..a8dbaad
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
> @@ -0,0 +1,131 @@
> +/*
> + * Hisilicon Terminal SoCs drm driver
> + *
> + * Copyright (c) 2014-2015 Hisilicon Limited.
> + * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_encoder_slave.h>
> +
> +#define DSI_24BITS_1               (5)
> +
> +struct hisi_dsi {
> +	u32 lanes;
> +	u32 format;
> +	u32 date_enable_pol;
> +	u32 mode_flags;
> +	u8 color_mode;
> +	void *ctx;
> +};
> +
> +struct hisi_dsi_context {
> +	struct hisi_dsi dsi;
> +	struct clk *dsi_cfg_clk;
> +	struct drm_device *dev;
> +
> +	void __iomem *base;
> +	int nominal_pixel_clk_kHz;
> +};
> +
> +static int hisi_dsi_bind(struct device *dev, struct device *master,
> +			 void *data)
> +{
> +	int ret = 0;
> +
> +	return ret;
> +}
> +
> +static void hisi_dsi_unbind(struct device *dev, struct device *master,
> +			    void *data)
> +{
> +	/* do nothing */
> +}
> +
> +static const struct component_ops hisi_dsi_ops = {
> +	.bind	= hisi_dsi_bind,
> +	.unbind	= hisi_dsi_unbind,
> +};
> +
> +static int hisi_dsi_probe(struct platform_device *pdev)
> +{
> +	struct hisi_dsi_context *ctx;
> +	struct hisi_dsi *dsi;
> +	struct resource *res;
> +	struct device_node *slave_node;
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret;
> +
> +	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx) {
> +		DRM_ERROR("failed to allocate hisi dsi context.\n");
> +		ret = -ENOMEM;
> +	}
> +
> +	ctx->dsi_cfg_clk = devm_clk_get(&pdev->dev, "pclk_dsi");
> +	if (IS_ERR(ctx->dsi_cfg_clk)) {
> +		DRM_ERROR("failed to parse the dsi config clock\n");
> +		ret = PTR_ERR(ctx->dsi_cfg_clk);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ctx->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ctx->base)) {
> +		DRM_ERROR("failed to remap dsi io region\n");
> +		ret = PTR_ERR(ctx->base);
> +	}
> +
> +	slave_node = of_parse_phandle(np, "encoder-slave", 0);
> +	if (!slave_node) {
> +		DRM_ERROR("failed to parse the slave encoder node\n");
> +		return -EINVAL;
> +	}
> +
> +	dsi = &ctx->dsi;
> +	dsi->ctx = ctx;
> +	dsi->lanes = 3;
> +	dsi->date_enable_pol = 0;
> +	dsi->color_mode = DSI_24BITS_1;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> +
> +	return component_add(&pdev->dev, &hisi_dsi_ops);
> +}
> +

The DSI driver should register the dsi host via 
mipi_dsi_host_register(). That's the standard way of establishing a
connection between a host and dsi peripherals.

The dsi_context approach isn't something that will work very well.
With this approach, you're forced to set DSI parameters like number of
lanes, format, mode flags etc in the host driver, rather than receiving
them from the connected device.

Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
