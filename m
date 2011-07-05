From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 08:48:06 +0100
Subject: [PATCH 6/7] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <1309781915-31549-7-git-send-email-kgene.kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-7-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110705074806.GN8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 09:18:34PM +0900, Kukjin Kim wrote:
>  static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>  				struct spi_device *spi,
>  				struct spi_transfer *xfer, int dma_mode)
> @@ -236,6 +322,11 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>  	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
>  	void __iomem *regs = sdd->regs;
>  	u32 modecfg, chcfg;
> +#if defined(CONFIG_DMADEV_PL330)
> +	struct dma_slave_config slave_config;
> +	struct scatterlist tx_sg;
> +	struct scatterlist rx_sg;
> +#endif
>  
>  	modecfg = readl(regs + S3C64XX_SPI_MODE_CFG);
>  	modecfg &= ~(S3C64XX_SPI_MODE_TXDMA_ON | S3C64XX_SPI_MODE_RXDMA_ON);
> @@ -261,10 +352,34 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>  		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
>  		if (dma_mode) {
>  			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
> +#if defined(CONFIG_DMADEV_PL330)
> +			memset(&slave_config, 0, sizeof(slave_config));
> +			slave_config.direction = DMA_TO_DEVICE;
> +			slave_config.src_addr = xfer->tx_dma;

If you're doing DMA to the device, you should not set src_addr here.
That comes from the SG list passed in via the prep function.

> +			slave_config.dst_addr =
> +				sdd->sfr_start + S3C64XX_SPI_TX_DATA;
> +			slave_config.dst_addr_width = sdd->cur_bpw / 8;
> +			dmaengine_slave_config(sdd->tx_chan, &slave_config);
> +
> +			sg_init_table(&tx_sg, 1);
> +			sg_set_page(&tx_sg, pfn_to_page(PFN_DOWN(xfer->tx_dma)),
> +				xfer->len, offset_in_page(xfer->tx_dma));
> +			sg_dma_len(&tx_sg) =  xfer->len;
> +			sg_dma_address(&tx_sg) = xfer->tx_dma;
> +			sdd->tx_desc =
> +				sdd->tx_chan->device->device_prep_slave_sg(
> +				sdd->tx_chan, &tx_sg, 1, DMA_TO_DEVICE,
> +				DMA_PREP_INTERRUPT);
> +			sdd->tx_desc->callback = s3c64xx_spi_dma_txcb;
> +			sdd->tx_desc->callback_param = sdd;
> +			dmaengine_submit(sdd->tx_desc);
> +			dma_async_issue_pending(sdd->tx_chan);
> +#else
>  			s3c2410_dma_config(sdd->tx_dmach, sdd->cur_bpw / 8);
>  			s3c2410_dma_enqueue(sdd->tx_dmach, (void *)sdd,
>  						xfer->tx_dma, xfer->len);
>  			s3c2410_dma_ctrl(sdd->tx_dmach, S3C2410_DMAOP_START);
> +#endif
>  		} else {
>  			switch (sdd->cur_bpw) {
>  			case 32:
> @@ -296,10 +411,33 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>  			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
>  					| S3C64XX_SPI_PACKET_CNT_EN,
>  					regs + S3C64XX_SPI_PACKET_CNT);
> +#if defined(CONFIG_DMADEV_PL330)
> +			slave_config.direction = DMA_FROM_DEVICE;
> +			slave_config.dst_addr = xfer->rx_dma;

If you're doing DMA from the device, you should not set dst_addr here.
That comes from the SG list passed in via the prep function.

> +			slave_config.src_addr =
> +				sdd->sfr_start + S3C64XX_SPI_RX_DATA;
> +			slave_config.src_addr_width = sdd->cur_bpw / 8;
> +			dmaengine_slave_config(sdd->rx_chan, &slave_config);
> +
> +			sg_init_table(&rx_sg, 1);
> +			sg_set_page(&rx_sg, pfn_to_page(PFN_DOWN(xfer->rx_dma)),
> +				xfer->len, offset_in_page(xfer->rx_dma));
> +			sg_dma_len(&rx_sg) =  xfer->len;
> +			sg_dma_address(&rx_sg) = xfer->rx_dma;
> +			sdd->rx_desc =
> +				sdd->rx_chan->device->device_prep_slave_sg(
> +				sdd->rx_chan, &rx_sg, 1, DMA_FROM_DEVICE,
> +				DMA_PREP_INTERRUPT);
> +			sdd->rx_desc->callback = s3c64xx_spi_dma_rxcb;
> +			sdd->rx_desc->callback_param = sdd;
> +			dmaengine_submit(sdd->rx_desc);
> +			dma_async_issue_pending(sdd->rx_chan);
> +#else
>  			s3c2410_dma_config(sdd->rx_dmach, sdd->cur_bpw / 8);
>  			s3c2410_dma_enqueue(sdd->rx_dmach, (void *)sdd,
>  						xfer->rx_dma, xfer->len);
>  			s3c2410_dma_ctrl(sdd->rx_dmach, S3C2410_DMAOP_START);
> +#endif
>  		}
>  	}
>  

> @@ -742,8 +848,50 @@ out:
>  		msg->complete(msg->context);
>  }
>  
> +#if defined(CONFIG_DMADEV_PL330)
> +static bool rxfilter(struct dma_chan *chan, void *param)
> +{
> +	struct s3c64xx_spi_driver_data *sdd
> +		= (struct s3c64xx_spi_driver_data *)param;
> +	struct dma_pl330_peri *peri = (struct dma_pl330_peri *)chan->private;
> +
> +	if (peri->peri_id != sdd->rx_dmach)
> +		return false;
> +
> +	return true;
> +}

Blank line here please.

> +static bool txfilter(struct dma_chan *chan, void *param)
> +{
> +	struct s3c64xx_spi_driver_data *sdd
> +		= (struct s3c64xx_spi_driver_data *)param;
> +	struct dma_pl330_peri *peri = (struct dma_pl330_peri *)chan->private;
> +
> +	if (peri->peri_id != sdd->tx_dmach)
> +		return false;
> +
> +	return true;
> +}
> +#endif
> +
>  static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
>  {
> +#if defined(CONFIG_DMADEV_PL330)
> +	dma_cap_mask_t mask;
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +	sdd->rx_chan =
> +		dma_request_channel(mask, rxfilter, (void *)sdd);

No need to split this line.

> +	if (!sdd->rx_chan) {
> +		dev_err(&sdd->pdev->dev, "cannot get RxDMA\n");
> +		return 0;
> +	}
> +	sdd->tx_chan =
> +		dma_request_channel(mask, txfilter, (void *)sdd);

Nor this one.

> +	if (!sdd->tx_chan) {
> +		dev_err(&sdd->pdev->dev, "cannot get TxDMA\n");
> +		return 0;
> +	}

As you have separate DMA channels for TX and RX, you should be able to
configure the channels once here, and avoid making the
dmaengine_slave_config calls during normal operation.

> +#else
>  	if (s3c2410_dma_request(sdd->rx_dmach,
>  					&s3c64xx_spi_dma_client, NULL) < 0) {
>  		dev_err(&sdd->pdev->dev, "cannot get RxDMA\n");

Last point - for correctness, the struct device which should be used
when mapping and unmapping buffers for the DMA engine is the DMA
engine's struct device.

In other words, sdd->tx_chan->device->dev for TX transfers, and
sdd->rx_chan->device->dev for RX transfers.

The DMA engine device is the struct device which actually performs the
reading/writing of memory, and has the limitations on SG geometry, not
the peripheral device.
