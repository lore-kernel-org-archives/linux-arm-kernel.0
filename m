From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 27 Apr 2015 10:33:58 +0200
Subject: [PATCH] dmaengine: at_xdmac: fix slave configuration issue
In-Reply-To: <20150427033328.GH2738@intel.com>
References: <1429196640-8703-1-git-send-email-ludovic.desroches@atmel.com>
 <20150427033328.GH2738@intel.com>
Message-ID: <20150427083358.GG26450@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Mon, Apr 27, 2015 at 09:03:28AM +0530, Vinod Koul wrote:
> On Thu, Apr 16, 2015 at 05:04:00PM +0200, Ludovic Desroches wrote:
> > When doing the slave configuration, an error is returned if the maxburst
> > value is not supported. The bug comes from the fact that we always check
> > the maxburst for both directions but in the case of an unidirectional
> > channel, only one is set.
> While setting the slave configuration we are not tied to a channel
> direction, the direction is passed usin prep_ method. So from that
> prespective a channle can be used for tx and rx with same slave config set.
> 
> Now if we were invoking at_xdmac_set_slave_config from prep_ calls then it
> would have been fine but here we are checking when the slave config is set
> so this is not right. You should check maxburst at runtime then...
> 

I don't understand why we should wait before checking the
configuration... Some channels are unidirectionnal so implicitly we know
the direction at configuration time because the device will fill only a
part of the dma_slave_config structure. For example, the atmel usart
requests a tx and a rx channels. When configuring the tx channel, only
the dst_ fields of the dma_slave_config structure are filled. Is it a
bad behavior?

The change introduced by this patch doesn't really care about the
direction, it only tells that if the device only fills src_ fields then
I don't have to check fields not configured.

Regards

Ludovic

