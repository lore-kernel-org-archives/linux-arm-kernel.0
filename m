From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 30 Nov 2015 08:54:32 +0100
Subject: [PATCH v2 06/10] drm/hisilicon: Add vblank feature
In-Reply-To: <1448707145-69348-7-git-send-email-xinliang.liu@linaro.org>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
 <1448707145-69348-7-git-send-email-xinliang.liu@linaro.org>
Message-ID: <20151130075432.GF17050@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2015 at 06:39:01PM +0800, Xinliang Liu wrote:
> Add vblank handle for ADE.
> 
> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---
>  drivers/gpu/drm/hisilicon/hisi_drm_ade.c | 78 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hisi_drm_ade.h | 16 +++++++
>  drivers/gpu/drm/hisilicon/hisi_drm_drv.c | 19 +++++++-
>  3 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_ade.h
> 
> diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_ade.c b/drivers/gpu/drm/hisilicon/hisi_drm_ade.c
> index b0976c3..acb11e7 100644
> --- a/drivers/gpu/drm/hisilicon/hisi_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/hisi_drm_ade.c
> @@ -267,7 +267,79 @@ static void ade_power_down(struct ade_hw_ctx *ctx)
>  	ctx->power_on = false;
>  }
>  
> +static struct drm_crtc *hisi_get_crtc_from_index(struct drm_device *dev,
> +						 unsigned int index)

