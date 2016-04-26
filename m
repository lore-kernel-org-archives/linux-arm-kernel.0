From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 26 Apr 2016 09:18:54 +0530
Subject: [PATCH v5 3/3] dmaengine: sun6i: Add cyclic capability
In-Reply-To: <f2e8f84750757588f80c934a995c181d42905dde.1461307982.git.moinejf@free.fr>
References: <cover.1461307982.git.moinejf@free.fr>
 <f2e8f84750757588f80c934a995c181d42905dde.1461307982.git.moinejf@free.fr>
Message-ID: <20160426034853.GG2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 08:49:55AM +0200, Jean-Francois Moine wrote:
> DMA cyclic transfers are required by audio streaming.
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/dma/sun6i-dma.c | 129 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 122 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 821fc4f..f0c4a53 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -146,6 +146,8 @@ struct sun6i_vchan {
>  	struct dma_slave_config	cfg;
>  	struct sun6i_pchan	*phy;
>  	u8			port;
> +	u8			irq_type;
> +	bool			cyclic;
>  };
>  
>  struct sun6i_dma_dev {
> @@ -254,6 +256,30 @@ static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
>  	return addr_width >> 1;
>  }
>  
> +static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
> +{
> +	struct sun6i_desc *txd = pchan->desc;
> +	struct sun6i_dma_lli *lli;
> +	size_t bytes;
> +	dma_addr_t pos;
> +
> +	pos = readl(pchan->base + DMA_CHAN_LLI_ADDR);
> +	bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
> +
> +	if (pos == LLI_LAST_ITEM)
> +		return bytes;
> +
> +	for (lli = txd->v_lli; lli; lli = lli->v_lli_next) {
> +		if (lli->p_lli_next == pos) {
> +			for (lli = lli->v_lli_next; lli; lli = lli->v_lli_next)
> +				bytes += lli->len;
> +			break;
> +		}
> +	}
> +
> +	return bytes;
> +}
> +
>  static void *sun6i_dma_lli_add(struct sun6i_dma_lli *prev,
>  			       struct sun6i_dma_lli *next,
>  			       dma_addr_t next_phy,
> @@ -342,8 +368,12 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
>  	irq_reg = pchan->idx / DMA_IRQ_CHAN_NR;
>  	irq_offset = pchan->idx % DMA_IRQ_CHAN_NR;
>  
> +	vchan->irq_type = vchan->cyclic ? DMA_IRQ_PKG : DMA_IRQ_QUEUE;
> +
>  	irq_val = readl(sdev->base + DMA_IRQ_EN(irq_reg));
> -	irq_val |= DMA_IRQ_QUEUE << (irq_offset * DMA_IRQ_CHAN_WIDTH);
> +	irq_val &= ~((DMA_IRQ_HALF | DMA_IRQ_PKG | DMA_IRQ_QUEUE) <<
> +			(irq_offset * DMA_IRQ_CHAN_WIDTH));
> +	irq_val |= vchan->irq_type << (irq_offset * DMA_IRQ_CHAN_WIDTH);
>  	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
>  
>  	writel(pchan->desc->p_lli, pchan->base + DMA_CHAN_LLI_ADDR);
> @@ -440,11 +470,12 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
>  		writel(status, sdev->base + DMA_IRQ_STAT(i));
>  
>  		for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
> -			if (status & DMA_IRQ_QUEUE) {
> -				pchan = sdev->pchans + j;
> -				vchan = pchan->vchan;
> -
> -				if (vchan) {
> +			pchan = sdev->pchans + j;
> +			vchan = pchan->vchan;
> +			if (vchan && (status & vchan->irq_type)) {
> +				if (vchan->cyclic) {
> +					vchan_cyclic_callback(&pchan->desc->vd);
> +				} else {
>  					spin_lock(&vchan->vc.lock);
>  					vchan_cookie_complete(&pchan->desc->vd);
>  					pchan->done = pchan->desc;
> @@ -650,6 +681,78 @@ err_lli_free:
>  	return NULL;
>  }
>  
> +static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
> +					struct dma_chan *chan,
> +					dma_addr_t buf_addr,
> +					size_t buf_len,
> +					size_t period_len,
> +					enum dma_transfer_direction dir,
> +					unsigned long flags)
> +{
> +	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(chan->device);
> +	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
> +	struct dma_slave_config *sconfig = &vchan->cfg;
> +	struct sun6i_dma_lli *v_lli, *prev = NULL;
> +	struct sun6i_desc *txd;
> +	dma_addr_t p_lli;
> +	u32 lli_cfg;
> +	unsigned int i, periods = buf_len / period_len;
> +	int ret;

typically we check if direction is slave or not..

> +
> +	ret = set_config(sdev, sconfig, dir, &lli_cfg);
> +	if (ret) {
> +		dev_err(chan2dev(chan), "Invalid DMA configuration\n");
> +		return NULL;
> +	}
> +
> +	txd = kzalloc(sizeof(*txd), GFP_NOWAIT);
> +	if (!txd)
> +		return NULL;
> +
> +	for (i = 0; i < periods; i++) {
> +		v_lli = dma_pool_alloc(sdev->pool, GFP_NOWAIT, &p_lli);
> +		if (!v_lli) {
> +			dev_err(sdev->slave.dev, "Failed to alloc lli memory\n");
> +			goto err_lli_free;
> +		}
> +
> +		v_lli->len = period_len;
> +		v_lli->para = NORMAL_WAIT;
> +
> +		if (dir == DMA_MEM_TO_DEV) {
> +			v_lli->src = buf_addr + period_len * i;
> +			v_lli->dst = sconfig->dst_addr;
> +			v_lli->cfg = lli_cfg |
> +				DMA_CHAN_CFG_DST_IO_MODE |
> +				DMA_CHAN_CFG_SRC_LINEAR_MODE |
> +				DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
> +				DMA_CHAN_CFG_DST_DRQ(vchan->port);
> +		} else {

if we check direction above, then this is fine

-- 
~Vinod
