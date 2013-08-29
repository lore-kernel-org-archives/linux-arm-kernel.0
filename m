From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Thu, 29 Aug 2013 03:32:04 +0000
Subject: [PATCH v4 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20130828081742.GC11414@intel.com>
References: <1376633274-17850-1-git-send-email-b35083@freescale.com>
 <20130828081742.GC11414@intel.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E8520A8C7@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +		} else {
> since you support cyclic, is there a reasonw why you dont support
> pause/resume?
> is it hw issue or planned in future?
[Lu Jingchang] 
The HW supports start/stop request from the peripheral dma request, I had planned to add this in future as requested.
I will add this in the next version patch.
Thanks.

> 
> > +			return -EINVAL;
> > +		}
> > +		return 0;
> > +
> > +	default:
> > +		return -ENXIO;
> > +	}
> > +}
> > +
> > +static enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
> > +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> > +{
> > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > +
> > +	if (fsl_chan->status == DMA_ERROR)
> > +		return DMA_ERROR;
> > +
> > +	return dma_cookie_status(chan, cookie, txstate);
> this will tell if the DMA is completed or not only.
> You also need to calculate residue for the pending dma
> 
> Since you support cyclic this should be done properly...
> 
> also you cna take more help from vchan support to make your life
> simpler...
[Lu Jingchang] 
Ok, if it is needed, I will add residue calculation in the next version. 
Thanks.
> 
[...]
> > +static struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
> > +		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
> > +		size_t period_len, enum dma_transfer_direction direction,
> > +		unsigned long flags, void *context)
> > +{
> > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > +	struct fsl_edma_desc *fsl_desc;
> > +	dma_addr_t dma_buf_next;
> > +	int sg_len, i;
> > +	u32 src_addr, dst_addr, last_sg, nbytes;
> > +	u16 soff, doff, iter;
> > +
> > +	if (!fsl_chan->fsc.dir == DMA_MEM_TO_DEV &&
> > +			!fsl_chan->fsc.dir == DMA_DEV_TO_MEM)
> > +		return NULL;
> you are ignoring the direction arg. Also use is_slave_direction() helper

[...]

> > +	if (!fsl_chan->fsc.dir == DMA_MEM_TO_DEV &&
> > +			!fsl_chan->fsc.dir == DMA_DEV_TO_MEM)
> > +		return NULL;
> ditto
[Lu Jingchang] 
Thanks. I will call the helper function instead.


[...]

> > +static bool fsl_edma_filter_fn(struct dma_chan *chan, void *fn_param)
> > +{
> > +	struct fsl_edma_filter_param *fparam = fn_param;
> > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > +
> > +	if (fsl_chan->edmamux->mux_id != fparam->mux_id)
> > +		return false;
> > +
> > +	fsl_chan->slot_id = fparam->slot_id;
> > +	chan->private = fn_param;
> why do you need to use chan->private?
[Lu Jingchang] 
The private used here is to store the slot_id information, which must be used by the DMAMUX in alloc_chan_resources function. Thanks.

> > +	return true;
> > +}
> > +
> > +static struct dma_chan *fsl_edma_xlate(struct of_phandle_args
> *dma_spec,
> > +		struct of_dma *ofdma)
> > +{
> > +	dma_cap_mask_t mask;
> > +	struct fsl_edma_filter_param fparam;
> > +
> > +	if (dma_spec->args_count != 2)
> > +		return NULL;
> > +
> > +	fparam.mux_id = dma_spec->args[0];
> > +	fparam.slot_id = dma_spec->args[1];
> > +
> > +	dma_cap_zero(mask);
> > +	dma_cap_set(DMA_SLAVE, mask);
> > +	dma_cap_set(DMA_CYCLIC, mask);
> > +	return dma_request_channel(mask, fsl_edma_filter_fn, (void
> *)&fparam);
> > +}
> > +
> > +static int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
> > +{
> > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > +	struct fsl_edma_filter_param *data = chan->private;
> > +	unsigned char val;
> > +
> > +	val = EDMAMUX_CHCFG_ENBL | EDMAMUX_CHCFG_SOURCE(data->slot_id);
> okay, so what does the slot_id mean?
>
[Lu Jingchang] 
slot_id is the request source id, a peripheral device ID. Each peripheral using DMA has a ID that can be identified by the DMA engine. the peripheral ID must be written to the DMAMUX configuration register to route the peripheral to DMA engine channel. Thanks.


Best Regards,
Jingchang