Ugly that you had to add this, but unfortunately necessary :( Fixing up
the drm vblank hooks so that they deal with struct drm_crtc directly is
somewhere on my todo. But drm_irq.c is still a bit a mess, so this is some
ways off still.

What might be possible as a follow-up cleanup though is to add
vblank_enable and vblank_disable functions to struct
drm_crtc_helper_funcs. And then provide this code here to map from int
index to struct drm_crtc * as helpers in a new drm_vblank_helper.c file.
That might be a good intermediate step.

But nothing that needs to be done before merging hisilicon, that's for
sure.

One more comment below.

> +{
> +	unsigned int index_tmp = 0;
> +	struct drm_crtc *crtc;
> +
> +	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> +		if (index_tmp == index)
> +			return crtc;
> +
> +		index_tmp++;
> +	}
> +
> +	WARN_ON(true);
> +}
> +
> +int ade_enable_vblank(struct drm_device *dev, int crtc_index)
> +{
> +	struct drm_crtc *crtc = hisi_get_crtc_from_index(dev, crtc_index);
> +	struct ade_crtc *acrtc = to_ade_crtc(crtc);
> +	struct ade_hw_ctx *ctx = acrtc->ctx;
> +	void __iomem *base = ctx->base;
> +	u32 intr_en;
> +
> +	DRM_INFO("enable_vblank enter.\n");
> +	if (!ctx->power_on)
> +		(void)ade_power_up(ctx);
> +
> +	intr_en = readl(base + LDI_INT_EN);
> +	intr_en |= LDI_ISR_FRAME_END_INT;
> +	writel(intr_en, base + LDI_INT_EN);
>  
> +	return 0;
> +}
> +
> +void ade_disable_vblank(struct drm_device *dev, int crtc_index)
> +{
> +	struct drm_crtc *crtc = hisi_get_crtc_from_index(dev, crtc_index);
> +	struct ade_crtc *acrtc = to_ade_crtc(crtc);
> +	struct ade_hw_ctx *ctx = acrtc->ctx;
> +	void __iomem *base = ctx->base;
> +	u32 intr_en;
> +
> +	DRM_INFO("disable_vblank enter.\n");
> +	if (!ctx->power_on) {
> +		DRM_ERROR("power is down! vblank disable fail\n");
> +		return;
> +	}
> +	intr_en = readl(base + LDI_INT_EN);
> +	intr_en &= ~LDI_ISR_FRAME_END_INT;
> +	writel(intr_en, base + LDI_INT_EN);
> +}
> +
> +static irqreturn_t ade_irq_handler(int irq, void *data)
> +{
> +	struct ade_crtc *acrtc = data;
> +	struct ade_hw_ctx *ctx = acrtc->ctx;
> +	struct drm_crtc *crtc = &acrtc->base;
> +	struct drm_device *dev = crtc->dev;
> +	void __iomem *base = ctx->base;
> +	u32 status;
> +
> +	status = readl(base + LDI_MSK_INT);
> +	/* DRM_INFO("LDI IRQ: status=0x%X\n",status); */
> +
> +	/* vblank irq */
> +	if (status & LDI_ISR_FRAME_END_INT) {
> +		writel(LDI_ISR_FRAME_END_INT, base + LDI_INT_CLR);
> +		drm_handle_vblank(dev, drm_crtc_index(crtc));

drm_crtc_handle_vblank please. At least when calling into the vblank code
drivers don't have to do the struct drm_crtc -> int index conversion any
more. Please make sure you do that everywhere, in case I've missed one.

Cheers, Daniel

> +	}
> +
> +	return IRQ_HANDLED;
> +}
>  
>  /*
>   * set modules' reset mode: by software or hardware
> @@ -858,6 +930,12 @@ static int ade_bind(struct device *dev, struct device *master, void *data)
>  	if (ret)
>  		return ret;
>  
> +	/* vblank irq init */
> +	ret = request_irq(ctx->irq, ade_irq_handler, DRIVER_IRQ_SHARED,
> +			  drm_dev->driver->name, acrtc);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_ade.h b/drivers/gpu/drm/hisilicon/hisi_drm_ade.h
> new file mode 100644
> index 0000000..d1d7b5d
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hisi_drm_ade.h
> @@ -0,0 +1,16 @@
> +/*
> + * Copyright (c) 2014-2015 Hisilicon Limited.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __HISI_DRM_ADE_H__
> +#define __HISI_DRM_ADE_H__
> +
> +int ade_enable_vblank(struct drm_device *dev, int crtc_index);
> +void ade_disable_vblank(struct drm_device *dev, int crtc_index);
> +
> +#endif
> diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_drv.c b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
> index d0eca80..13f59aa 100644
> --- a/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
> @@ -21,6 +21,7 @@
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_atomic_helper.h>
>  
> +#include "hisi_drm_ade.h"
>  #include "hisi_drm_drv.h"
>  
>  #define DRIVER_NAME	"hisi-drm"
> @@ -29,6 +30,7 @@ static int hisi_drm_unload(struct drm_device *dev)
>  {
>  	struct hisi_drm_private *priv = dev->dev_private;
>  
> +	drm_vblank_cleanup(dev);
>  	drm_mode_config_cleanup(dev);
>  	devm_kfree(dev->dev, priv);
>  	dev->dev_private = NULL;
> @@ -76,11 +78,22 @@ static int hisi_drm_load(struct drm_device *dev, unsigned long flags)
>  		goto err_mode_config_cleanup;
>  	}
>  
> +	/* vblank init */
> +	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
> +	if (ret) {
> +		DRM_ERROR("failed to initialize vblank.\n");
> +		goto err_unbind_all;
> +	}
> +	/* with irq_enabled = true, we can use the vblank feature. */
> +	dev->irq_enabled = true;
> +
>  	/* reset all the states of crtc/plane/encoder/connector */
>  	drm_mode_config_reset(dev);
>  
>  	return 0;
>  
> +err_unbind_all:
> +	component_unbind_all(dev->dev, dev);
>  err_mode_config_cleanup:
>  	drm_mode_config_cleanup(dev);
>  	devm_kfree(dev->dev, priv);
> @@ -126,7 +139,7 @@ static int hisi_gem_cma_dumb_create(struct drm_file *file,
>  
>  static struct drm_driver hisi_drm_driver = {
>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
> -				  DRIVER_ATOMIC,
> +				  DRIVER_ATOMIC | DRIVER_HAVE_IRQ,
>  	.load			= hisi_drm_load,
>  	.unload                 = hisi_drm_unload,
>  	.fops			= &hisi_drm_fops,
> @@ -148,6 +161,10 @@ static struct drm_driver hisi_drm_driver = {
>  	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
>  	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
>  
> +	.get_vblank_counter	= drm_vblank_count,
> +	.enable_vblank		= ade_enable_vblank,
> +	.disable_vblank		= ade_disable_vblank,
> +
>  	.name			= "hisi",
>  	.desc			= "Hisilicon SoCs' DRM Driver",
>  	.date			= "20150718",
> -- 
> 1.9.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
