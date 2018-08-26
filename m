From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Sun, 26 Aug 2018 16:28:13 +0200
Subject: [PATCH v1 7/7] drm: add Atmel LCDC display controller support
In-Reply-To: <20180812184629.3808-7-sam@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-7-sam@ravnborg.org>
Message-ID: <8581453a-8abe-c321-17c1-493f805510b1@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 12.08.2018 20.46, skrev Sam Ravnborg:
> This is a DRM based driver for the Atmel LCDC IP.
> There exist today a framebuffer based driver and
> this is a re-implmentation of the same on top of DRM.
>
> The rewrite was based on the original fbdev driver
> but the driver has also seen inspiration from
> the atmel-hlcdc_dc driver and others.
>
> The driver is not a full replacement:
> - STN displays are not supported
> 	Binding support is missing but most of the
> 	STN specific functionality is otherwise ported
> 	from the fbdev driver.
> - gamma support is missing
> 	The driver utilises drm_simple_kms_helper and
> 	this helper lacks support for settting up gamma
> - modesetting is not checked (see TODO in file)
> - support for extra modes as applicable (and lcd-wiring-mode)
> - support for AVR32 (is it relevant?)
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   MAINTAINERS                           |    7 +
>   drivers/gpu/drm/atmel/Kconfig         |   12 +
>   drivers/gpu/drm/atmel/Makefile        |    2 +
>   drivers/gpu/drm/atmel/atmel_lcdc-dc.c | 1094 +++++++++++++++++++++++++++++++++
>   4 files changed, 1115 insertions(+)
>   create mode 100644 drivers/gpu/drm/atmel/atmel_lcdc-dc.c
>

<snip>

