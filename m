From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 7 Feb 2011 09:25:21 +0100
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
	<1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110207082521.GI9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 05, 2011 at 10:08:12AM +0800, Shawn Guo wrote:
> This patch adds dma support for Freescale MXS-based SoC i.MX23/28,
> including apbh-dma and apbx-dma.
> 
> * apbh-dma and apbx-dma are supported in the driver as two instances,
>   and have to be filtered by dma clients via device id.  It becomes
>   the convention that apbh-dma always gets registered prior to
>   apbx-dma.
> 
> * apbh-dma is different between mx23 and mx28, hardware version
>   register is used to handle the differences.
> 
> * Every the mxs dma channel is statically assigned to client device
>   by soc design with fixed irq.  The irq number is being passed by
>   alloc_chan function with mxs_dma_data, and client driver has to
>   filter the correct channel by its channel id.
> 
> * mxs-dma supports pio function besides data transfer.  The driver
>   uses dma_data_direction DMA_NONE to identify the pio mode, and
>   steals sgl and sg_len to get pio words and numbers from clients.
> 
> * mxs dmaengine has some very specific features, like sense function
>   and the special NAND support (nand_lock, nand_wait4ready).  These
>   are too specific to implemented in generic dmaengine driver.
> 
> * The parameter "flags" of prep functions is currently being used to
>   pass wait4end flag from clients.
> 
> * The driver refers to imx-sdma and only a single descriptor is
>   statically assigned to each channel.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/dma.h |   16 +
>  drivers/dma/Kconfig                  |    8 +
>  drivers/dma/Makefile                 |    1 +
>  drivers/dma/mxs-dma.c                |  702 ++++++++++++++++++++++++++++++++++
>  4 files changed, 727 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/include/mach/dma.h
>  create mode 100644 drivers/dma/mxs-dma.c
> 
> diff --git a/arch/arm/mach-mxs/include/mach/dma.h b/arch/arm/mach-mxs/include/mach/dma.h
> new file mode 100644
> index 0000000..429f431
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/dma.h
> +
> +static struct dma_async_tx_descriptor *mxs_dma_prep_slave_sg(
> +		struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_data_direction direction,
> +		unsigned long flags)
> +{
> +	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> +	struct mxs_dma_ccw *ccw;
> +	struct scatterlist *sg;
> +	int ret, i, j;
> +	u32 *pio;
> +
> +	dev_dbg(mxs_dma->dev, "%s: channel %d\n", __func__, chan->chan_id);
> +
> +	if (mxs_chan->status == DMA_IN_PROGRESS)
> +		return NULL;
> +
> +	mxs_chan->status = DMA_IN_PROGRESS;
> +	mxs_chan->flags = 0;
> +
> +	dev_dbg(mxs_dma->dev, "%s: setting up %d entries\n", __func__, sg_len);
> +
> +	if (sg_len > ((direction == DMA_NONE) ? MXS_PIO_WORDS : NUM_CCW)) {
> +		dev_err(mxs_dma->dev, "maximum number of sg exceeded: %d > %d\n",
> +				sg_len, NUM_CCW);
> +		ret = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	if (direction == DMA_NONE) {
> +		ccw = &mxs_chan->ccw[0];
> +		pio = (u32 *) sgl;
> +
> +		for (j = 0; j < sg_len;)
> +			ccw->pio_words[j++] = *pio++;
> +
> +		ccw->next = 0;
> +		ccw->bits.chain = 0;
> +		ccw->bits.irq = 1;
> +		ccw->bits.dec_sem = 1;
> +		ccw->bits.wait4end = flags;
> +		ccw->bits.halt_on_terminate = 1;
> +		ccw->bits.terminate_flush = 1;
> +		ccw->bits.pio_num = sg_len;
> +		ccw->bits.command = MXS_DMA_NO_XFER;

Does this have a valid usecase? I would just return some error code
here. pio_num and pio_words are unused in the driver and I don't think
a dmaengine driver should have some kind of PIO fallback.

> +	} else {
> +		for_each_sg(sgl, sg, sg_len, i) {
> +			if (sg->length > MAX_XFER_BYTES) {
> +				dev_err(mxs_dma->dev, "maximum bytes for sg entry exceeded: %d > %d\n",
> +						sg->length, MAX_XFER_BYTES);
> +				ret = -EINVAL;
> +				goto err_out;
> +			}
> +
> +			ccw = &mxs_chan->ccw[i];
> +
> +			ccw->next = mxs_chan->ccw_phys + sizeof(*ccw) * (i + 1);
> +			ccw->bufaddr = sg->dma_address;
> +			ccw->bits.xfer_bytes = sg->length;
> +			ccw->bits.chain = 1;
> +			ccw->bits.irq = 0;
> +			ccw->bits.dec_sem = 0;
> +			ccw->bits.wait4end = 0;
> +			ccw->bits.halt_on_terminate = 1;
> +			ccw->bits.terminate_flush = 1;
> +			ccw->bits.pio_num = 0;
> +			ccw->bits.command = (direction == DMA_FROM_DEVICE) ?
> +						MXS_DMA_WRITE : MXS_DMA_READ;
> +
> +			if (i + 1 == sg_len) {
> +				ccw->next = 0;
> +				ccw->bits.chain = 0;
> +				ccw->bits.irq = 1;
> +				ccw->bits.dec_sem = 1;
> +				ccw->bits.wait4end = 1;
> +			}
> +		}
> +	}
> +
> +	return &mxs_chan->desc;
> +
> +err_out:
> +	mxs_chan->status = DMA_ERROR;
> +	return NULL;
> +}
> +
> +
> +static int __init mxs_dma_probe(struct platform_device *pdev)
> +{
> +	const struct platform_device_id *id_entry =
> +				platform_get_device_id(pdev);
> +	struct mxs_dma_engine *mxs_dma;
> +	struct resource *iores;
> +	int ret, i;
> +
> +	mxs_dma = kzalloc(sizeof(*mxs_dma), GFP_KERNEL);
> +	if (!mxs_dma)
> +		return -ENOMEM;
> +
> +	mxs_dma->dev = &pdev->dev;
> +	mxs_dma->dev_id = id_entry->driver_data;
> +
> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (!request_mem_region(iores->start, resource_size(iores),
> +				pdev->name)) {
> +		ret = -EBUSY;
> +		goto err_request_region;
> +	}
> +
> +	mxs_dma->base = ioremap(iores->start, resource_size(iores));
> +	if (!mxs_dma->base) {
> +		ret = -ENOMEM;
> +		goto err_ioremap;
> +	}
> +
> +	mxs_dma->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(mxs_dma->clk)) {
> +		ret = PTR_ERR(mxs_dma->clk);
> +		goto err_clk;
> +	}
> +
> +	dma_cap_set(DMA_SLAVE, mxs_dma->dma_device.cap_mask);
> +	dma_cap_set(DMA_CYCLIC, mxs_dma->dma_device.cap_mask);
> +
> +	INIT_LIST_HEAD(&mxs_dma->dma_device.channels);
> +
> +	/* Initialize channel parameters */
> +	for (i = 0; i < MXS_DMA_CHANNELS; i++) {
> +		struct mxs_dma_chan *mxs_chan = &mxs_dma->mxs_chans[i];
> +
> +		mxs_chan->mxs_dma = mxs_dma;
> +		spin_lock_init(&mxs_chan->lock);
> +
> +		mxs_chan->chan.device = &mxs_dma->dma_device;
> +
> +		/* Add the channel to mxs_chan list */
> +		list_add_tail(&mxs_chan->chan.device_node, &mxs_dma->dma_device.channels);
> +	}
> +
> +	ret = mxs_dma_init(mxs_dma);
> +	if (ret)
> +		goto err_init;
> +
> +	mxs_dma->dma_device.dev = &pdev->dev;
> +
> +	/* mxs_dma gets 65535 bytes maximum sg size */
> +	mxs_dma->dma_device.dev->dma_parms = &mxs_dma->dma_parms;
> +	dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
> +
> +	mxs_dma->dma_device.device_alloc_chan_resources = mxs_dma_alloc_chan_resources;
> +	mxs_dma->dma_device.device_free_chan_resources = mxs_dma_free_chan_resources;
> +	mxs_dma->dma_device.device_tx_status = mxs_dma_tx_status;
> +	mxs_dma->dma_device.device_prep_slave_sg = mxs_dma_prep_slave_sg;
> +	mxs_dma->dma_device.device_prep_dma_cyclic = mxs_dma_prep_dma_cyclic;
> +	mxs_dma->dma_device.device_control = mxs_dma_control;
> +	mxs_dma->dma_device.device_issue_pending = mxs_dma_issue_pending;
> +
> +	ret = dma_async_device_register(&mxs_dma->dma_device);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to register\n");
> +		goto err_dma_register;
> +	}
> +
> +	/*
> +	 * dmaengine clients have to use dma_device.dev_id to filter
> +	 * dma device between apbh and apbx, so need to ensure it is
> +	 * identical to mxs_dma_engine.dev_id.
> +	 */
> +	if (mxs_dma->dma_device.dev_id != mxs_dma->dev_id) {
> +		dev_err(&pdev->dev, "dev_id of dma_device %d differs from mxs_dma_engine %d\n",
> +				mxs_dma->dma_device.dev_id, mxs_dma->dev_id);
> +		goto err_init;
> +	}

