From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 24 Aug 2018 14:31:25 +0200
Subject: [PATCH v1 7/7] drm: add Atmel LCDC display controller support
In-Reply-To: <20180812184629.3808-7-sam@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-7-sam@ravnborg.org>
Message-ID: <20180824143125.4e99e791@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Noralf

Hi Sam,

On Sun, 12 Aug 2018 20:46:29 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

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
>  MAINTAINERS                           |    7 +
>  drivers/gpu/drm/atmel/Kconfig         |   12 +
>  drivers/gpu/drm/atmel/Makefile        |    2 +
>  drivers/gpu/drm/atmel/atmel_lcdc-dc.c | 1094 +++++++++++++++++++++++++++++++++
>  4 files changed, 1115 insertions(+)
>  create mode 100644 drivers/gpu/drm/atmel/atmel_lcdc-dc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09ce76a9a1dc..0a594d02a7c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4685,6 +4685,13 @@ F:	drivers/gpu/drm/atmel/atmel-hlcdc*
>  F:	Documentation/devicetree/bindings/display/atmel/
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
> +DRM DRIVERS FOR ATMEL LCDC
> +M:	Sam Ravnborg <sam@ravnborg.org>
> +L:	dri-devel at lists.freedesktop.org
> +S:	Maintained
> +F:	drivers/gpu/drm/atmel/atmel-lcdc*
> +F:	Documentation/devicetree/bindings/display/atmel/
> +

As stated in one of my previous replies, I think we should keep a
single entry for both drivers, just update the existing one and we
should be good.

>  DRM DRIVERS FOR BRIDGE CHIPS
>  M:	Archit Taneja <architt@codeaurora.org>
>  M:	Andrzej Hajda <a.hajda@samsung.com>

[...]

> +/*
> + * The Atmel LCD controller display-controller supports several formats but
> + * this driver supports only a small subset.
> + * TODO: atmel_lcdfb supports more - port it over
> + * Maybe actual wiring will impact mode support?
> + */
> +static const u32 lcdc_dc_formats[] = {
> +	DRM_FORMAT_BGR565,
> +};
> +
> +/* Start LCD Controller (DMA + PWR) */
> +static void lcdc_dc_start(struct lcdc_dc *lcdc_dc)
> +{
> +	// Enable DMA

Avoid using C++ style comments.

> +	regmap_write(lcdc_dc->regmap, ATMEL_LCDC_DMACON, ATMEL_LCDC_DMAEN);
> +	// Enable LCD
> +	regmap_write(lcdc_dc->regmap, ATMEL_LCDC_PWRCON,
> +		     (lcdc_dc->desc->guard_time << ATMEL_LCDC_GUARDT_OFFSET)
> +		     | ATMEL_LCDC_PWR);
> +}

> +
> +static int lcdc_dc_display_check(struct drm_simple_display_pipe *pipe,
> +				 struct drm_plane_state *pstate,
> +				 struct drm_crtc_state *cstate)
> +{
> +	const struct drm_display_mode *dmode;
> +	struct drm_framebuffer *old_fb;
> +	struct drm_framebuffer *fb;
> +
> +	dmode = &cstate->mode;
> +	old_fb = pipe->plane.state->fb;
> +	fb = pstate->fb;
> +
> +	/* Check timing? */

Did you look at what other simple DRM drivers check in this hook?

> +	/* TODO */
> +
> +	return 0;
> +}


