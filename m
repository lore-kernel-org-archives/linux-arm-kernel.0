From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 30 Aug 2016 22:00:19 +0530
Subject: [PATCH v8 05/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <1472223413-7254-6-git-send-email-peter.griffin@linaro.org>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
 <1472223413-7254-6-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160830163019.GM9355@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 03:56:40PM +0100, Peter Griffin wrote:

>  config STM32_DMA
>  	bool "STMicroelectronics STM32 DMA support"
>  	depends on ARCH_STM32
> @@ -567,7 +580,6 @@ config ZX_DMA
>  	help
>  	  Support the DMA engine for ZTE ZX296702 platform devices.
>  
> -

unrelated change?

> +	fdev->chans = devm_kzalloc(&pdev->dev,
> +				   fdev->nr_channels
> +				   * sizeof(struct st_fdma_chan), GFP_KERNEL);

devm_kcalloc()

> +	if (!fdev->chans)
> +		return -ENOMEM;
> +
> +	fdev->dev = &pdev->dev;
> +	fdev->drvdata = drvdata;
> +	platform_set_drvdata(pdev, fdev);
> +
> +	fdev->irq = platform_get_irq(pdev, 0);
> +	if (fdev->irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq resource\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, fdev->irq, st_fdma_irq_handler, 0,
> +			       dev_name(&pdev->dev), fdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request irq (%d)\n", ret);
> +		goto err;
> +	}
> +
> +	fdev->slim_rproc = st_slim_rproc_alloc(pdev, fdev->fw_name);
> +	if (!fdev->slim_rproc) {
> +		ret = PTR_ERR(fdev->slim_rproc);
> +		dev_err(&pdev->dev, "slim_rproc_alloc failed (%d)\n", ret);
> +		goto err;
> +	}
> +
> +	/* Initialise list of FDMA channels */
> +	INIT_LIST_HEAD(&fdev->dma_device.channels);
> +	for (i = 0; i < fdev->nr_channels; i++) {
> +		struct st_fdma_chan *fchan = &fdev->chans[i];
> +
> +		fchan->fdev = fdev;
> +		fchan->vchan.desc_free = st_fdma_free_desc;
> +		vchan_init(&fchan->vchan, &fdev->dma_device);

this initialized a tasklet

> +static int st_fdma_remove(struct platform_device *pdev)
> +{
> +	struct st_fdma_dev *fdev = platform_get_drvdata(pdev);
> +
> +	devm_free_irq(&pdev->dev, fdev->irq, fdev);
> +	st_slim_rproc_put(fdev->slim_rproc);
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&fdev->dma_device);

and that vchan tasklet is not quisced here :(

> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("STMicroelectronics FDMA engine driver");
> +MODULE_AUTHOR("Ludovic.barre <Ludovic.barre@st.com>");
> +MODULE_AUTHOR("Peter Griffin <peter.griffin@linaro.org>");

No MODULE_ALIAS?

-- 
~Vinod
