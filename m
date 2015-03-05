From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 5 Mar 2015 16:09:21 +0530
Subject: [PATCH 1/2] dmaengine: fsl-edma: add dma memcpy support
In-Reply-To: <1419928907-18053-2-git-send-email-jingchang.lu@freescale.com>
References: <1419928907-18053-1-git-send-email-jingchang.lu@freescale.com>
 <1419928907-18053-2-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20150305103921.GE2613@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 04:41:46PM +0800, Jingchang Lu wrote:
> This adds the memory copy capability support, the memcpy
> functionality needs to configure the DMAMUX of the channel
> with the always on slave id.
sorry looks like this slipped earlier..

> 
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  drivers/dma/fsl-edma.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
> index 09e2842..e0bd517 100644
> --- a/drivers/dma/fsl-edma.c
> +++ b/drivers/dma/fsl-edma.c
> @@ -110,6 +110,8 @@
>  #define EDMAMUX_CHCFG_ENBL		0x80
>  #define EDMAMUX_CHCFG_SOURCE(n)		((n) & 0x3F)
>  
> +#define SLAVE_ID_ALWAYSON	63 /* the always on slave id */
shouldnt this be namespaced aptly

otherwise this looks okay, so can you rebase and resend

-- 
~Vinod
> +
>  #define DMAMUX_NR	2
>  
>  #define FSL_EDMA_BUSWIDTHS	BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
> @@ -147,6 +149,7 @@ struct fsl_edma_slave_config {
>  struct fsl_edma_chan {
>  	struct virt_dma_chan		vchan;
>  	enum dma_status			status;
> +	u32				slave_id;
>  	struct fsl_edma_engine		*edma;
>  	struct fsl_edma_desc		*edesc;
>  	struct fsl_edma_slave_config	fsc;
> @@ -637,6 +640,45 @@ static struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
>  
> +static struct dma_async_tx_descriptor *
> +fsl_edma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst,
> +			dma_addr_t src, size_t len, unsigned long tx_flags)
> +{
> +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> +	struct fsl_edma_desc *fsl_desc;
> +	u16 soff, doff, attr;
> +
> +	/*
> +	 * use 4-bytes data transfer size if all is 4-bytes aligned,
> +	 * else 2-bytes data transfer size of all is 2-bytes aligned,
> +	 * otherwise 1-byte tranfer size.
> +	 */
> +	if (src & 0x1 || dst & 0x1 || len & 0x1) {
> +		attr = EDMA_TCD_ATTR_SSIZE_8BIT | EDMA_TCD_ATTR_DSIZE_8BIT;
> +		soff = 0x1;
> +		doff = 0x1;
> +	} else if (src & 0x2 || dst & 0x2 || len & 0x2) {
> +		attr = EDMA_TCD_ATTR_SSIZE_16BIT | EDMA_TCD_ATTR_DSIZE_16BIT;
> +		soff = 0x2;
> +		doff = 0x2;
> +	} else {
> +		attr = EDMA_TCD_ATTR_SSIZE_32BIT | EDMA_TCD_ATTR_DSIZE_32BIT;
> +		soff = 0x4;
> +		doff = 0x4;
> +	}
> +
> +	fsl_desc = fsl_edma_alloc_desc(fsl_chan, 1);
> +	if (!fsl_desc)
> +		return NULL;
> +	fsl_desc->iscyclic = false;
> +
> +	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, src, dst, attr, soff, len,
> +			  0, 1, 1, doff, 0, true, true, false);
> +
> +	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, tx_flags);
> +
> +}
> +
>  static void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
>  {
>  	struct virt_dma_desc *vdesc;
> @@ -735,6 +777,7 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
>  {
>  	struct fsl_edma_engine *fsl_edma = ofdma->of_dma_data;
>  	struct dma_chan *chan, *_chan;
> +	struct fsl_edma_chan *fsl_chan;
>  	unsigned long chans_per_mux = fsl_edma->n_chans / DMAMUX_NR;
>  
>  	if (dma_spec->args_count != 2)
> @@ -748,8 +791,10 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
>  			chan = dma_get_slave_channel(chan);
>  			if (chan) {
>  				chan->device->privatecnt++;
> -				fsl_edma_chan_mux(to_fsl_edma_chan(chan),
> -					dma_spec->args[1], true);
> +				fsl_chan = to_fsl_edma_chan(chan);
> +				fsl_chan->slave_id = dma_spec->args[1];
> +				fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id,
> +						  true);
>  				mutex_unlock(&fsl_edma->fsl_edma_mutex);
>  				return chan;
>  			}
> @@ -763,6 +808,17 @@ static int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  {
>  	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
>  
> +	/*
> +	 * If the slave id of the channel DMAMUX is not set yet,
> +	 * this could happy when the channel is requested by the
> +	 * dma_request_channel() for memory copy purpose instead
> +	 * of by dts binding, then configure the DMAMUX with the
> +	 * always on slave id.
> +	 */
> +	if (fsl_chan->slave_id == 0) {
> +		fsl_chan->slave_id = SLAVE_ID_ALWAYSON;
> +		fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
> +	}
>  	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
>  				sizeof(struct fsl_edma_hw_tcd),
>  				32, 0);
> @@ -778,6 +834,7 @@ static void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
>  	fsl_edma_disable_request(fsl_chan);
>  	fsl_edma_chan_mux(fsl_chan, 0, false);
> +	fsl_chan->slave_id = 0;
>  	fsl_chan->edesc = NULL;
>  	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
> @@ -903,6 +960,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
> +	dma_cap_set(DMA_MEMCPY, fsl_edma->dma_dev.cap_mask);
>  
>  	fsl_edma->dma_dev.dev = &pdev->dev;
>  	fsl_edma->dma_dev.device_alloc_chan_resources
> @@ -912,6 +970,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
>  	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
>  	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
> +	fsl_edma->dma_dev.device_prep_dma_memcpy = fsl_edma_prep_memcpy;
>  	fsl_edma->dma_dev.device_config = fsl_edma_slave_config;
>  	fsl_edma->dma_dev.device_pause = fsl_edma_pause;
>  	fsl_edma->dma_dev.device_resume = fsl_edma_resume;
> -- 
> 1.8.0
> 

-- 
