From: Anton_Bondarenko@mentor.com (Bondarenko, Anton)
Date: Thu, 1 Oct 2015 00:02:41 +0000
Subject: [PATCH v2 1/8] spi: imx: Fix DMA transfer
In-Reply-To: <20150930082341.GB2709@shlinux2>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
 <d61ed8cc9e13b0890e6243135c613edea1234698.1442923630.git.anton_bondarenko@mentor.com>
 <20150930082341.GB2709@shlinux2>
Message-ID: <04376A3D786BD947B28569C998A374A62E280DD6@NA-MBX-02.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> @@ -201,9 +202,8 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>>  {
>>  	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
>>  
>> -	if (spi_imx->dma_is_inited
>> -	    && transfer->len > spi_imx->rx_wml * sizeof(u32)
>> -	    && transfer->len > spi_imx->tx_wml * sizeof(u32))
>> +	if (spi_imx->dma_is_inited &&
>> +	    (transfer->len > spi_imx->wml * sizeof(u32)))
> Add Sascha in the loop. I don't think "* sizeof(u32)", since even 1 byte data
> will consume one position of 32bit FIFO Thus if here
> spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2 = 32, the threshold value
> which judge DMA mode used or not should be 32 not 32 * 4.
> Of course, it will not cause any function break since both DMA and PIO can work
> ,but I think we'd better correct it.
I agree, in case of 1 byte SPI word we do not need to multiply by 4.
But for 16 bit and 32 bit SPI words it's necessary. This part is
addressed in patch 3.
I could remove "* sizeof(u32)" for now.
>>  		return true;
>>  	return false;
>>  }
>> @@ -369,19 +374,10 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>>  	 * and enable DMA request.
>>  	 */
>>  	if (spi_imx->dma_is_inited) {
>> -		dma = readl(spi_imx->base + MX51_ECSPI_DMA);
>> -
>> -		spi_imx->rxt_wml = spi_imx_get_fifosize(spi_imx) / 2;
>> -		rx_wml_cfg = spi_imx->rx_wml << MX51_ECSPI_DMA_RX_WML_OFFSET;
>> -		tx_wml_cfg = spi_imx->tx_wml << MX51_ECSPI_DMA_TX_WML_OFFSET;
>> -		rxt_wml_cfg = spi_imx->rxt_wml << MX51_ECSPI_DMA_RXT_WML_OFFSET;
>> -		dma = (dma & ~MX51_ECSPI_DMA_TX_WML_MASK
>> -			   & ~MX51_ECSPI_DMA_RX_WML_MASK
>> -			   & ~MX51_ECSPI_DMA_RXT_WML_MASK)
>> -			   | rx_wml_cfg | tx_wml_cfg | rxt_wml_cfg
>> -			   |(1 << MX51_ECSPI_DMA_TEDEN_OFFSET)
>> -			   |(1 << MX51_ECSPI_DMA_RXDEN_OFFSET)
>> -			   |(1 << MX51_ECSPI_DMA_RXTDEN_OFFSET);
>> +		dma = (spi_imx->wml - 1) << MX51_ECSPI_DMA_RX_WML_OFFSET
>> +		      | (spi_imx->wml - 1) << MX51_ECSPI_DMA_TX_WML_OFFSET
>> +		      | (1 << MX51_ECSPI_DMA_TEDEN_OFFSET)
>> +		      | (1 << MX51_ECSPI_DMA_RXDEN_OFFSET);
> Please set tx threshold as 0 as your v1 patch if I remember right, as our
> internal tree done:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/drivers/spi/spi-imx.c?h=imx_3.14.28_7d_alpha&id=2e7615e2f399e39c58dd31f84a31f7c2592da7e7
Will be fixed in V3 patchset
>>  
>>  		writel(dma, spi_imx->base + MX51_ECSPI_DMA);
>>  	}
>> @@ -825,6 +821,8 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>>  	if (of_machine_is_compatible("fsl,imx6dl"))
>>  		return 0;
>>  
>> +	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
>> +
>>  	/* Prepare for TX DMA: */
>>  	master->dma_tx = dma_request_slave_channel(dev, "tx");
>>  	if (!master->dma_tx) {
>> @@ -836,7 +834,8 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>>  	slave_config.direction = DMA_MEM_TO_DEV;
>>  	slave_config.dst_addr = res->start + MXC_CSPITXDATA;
>>  	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> -	slave_config.dst_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
>> +	slave_config.dst_maxburst = spi_imx_get_fifosize(spi_imx)
>> +					- spi_imx->wml;
> slave_config.dst_maxburst = spi_imx->wml;?
Will be fixed in V3
>>  	ret = dmaengine_slave_config(master->dma_tx, &slave_config);
>>  	if (ret) {
>>  		dev_err(dev, "error in TX dma configuration.\n");
>> @@ -854,7 +853,8 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>>  	slave_config.direction = DMA_DEV_TO_MEM;
>>  	slave_config.src_addr = res->start + MXC_CSPIRXDATA;
>>  	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> -	slave_config.src_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
>> +	slave_config.src_maxburst = spi_imx_get_fifosize(spi_imx)
>> +					- spi_imx->wml;
> slave_config.src_maxburst = spi_imx->wml;?
Will be fixed in V3
>>  	ret = dmaengine_slave_config(master->dma_rx, &slave_config);
>>  	if (ret) {
>>  		dev_err(dev, "error in RX dma configuration.\n");
>> @@ -867,8 +867,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>>  	master->max_dma_len = MAX_SDMA_BD_BYTES;
>>  	spi_imx->bitbang.master->flags = SPI_MASTER_MUST_RX |
>>  					 SPI_MASTER_MUST_TX;
>> -	spi_imx->tx_wml = spi_imx_get_fifosize(spi_imx) / 2;
>> -	spi_imx->rx_wml = spi_imx_get_fifosize(spi_imx) / 2;
>>  	spi_imx->dma_is_inited = 1;
>>  
>>  	return 0;
>> @@ -897,8 +895,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>>  	struct dma_async_tx_descriptor *desc_tx = NULL, *desc_rx = NULL;
>>  	int ret;
>>  	unsigned long timeout;
>> -	u32 dma;
>> -	int left;
>> +	const int left = transfer->len % spi_imx->wml;
>>  	struct spi_master *master = spi_imx->bitbang.master;
>>  	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
>>  
>> @@ -915,9 +912,23 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>>  	}
>>  
>>  	if (rx) {
>> +		/* Cut RX data tail */
>> +		const unsigned int old_nents = rx->nents;
>> +
>> +		WARN_ON(sg_dma_len(&rx->sgl[rx->nents - 1]) < left);
>> +		sg_dma_len(&rx->sgl[rx->nents - 1]) -= left;
>> +		if (sg_dma_len(&rx->sgl[rx->nents - 1]) == 0)
>> +			--rx->nents;
>> +
>>  		desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
>>  					rx->sgl, rx->nents, DMA_DEV_TO_MEM,
>>  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> +
>> +		/* Restore old SG table state */
>> +		if (old_nents > rx->nents)
>> +			++rx->nents;
>> +		sg_dma_len(&rx->sgl[rx->nents - 1]) += left;
>> +
>>  		if (!desc_rx)
>>  			goto no_dma;
>>  
>> @@ -932,17 +943,10 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>>  	/* Trigger the cspi module. */
>>  	spi_imx->dma_finished = 0;
>>  
>> -	dma = readl(spi_imx->base + MX51_ECSPI_DMA);
>> -	dma = dma & (~MX51_ECSPI_DMA_RXT_WML_MASK);
>> -	/* Change RX_DMA_LENGTH trigger dma fetch tail data */
>> -	left = transfer->len % spi_imx->rxt_wml;
>> -	if (left)
>> -		writel(dma | (left << MX51_ECSPI_DMA_RXT_WML_OFFSET),
>> -				spi_imx->base + MX51_ECSPI_DMA);
>> +	dma_async_issue_pending(master->dma_rx);
>> +	dma_async_issue_pending(master->dma_tx);
>>  	spi_imx->devtype_data->trigger(spi_imx);
>>  
>> -	dma_async_issue_pending(master->dma_tx);
>> -	dma_async_issue_pending(master->dma_rx);
> why change the sequence of issue_pending and trigger? I don't think need to do so.
The reason for order change for TX/RX requests is avoiding buffer
overflow for RX. This will happen if our code will be interrupted after
SPI HW and TX DMA started. This mean we will sent TX data, but there is
no one to consume RX data. So RX DMA should start before TX DMA.
On other hand TX DMA should start work earlier to fill buffer before SPI
HW starts pushing data out. This will give us a small performance bonus.
Not a big one, but still something for free.
>>  	/* Wait SDMA to finish the data transfer.*/
>>  	timeout = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
>>  						IMX_DMA_TIMEOUT);
>> @@ -951,6 +955,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>>  			dev_driver_string(&master->dev),
>>  			dev_name(&master->dev));
>>  		dmaengine_terminate_all(master->dma_tx);
>> +		dmaengine_terminate_all(master->dma_rx);
>>  	} else {
>>  		timeout = wait_for_completion_timeout(
>>  				&spi_imx->dma_rx_completion, IMX_DMA_TIMEOUT);
>> @@ -960,10 +965,32 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>>  				dev_name(&master->dev));
>>  			spi_imx->devtype_data->reset(spi_imx);
>>  			dmaengine_terminate_all(master->dma_rx);
>> +		} else if (left) {
>> +			void *pio_buffer = transfer->rx_buf
>> +						+ (transfer->len - left);
>> +
>> +			dma_sync_sg_for_cpu(master->dma_rx->device->dev,
>> +					    rx->sgl, rx->nents,
>> +					    DMA_FROM_DEVICE);
> Only the last entry needed:
> dma_sync_sg_for_cpu(master->dma_rx->device->dev,
> 			rx->sgl[rx->nents - 1], 1,
> 			DMA_FROM_DEVICE);
Agree. Will be fixed in V3
>> +
>> +			spi_imx->rx_buf = pio_buffer;
>> +			spi_imx->txfifo = left;
>> +			reinit_completion(&spi_imx->xfer_done);
>> +
>> +			spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TCEN);
>> +
>> +			timeout = wait_for_completion_timeout(
>> +					&spi_imx->xfer_done, IMX_DMA_TIMEOUT);
>> +			if (!timeout) {
>> +				pr_warn("%s %s: I/O Error in RX tail\n",
>> +					dev_driver_string(&master->dev),
>> +					dev_name(&master->dev));
>> +			}
>> +
>> +			dmac_flush_range(pio_buffer, pio_buffer + left);
The line above causing build error in some configurations. Replacing it
with dma_sync_sg call similar to previous one, but with
>> +			outer_flush_range(virt_to_phys(pio_buffer),
>> +					  virt_to_phys(pio_buffer) + left);
>>  		}
>> -		writel(dma |
>> -		       spi_imx->rxt_wml << MX51_ECSPI_DMA_RXT_WML_OFFSET,
>> -		       spi_imx->base + MX51_ECSPI_DMA);
>>  	}
>>  
>>  	spi_imx->dma_finished = 1;
>> -- 
>> 2.5.2
>>
