From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Oct 2012 09:38:29 +0100
Subject: [PATCH] i2c: at91: add dma support
In-Reply-To: <1349876587-31182-1-git-send-email-ludovic.desroches@atmel.com>
References: <1349876587-31182-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20121017083828.GJ21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 03:43:07PM +0200, ludovic.desroches at atmel.com wrote:
> +	txdesc = chan_tx->device->device_prep_slave_sg(chan_tx, &dma->sg,
> +		1, DMA_TO_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK, NULL);

No, a while back the DMA engine API changed.  It no longer takes
DMA_TO_DEVICE/DMA_FROM_DEVICE but DMA_MEM_TO_DEV and DMA_DEV_TO_MEM.

> +	/* Keep in mind that we won't use dma to read the last two bytes */
> +	at91_twi_irq_save(dev);
> +	dma_addr = dma_map_single(dev->dev, dev->buf, dev->buf_len - 2,
> +				  DMA_FROM_DEVICE);

Ditto.

> +	dma->xfer_in_progress = true;
> +	cookie = rxdesc->tx_submit(rxdesc);
> +	if (dma_submit_error(cookie)) {

tx_submit never errors (anymore.)

> +	slave_config.direction = DMA_TO_DEVICE;

Same comment as for the other directions.  Note that DMA engine drivers
really should ignore this parameter now, and DMA engine users should phase
it out.

> +	if (dmaengine_slave_config(dma->chan_tx, &slave_config)) {
> +		dev_err(dev->dev, "failed to configure tx channel\n");
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	slave_config.direction = DMA_FROM_DEVICE;

Ditto.
