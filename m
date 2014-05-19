From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 19 May 2014 11:40:30 +0300
Subject: [PATCH 2/2] dmaengine: s3c24xx-dma: Add cyclic transfer support
In-Reply-To: <1400445876-17460-1-git-send-email-anarsoul@gmail.com>
References: <1400445779-17365-1-git-send-email-anarsoul@gmail.com>
 <1400445876-17460-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1400488830.3703.64.camel@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-05-18 at 23:44 +0300, Vasily Khoruzhick wrote:
> Many audio interface drivers require support of cyclic transfers to work
> correctly, for example Samsung ASoC DMA driver. This patch adds support
> for cyclic transfers to the s3c24xx-dma driver

> +static struct dma_async_tx_descriptor *s3c24xx_dma_prep_dma_cyclic(
> +	struct dma_chan *chan, dma_addr_t addr, size_t size, size_t period,
> +	enum dma_transfer_direction direction, unsigned long flags,
> +	void *context)
> +{
> +	struct s3c24xx_dma_chan *s3cchan = to_s3c24xx_dma_chan(chan);
> +	struct s3c24xx_dma_engine *s3cdma = s3cchan->host;
> +	const struct s3c24xx_dma_platdata *pdata = s3cdma->pdata;
> +	struct s3c24xx_dma_channel *cdata = &pdata->channels[s3cchan->id];
> +	struct s3c24xx_txd *txd;
> +	struct s3c24xx_sg *dsg;
> +	unsigned sg_len;
> +	dma_addr_t slave_addr;
> +	u32 hwcfg = 0;
> +	int i;
> +
> +	dev_dbg(&s3cdma->pdev->dev,
> +		"prepare cyclic transaction of %d bytes with period %d from %s\n",
> +		size, period, s3cchan->name);
> +
> +	txd = s3c24xx_dma_get_txd();
> +	if (!txd)
> +		return NULL;
> +
> +	txd->cyclic = 1;
> +
> +	if (cdata->handshake)
> +		txd->dcon |= S3C24XX_DCON_HANDSHAKE;
> +
> +	switch (cdata->bus) {
> +	case S3C24XX_DMA_APB:
> +		txd->dcon |= S3C24XX_DCON_SYNC_PCLK;
> +		hwcfg |= S3C24XX_DISRCC_LOC_APB;
> +		break;
> +	case S3C24XX_DMA_AHB:
> +		txd->dcon |= S3C24XX_DCON_SYNC_HCLK;
> +		hwcfg |= S3C24XX_DISRCC_LOC_AHB;
> +		break;
> +	}
> +
> +	/*
> +	 * Always assume our peripheral desintation is a fixed
> +	 * address in memory.
> +	 */
> +	hwcfg |= S3C24XX_DISRCC_INC_FIXED;
> +
> +	/*
> +	 * Individual dma operations are requested by the slave,
> +	 * so serve only single atomic operations (S3C24XX_DCON_SERV_SINGLE).
> +	 */
> +	txd->dcon |= S3C24XX_DCON_SERV_SINGLE;
> +
> +	if (direction == DMA_MEM_TO_DEV) {
> +		txd->disrcc = S3C24XX_DISRCC_LOC_AHB |
> +			      S3C24XX_DISRCC_INC_INCREMENT;
> +		txd->didstc = hwcfg;
> +		slave_addr = s3cchan->cfg.dst_addr;
> +		txd->width = s3cchan->cfg.dst_addr_width;
> +	} else if (direction == DMA_DEV_TO_MEM) {
> +		txd->disrcc = hwcfg;
> +		txd->didstc = S3C24XX_DIDSTC_LOC_AHB |
> +			      S3C24XX_DIDSTC_INC_INCREMENT;
> +		slave_addr = s3cchan->cfg.src_addr;
> +		txd->width = s3cchan->cfg.src_addr_width;
> +	} else {
> +		s3c24xx_dma_free_txd(txd);
> +		dev_err(&s3cdma->pdev->dev,
> +			"direction %d unsupported\n", direction);
> +		return NULL;
> +	}

Instead of doing this, you may put few lines on top of function

if (!is_slave_direction) {
	dev_err(&s3cdma->pdev->dev, "direction %d unsupported\n", direction);
	return NULL;
}

As an additional effect you can transform the 'else if' to just 'else' above the code.

> +
> +	sg_len = size / period;
> +
> +	for (i = 0; i < sg_len; i++) {
> +		dsg = kzalloc(sizeof(*dsg), GFP_NOWAIT);
> +		if (!dsg) {
> +			s3c24xx_dma_free_txd(txd);
> +			return NULL;
> +		}
> +		list_add_tail(&dsg->node, &txd->dsg_list);
> +
> +		dsg->len = period;
> +		/* Check last period length */
> +		if (i == (sg_len - 1))
> +			dsg->len = size - (period * i);
> +		if (direction == DMA_MEM_TO_DEV) {
> +			dsg->src_addr = addr + (period * i);
> +			dsg->dst_addr = slave_addr;
> +		} else { /* DMA_DEV_TO_MEM */
> +			dsg->src_addr = slave_addr;
> +			dsg->dst_addr = addr + (period * i);
> +		}
> +	}
> +
> +	return vchan_tx_prep(&s3cchan->vc, &txd->vd, flags);
> +}


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
