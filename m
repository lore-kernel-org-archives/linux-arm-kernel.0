From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 10 Jun 2013 13:10:18 +0200
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
Message-ID: <51B5B41A.7070306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/13 21:29, Russell King wrote:
> This patch adds support for the pair of LCD controllers on the Marvell
> Armada 510 SoCs.  This driver supports:
> - multiple contiguous scanout buffers for video and graphics
> - shm backed cacheable buffer objects for X pixmaps for Vivante GPU
>    acceleration
> - dual lcd0 and lcd1 crt operation
> - video overlay on each LCD crt
> - page flipping of the main scanout buffers
>
> Included in this commit is the core driver with no output support; output
> support is platform and encoder driver dependent.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
[...]
> diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
> new file mode 100644
> index 0000000..e5ab4cb
> --- /dev/null
> +++ b/drivers/gpu/drm/armada/armada_crtc.c
> @@ -0,0 +1,766 @@
> +/*
> + * Copyright (C) 2012 Russell King
> + *  Rewritten from the dovefb driver, and Armada510 manuals.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
[...]
> +static void armada_drm_crtc_update(struct armada_crtc *dcrtc)
> +{
> +	uint32_t dumb_ctrl;
> +
> +	dumb_ctrl = dcrtc->cfg_dumb_ctrl;
> +
> +	if (!dpms_blanked(dcrtc->dpms))
> +		dumb_ctrl |= CFG_DUMB_ENA;
> +
> +	/*
> +	 * When a dumb interface isn't under 24bit, it might be
> +	 * under SPI or GPIO.  If set to 7, this will force
> +	 * LCD_D[23:0] to output blank color and damage GPIO
> +	 * and SPI behaviour.  So leave it as-is unless in
> +	 * DUMB24_RGB888_0 mode.
> +	 */
> +	if (dpms_blanked(dcrtc->dpms) &&
> +	    (dumb_ctrl & DUMB_MASK) == DUMB24_RGB888_0) {
> +		dumb_ctrl &= ~DUMB_MASK;
> +		dumb_ctrl |= DUMB_BLANK;
> +	}
> +
> +	/*
> +	 * The spec is unclear about the polarities of the syncs.
> +	 * We assume their non-inverted state is active high.
> +	 */

nit: "We confirmed their non-inverted state is active high."