> diff --git a/drivers/gpu/drm/atmel/atmel_lcdc-dc.c b/drivers/gpu/drm/atmel/atmel_lcdc-dc.c
> new file mode 100644
> index 000000000000..275a09e2e100
> --- /dev/null
> +++ b/drivers/gpu/drm/atmel/atmel_lcdc-dc.c
> @@ -0,0 +1,1094 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Sam Ravnborg
> + *
> + * The driver is based on atmel_lcdfb which is:
> + * Copyright (C) 2007 Atmel Corporation
> + *
> + * Atmel LCD Controller Display Controller.
> + * A sub-device of the Atmel LCDC IP.
> + *
> + * The Atmel LCD Controller supports in the following configuration:
> + * - TFT only, with BGR565, 8 bits/pixel
> + * - Resolution up to 2048x2048
> + * - Single plane, crtc, one fixed output
> + *
> + * Features not (yet) ported from atmel_lcdfb:
> + * - Support for extra modes (and configurable intensify bit)
> + * - Check modesetting support - lcdc_dc_display_check()
> + * - set color / palette handling
> + * - support for STN displays (partly implemented)
> + * - AVR32 support (relevant?)
> + */
> +
> +#include <linux/regulator/consumer.h>
> +#include <linux/mfd/atmel-lcdc.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/irqreturn.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +
> +#include <video/videomode.h>
> +
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_vblank.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_of.h>
> +
> +/* Parameters */
> +#define ATMEL_LCDC_DMA_BURST_LEN	8	/* words */
> +
> +/**
> + * struct atmel_lcdc_dc_desc - CPU specific configuration properties
> + */
> +struct atmel_lcdc_dc_desc {
> +	int guard_time;
> +	int fifo_size;
> +	int min_width;
> +	int min_height;
> +	int max_width;
> +	int max_height;
> +	bool have_hozval;
> +	bool have_alt_pixclock;
> +};
> +
> +/* private data */
> +struct lcdc_dc {
> +	const struct atmel_lcdc_dc_desc *desc;
> +	struct atmel_mfd_lcdc *mfd_lcdc;
> +	struct regulator *lcd_supply;
> +	struct drm_fbdev_cma *fbdev;

There's generic fbdev emulaton now, so you can drop this.
More info further down.

> +	struct drm_bridge *bridge;
> +	struct drm_panel *panel;
> +	struct regmap *regmap;
> +	struct device *dev;
> +
> +	struct drm_simple_display_pipe pipe;
> +	struct work_struct reset_lcdc_work;
> +	struct drm_connector connector;
> +};
> +
> +/* Configuration of individual CPU's */
> +static const struct atmel_lcdc_dc_desc atmel_lcdc_dc_at91sam9261 = {
> +	.guard_time = 1,
> +	.fifo_size = 512,
> +	.min_width = 0,
> +	.min_height = 0,

Looks like the minimum is always zero, maybe drop it?

> +	.max_width = 2048,
> +	.max_height = 2048,
> +	.have_hozval = true,
> +	.have_alt_pixclock = false,
> +};
> +
> +static const struct atmel_lcdc_dc_desc atmel_lcdc_dc_at91sam9263 = {
> +	.guard_time = 1,
> +	.fifo_size = 2048,
> +	.min_width = 0,
> +	.min_height = 0,
> +	.max_width = 2048,
> +	.max_height = 2048,
> +	.have_hozval = false,
> +	.have_alt_pixclock = false,
> +};
> +
> +static const struct atmel_lcdc_dc_desc atmel_lcdc_dc_at91sam9g10 = {
> +	.guard_time = 1,
> +	.fifo_size = 512,
> +	.min_width = 0,
> +	.min_height = 0,
> +	.max_width = 2048,
> +	.max_height = 2048,
> +	.have_hozval = true,
> +	.have_alt_pixclock = false,
> +};
> +
> +static const struct atmel_lcdc_dc_desc atmel_lcdc_dc_at91sam9g45 = {
> +	.guard_time = 1,
> +	.fifo_size = 512,
> +	.min_width = 0,
> +	.min_height = 0,
> +	.max_width = 2048,
> +	.max_height = 2048,
> +	.have_hozval = false,
> +	.have_alt_pixclock = true,
> +};
> +
> +static const struct atmel_lcdc_dc_desc atmel_lcdc_dc_at91sam9g46 = {
> +	.guard_time = 1,
> +	.fifo_size = 512,
> +	.min_width = 0,
> +	.min_height = 0,
> +	.max_width = 2048,
> +	.max_height = 2048,
> +	.have_hozval = false,
> +	.have_alt_pixclock = false,
> +};
> +
> +static const struct atmel_lcdc_dc_desc atmel_lcdc_dc_at91sam9m10 = {
> +	.guard_time = 1,
> +	.fifo_size = 512,
> +	.min_width = 0,
> +	.min_height = 0,
> +	.max_width = 2048,
> +	.max_height = 2048,
> +	.have_hozval = false,
> +	.have_alt_pixclock = false,
> +};
> +
> +static const struct atmel_lcdc_dc_desc atmel_lcdc_dc_at91sam9m11 = {
> +	.guard_time = 1,
> +	.fifo_size = 512,
> +	.min_width = 0,
> +	.min_height = 0,
> +	.max_width = 2048,
> +	.max_height = 2048,
> +	.have_hozval = false,
> +	.have_alt_pixclock = false,
> +};
> +
> +static const struct atmel_lcdc_dc_desc atmel_lcdc_dc_at91sam9rl = {
> +	.guard_time = 1,
> +	.fifo_size = 512,
> +	.min_width = 0,
> +	.min_height = 0,
> +	.max_width = 2048,
> +	.max_height = 2048,
> +	.have_hozval = false,
> +	.have_alt_pixclock = false,
> +};

<snip>

