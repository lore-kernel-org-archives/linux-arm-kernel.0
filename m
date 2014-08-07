From: emilio@elopez.com.ar (=?windows-1252?Q?Emilio_L=F3pez?=)
Date: Thu, 07 Aug 2014 17:37:13 -0300
Subject: [PATCH v3 2/8] spi: sun4i: add DMA support
In-Reply-To: <20140805202354.GA2019@lukather>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
 <1407183002-29420-3-git-send-email-emilio@elopez.com.ar>
 <20140805202354.GA2019@lukather>
Message-ID: <53E3E379.2030608@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 05/08/14 a las 17:23, Maxime Ripard escibi?:
> Hi,
>
> On Mon, Aug 04, 2014 at 05:09:56PM -0300, Emilio L?pez wrote:
>> +	if (sun4i_spi_can_dma(master, spi, tfr)) {
>> +		dev_dbg(&sspi->master->dev, "Using DMA mode for transfer\n");
>> +
>> +		if (sspi->tx_buf) {
>> +			desc_tx = dmaengine_prep_slave_sg(sspi->tx_dma_chan,
>> +					tfr->tx_sg.sgl, tfr->tx_sg.nents,
>> +					DMA_TO_DEVICE,
>> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> +			if (!desc_tx) {
>> +				dev_err(&sspi->master->dev,
>> +					"Couldn't prepare dma slave\n");
>> +				return -EIO;
>> +			}
>> +
>> +			dmaengine_submit(desc_tx);
>> +		}
>> +
>> +		if (sspi->rx_buf) {
>> +			desc_rx = dmaengine_prep_slave_sg(sspi->rx_dma_chan,
>> +					tfr->rx_sg.sgl, tfr->rx_sg.nents,
>> +					DMA_FROM_DEVICE,
>> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> +			if (!desc_rx) {
>> +				dev_err(&sspi->master->dev,
>> +					"Couldn't prepare dma slave\n");
>> +				return -EIO;
>> +			}
>> +
>> +			dmaengine_submit(desc_rx);
>> +		}
>> +
>> +		/* Enable DMA requests */
>> +		reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
>> +		sun4i_spi_write(sspi, SUN4I_CTL_REG,
>> +				reg | SUN4I_CTL_DMAMC_DEDICATED);
>> +		sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG,
>> +				SUN4I_DMA_CTL_TF_NOT_FULL |
>> +				SUN4I_DMA_CTL_RF_READY);
>> +
>> +		dma_async_issue_pending(sspi->rx_dma_chan);
>> +		dma_async_issue_pending(sspi->tx_dma_chan);
>
> I guess the DMA levels setup and the issue pending calls could be
> moved to the if statements above about wether the RX and TX buffers
> are here or not.

Ok, I'll do that.

>> +	} else {
>> +		dev_dbg(&sspi->master->dev, "Using PIO mode for transfer\n");
>> +
>> +		/* Disable DMA requests */
>> +		reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
>> +		sun4i_spi_write(sspi, SUN4I_CTL_REG,
>> +				reg & ~SUN4I_CTL_DMAMC_DEDICATED);
>> +		sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, 0);
>> +
>> +		/* Fill the TX FIFO */
>> +		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
>> +	}
>> +
>>   	/* Start the transfer */
>>   	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
>>   	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
>> @@ -286,7 +359,12 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>>   		goto out;
>>   	}
>>
>> -	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>> +	if (sun4i_spi_can_dma(master, spi, tfr) && desc_rx) {
>> +		/* The receive transfer should be the last one to finish */
>> +		dma_wait_for_async_tx(desc_rx);
>> +	} else {
>> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>> +	}
>>
>>   out:
>>   	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
>> @@ -351,6 +429,7 @@ static int sun4i_spi_runtime_suspend(struct device *dev)
>>
>>   static int sun4i_spi_probe(struct platform_device *pdev)
>>   {
>> +	struct dma_slave_config dma_sconfig;
>>   	struct spi_master *master;
>>   	struct sun4i_spi *sspi;
>>   	struct resource	*res;
>> @@ -386,7 +465,10 @@ static int sun4i_spi_probe(struct platform_device *pdev)
>>   		goto err_free_master;
>>   	}
>>
>> +	init_completion(&sspi->done);
>>   	sspi->master = master;
>> +	master->can_dma = sun4i_spi_can_dma;
>> +	master->prepare_message = sun4i_spi_prepare_message;
>>   	master->set_cs = sun4i_spi_set_cs;
>>   	master->transfer_one = sun4i_spi_transfer_one;
>>   	master->num_chipselect = 4;
>> @@ -409,7 +491,45 @@ static int sun4i_spi_probe(struct platform_device *pdev)
>>   		goto err_free_master;
>>   	}
>>
>> -	init_completion(&sspi->done);
>> +	sspi->tx_dma_chan = dma_request_slave_channel_reason(&pdev->dev, "tx");
>> +	if (IS_ERR(sspi->tx_dma_chan)) {
>> +		dev_err(&pdev->dev, "Unable to acquire DMA channel TX\n");
>> +		ret = PTR_ERR(sspi->tx_dma_chan);
>> +		goto err_free_master;
>> +	}
>> +
>> +	dma_sconfig.direction = DMA_MEM_TO_DEV;
>> +	dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +	dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +	dma_sconfig.dst_addr = res->start + SUN4I_TXDATA_REG;
>> +	dma_sconfig.src_maxburst = 1;
>> +	dma_sconfig.dst_maxburst = 1;
>> +
>> +	ret = dmaengine_slave_config(sspi->tx_dma_chan, &dma_sconfig);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Unable to configure TX DMA slave\n");
>> +		goto err_tx_dma_release;
>> +	}
>> +
>> +	sspi->rx_dma_chan = dma_request_slave_channel_reason(&pdev->dev, "rx");
>> +	if (IS_ERR(sspi->rx_dma_chan)) {
>> +		dev_err(&pdev->dev, "Unable to acquire DMA channel RX\n");
>> +		ret = PTR_ERR(sspi->rx_dma_chan);
>> +		goto err_tx_dma_release;
>> +	}
>> +
>> +	dma_sconfig.direction = DMA_DEV_TO_MEM;
>> +	dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +	dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +	dma_sconfig.src_addr = res->start + SUN4I_RXDATA_REG;
>> +	dma_sconfig.src_maxburst = 1;
>> +	dma_sconfig.dst_maxburst = 1;
>> +
>> +	ret = dmaengine_slave_config(sspi->rx_dma_chan, &dma_sconfig);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Unable to configure RX DMA slave\n");
>> +		goto err_rx_dma_release;
>> +	}
>>
>>   	/*
>>   	 * This wake-up/shutdown pattern is to be able to have the
>> @@ -418,7 +538,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
>>   	ret = sun4i_spi_runtime_resume(&pdev->dev);
>>   	if (ret) {
>>   		dev_err(&pdev->dev, "Couldn't resume the device\n");
>> -		goto err_free_master;
>> +		goto err_rx_dma_release;
>>   	}
>>
>>   	pm_runtime_set_active(&pdev->dev);
>> @@ -436,6 +556,10 @@ static int sun4i_spi_probe(struct platform_device *pdev)
>>   err_pm_disable:
>>   	pm_runtime_disable(&pdev->dev);
>>   	sun4i_spi_runtime_suspend(&pdev->dev);
>> +err_rx_dma_release:
>> +	dma_release_channel(sspi->rx_dma_chan);
>> +err_tx_dma_release:
>> +	dma_release_channel(sspi->tx_dma_chan);
>>   err_free_master:
>>   	spi_master_put(master);
>>   	return ret;
>> @@ -443,8 +567,17 @@ err_free_master:
>>
>>   static int sun4i_spi_remove(struct platform_device *pdev)
>>   {
>> +	struct spi_master *master = platform_get_drvdata(pdev);
>> +	struct sun4i_spi *sspi = spi_master_get_devdata(master);
>> +
>> +	if (pm_runtime_active(&pdev->dev))
>> +		sun4i_spi_runtime_suspend(&pdev->dev);
>> +
>
> This doesn't really belong in this patch, please send a separate one.

Sure

Thanks!

Emilio
