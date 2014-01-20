From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 20 Jan 2014 15:05:41 +0530
Subject: [PATCHv10 2/2] dma: Add Freescale eDMA engine driver support
In-Reply-To: <43d79ce905e24e9bb58ef49ac19db7d7@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1389938684-29467-1-git-send-email-b35083@freescale.com>
 <1389938684-29467-3-git-send-email-b35083@freescale.com>
 <20140120074019.GF26823@intel.com>
 <43d79ce905e24e9bb58ef49ac19db7d7@BL2PR03MB467.namprd03.prod.outlook.com>
Message-ID: <20140120093541.GX26823@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 09:06:43AM +0000, Jingchang Lu wrote:
> 
> 
> > -----Original Message-----
> > From: Vinod Koul [mailto:vinod.koul at intel.com]
> > Sent: Monday, January 20, 2014 3:40 PM
> > To: Lu Jingchang-B35083
> > Cc: dan.j.williams at intel.com; arnd at arndb.de; shawn.guo at linaro.org;
> > pawel.moll at arm.com; mark.rutland at arm.com; swarren at wwwdotorg.org; linux-
> > kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > devicetree at vger.kernel.org; Wang Huan-B18965
> > Subject: Re: [PATCHv10 2/2] dma: Add Freescale eDMA engine driver support
> > 
> > On Fri, Jan 17, 2014 at 02:04:44PM +0800, Jingchang Lu wrote:
> > > Add Freescale enhanced direct memory(eDMA) controller support.
> > > This module can be found on Vybrid and LS-1 SoCs.
> > >
> > > Signed-off-by: Alison Wang <b18965@freescale.com>
> > > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > 
> > > +static int fsl_edma_control(struct dma_chan *chan, enum dma_ctrl_cmd
> > cmd,
> > > +		unsigned long arg)
> > > +{
> > > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > > +	struct dma_slave_config *cfg = (void *)arg;
> > > +	unsigned long flags;
> > > +	LIST_HEAD(head);
> > > +
> > > +	switch (cmd) {
> > > +	case DMA_TERMINATE_ALL:
> > > +		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
> > > +		fsl_edma_disable_request(fsl_chan);
> > > +		fsl_chan->edesc = NULL;
> > > +		vchan_get_all_descriptors(&fsl_chan->vchan, &head);
> > > +		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
> > > +		vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
> > > +		return 0;
> > well what happens to the current ongoing transactions, i don't see those
> > getting
> > terminated?
> The fsl_edma_disable_request(fsl_chan) would end the channel's ongoing transaction, then
> the eDMA would not response to device dma request, and the vchan_dma_desc_free_list()
> will release all associate memory. Thanks.
Can you explain a bit more how terminate will happen, given taht you are using
same thing for pause?

> > 
> > > +
> > > +	case DMA_SLAVE_CONFIG:
> > > +		fsl_chan->fsc.dir = cfg->direction;
> > > +		if (cfg->direction == DMA_DEV_TO_MEM) {
> > > +			fsl_chan->fsc.dev_addr = cfg->src_addr;
> > > +			fsl_chan->fsc.addr_width = cfg->src_addr_width;
> > > +			fsl_chan->fsc.burst = cfg->src_maxburst;
> > > +			fsl_chan->fsc.attr = fsl_edma_get_tcd_attr(cfg-
> > >src_addr_width);
> > > +		} else if (cfg->direction == DMA_MEM_TO_DEV) {
> > > +			fsl_chan->fsc.dev_addr = cfg->dst_addr;
> > > +			fsl_chan->fsc.addr_width = cfg->dst_addr_width;
> > > +			fsl_chan->fsc.burst = cfg->dst_maxburst;
> > > +			fsl_chan->fsc.attr = fsl_edma_get_tcd_attr(cfg-
> > >dst_addr_width);
> > okay atrr is address width, why not save this standard struct instead?
> The value saved in fsc.attr is transferred by fsl_edma_get_tcd_attr(), it can
> be set into the channel control register later directly. the edma driver doesn't
> need to save all dma_slave_config parameters, so it only gets the necessaries.
Okay then this apprach looks okay

> > > +		} else {
> > > +			return -EINVAL;
> > > +		}
> > > +		return 0;
> > > +
> > > +	case DMA_PAUSE:
> > > +		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
> > > +		if (fsl_chan->edesc) {
> > > +			fsl_edma_disable_request(fsl_chan);
> > > +			fsl_chan->status = DMA_PAUSED;
> > > +		}
> > > +		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
> > > +		return 0;
> > > +
> > > +	case DMA_RESUME:
> > > +		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
> > > +		if (fsl_chan->edesc) {
> > > +			fsl_edma_enable_request(fsl_chan);
> > > +			fsl_chan->status = DMA_IN_PROGRESS;
> > > +		}
> > > +		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
> > > +		return 0;
> > > +
> > > +	default:
> > > +		return -ENXIO;
> > > +	}
> > > +}
> > > +
> > 
> > > +static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan
> > *fsl_chan,
> > > +		int sg_len)
> > > +{
> > > +	struct fsl_edma_desc *fsl_desc;
> > > +	int i;
> > > +
> > > +	fsl_desc = kzalloc(sizeof(*fsl_desc) + sizeof(struct
> > fsl_edma_sw_tcd) * sg_len,
> > > +				GFP_NOWAIT);
> > > +	if (!fsl_desc)
> > > +		return NULL;
> > > +
> > > +	fsl_desc->echan = fsl_chan;
> > > +	fsl_desc->n_tcds = sg_len;
> > > +	for (i = 0; i < sg_len; i++) {
> > > +		fsl_desc->tcd[i].vtcd = dma_pool_alloc(fsl_chan->tcd_pool,
> > > +					GFP_NOWAIT, &fsl_desc->tcd[i].ptcd);
> > > +		if (!fsl_desc->tcd[i].vtcd)
> > > +			goto err;
> > > +	}
> > > +	return fsl_desc;
> > > +
> > > +err:
> > > +	while (--i >= 0)
> > > +		dma_pool_free(fsl_chan->tcd_pool, fsl_desc->tcd[i].vtcd,
> > > +				fsl_desc->tcd[i].ptcd);
> > > +	kfree(fsl_desc);
> > > +	return NULL;
> > > +}
> > > +
> > > +static struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
> > > +		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
> > > +		size_t period_len, enum dma_transfer_direction direction,
> > > +		unsigned long flags, void *context)
> > > +{
> > you may want to implement the capablities api subsequently for audio
> > usage.
> Do you mean the device_slave_caps function? If it is, I will add it.
Yes, that can be incrementally added..

-- 
