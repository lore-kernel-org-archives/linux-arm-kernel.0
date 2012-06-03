From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Jun 2012 20:09:32 +0100
Subject: [PATCH v4] MTD: LPC32xx SLC NAND driver
In-Reply-To: <1338748689-29645-1-git-send-email-stigge@antcom.de>
References: <1338748689-29645-1-git-send-email-stigge@antcom.de>
Message-ID: <20120603190932.GB23368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 03, 2012 at 08:38:09PM +0200, Roland Stigge wrote:
> +static int lpc32xx_xmit_dma(struct mtd_info *mtd, dma_addr_t dma,
> +			    void *mem, int len, enum dma_transfer_direction dir)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	struct lpc32xx_nand_host *host = chip->priv;
> +	struct dma_async_tx_descriptor *desc;
> +	int flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> +	int res;
> +	dma_cookie_t cookie;
> +
> +	host->dma_slave_config.direction = dir;
> +	host->dma_slave_config.src_addr = dma;
> +	host->dma_slave_config.dst_addr = dma;
> +	host->dma_slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	host->dma_slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	host->dma_slave_config.src_maxburst = 4;
> +	host->dma_slave_config.dst_maxburst = 4;
> +	/* DMA controller does flow control: */
> +	host->dma_slave_config.device_fc = false;
> +	if (dmaengine_slave_config(host->dma_chan, &host->dma_slave_config)) {
> +		dev_err(mtd->dev.parent, "Failed to setup DMA slave\n");
> +		return -ENXIO;
> +	}
> +
> +	sg_init_one(&host->sgl, mem, len);
> +
> +	res = dma_map_sg(host->dma_chan->device->dev, &host->sgl, 1,
> +			 DMA_BIDIRECTIONAL);
> +	if (res != 1) {
> +		dev_err(mtd->dev.parent, "Failed to map sg list\n");
> +		return -ENXIO;
> +	}
> +	desc = dmaengine_prep_slave_sg(host->dma_chan, &host->sgl, 1, dir,
> +				       flags);
> +	if (!desc) {
> +		dev_err(mtd->dev.parent, "Failed to prepare slave sg\n");
> +		goto out1;
> +	}
> +
> +	init_completion(&host->comp);
> +	desc->callback = lpc32xx_dma_complete_func;
> +	desc->callback_param = &host->comp;
> +
> +	cookie = dmaengine_submit(desc);
> +	if (dma_submit_error(cookie)) {
> +		dev_err(mtd->dev.parent, "Failed to dmaengine_submit()\n");
> +		goto out1;
> +	}

dmaengine_submit() is no longer allowed to fail, so you don't need this
check here anymore.  It's been that way for a long time.

> +	dma_async_issue_pending(host->dma_chan);
> +
> +	wait_for_completion_timeout(&host->comp, msecs_to_jiffies(1000));

What about unmapping the buffer upon completion?

> +
> +	return 0;
> +out1:
> +	dma_unmap_sg(host->dma_chan->device->dev, &host->sgl, 1,
> +		     DMA_BIDIRECTIONAL);
> +	return -ENXIO;
> +}