> +
> +/* scheduled worker to reset LCD */
> +static void reset_lcdc_work(struct work_struct *work)
> +{
> +	struct lcdc_dc *lcdc_dc;
> +
> +	lcdc_dc = container_of(work, struct lcdc_dc, reset_lcdc_work);
> +

Hm, you need a lock to protect this section and you have to check the
LCDC state, because it might have been disabled through the ->disable()
hook just after you have scheduled this reset operation.

> +	lcdc_dc_stop(lcdc_dc);
> +	lcdc_dc_start(lcdc_dc);
> +}
> +
> +static irqreturn_t lcdc_dc_irq_handler(int irq, void *arg)
> +{
> +	struct lcdc_dc *lcdc_dc;
> +	struct drm_device *drm;
> +	unsigned int status;
> +	struct device *dev;
> +	unsigned int imr;
> +	unsigned int isr;
> +
> +	drm = arg;
> +	lcdc_dc = drm->dev_private;
> +	dev = lcdc_dc->dev;
> +
> +	regmap_read(lcdc_dc->regmap, ATMEL_LCDC_IMR, &imr);
> +	regmap_read(lcdc_dc->regmap, ATMEL_LCDC_ISR, &isr);
> +	status = imr & isr;
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	if (status & ATMEL_LCDC_LSTLNI)
> +		drm_crtc_handle_vblank(&lcdc_dc->pipe.crtc);
> +
> +	if (status & ATMEL_LCDC_UFLWI) {
> +		DRM_DEV_INFO(dev, "FIFO underflow %#x\n", status);
> +		/* reset DMA and FIFO to avoid screen shifting */
> +		schedule_work(&lcdc_dc->reset_lcdc_work);
> +	}

Add a blank line here.

> +	if (status & ATMEL_LCDC_OWRI)
> +		DRM_DEV_INFO(dev, "FIFO overwrite interrupt");
> +
> +	if (status & ATMEL_LCDC_MERI)
> +		DRM_DEV_INFO(dev, "DMA memory error");
> +
> +	/* Clear all reported (from ISR) interrupts */
> +	regmap_write(lcdc_dc->regmap, ATMEL_LCDC_ICR, isr);
> +
> +	return IRQ_HANDLED;
> +}
> +

[...]

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

		return ret;

> +	}
> +
> +	bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_Unknown);

drm_of_find_panel_or_bridge() might directly return a bridge. And maybe
we should declare a DPI connector. And finally, you can might want to
use devm_drm_panel_bridge_add() instead of drm_panel_bridge_add()

	if (panel)
		bridge = devm_drm_panel_bridge_add(dev, panel,
						   DRM_MODE_CONNECTOR_DPI);


> +	if (IS_ERR(bridge)) {
> +		ret = PTR_ERR(bridge);
> +		DRM_DEV_ERROR(dev, "Failed to add bridge (%d)", ret);
> +		goto err_panel_remove;

Hm, if drm_panel_bridge_add() failed, you shouldn't call
drm_panel_bridge_remove(bridge). You can just do

		return ret;

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

If you use devm_drm_panel_bridge_add(), you can return directly.

> +	}
> +
> +	ret = drm_simple_display_pipe_attach_bridge(&lcdc_dc->pipe, bridge);
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "failed to attach bridge (%d)", ret);
> +		goto err_panel_remove;

Ditto.

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

And now you should be able to get rid of the error path entirely.

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

Hm, do you really need to call that here? I'd make it part of the
runtime PM resume hook, and put a lcdc_dc_stop_clock() in the suspend
hook.

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

This call will automatically call the runtime PM resume hook, so if you
need the clk to be enabled before that point you should put it earlier.

Also, you should call pm_runtime_get_sync() in the ->enable() path and
pm_runtime_put() in the ->disable() path.

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

Isn't there a race here? What if there was a work queued but you
disabled the clk? I guess reg read/write accesses might fail (don't
know how bad this can go though).

> +
> +	return ret;
> +}
> +
> +static void lcdc_dc_unload(struct drm_device *dev)
> +{
> +	struct lcdc_dc *lcdc_dc = dev->dev_private;
> +
> +	drm_fb_cma_fbdev_fini(dev);
> +	flush_work(&lcdc_dc->reset_lcdc_work);
> +	drm_kms_helper_poll_fini(dev);
> +	if (lcdc_dc->panel)
> +		drm_panel_bridge_remove(lcdc_dc->bridge);

You can drop that one if you use the devm_ version.

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

And again, it might be too late. Should be moved just after disabling
the IRQ, since this is the only path where you queue this work.

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

That's all I see for now, but keep in mind that I don't know much about
the DRM simple interface, so you'd better wait for a review from
someone who knows better (Noralf?).

Regards,

Boris
