From: sam@ravnborg.org (Sam Ravnborg)
Date: Sun, 26 Aug 2018 20:41:21 +0200
Subject: [PATCH v1 7/7] drm: add Atmel LCDC display controller support
In-Reply-To: <20180824143125.4e99e791@bbrezillon>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-7-sam@ravnborg.org>
 <20180824143125.4e99e791@bbrezillon>
Message-ID: <20180826184121.GA24867@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris.

Very usefull feedback!
I am working on v2, and have addressed your review items.
Just a few comments below to a few items.
The rest is processed/done.

I hope to post v2 in the week to come.

> > +static int lcdc_dc_load(struct drm_device *drm)
> > +{
> > +	const struct of_device_id *match;
> > +	struct platform_device *pdev;
> > +	struct lcdc_dc *lcdc_dc;
> > +	struct device *dev;
> > +	int ret;
> > +
> > +	dev = drm->dev;
> > +	pdev = to_platform_device(dev);
> > +
> > +	match = of_match_node(atmel_lcdc_of_match, dev->parent->of_node);
> > +	if (!match) {
> > +		DRM_DEV_ERROR(dev, "invalid compatible string (node=%s)",
> > +			      dev->parent->of_node->name);
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (!match->data) {
> > +		DRM_DEV_ERROR(dev, "invalid lcdc_dc description\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	lcdc_dc = devm_kzalloc(dev, sizeof(*lcdc_dc), GFP_KERNEL);
> > +	if (!lcdc_dc) {
> > +		DRM_DEV_ERROR(dev, "Failed to allocate lcdc_dc\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* reset of lcdc might sleep and require a preemptible task context */
> > +	INIT_WORK(&lcdc_dc->reset_lcdc_work, reset_lcdc_work);
> > +
> > +	platform_set_drvdata(pdev, drm);
> > +	dev_set_drvdata(dev, lcdc_dc);
> > +
> > +	lcdc_dc->mfd_lcdc = dev_get_drvdata(dev->parent);
> > +	drm->dev_private = lcdc_dc;
> > +
> > +	lcdc_dc->regmap = lcdc_dc->mfd_lcdc->regmap;
> > +	lcdc_dc->desc = match->data;
> > +	lcdc_dc->dev = dev;
> > +
> > +	lcdc_dc->lcd_supply = devm_regulator_get(dev, "lcd");
> > +	if (IS_ERR(lcdc_dc->lcd_supply)) {
> > +		DRM_DEV_ERROR(dev, "Failed to get lcd-supply (%ld)\n",
> > +			      PTR_ERR(lcdc_dc->lcd_supply));
> > +		lcdc_dc->lcd_supply = NULL;
> > +	}
> > +
> > +	lcdc_dc_start_clock(lcdc_dc);
> 
> Hm, do you really need to call that here? I'd make it part of the
> runtime PM resume hook, and put a lcdc_dc_stop_clock() in the suspend
> hook.

As suggested I have introduced suspend/resume hooks and have included
start/stop clock calls.

But as the suspend/resume hooks depends on CONFIG_PM_SLEEP I
still need the explicit call in this function.

> > +
> > +	pm_runtime_enable(dev);
> > +
> > +	ret = drm_vblank_init(drm, 1);
> > +	if (ret) {
> > +		DRM_DEV_ERROR(dev, "failed to initialize vblank (%d)\n",
> > +			      ret);
> > +		goto err_pm_runtime_disable;
> > +	}
> > +
> > +	ret = lcdc_dc_modeset_init(lcdc_dc, drm);
> > +	if (ret) {
> > +		DRM_DEV_ERROR(dev, "modeset_init failed (%d)", ret);
> > +		goto err_pm_runtime_disable;
> > +	}
> > +
> > +	pm_runtime_get_sync(dev);
> 
> This call will automatically call the runtime PM resume hook, so if you
> need the clk to be enabled before that point you should put it earlier.
> 
> Also, you should call pm_runtime_get_sync() in the ->enable() path and
> pm_runtime_put() in the ->disable() path.
Good catch! Added.

	Sam
