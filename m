From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 25 May 2016 10:27:23 -0700
Subject: [PATCH v4 06/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <1464192412-16386-8-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-8-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160525172723.GU1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 25 May 09:06 PDT 2016, Peter Griffin wrote:

> diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
[..]
> +
> +static int st_fdma_alloc_chan_res(struct dma_chan *chan)
> +{
> +	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
> +	int ret;
> +
> +	/* Create the dma pool for descriptor allocation */
> +	fchan->node_pool = dma_pool_create(dev_name(&chan->dev->device),
> +					    fchan->fdev->dev,
> +					    sizeof(struct st_fdma_hw_node),
> +					    __alignof__(struct st_fdma_hw_node),
> +					    0);
> +
> +	if (!fchan->node_pool) {
> +		dev_err(fchan->fdev->dev, "unable to allocate desc pool\n");
> +		return -ENOMEM;
> +	}
> +
> +
> +	ret = rproc_boot(fchan->fdev->rproc);
> +	if (ret) {
> +		dev_err(fchan->fdev->dev, "rproc_boot failed\n");

rproc_boot(), rproc_fw_boot() and xp70_rproc_start() has already given
you specific error messages; drop this generic message.

Don't you want to destroy the dma_pool if this happens?

> +		return ret;
> +	}
> +
> +	dev_dbg(fchan->fdev->dev, "alloc ch_id:%d type:%d\n",
> +		fchan->vchan.chan.chan_id, fchan->cfg.type);
> +
> +	return 0;
> +}
> +
[..]
> +
> +static const struct st_fdma_driverdata fdma_mpe31_stih407_11 = {
> +	.name = "STiH407",
> +	.id = 0,
> +};
> +
> +static const struct st_fdma_driverdata fdma_mpe31_stih407_12 = {
> +	.name = "STiH407",
> +	.id = 1,
> +};
> +
> +static const struct st_fdma_driverdata fdma_mpe31_stih407_13 = {
> +	.name = "STiH407",
> +	.id = 2,
> +};
> +
> +static const struct of_device_id st_fdma_match[] = {
> +	{ .compatible = "st,stih407-fdma-mpe31-11"
> +	  , .data = &fdma_mpe31_stih407_11 },
> +	{ .compatible = "st,stih407-fdma-mpe31-12"
> +	  , .data = &fdma_mpe31_stih407_12 },
> +	{ .compatible = "st,stih407-fdma-mpe31-13"
> +	  , .data = &fdma_mpe31_stih407_13 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, st_fdma_match);
> +
> +static int st_fdma_parse_dt(struct platform_device *pdev,
> +			const struct st_fdma_driverdata *drvdata,
> +			struct st_fdma_dev *fdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret;
> +
> +	if (!np)
> +		goto err;

ret is left uninitialized here. Also as no error handling is done, just
return your error directly.

> +
> +	ret = of_property_read_u32(np, "dma-channels", &fdev->nr_channels);
> +	if (ret)
> +		goto err;
> +
> +	snprintf(fdev->fw_name, FW_NAME_SIZE, "fdma_%s_%d.elf",
> +		drvdata->name, drvdata->id);
> +
> +err:
> +	return ret;
> +}
> +#define FDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
> +				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
> +				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
> +				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
> +
> +static int st_fdma_probe(struct platform_device *pdev)
> +{
> +	struct st_fdma_dev *fdev;
> +	const struct of_device_id *match;
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct st_fdma_driverdata *drvdata;
> +	int ret, i;
> +
> +	match = of_match_device((st_fdma_match), &pdev->dev);
> +	if (!match || !match->data) {
> +		dev_err(&pdev->dev, "No device match found\n");
> +		return -ENODEV;
> +	}
> +
> +	drvdata = match->data;

Use of_device_get_match_data() instead. This also allows you to keep the
of_match_table and driverdata at the end of the file.

[..]
> +
> +	fdev->rproc = xp70_rproc_alloc(pdev, fdev->fw_name);
> +	if (!fdev->rproc) {
> +		dev_err(&pdev->dev, "xp70_rproc_init failed\n");

All (non-development) error paths in xp70_rproc_alloc() will have
already printed a more specific error message, so no need to print
another generic on here.

> +		ret = PTR_ERR(fdev->rproc);
> +		goto err;
> +	}
> +

Regards,
Bjorn
