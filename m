From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Aug 2013 13:49:37 +0530
Subject: [PATCH v2 10/11] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <1376153545-14361-11-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
 <1376153545-14361-11-git-send-email-zonque@gmail.com>
Message-ID: <20130814081937.GK32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 06:52:24PM +0200, Daniel Mack wrote:
> In order to report the channel's residue, we have to memorize the first
> dma buffer position when the channel is configured.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/dma/mmp_pdma.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index 7a0956b..ab0303b 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -28,8 +28,8 @@
>  #define DALGN		0x00a0
>  #define DINT		0x00f0
>  #define DDADR		0x0200
> -#define DSADR		0x0204
> -#define DTADR		0x0208
> +#define DSADR(n)	(0x0204 + ((n) << 4))
> +#define DTADR(n)	(0x0208 + ((n) << 4))
>  #define DCMD		0x020c
>  
>  #define DCSR_RUN	(1 << 31)	/* Run Bit (read / write) */
> @@ -97,6 +97,13 @@ struct mmp_pdma_chan {
>  	struct dma_async_tx_descriptor desc;
>  	struct mmp_pdma_phy *phy;
>  	enum dma_transfer_direction dir;
> +	/*
> +	 * We memorize the original start address of the first descriptor as
> +	 * well as the original total length so we can later determine the
> +	 * channel's residue.
> +	 */
> +	dma_addr_t start_addr;
> +	u32 total_len;
well instead of rembering two values and doing two computations runtime, you can store
last_addr = start_addr + total_len;

then calculate
	residue = last_addr - dma_poistion;

Neverthless, this is okay too, so am going to apply this one..

~Vinod
>  
>  	/* channel's basic info */
>  	struct tasklet_struct tasklet;
> @@ -470,6 +477,13 @@ mmp_pdma_prep_memcpy(struct dma_chan *dchan,
>  		chan->dcmd |= DCMD_BURST32;
>  	}
>  
> +	if (chan->dir == DMA_MEM_TO_DEV)
> +		chan->start_addr = dma_src;
> +	else
> +		chan->start_addr = dma_dst;
> +
> +	chan->total_len = len;
> +
>  	do {
>  		/* Allocate the link descriptor from DMA pool */
>  		new = mmp_pdma_alloc_descriptor(chan);
> @@ -541,11 +555,17 @@ mmp_pdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
>  		return NULL;
>  
>  	chan->byte_align = false;
> +	chan->total_len = 0;
>  
>  	for_each_sg(sgl, sg, sg_len, i) {
>  		addr = sg_dma_address(sg);
>  		avail = sg_dma_len(sgl);
>  
> +		if (!first)
> +			chan->start_addr = addr;
> +
> +		chan->total_len += avail;
> +
>  		do {
>  			len = min_t(size_t, avail, PDMA_MAX_DESC_BYTES);
>  			if (addr & 0x7)
> @@ -672,6 +692,20 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
>  	return ret;
>  }
>  
> +static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan)
> +{
> +	u32 curr, done;
> +
> +	if (chan->dir == DMA_DEV_TO_MEM)
> +		curr = readl(chan->phy->base + DTADR(chan->phy->idx));
> +	else
> +		curr = readl(chan->phy->base + DSADR(chan->phy->idx));
> +
> +	done = curr - chan->start_addr;
> +
> +	return chan->total_len - done;
simpler logic:
store the 
> +}
> +
>  static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
>  			dma_cookie_t cookie, struct dma_tx_state *txstate)
>  {
> @@ -681,6 +715,7 @@ static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
>  
>  	spin_lock_irqsave(&chan->desc_lock, flags);
>  	ret = dma_cookie_status(dchan, cookie, txstate);
> +	txstate->residue = mmp_pdma_residue(chan);
>  	spin_unlock_irqrestore(&chan->desc_lock, flags);
>  
>  	return ret;
> -- 
> 1.8.3.1
> 

-- 
