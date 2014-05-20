From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 20 May 2014 11:31:20 +0300
Subject: [PATCH v2 2/2] dmaengine: s3c24xx-dma: Add cyclic transfer support
In-Reply-To: <1400519158-5801-2-git-send-email-anarsoul@gmail.com>
References: <1400519158-5801-1-git-send-email-anarsoul@gmail.com>
 <1400519158-5801-2-git-send-email-anarsoul@gmail.com>
Message-ID: <1400574680.3703.72.camel@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-05-19 at 20:05 +0300, Vasily Khoruzhick wrote:
> Many audio interface drivers require support of cyclic transfers to work
> correctly, for example Samsung ASoC DMA driver. This patch adds support
> for cyclic transfers to the s3c24xx-dma driver

Sorry, not mentioned earlier, but couple of nitpicks below. (I think you
may wait for more comments and then decide what to do with mine)

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

size and period are size_t, thus %zu.

...

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

Redundant parenthesis.

> +			dsg->len = size - (period * i);
> +		if (direction == DMA_MEM_TO_DEV) {
> +			dsg->src_addr = addr + (period * i);

Ditto.

> +			dsg->dst_addr = slave_addr;
> +		} else { /* DMA_DEV_TO_MEM */
> +			dsg->src_addr = slave_addr;
> +			dsg->dst_addr = addr + (period * i);

Ditto.

> +		}
> +	}
> +
> +	return vchan_tx_prep(&s3cchan->vc, &txd->vd, flags);
> +}


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