> +	if (dcrtc->crtc.mode.flags & DRM_MODE_FLAG_NCSYNC)
> +		dumb_ctrl |= CFG_INV_CSYNC;
> +	if (dcrtc->crtc.mode.flags & DRM_MODE_FLAG_NHSYNC)
> +		dumb_ctrl |= CFG_INV_HSYNC;
> +	if (dcrtc->crtc.mode.flags & DRM_MODE_FLAG_NVSYNC)
> +		dumb_ctrl |= CFG_INV_VSYNC;
> +
> +	if (dcrtc->dumb_ctrl != dumb_ctrl) {
> +		dcrtc->dumb_ctrl = dumb_ctrl;
> +		writel_relaxed(dumb_ctrl, dcrtc->base + LCD_SPU_DUMB_CTRL);
> +	}
> +}
[...]
> diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> new file mode 100644
> index 0000000..bb70cf5
> --- /dev/null
> +++ b/drivers/gpu/drm/armada/armada_drv.c
> @@ -0,0 +1,326 @@
> +/*
> + * Copyright (C) 2012 Russell King
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc_helper.h>
> +#include "armada_crtc.h"
> +#include "armada_drm.h"
> +#include "armada_gem.h"
> +#include "armada_hw.h"
> +#include "armada_ioctl.h"
> +#include "armada_ioctlP.h"
> +
> +static int armada_drm_load(struct drm_device *dev, unsigned long flags)
> +{
> +	struct armada_private *priv;
> +	struct resource *res[ARRAY_SIZE(priv->dcrtc)];
> +	struct resource *mem = NULL;
> +	int ret, n, i;
> +
> +	memset(res, 0, sizeof(res));
> +
> +	for (n = i = 0; ; n++) {
> +		struct resource *r = platform_get_resource(dev->platformdev,
> +							   IORESOURCE_MEM, n);
> +		if (!r)
> +			break;
> +
> +		if (resource_size(r) > SZ_4K)
> +			mem = r;

nit again: The register address window of Dove LCD is 64k although you 
are right an no more than 512B are used. Also a comment would be nice,
that everything above 4k (64k) is interpreted as gfx mem.

> +		else if (i < ARRAY_SIZE(priv->dcrtc))
> +			res[i++] = r;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	if (!res[0] || !mem)
> +		return -ENXIO;
> +
> +	if (!devm_request_mem_region(dev->dev, mem->start,
> +			resource_size(mem), "armada-drm"))
> +		return -EBUSY;
> +
> +	priv = devm_kzalloc(dev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		DRM_ERROR("failed to allocate private\n");
> +		ret = -ENOMEM;
> +		goto err_buf;
> +	}
> +
> +	dev->dev_private = priv;
> +
> +	/* Mode setting support */
> +	drm_mode_config_init(dev);
> +	dev->mode_config.min_width = 0;
> +	dev->mode_config.min_height = 0;
> +	dev->mode_config.max_width = 2048;
> +	dev->mode_config.max_height = 2048;
> +	dev->mode_config.preferred_depth = 24;
> +	dev->mode_config.funcs = &armada_drm_mode_config_funcs;
> +	drm_mm_init(&priv->linear, mem->start, resource_size(mem));
> +
> +	/* Create all LCD controllers */
> +	for (n = 0; n < ARRAY_SIZE(priv->dcrtc); n++) {
> +		struct clk *clk;
> +
> +		if (!res[n])
> +			break;
> +
> +		clk = clk_get_sys("dovefb.0", "extclk");

To be precise: the above should have the index at extclk as there
is two extclk inputs that can be used for both lcdcs. So currently,
as armada_crtc is hard-coding extclk0 input it should be
"armadafb.%d", "extclk0".

But I know, clocking in general will work-out with parent select for
clk-mux and DT support.

[...]
> diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
> new file mode 100644
> index 0000000..68c4efd
> --- /dev/null
> +++ b/drivers/gpu/drm/armada/armada_overlay.c
> @@ -0,0 +1,514 @@
> +/*
> + * Copyright (C) 2012 Russell King
> + *  Rewritten from the dovefb driver, and Armada510 manuals.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
[...]
> +int armada_overlay_put_image_ioctl(struct drm_device *dev, void *data,
> +	struct drm_file *file)
> +{
> +	struct drm_armada_overlay_put_image *args = data;
> +	struct armada_private *priv = dev->dev_private;
> +	struct armada_overlay *ovl = priv->overlay;
> +	struct armada_gem_object *obj;
> +	struct armada_crtc *dcrtc;
> +	uint32_t stride_uv, stride_yc, src_hw, dst_hw, dst_yx;
> +	bool planar = false;
> +	int ret, idx;
> +
> +	if (!ovl) {
> +		DRM_DEBUG_DRIVER("no overlay");
> +		return -ENODEV;
> +	}
> +
> +	if (!(args->flags & ARMADA_OVERLAY_ENABLE)) {
> +		mutex_lock(&dev->mode_config.mutex);
> +		mutex_lock(&dev->struct_mutex);
> +
> +		armada_drm_overlay_off(dev, ovl);
> +
> +		mutex_unlock(&dev->struct_mutex);
> +		mutex_unlock(&dev->mode_config.mutex);
> +
> +		return 0;
> +	}
> +
> +//	DRM_DEBUG_DRIVER("flags %x handle %x src %dx%d dst %dx%d+%d+%d\n",
> +//		args->flags, args->bo_handle, args->src_scan_width, args->src_scan_height,
> +//		args->dst_width, args->dst_height, args->dst_x, args->dst_y);

nit: Reminder for a hopefully soon to surface non-RFC patch.

[...]
> diff --git a/drivers/gpu/drm/armada/armada_slave.c b/drivers/gpu/drm/armada/armada_slave.c
> new file mode 100644
> index 0000000..422a345
> --- /dev/null
> +++ b/drivers/gpu/drm/armada/armada_slave.c
> @@ -0,0 +1,138 @@
> +/*
> + * Copyright (C) 2012 Russell King
> + *  Rewritten from the dovefb driver, and Armada510 manuals.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
[...]
> +static int armada_drm_conn_slave_create(struct drm_connector *conn, const void *data)
> +{
> +	const struct armada_drm_slave_config *config = data;
> +	struct drm_encoder_slave *slave;
> +	struct i2c_adapter *adap;
> +	int ret;
> +
> +	conn->interlace_allowed = config->interlace_allowed;
> +	conn->doublescan_allowed = config->doublescan_allowed;
> +	conn->polled = config->polled;
> +
> +	drm_connector_helper_add(conn, &armada_drm_slave_helper_funcs);
> +
> +	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
> +	if (!slave)
> +		return -ENOMEM;
> +
> +	slave->base.possible_crtcs = config->crtcs;
> +
> +	adap = i2c_get_adapter(config->i2c_adapter_id);
> +	if (!adap) {
> +		kfree(slave);
> +		return -EPROBE_DEFER;
> +	}
> +
> +	ret = drm_encoder_init(conn->dev, &slave->base,
> +			       &armada_drm_slave_encoder_funcs,
> +			       DRM_MODE_ENCODER_TMDS);
> +	if (ret) {
> +		DRM_ERROR("unable to init encoder\n");
> +		i2c_put_adapter(adap);
> +		kfree(slave);
> +		return ret;
> +	}
> +
> +	ret = drm_i2c_encoder_init(conn->dev, slave, adap, &config->info);
> +	i2c_put_adapter(adap);
> +	if (ret) {
> +		DRM_ERROR("unable to init encoder slave\n");
> +		armada_drm_slave_destroy(&slave->base);
> +		return ret;
> +	}
> +
> +	drm_encoder_helper_add(&slave->base, &drm_slave_encoder_helpers);
> +
> +	ret = slave->slave_funcs->create_resources(&slave->base, conn);
> +	if (ret) {
> +		armada_drm_slave_destroy(&slave->base);
> +		return ret;
> +	}
> +
> +	ret = drm_mode_connector_attach_encoder(conn, &slave->base);
> +	if (ret) {
> +		armada_drm_slave_destroy(&slave->base);
> +		return ret;
> +	}
> +
> +	conn->encoder = &slave->base;
> +
> +	return ret;
> +}
> +
> +static const struct armada_output_type armada_drm_conn_slave = {
> +	.connector_type	= DRM_MODE_CONNECTOR_HDMIA,

For a rework of DRM slave encoder API, there should also be some way to
get .connector_type and .encoder_type above from that slave encoder.
IMHO it should be up to the slave encoder to determine connector and
encoder type.

[...]
> diff --git a/drivers/gpu/drm/armada/armada_slave.h b/drivers/gpu/drm/armada/armada_slave.h
> new file mode 100644
> index 0000000..1b86696
> --- /dev/null
> +++ b/drivers/gpu/drm/armada/armada_slave.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (C) 2012 Russell King
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef ARMADA_TDA19988_H
> +#define ARMADA_TDA19988_H

nit: ARMADA_SLAVE_H

> +
> +#include <linux/i2c.h>
> +#include <drm/drmP.h>
> +
> +struct armada_drm_slave_config {
> +	int i2c_adapter_id;
> +	uint32_t crtcs;
> +	uint8_t polled;
> +	bool interlace_allowed;
> +	bool doublescan_allowed;
> +	struct i2c_board_info info;
> +};
> +
> +int armada_drm_connector_slave_create(struct drm_device *dev,
> +	const struct armada_drm_slave_config *);
> +
> +#endif

Thanks again for sharing the driver as RFC! Will test soon and post
promised tda998x sync patches.

Sebastian