> +DEFINE_DRM_GEM_CMA_FOPS(lcdc_dc_drm_fops);
> +
> +static struct drm_driver lcdc_dc_drm_driver = {
> +	.driver_features = DRIVER_HAVE_IRQ |
> +			   DRIVER_GEM |
> +			   DRIVER_MODESET |
> +			   DRIVER_PRIME |
> +			   DRIVER_ATOMIC,
> +	.name = "atmel-lcdc",
> +	.desc = "Atmel LCD Display Controller DRM",
> +	.date = "20180808",
> +	.major = 1,
> +	.minor = 0,
> +	.patchlevel = 0,
> +
> +	.lastclose = drm_fb_helper_lastclose,

You can drop this, lastclose is handled by the generic fbdev emulation.

> +	.fops = &lcdc_dc_drm_fops,
> +
> +	.irq_handler = lcdc_dc_irq_handler,
> +	.irq_preinstall = lcdc_dc_irq_uninstall,
> +	.irq_postinstall = lcdc_dc_irq_postinstall,
> +	.irq_uninstall = lcdc_dc_irq_uninstall,
> +
> +	.dumb_create = drm_gem_cma_dumb_create,
> +
> +	.gem_print_info = drm_gem_cma_print_info,
> +	.gem_vm_ops = &drm_gem_cma_vm_ops,
> +
> +	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> +	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> +
> +	.gem_prime_import = drm_gem_prime_import,
> +	.gem_prime_export = drm_gem_prime_export,
> +
> +	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
> +	.gem_free_object_unlocked = drm_gem_cma_free_object,
> +
> +	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> +	.gem_prime_vmap = drm_gem_cma_prime_vmap,
> +	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
> +	.gem_prime_mmap = drm_gem_cma_prime_mmap,
> +};
> +
> +static int lcdc_dc_modeset_init(struct lcdc_dc *lcdc_dc, struct drm_device *drm)
> +{
> +	struct drm_bridge *bridge;
> +	struct drm_panel *panel;
> +	struct device_node *np;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = drm->dev;
> +
> +	drm_mode_config_init(drm);
> +	drm->mode_config.min_width  = lcdc_dc->desc->min_width;
> +	drm->mode_config.min_height = lcdc_dc->desc->min_height;
> +	drm->mode_config.max_width  = lcdc_dc->desc->max_width;
> +	drm->mode_config.max_height = lcdc_dc->desc->max_height;
> +	drm->mode_config.funcs	    = &mode_config_funcs;
> +
> +	np = dev->of_node;
> +	/* port at 0 is the output port */
> +	ret = drm_of_find_panel_or_bridge(np, 0, 0, &panel, &bridge);
> +	if (ret && ret != -ENODEV) {
> +		DRM_DEV_ERROR(dev, "Failed to find panel (%d)\n", ret);
> +		goto err_out;
> +	}
> +
> +	bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_Unknown);
> +	if (IS_ERR(bridge)) {
> +		ret = PTR_ERR(bridge);
> +		DRM_DEV_ERROR(dev, "Failed to add bridge (%d)", ret);
> +		goto err_panel_remove;
> +	}
> +
> +	lcdc_dc->panel = panel;
> +	lcdc_dc->bridge = bridge;
> +
> +	ret = drm_simple_display_pipe_init(drm,
> +					   &lcdc_dc->pipe,
> +					   &lcdc_dc_display_funcs,
> +					   lcdc_dc_formats,
> +					   ARRAY_SIZE(lcdc_dc_formats),
> +					   NULL,
> +					   &lcdc_dc->connector);
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "Failed to init display pipe (%d)\n", ret);
> +		goto err_panel_remove;
> +	}
> +
> +	ret = drm_simple_display_pipe_attach_bridge(&lcdc_dc->pipe, bridge);
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "failed to attach bridge (%d)", ret);
> +		goto err_panel_remove;
> +	}
> +
> +	drm_mode_config_reset(drm);
> +
> +	return 0;
> +
> +err_panel_remove:
> +	if (panel)
> +		drm_panel_bridge_remove(bridge);
> +
> +err_out:
> +	return ret;
> +}
> +
> +static int lcdc_dc_load(struct drm_device *drm)
> +{
> +	const struct of_device_id *match;
> +	struct platform_device *pdev;
> +	struct lcdc_dc *lcdc_dc;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = drm->dev;
> +	pdev = to_platform_device(dev);
> +
> +	match = of_match_node(atmel_lcdc_of_match, dev->parent->of_node);
> +	if (!match) {
> +		DRM_DEV_ERROR(dev, "invalid compatible string (node=%s)",
> +			      dev->parent->of_node->name);
> +		return -ENODEV;
> +	}
> +
> +	if (!match->data) {
> +		DRM_DEV_ERROR(dev, "invalid lcdc_dc description\n");
> +		return -EINVAL;
> +	}
> +
> +	lcdc_dc = devm_kzalloc(dev, sizeof(*lcdc_dc), GFP_KERNEL);
> +	if (!lcdc_dc) {
> +		DRM_DEV_ERROR(dev, "Failed to allocate lcdc_dc\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* reset of lcdc might sleep and require a preemptible task context */
> +	INIT_WORK(&lcdc_dc->reset_lcdc_work, reset_lcdc_work);
> +
> +	platform_set_drvdata(pdev, drm);
> +	dev_set_drvdata(dev, lcdc_dc);
> +
> +	lcdc_dc->mfd_lcdc = dev_get_drvdata(dev->parent);
> +	drm->dev_private = lcdc_dc;
> +
> +	lcdc_dc->regmap = lcdc_dc->mfd_lcdc->regmap;
> +	lcdc_dc->desc = match->data;
> +	lcdc_dc->dev = dev;
> +
> +	lcdc_dc->lcd_supply = devm_regulator_get(dev, "lcd");
> +	if (IS_ERR(lcdc_dc->lcd_supply)) {
> +		DRM_DEV_ERROR(dev, "Failed to get lcd-supply (%ld)\n",
> +			      PTR_ERR(lcdc_dc->lcd_supply));
> +		lcdc_dc->lcd_supply = NULL;
> +	}
> +
> +	lcdc_dc_start_clock(lcdc_dc);
> +
> +	pm_runtime_enable(dev);
> +
> +	ret = drm_vblank_init(drm, 1);
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "failed to initialize vblank (%d)\n",
> +			      ret);
> +		goto err_pm_runtime_disable;
> +	}
> +
> +	ret = lcdc_dc_modeset_init(lcdc_dc, drm);
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "modeset_init failed (%d)", ret);
> +		goto err_pm_runtime_disable;
> +	}
> +
> +	pm_runtime_get_sync(dev);
> +	ret = drm_irq_install(drm, lcdc_dc->mfd_lcdc->irq);
> +	pm_runtime_put_sync(dev);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to install IRQ (%d)\n", ret);
> +
> +		goto err_pm_runtime_disable;
> +	}
> +
> +	/*
> +	 * Passing in 16 here will make the RGB656 mode the default
> +	 * Passing in 32 will use XRGB8888 mode
> +	 */
> +	drm_fb_cma_fbdev_init(drm, 16, 0);

