From: marex@denx.de (Marek Vasut)
Date: Tue, 14 Jan 2014 22:38:32 +0100
Subject: [PATCH v2 1/2] spi: spi-imx: enable dma support for escpi
 controller
In-Reply-To: <1388789632-12238-1-git-send-email-Frank.Li@freescale.com>
References: <1388789632-12238-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <201401142238.32262.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 03, 2014 at 11:53:51 PM, Frank Li wrote:
> After enable DMA
> 
> spi-nor read speed is
> dd if=/dev/mtd0 of=/dev/null bs=1M count=1
> 1+0 records in
> 1+0 records out
> 1048576 bytes (1.0 MB) copied, 0.720402 s, 1.5 MB/s
> 
> spi-nor write speed is
> dd if=/dev/zero of=/dev/mtd0 bs=1M count=1
> 1+0 records in
> 1+0 records out
> 1048576 bytes (1.0 MB) copied, 3.56044 s, 295 kB/s
> 
> Before enable DMA
> 
> spi-nor read speed is
> dd if=/dev/mtd0 of=/dev/null bs=1M count=1
> 1+0 records in
> 1+0 records out
> 1048576 bytes (1.0 MB) copied, 2.37717 s, 441 kB/s
> 
> spi-nor write speed is
> 
> dd if=/dev/zero of=/dev/mtd0 bs=1M count=1
> 1+0 records in
> 1+0 records out
> 1048576 bytes (1.0 MB) copied, 4.83181 s, 217 kB/s
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
[...]