I think it makes more sense to match against device names (apbh vs.
apbx) in the client's filter function than to rely on exact numbering.

> +
> +	dev_info(mxs_dma->dev, "initialized\n");
> +
> +	return 0;
> +
> +err_init:
> +	dma_async_device_unregister(&mxs_dma->dma_device);
> +err_dma_register:
> +	clk_put(mxs_dma->clk);
> +err_clk:
> +	iounmap(mxs_dma->base);
> +err_ioremap:
> +	release_mem_region(iores->start, resource_size(iores));
> +err_request_region:
> +	kfree(mxs_dma);
> +	return ret;
> +}
> +
> +static int __exit mxs_dma_remove(struct platform_device *pdev)
> +{
> +	return -EBUSY;
> +}
> +
> +static struct platform_device_id mxs_dma_type[] = {
> +	{
> +		.name = "mxs-dma-apbh",
> +		.driver_data = MXS_DMA_APBH,
> +	}, {
> +		.name = "mxs-dma-apbx",
> +		.driver_data = MXS_DMA_APBX,
> +	}
> +};
> +
> +static struct platform_driver mxs_dma_driver = {
> +	.driver		= {
> +		.name	= "mxs-dma",
> +	},
> +	.id_table	= mxs_dma_type,
> +	.remove		= __exit_p(mxs_dma_remove),
> +};
> +
> +static int __init mxs_dma_module_init(void)
> +{
> +	return platform_driver_probe(&mxs_dma_driver, mxs_dma_probe);
> +}
> +subsys_initcall(mxs_dma_module_init);
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