You are using both drm_fb_cma_fbdev_init() and drm_fbdev_cma_init() which
does the same. I'm to blame for the confusion, the generic fbdev emulation
idea came up during refactoring, so there's an old way and a new way, which
is now obsolete (both will be removed when drivers have been converted to
drm_fbdev_generic_setup()).

You can use drm_fbdev_generic_setup(drm, 16) instead, and that's all you
need to get fbdev emulation.

I see that many drivers register fbdev before they register the DRM device.
Personally I find this strange to make the emulated device available
before the real one. I suggest you call drm_fbdev_generic_setup() after
drm_dev_register() and if it fails, just put a note in the log and let the
driver succeed in probing.

> +
> +	drm_kms_helper_poll_init(drm);
> +
> +	lcdc_dc->fbdev = drm_fbdev_cma_init(drm, 8, 1);
> +	if (IS_ERR(lcdc_dc->fbdev)) {
> +		ret = PTR_ERR(lcdc_dc->fbdev);
> +		DRM_DEV_ERROR(dev, "Failed to init FB CMA area (%d)", ret);
> +		goto err_irq_uninstall;
> +	}
> +
> +	drm_helper_hpd_irq_event(drm);
> +
> +	return 0;
> +
> +err_irq_uninstall:
> +	pm_runtime_get_sync(dev);
> +	drm_irq_uninstall(drm);
> +	pm_runtime_put_sync(dev);
> +
> +err_pm_runtime_disable:
> +	pm_runtime_disable(dev);
> +	lcdc_dc_stop_clock(lcdc_dc);
> +
> +	cancel_work_sync(&lcdc_dc->reset_lcdc_work);
> +
> +	return ret;
> +}
> +
> +static void lcdc_dc_unload(struct drm_device *dev)
> +{
> +	struct lcdc_dc *lcdc_dc = dev->dev_private;
> +
> +	drm_fb_cma_fbdev_fini(dev);

You can remove this. fbdev is automatically unregistered by
drm_dev_unregister().

Noralf.

> +	flush_work(&lcdc_dc->reset_lcdc_work);
> +	drm_kms_helper_poll_fini(dev);
> +	if (lcdc_dc->panel)
> +		drm_panel_bridge_remove(lcdc_dc->bridge);
> +	drm_mode_config_cleanup(dev);
> +
> +	pm_runtime_get_sync(dev->dev);
> +	drm_irq_uninstall(dev);
> +	pm_runtime_put_sync(dev->dev);
> +
> +	dev->dev_private = NULL;
> +
> +	pm_runtime_disable(dev->dev);
> +	lcdc_dc_stop_clock(lcdc_dc);
> +	cancel_work_sync(&lcdc_dc->reset_lcdc_work);
> +}
> +
> +
> +static int lcdc_dc_probe(struct platform_device *pdev)
> +{
> +	struct drm_device *drm;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = &pdev->dev;
> +
> +	drm = drm_dev_alloc(&lcdc_dc_drm_driver, dev);
> +	if (IS_ERR(drm)) {
> +		DRM_DEV_ERROR(dev, "Failed to allocate drm device\n");
> +		return PTR_ERR(drm);
> +	}
> +
> +	ret = lcdc_dc_load(drm);
> +	if (ret)
> +		goto err_put_ref;
> +
> +	ret = drm_dev_register(drm, 0);
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "Failed to register drm (%d)\n", ret);
> +		goto err_unload;
> +	}
> +
> +	return 0;
> +
> +err_unload:
> +	lcdc_dc_unload(drm);
> +
> +err_put_ref:
> +	drm_dev_put(drm);
> +	return ret;
> +}
> +
> +static int lcdc_dc_remove(struct platform_device *pdev)
> +{
> +	struct drm_device *drm;
> +
> +	drm = platform_get_drvdata(pdev);
> +
> +	drm_dev_unregister(drm);
> +	lcdc_dc_unload(drm);
> +	drm_dev_unref(drm);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id lcdc_dc_dt_ids[] = {
> +	{ .compatible = "atmel,lcdc-display-controller", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, lcdc_dc_dt_ids);
> +
> +static struct platform_driver lcdc_dc_driver = {
> +	.probe		= lcdc_dc_probe,
> +	.remove		= lcdc_dc_remove,
> +	.driver		= {
> +		.of_match_table = lcdc_dc_dt_ids,
> +		.name	= "atmel-lcdc-dc",
> +	},
> +};
> +
> +module_platform_driver(lcdc_dc_driver);
> +
> +MODULE_AUTHOR("Sam Ravnborg <sam@ravnborg.org>");
> +MODULE_DESCRIPTION("Atmel LCDC Display Controller DRM Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:atmel-lcdc-dc");