> +
> +static void spi_imx_dma_rx_callback(void *cookie)
> +{
> +	struct spi_imx_data *spi_imx = (struct spi_imx_data *)cookie;
> +
> +	complete(&spi_imx->dma_rx_completion);
> +
> +}
> +
> +static void spi_imx_dma_tx_callback(void *cookie)
> +{
> +	struct spi_imx_data *spi_imx = (struct spi_imx_data *)cookie;
> +
> +	complete(&spi_imx->dma_tx_completion);
> +}
> +
> +static int spi_imx_sdma_transfer(struct spi_device *spi,
> +				struct spi_transfer *transfer)
> +{

This function needs splitting into multiple smaller ones, seriously. This 
doesn't fit either on my rMBP's screen or on my desktop's _pivoted_ 27" 
widescreen 2500x1400 LCD !

> +	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
> +	int ret = 0;
> +	int sg_num;
> +	int loop;
> +	int left;
> +	u32 dma;
> +
> +	struct scatterlist *sg_rx, *sg_tx;
> +	struct dma_async_tx_descriptor *txdesc;
> +	struct dma_async_tx_descriptor *rxdesc;
> +
> +	init_completion(&spi_imx->dma_rx_completion);
> +	init_completion(&spi_imx->dma_tx_completion);

This should be reinit_completion(), the init_completion() should happen in the 
probe function, CAREFUL about this !

> +
> +	/*
> +	 * Get the valid physical address for the tx buf, if the rx buf address
> +	 * is null or it cannot be mapped, we should allocate memory for it.
> +	 */

I will skip this function until it's properly split. But anyway...

I know the MXC SPI controller works in full-duplex mode, thus must have two 
equally big buffers (one for RX and one for TX) even if used in half-duplex 
mode, right?

The problem I perceive here is that when I do for example 4 MB long continuous 
half-duplex transfer with the IMX SPI, your code will happily allocate 4MB big 
buffer, right ?

Hence my suggestion, won't it be better to split such long transfers into a 
chain of DMA descriptors AND use a small (say, 16KiB) buffer for the unwanted 
direction ? This way, you would allocate the small 16KiB block only once (heck, 
you can even allocate it in probe() ), and each descriptor would point to this 
block, overwriting it or sourcing zeroes from it .

But please, correct me if I misunderstood your code.

[...]

> +
> +static int spi_imx_pio_transfer(struct spi_device *spi,
>  				struct spi_transfer *transfer)
>  {
>  	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
> @@ -729,6 +1088,27 @@ static int spi_imx_transfer(struct spi_device *spi,
>  	return transfer->len;
>  }
> 
> +static int spi_imx_transfer(struct spi_device *spi,
> +				struct spi_transfer *transfer)
> +{
> +	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
> +
> +	if (spi_imx->dma_chan_tx && spi_imx->dma_chan_rx) {

You do have spi_imx->dma_is_inited variable , so use it here.

> +		/*
> +		 * Don't use sdma when the size of data to be transfered is
> +		 * lower then SDMA wartermark.
> +		 */
> +		if ((transfer->len >= spi_imx->rx_wml) &&
> +				(transfer->len > spi_imx->tx_wml)) {

Why do you use -ge in the first test and -gt in the second ? Besides, the 
formating of the condition is really weird.

> +			spi_imx->usedma = 1;

Don't you need to do some kind of locking here so that spi_imx->usedma won't be 
overwritten if multiple users enter the spi_imx_transfer() function ? I am not 
sure if this is called from a context already protected by the SPI framework's 
mutex or not.

> +			return spi_imx_sdma_transfer(spi, transfer);
> +		}
> +	}
> +
> +	spi_imx->usedma = 0;
> +	return spi_imx_pio_transfer(spi, transfer);
> +}
> +
>  static int spi_imx_setup(struct spi_device *spi)
>  {
>  	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
> @@ -778,6 +1158,56 @@ spi_imx_unprepare_message(struct spi_master *master,
> struct spi_message *msg) return 0;
>  }
> 
> +static int spi_imx_sdma_init(struct spi_imx_data *spi_imx)
> +{
> +	struct dma_slave_config slave_config = {};
> +	struct device *dev = spi_imx->dev;
> +	int ret;
> +
> +

One newline too much here.

> +	/* Prepare for TX : */

I suppose this should be "Prepare TX DMA" ?

> +	spi_imx->dma_chan_tx = dma_request_slave_channel(dev, "tx");
> +	if (!spi_imx->dma_chan_tx) {
> +		dev_err(dev, "cannot get the TX DMA channel!\n");

Sentence usually starts with capital letter ;-)

> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	slave_config.direction = DMA_MEM_TO_DEV;
> +	slave_config.dst_addr = spi_imx->mapbase + MXC_CSPITXDATA;
> +	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	slave_config.dst_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
> +	ret = dmaengine_slave_config(spi_imx->dma_chan_tx, &slave_config);
> +	if (ret) {
> +		dev_err(dev, "error in TX dma configuration.");
> +		goto err;
> +	}
> +
> +	/* Prepare for RX : */
> +	spi_imx->dma_chan_rx = dma_request_slave_channel(dev, "rx");
> +	if (!spi_imx->dma_chan_rx) {
> +		dev_dbg(dev, "cannot get the DMA channel.\n");

I'd turn all these dev_err() calls here into dev_dbg() and I'd print an error 
message if this function returns !0 at where's it's called from below.

> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	slave_config.direction = DMA_DEV_TO_MEM;
> +	slave_config.src_addr = spi_imx->mapbase + MXC_CSPIRXDATA;
> +	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	slave_config.src_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
> +	ret = dmaengine_slave_config(spi_imx->dma_chan_rx, &slave_config);
> +	if (ret) {
> +		dev_err(dev, "error in RX dma configuration.\n");
> +		goto err;
> +	}
> +	spi_imx->dma_is_inited = 1;
> +
> +	return 0;
> +err:
> +	spi_imx_sdma_exit(spi_imx);
> +	return ret;
> +}
> +
>  static int spi_imx_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -849,6 +1279,8 @@ static int spi_imx_probe(struct platform_device *pdev)
>  		(struct spi_imx_devtype_data *) pdev->id_entry->driver_data;
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res)
> +		spi_imx->mapbase = res->start;
>  	spi_imx->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(spi_imx->base)) {
>  		ret = PTR_ERR(spi_imx->base);
> @@ -890,6 +1322,9 @@ static int spi_imx_probe(struct platform_device *pdev)
> 
>  	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
> 
> +	spi_imx->dev = &pdev->dev;
> +	spi_imx_sdma_init(spi_imx);

You must check return value here. I would say you want to print an error message 
here, but you also want to avoid failing entirely, just indicate the DMA 
couldn't be init'd and you'd just use PIO.

> +
>  	spi_imx->devtype_data->reset(spi_imx);
> 
>  	spi_imx->devtype_data->intctrl(spi_imx, 0);
