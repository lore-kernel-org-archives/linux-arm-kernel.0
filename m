From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Tue, 17 Sep 2013 07:37:48 +0000
Subject: [PATCH 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20130917045359.GN17188@intel.com>
References: <1378374799-16357-1-git-send-email-b35083@freescale.com>
 <20130917045359.GN17188@intel.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E85223E0C@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Tuesday, September 17, 2013 12:54 PM
> To: Lu Jingchang-B35083
> Cc: djbw at fb.com; shawn.guo at linaro.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; Wang
> Huan-B18965
> Subject: Re: [PATCH 3/3] dma: Add Freescale eDMA engine driver support
> 
> I need ACK from DT maintainers on the above parts
Should I cc this to one of the DT maintainers? Thanks.

> 
> > +static int fsl_edma_control(struct dma_chan *chan, enum dma_ctrl_cmd
> cmd,
> > +		unsigned long arg)
> > +{
> > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > +	struct dma_slave_config *cfg = (void *)arg;
> > +
> > +	switch (cmd) {
> > +	case DMA_TERMINATE_ALL:
> > +		fsl_edma_disable_request(fsl_chan);
> > +		fsl_chan->edesc = NULL;
> you need to hold the lock here to prevent race here!
Thanks, I will fix this in the next version of the patch.

> 
> > +		vchan_free_chan_resources(&fsl_chan->vchan);
> > +		return 0;
> > +
> > +	case DMA_SLAVE_CONFIG:
> > +		fsl_chan->fsc.dir = cfg->direction;
> > +		if (cfg->direction == DMA_DEV_TO_MEM) {
> > +			fsl_chan->fsc.dev_addr = cfg->src_addr;
> > +			fsl_chan->fsc.addr_width = cfg->src_addr_width;
> > +			fsl_chan->fsc.burst = cfg->src_maxburst;
> > +			fsl_chan->fsc.attr = fsl_edma_get_tcd_attr(cfg-
> >src_addr_width);
> > +		} else if (cfg->direction == DMA_MEM_TO_DEV) {
> > +			fsl_chan->fsc.dev_addr = cfg->dst_addr;
> > +			fsl_chan->fsc.addr_width = cfg->dst_addr_width;
> > +			fsl_chan->fsc.burst = cfg->dst_maxburst;
> > +			fsl_chan->fsc.attr = fsl_edma_get_tcd_attr(cfg-
> >dst_addr_width);
> > +		} else {
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (!cfg->slave_id) {
> > +			return -EINVAL;
> should you check for this first, you wrote the channel with config above
> and now
> returning error?
Yes, the slave id should be checked first, thanks!

> > +	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
> > +	vdesc = vchan_find_desc(&fsl_chan->vchan, cookie);
> > +	if (fsl_chan->edesc && cookie == fsl_chan->edesc->vdesc.tx.cookie)
> > +		txstate->residue = fsl_edma_desc_residue(fsl_chan, vdesc, 1);
> why not use true/false for the last bool arg?
Thanks, I will use true/false instead.






Best Regards,
Jingchang
