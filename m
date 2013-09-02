From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 2 Sep 2013 10:20:50 +0530
Subject: [PATCH v4 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E8520A8C7@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1376633274-17850-1-git-send-email-b35083@freescale.com>
 <20130828081742.GC11414@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E8520A8C7@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <20130902045050.GE7376@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 03:32:04AM +0000, Lu Jingchang-B35083 wrote:

Please use a right MUA and wrap your lines at 80chars...

> 
> > 
> > > +			return -EINVAL;
> > > +		}
> > > +		return 0;
> > > +
> > > +	default:
> > > +		return -ENXIO;
> > > +	}
> > > +}
> > > +
> > > +static enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
> > > +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> > > +{
> > > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > > +
> > > +	if (fsl_chan->status == DMA_ERROR)
> > > +		return DMA_ERROR;
> > > +
> > > +	return dma_cookie_status(chan, cookie, txstate);
> > this will tell if the DMA is completed or not only.
> > You also need to calculate residue for the pending dma
> > 
> > Since you support cyclic this should be done properly...
> > 
> > also you cna take more help from vchan support to make your life
> > simpler...
> [Lu Jingchang]
No need to put your name :)
 
> Ok, if it is needed, I will add residue calculation in the next version. 
Yes this is needed

> > > +static bool fsl_edma_filter_fn(struct dma_chan *chan, void *fn_param)
> > > +{
> > > +	struct fsl_edma_filter_param *fparam = fn_param;
> > > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > > +
> > > +	if (fsl_chan->edmamux->mux_id != fparam->mux_id)
> > > +		return false;
> > > +
> > > +	fsl_chan->slot_id = fparam->slot_id;
> > > +	chan->private = fn_param;
> > why do you need to use chan->private?
> [Lu Jingchang] 
> The private used here is to store the slot_id information, which must be used
> by the DMAMUX in alloc_chan_resources function. Thanks.
Why dont you pass this in struct dma_slave_config memeber slave_id for this.

> 
> > > +	return true;
> > > +}
> > > +
> > > +static struct dma_chan *fsl_edma_xlate(struct of_phandle_args
> > *dma_spec,
> > > +		struct of_dma *ofdma)
> > > +{
> > > +	dma_cap_mask_t mask;
> > > +	struct fsl_edma_filter_param fparam;
> > > +
> > > +	if (dma_spec->args_count != 2)
> > > +		return NULL;
> > > +
> > > +	fparam.mux_id = dma_spec->args[0];
> > > +	fparam.slot_id = dma_spec->args[1];
> > > +
> > > +	dma_cap_zero(mask);
> > > +	dma_cap_set(DMA_SLAVE, mask);
> > > +	dma_cap_set(DMA_CYCLIC, mask);
> > > +	return dma_request_channel(mask, fsl_edma_filter_fn, (void
> > *)&fparam);
> > > +}
> > > +
> > > +static int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
> > > +{
> > > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > > +	struct fsl_edma_filter_param *data = chan->private;
> > > +	unsigned char val;
> > > +
> > > +	val = EDMAMUX_CHCFG_ENBL | EDMAMUX_CHCFG_SOURCE(data->slot_id);
> > okay, so what does the slot_id mean?
> >
> [Lu Jingchang] 
> slot_id is the request source id, a peripheral device ID. Each peripheral
> using DMA has a ID that can be identified by the DMA engine. the peripheral ID
> must be written to the DMAMUX configuration register to route the peripheral
> to DMA engine channel. Thanks.
And thanks makes me belive you dont need this way, slave_id is the thing for
you...

~Vinod

-- 
