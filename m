From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Tue, 15 Aug 2017 23:49:56 +0200
Subject: [PATCH 2/4] drm/tve200: Add new driver for TVE200
In-Reply-To: <20170813151132.24736-3-linus.walleij@linaro.org>
References: <20170813151132.24736-1-linus.walleij@linaro.org>
 <20170813151132.24736-3-linus.walleij@linaro.org>
Message-ID: <e1004ea1-bd36-e3e4-c4e7-23d38a969e77@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 13.08.2017 17.11, skrev Linus Walleij:
> This adds a new DRM driver for the Faraday Technology TVE200
> block. This "TV Encoder" encodes a ITU-T BT.656 stream and can
> be found in the StorLink SL3516 (later Cortina Systems CS3516)
> as well as the Grain Media GM8180.
>
> I do not have definitive word from anyone at Faraday that this
> IP block is theirs, but it bears the hallmark of their 3-digit
> version code (200) and is used in two SoCs from completely
> different companies. (Grain Media was fully owned by Faraday
> until it was transferred to NovoTek this january, and
> Faraday did lots of work on the StorLink SoCs.)
>
> The D-Link DIR-685 uses this in connection with the Ilitek
> ILI9322 panel driver that supports BT.656 input, while the
> GM8180 apparently has been used with the Cirrus Logic CS4954
> digital video encoder. The oldest user seems to be
> something called Techwall 2835.
>
> This driver is heavily inspired by Eric Anholt's PL111
> driver and therefore I have mentioned all the ancestor authors
> in the header file.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

[...]

> diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c

[...]

> +static struct drm_driver tve200_drm_driver = {
> +	.driver_features =
> +		DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME | DRIVER_ATOMIC,
> +	.lastclose = tve200_lastclose,
> +	.ioctls = NULL,
> +	.fops = &drm_fops,
> +	.name = "tve200",
> +	.desc = DRIVER_DESC,
> +	.date = "20170703",
> +	.major = 1,
> +	.minor = 0,
> +	.patchlevel = 0,
> +	.dumb_create = drm_gem_cma_dumb_create,
> +	.dumb_destroy = drm_gem_dumb_destroy,
> +	.dumb_map_offset = drm_gem_cma_dumb_map_offset,

The dumb_destroy and dumb_map_offset callbacks have defaults now that
fits the cma helper drivers so you don't need to set them. And
drm_gem_cma_dumb_map_offset() is gone as soon as I get and ack on the
remaining cleanup patches.

Noralf.

> +	.gem_free_object = drm_gem_cma_free_object,
> +	.gem_vm_ops = &drm_gem_cma_vm_ops,
> +
> +	.enable_vblank = tve200_enable_vblank,
> +	.disable_vblank = tve200_disable_vblank,
> +
> +	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> +	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> +	.gem_prime_import = drm_gem_prime_import,
> +	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> +	.gem_prime_export = drm_gem_prime_export,
> +	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
> +};
> +
> +static int tve200_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tve200_drm_dev_private *priv;
> +	struct drm_device *drm;
> +	struct resource *res;
> +	int irq;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	drm = drm_dev_alloc(&tve200_drm_driver, dev);
> +	if (IS_ERR(drm))
> +		return PTR_ERR(drm);
> +	platform_set_drvdata(pdev, drm);
> +	priv->drm = drm;
> +	drm->dev_private = priv;
> +
> +	/* Clock the silicon so we can access the registers */
> +	priv->pclk = devm_clk_get(dev, "PCLK");
> +	if (IS_ERR(priv->pclk)) {
> +		dev_err(dev, "unable to get PCLK\n");
> +		ret = PTR_ERR(priv->pclk);
> +		goto dev_unref;
> +	}
> +	ret = clk_prepare_enable(priv->pclk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable PCLK\n");
> +		goto dev_unref;
> +	}
> +
> +	/* This clock is for the pixels (27MHz) */
> +	priv->clk = devm_clk_get(dev, "TVE");
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(dev, "unable to get TVE clock\n");
> +		ret = PTR_ERR(priv->clk);
> +		goto clk_disable;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->regs = devm_ioremap_resource(dev, res);
> +	if (!priv->regs) {
> +		dev_err(dev, "%s failed mmio\n", __func__);
> +		ret = -EINVAL;
> +		goto dev_unref;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (!irq) {
> +		ret = -EINVAL;
> +		goto dev_unref;
> +	}
> +
> +	/* turn off interrupts before requesting the irq */
> +	writel(0, priv->regs + TVE200_INT_EN);
> +
> +	ret = devm_request_irq(dev, irq, tve200_irq, 0, "tve200", priv);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = tve200_modeset_init(drm);
> +	if (ret)
> +		goto dev_unref;
> +
> +	ret = drm_dev_register(drm, 0);
> +	if (ret < 0)
> +		goto dev_unref;
> +
> +	return 0;
> +
> +clk_disable:
> +	clk_disable_unprepare(priv->pclk);
> +dev_unref:
> +	drm_dev_unref(drm);
> +	return ret;
> +}
> +
> +static int tve200_remove(struct platform_device *pdev)
> +{
> +	struct drm_device *drm = platform_get_drvdata(pdev);
> +	struct tve200_drm_dev_private *priv = drm->dev_private;
> +
> +	drm_dev_unregister(drm);
> +	if (priv->fbdev)
> +		drm_fbdev_cma_fini(priv->fbdev);
> +	drm_mode_config_cleanup(drm);
> +	clk_disable_unprepare(priv->pclk);
> +	drm_dev_unref(drm);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id tve200_of_match[] = {
> +	{
> +		.compatible = "faraday,tve200",
> +	},
> +	{},
> +};
> +
> +static struct platform_driver tve200_driver = {
> +	.driver = {
> +		.name           = "tve200",
> +		.of_match_table = of_match_ptr(tve200_of_match),
> +	},
> +	.probe = tve200_probe,
> +	.remove = tve200_remove,
> +};
> +module_platform_driver(tve200_driver);
> +
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> +MODULE_LICENSE("GPL");
