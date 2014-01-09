From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 09 Jan 2014 09:35:56 +0100
Subject: [PATCH v5 2/4] [media] exynos-scaler: Add core functionality for
 the SCALER driver
In-Reply-To: <1389238094-19386-3-git-send-email-shaik.ameer@samsung.com>
References: <1389238094-19386-1-git-send-email-shaik.ameer@samsung.com>
 <1389238094-19386-3-git-send-email-shaik.ameer@samsung.com>
Message-ID: <6360580.TZncfE63yq@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Thursday, January 09, 2014 08:58:12 AM Shaik Ameer Basha wrote:
> This patch adds the core functionality for the SCALER driver.
> 
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/media/platform/exynos-scaler/scaler.c | 1231 +++++++++++++++++++++++++
>  drivers/media/platform/exynos-scaler/scaler.h |  376 ++++++++
>  2 files changed, 1607 insertions(+)
>  create mode 100644 drivers/media/platform/exynos-scaler/scaler.c
>  create mode 100644 drivers/media/platform/exynos-scaler/scaler.h

[...]

> +static int scaler_probe(struct platform_device *pdev)
> +{
> +	struct scaler_dev *scaler;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	scaler = devm_kzalloc(dev, sizeof(*scaler), GFP_KERNEL);
> +	if (!scaler)
> +		return -ENOMEM;
> +
> +	scaler->pdev = pdev;
> +	scaler->variant = scaler_get_variant_data(pdev);
> +
> +	init_waitqueue_head(&scaler->irq_queue);
> +	spin_lock_init(&scaler->slock);
> +	mutex_init(&scaler->lock);
> +	scaler->clock = ERR_PTR(-EINVAL);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	scaler->regs = devm_request_and_ioremap(dev, res);
> +	if (!scaler->regs)
> +		return -ENODEV;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!res) {
> +		dev_err(dev, "failed to get IRQ resource\n");
> +		return -ENXIO;
> +	}
> +
> +	ret = scaler_clk_get(scaler);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_request_irq(dev, res->start, scaler_irq_handler,
> +				0, pdev->name, scaler);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to install irq (%d)\n", ret);
> +		goto err_clk;
> +	}
> +
> +	platform_set_drvdata(pdev, scaler);
> +	pm_runtime_enable(dev);
> +
> +	/* Initialize the continious memory allocator */
> +	scaler->alloc_ctx = vb2_dma_contig_init_ctx(dev);
> +	if (IS_ERR(scaler->alloc_ctx)) {
> +		ret = PTR_ERR(scaler->alloc_ctx);
> +		goto err_clk;
> +	}
> +
> +	ret = v4l2_device_register(dev, &scaler->v4l2_dev);
> +	if (ret < 0)
> +		goto err_clk;
> +
> +	ret = scaler_register_m2m_device(scaler);
> +	if (ret < 0)
> +		goto err_v4l2;
> +
> +	dev_info(dev, "registered successfully\n");
> +	return 0;
> +
> +err_v4l2:
> +	v4l2_device_unregister(&scaler->v4l2_dev);
> +err_clk:
> +	scaler_clk_put(scaler);

vb2_dma_contig_cleanup_ctx() and pm_runtime_disable() calls on
failure are missing

> +	return ret;
> +}
> +
> +static int scaler_remove(struct platform_device *pdev)
> +{
> +	struct scaler_dev *scaler = platform_get_drvdata(pdev);
> +
> +	scaler_unregister_m2m_device(scaler);
> +	v4l2_device_unregister(&scaler->v4l2_dev);
> +
> +	vb2_dma_contig_cleanup_ctx(scaler->alloc_ctx);
> +	pm_runtime_disable(&pdev->dev);
> +	scaler_clk_put(scaler);
> +
> +	scaler_dbg(scaler, "%s driver unloaded\n", pdev->name);
> +	return 0;
> +}

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
