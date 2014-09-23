From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 23 Sep 2014 15:58:50 +0530
Subject: [PATCH 1/2] dmaengine: Add QCOM ADM DMA driver
In-Reply-To: <1410401933-20621-2-git-send-email-agross@codeaurora.org>
References: <1410401933-20621-1-git-send-email-agross@codeaurora.org>
 <1410401933-20621-2-git-send-email-agross@codeaurora.org>
Message-ID: <20140923102850.GI24663@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 09:18:52PM -0500, Andy Gross wrote:

> +static int adm_slave_config(struct adm_chan *achan,
> +		struct dma_slave_config *cfg)
> +{
> +	int ret = 0;
> +	u32 burst;
> +	struct adm_device *adev = achan->adev;
> +
> +	memcpy(&achan->slave, cfg, sizeof(*cfg));
> +
> +	/* set channel CRCI burst, if applicable */
> +	if (achan->crci) {
> +		burst = max_t(u32, cfg->src_maxburst, cfg->dst_maxburst);
> +
> +		switch (burst) {
> +		case 16:
> +			achan->blk_size = 0;
> +			break;
> +		case 32:
> +			achan->blk_size = 1;
> +			break;
> +		case 64:
> +			achan->blk_size = 2;
> +			break;
> +		case 128:
> +			achan->blk_size = 3;
> +			break;
> +		case 192:
> +			achan->blk_size = 4;
> +			break;
> +		case 256:
> +			achan->blk_size = 5;
> +			break;
> +		default:
> +			achan->slave.src_maxburst = 0;
> +			achan->slave.dst_maxburst = 0;
Why clear these for error cases
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (!ret)
> +			writel(achan->blk_size,
> +				adev->regs + HI_CRCI_CTL(achan->id, adev->ee));
and why do we write to HW on this. Shouldn't this be done when you program
the descriptor?

> +static enum dma_status adm_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> +	struct dma_tx_state *txstate)
> +{
> +	struct adm_chan *achan = to_adm_chan(chan);
> +	struct virt_dma_desc *vd;
> +	enum dma_status ret;
> +	unsigned long flags;
> +	size_t residue = 0;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +
Last arg can be null to this, so before you do residue calcluation and block
interrupts would make sense to return from here if arg is NULL

> +	spin_lock_irqsave(&achan->vc.lock, flags);
> +
> +	vd = vchan_find_desc(&achan->vc, cookie);
> +	if (vd)
> +		residue = container_of(vd, struct adm_async_desc, vd)->length;
> +	else if (achan->curr_txd && achan->curr_txd->vd.tx.cookie == cookie)
> +		residue = achan->curr_txd->length;
so this is current cookie, so you need to read from HW on current position
> +
> +	spin_unlock_irqrestore(&achan->vc.lock, flags);
> +
> +	dma_set_residue(txstate, residue);
> +
> +	if (achan->error)
> +		return DMA_ERROR;
> +
> +	return ret;

-- 
~Vinod
