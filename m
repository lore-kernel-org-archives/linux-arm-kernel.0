From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Mon, 2 Sep 2013 07:10:53 +0000
Subject: [PATCH v4 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20130902045050.GE7376@intel.com>
References: <1376633274-17850-1-git-send-email-b35083@freescale.com>
 <20130828081742.GC11414@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E8520A8C7@039-SN1MPN1-003.039d.mgd.msft.net>
 <20130902045050.GE7376@intel.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E8520D0D4@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Monday, September 02, 2013 12:51 PM
> To: Lu Jingchang-B35083
> Cc: shawn.guo at linaro.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; devicetree at vger.kernel.org
> Subject: Re: [PATCH v4 3/3] dma: Add Freescale eDMA engine driver support
> 
> On Thu, Aug 29, 2013 at 03:32:04AM +0000, Lu Jingchang-B35083 wrote:
> 
> Please use a right MUA and wrap your lines at 80chars...
> 
> >
> > >
> > > > +			return -EINVAL;
> > > > +		}
> > > > +		return 0;
> > > > +
> > > > +	default:
> > > > +		return -ENXIO;
> > > > +	}
> > > > +}
> > > > +
> > > > +static enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
> > > > +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> > > > +{
> > > > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > > > +
> > > > +	if (fsl_chan->status == DMA_ERROR)
> > > > +		return DMA_ERROR;
> > > > +
> > > > +	return dma_cookie_status(chan, cookie, txstate);
> > > this will tell if the DMA is completed or not only.
> > > You also need to calculate residue for the pending dma
> > >
> > > Since you support cyclic this should be done properly...
> > >
> > > also you cna take more help from vchan support to make your life
> > > simpler...
> > [Lu Jingchang]
> No need to put your name :)
[Lu Jingchang-b35083] 
Aha, the Microsoft Outlook adds this automatically with default option.
> 
> > Ok, if it is needed, I will add residue calculation in the next version.
> Yes this is needed
> 
> > > > +static bool fsl_edma_filter_fn(struct dma_chan *chan, void
> *fn_param)
> > > > +{
> > > > +	struct fsl_edma_filter_param *fparam = fn_param;
> > > > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > > > +
> > > > +	if (fsl_chan->edmamux->mux_id != fparam->mux_id)
> > > > +		return false;
> > > > +
> > > > +	fsl_chan->slot_id = fparam->slot_id;
> > > > +	chan->private = fn_param;
> > > why do you need to use chan->private?
> > [Lu Jingchang]
> > The private used here is to store the slot_id information, which must
> be used
> > by the DMAMUX in alloc_chan_resources function. Thanks.
> Why dont you pass this in struct dma_slave_config memeber slave_id for
> this.
[Lu Jingchang-b35083] 
I will drop this private and setup the slave_id directly in the filter function.
The slave id is only used in first request phase, if filter is true, the channel
Should be to this slave.
Thanks.







Best Regards,
Jingchang
