From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 20 Jan 2014 13:10:19 +0530
Subject: [PATCHv10 2/2] dma: Add Freescale eDMA engine driver support
In-Reply-To: <1389938684-29467-3-git-send-email-b35083@freescale.com>
References: <1389938684-29467-1-git-send-email-b35083@freescale.com>
 <1389938684-29467-3-git-send-email-b35083@freescale.com>
Message-ID: <20140120074019.GF26823@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 02:04:44PM +0800, Jingchang Lu wrote:
> Add Freescale enhanced direct memory(eDMA) controller support.
> This module can be found on Vybrid and LS-1 SoCs.
> 
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---

> +struct fsl_edma_sw_tcd {
> +	dma_addr_t			ptcd;
> +	struct fsl_edma_hw_tcd		*vtcd;
> +};
> +
> +struct fsl_edma_slave_config {
> +	enum dma_transfer_direction	dir;
> +	enum dma_slave_buswidth		addr_width;
> +	u32				dev_addr;
u32 for device address doesnt look right, we should be using dma_addr_t?
> +	u32				burst;
> +	u32				attr;
Looking at this, all fields expect attr are in dma_slave_config! So why do we
need these here and what does the attr mean?

> +static int fsl_edma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> +		unsigned long arg)
> +{
> +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> +	struct dma_slave_config *cfg = (void *)arg;
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	switch (cmd) {
> +	case DMA_TERMINATE_ALL:
> +		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
> +		fsl_edma_disable_request(fsl_chan);
> +		fsl_chan->edesc = NULL;
> +		vchan_get_all_descriptors(&fsl_chan->vchan, &head);
> +		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
> +		vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
> +		return 0;
well what happens to the current ongoing transactions, i don't see those getting
terminated?

> +
> +	case DMA_SLAVE_CONFIG:
> +		fsl_chan->fsc.dir = cfg->direction;
> +		if (cfg->direction == DMA_DEV_TO_MEM) {
> +			fsl_chan->fsc.dev_addr = cfg->src_addr;
> +			fsl_chan->fsc.addr_width = cfg->src_addr_width;
> +			fsl_chan->fsc.burst = cfg->src_maxburst;
> +			fsl_chan->fsc.attr = fsl_edma_get_tcd_attr(cfg->src_addr_width);
> +		} else if (cfg->direction == DMA_MEM_TO_DEV) {
> +			fsl_chan->fsc.dev_addr = cfg->dst_addr;
> +			fsl_chan->fsc.addr_width = cfg->dst_addr_width;
> +			fsl_chan->fsc.burst = cfg->dst_maxburst;
> +			fsl_chan->fsc.attr = fsl_edma_get_tcd_attr(cfg->dst_addr_width);
okay atrr is address width, why not save this standard struct instead?

> +		} else {
> +			return -EINVAL;
> +		}
> +		return 0;
> +
> +	case DMA_PAUSE:
> +		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
> +		if (fsl_chan->edesc) {
> +			fsl_edma_disable_request(fsl_chan);
> +			fsl_chan->status = DMA_PAUSED;
> +		}
> +		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
> +		return 0;
> +
> +	case DMA_RESUME:
> +		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
> +		if (fsl_chan->edesc) {
> +			fsl_edma_enable_request(fsl_chan);
> +			fsl_chan->status = DMA_IN_PROGRESS;
> +		}
> +		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
> +		return 0;
> +
> +	default:
> +		return -ENXIO;
> +	}
> +}
> +

> +static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
> +		int sg_len)
> +{
> +	struct fsl_edma_desc *fsl_desc;
> +	int i;
> +
> +	fsl_desc = kzalloc(sizeof(*fsl_desc) + sizeof(struct fsl_edma_sw_tcd) * sg_len,
> +				GFP_NOWAIT);
> +	if (!fsl_desc)
> +		return NULL;
> +
> +	fsl_desc->echan = fsl_chan;
> +	fsl_desc->n_tcds = sg_len;
> +	for (i = 0; i < sg_len; i++) {
> +		fsl_desc->tcd[i].vtcd = dma_pool_alloc(fsl_chan->tcd_pool,
> +					GFP_NOWAIT, &fsl_desc->tcd[i].ptcd);
> +		if (!fsl_desc->tcd[i].vtcd)
> +			goto err;
> +	}
> +	return fsl_desc;
> +
> +err:
> +	while (--i >= 0)
> +		dma_pool_free(fsl_chan->tcd_pool, fsl_desc->tcd[i].vtcd,
> +				fsl_desc->tcd[i].ptcd);
> +	kfree(fsl_desc);
> +	return NULL;
> +}
> +
> +static struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
> +		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
> +		size_t period_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
you may want to implement the capablities api subsequently for audio usage.

> +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> +	struct fsl_edma_desc *fsl_desc;
> +	dma_addr_t dma_buf_next;
> +	int sg_len, i;
> +	u32 src_addr, dst_addr, last_sg, nbytes;
> +	u16 soff, doff, iter;
> +
> +	if (!is_slave_direction(fsl_chan->fsc.dir))
> +		return NULL;
> +
> +	sg_len = buf_len / period_len;
> +	fsl_desc = fsl_edma_alloc_desc(fsl_chan, sg_len);
> +	if (!fsl_desc)
> +		return NULL;
> +	fsl_desc->iscyclic = true;
> +
> +	dma_buf_next = dma_addr;
> +	nbytes = fsl_chan->fsc.addr_width * fsl_chan->fsc.burst;
> +	iter = period_len / nbytes;
empty line here pls

> +	for (i = 0; i < sg_len; i++) {
> +		if (dma_buf_next >= dma_addr + buf_len)
> +			dma_buf_next = dma_addr;
> +
> +		/* get next sg's physical address */
> +		last_sg = fsl_desc->tcd[(i + 1) % sg_len].ptcd;
> +
> +		if (fsl_chan->fsc.dir == DMA_MEM_TO_DEV) {
> +			src_addr = dma_buf_next;
> +			dst_addr = fsl_chan->fsc.dev_addr;
> +			soff = fsl_chan->fsc.addr_width;
> +			doff = 0;
> +		} else {
> +			src_addr = fsl_chan->fsc.dev_addr;
> +			dst_addr = dma_buf_next;
> +			soff = 0;
> +			doff = fsl_chan->fsc.addr_width;
> +		}
> +
> +		fill_tcd_params(fsl_chan->edma, fsl_desc->tcd[i].vtcd, src_addr,
> +				dst_addr, fsl_chan->fsc.attr, soff, nbytes, 0,
> +				iter, iter, doff, last_sg, true, false, true);
> +		dma_buf_next += period_len;
> +	}
> +
> +	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
> +}

-- 
~Vinod