> -- 
> ~Vinod
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > Cc: <stable@vger.kernel.org> # 3.19 and later
> > ---
> >  drivers/dma/at_xdmac.c | 97 +++++++++++++++++++++++++++-----------------------
> >  1 file changed, 52 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> > index d9891d3..30e161b 100644
> > --- a/drivers/dma/at_xdmac.c
> > +++ b/drivers/dma/at_xdmac.c
> > @@ -501,54 +501,61 @@ static int at_xdmac_set_slave_config(struct dma_chan *chan,
> >  	u8 dwidth;
> >  	int csize;
> >  
> > -	atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG] =
> > -		AT91_XDMAC_DT_PERID(atchan->perid)
> > -		| AT_XDMAC_CC_DAM_INCREMENTED_AM
> > -		| AT_XDMAC_CC_SAM_FIXED_AM
> > -		| AT_XDMAC_CC_DIF(atchan->memif)
> > -		| AT_XDMAC_CC_SIF(atchan->perif)
> > -		| AT_XDMAC_CC_SWREQ_HWR_CONNECTED
> > -		| AT_XDMAC_CC_DSYNC_PER2MEM
> > -		| AT_XDMAC_CC_MBSIZE_SIXTEEN
> > -		| AT_XDMAC_CC_TYPE_PER_TRAN;
> > -	csize = at_xdmac_csize(sconfig->src_maxburst);
> > -	if (csize < 0) {
> > -		dev_err(chan2dev(chan), "invalid src maxburst value\n");
> > -		return -EINVAL;
> > -	}
> > -	atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG] |= AT_XDMAC_CC_CSIZE(csize);
> > -	dwidth = ffs(sconfig->src_addr_width) - 1;
> > -	atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG] |= AT_XDMAC_CC_DWIDTH(dwidth);
> > -
> > -
> > -	atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG] =
> > -		AT91_XDMAC_DT_PERID(atchan->perid)
> > -		| AT_XDMAC_CC_DAM_FIXED_AM
> > -		| AT_XDMAC_CC_SAM_INCREMENTED_AM
> > -		| AT_XDMAC_CC_DIF(atchan->perif)
> > -		| AT_XDMAC_CC_SIF(atchan->memif)
> > -		| AT_XDMAC_CC_SWREQ_HWR_CONNECTED
> > -		| AT_XDMAC_CC_DSYNC_MEM2PER
> > -		| AT_XDMAC_CC_MBSIZE_SIXTEEN
> > -		| AT_XDMAC_CC_TYPE_PER_TRAN;
> > -	csize = at_xdmac_csize(sconfig->dst_maxburst);
> > -	if (csize < 0) {
> > -		dev_err(chan2dev(chan), "invalid src maxburst value\n");
> > -		return -EINVAL;
> > +	if (sconfig->src_addr) {
> > +		atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG] =
> > +			AT91_XDMAC_DT_PERID(atchan->perid)
> > +			| AT_XDMAC_CC_DAM_INCREMENTED_AM
> > +			| AT_XDMAC_CC_SAM_FIXED_AM
> > +			| AT_XDMAC_CC_DIF(atchan->memif)
> > +			| AT_XDMAC_CC_SIF(atchan->perif)
> > +			| AT_XDMAC_CC_SWREQ_HWR_CONNECTED
> > +			| AT_XDMAC_CC_DSYNC_PER2MEM
> > +			| AT_XDMAC_CC_MBSIZE_SIXTEEN
> > +			| AT_XDMAC_CC_TYPE_PER_TRAN;
> > +		csize = at_xdmac_csize(sconfig->src_maxburst);
> > +		if (csize < 0) {
> > +			dev_err(chan2dev(chan), "invalid src maxburst value\n");
> > +			return -EINVAL;
> > +		}
> > +		atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG] |= AT_XDMAC_CC_CSIZE(csize);
> > +		dwidth = ffs(sconfig->src_addr_width) - 1;
> > +		atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG] |= AT_XDMAC_CC_DWIDTH(dwidth);
> > +		/* Src addr is needed to configure the link list descriptor. */
> > +		atchan->per_src_addr = sconfig->src_addr;
> > +
> > +		dev_dbg(chan2dev(chan),
> > +			"%s: cfg[dev2mem]=0x%08x, per_src_addr=0x%08x\n",
> > +			__func__, atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG],
> > +			atchan->per_src_addr);
> >  	}
> > -	atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG] |= AT_XDMAC_CC_CSIZE(csize);
> > -	dwidth = ffs(sconfig->dst_addr_width) - 1;
> > -	atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG] |= AT_XDMAC_CC_DWIDTH(dwidth);
> >  
> > -	/* Src and dst addr are needed to configure the link list descriptor. */
> > -	atchan->per_src_addr = sconfig->src_addr;
> > -	atchan->per_dst_addr = sconfig->dst_addr;
> > +	if (sconfig->dst_addr) {
> > +		atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG] =
> > +			AT91_XDMAC_DT_PERID(atchan->perid)
> > +			| AT_XDMAC_CC_DAM_FIXED_AM
> > +			| AT_XDMAC_CC_SAM_INCREMENTED_AM
> > +			| AT_XDMAC_CC_DIF(atchan->perif)
> > +			| AT_XDMAC_CC_SIF(atchan->memif)
> > +			| AT_XDMAC_CC_SWREQ_HWR_CONNECTED
> > +			| AT_XDMAC_CC_DSYNC_MEM2PER
> > +			| AT_XDMAC_CC_MBSIZE_SIXTEEN
> > +			| AT_XDMAC_CC_TYPE_PER_TRAN;
> > +		csize = at_xdmac_csize(sconfig->dst_maxburst);
> > +		if (csize < 0) {
> > +			dev_err(chan2dev(chan), "invalid src maxburst value\n");
> > +			return -EINVAL;
> > +		}
> > +		atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG] |= AT_XDMAC_CC_CSIZE(csize);
> > +		dwidth = ffs(sconfig->dst_addr_width) - 1;
> > +		atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG] |= AT_XDMAC_CC_DWIDTH(dwidth);
> > +		/* Dst addr is needed to configure the link list descriptor. */
> > +		atchan->per_dst_addr = sconfig->dst_addr;
> >  
> > -	dev_dbg(chan2dev(chan),
> > -		"%s: cfg[dev2mem]=0x%08x, cfg[mem2dev]=0x%08x, per_src_addr=0x%08x, per_dst_addr=0x%08x\n",
> > -		__func__, atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG],
> > -		atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG],
> > -		atchan->per_src_addr, atchan->per_dst_addr);
> > +		dev_dbg(chan2dev(chan),
> > +			"%s: cfg[mem2dev]=0x%08x, per_dst_addr=0x%08x\n",
> > +			__func__, atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG],
> > +			atchan->per_dst_addr);
> > +	}
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.2.0
> > 
> 
> -- 
