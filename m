From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Tue, 3 Sep 2013 05:43:21 +0000
Subject: [PATCH v4 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20130902111200.GP7376@intel.com>
References: <1376633274-17850-1-git-send-email-b35083@freescale.com>
 <20130828081742.GC11414@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E8520A8C7@039-SN1MPN1-003.039d.mgd.msft.net>
 <20130902045050.GE7376@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E8520D0D4@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130902063721.GK7376@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E8520F101@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130902111200.GP7376@intel.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E852102A1@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > How about change the filter_fn to follow:
> > static bool fsl_edma_filter_fn(struct dma_chan *chan, void *fn_param)
> > {
> >         struct fsl_edma_filter_param *fparam = fn_param;
> >         struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> >         unsigned char val;
> >
> >         if (fsl_chan->edmamux->mux_id != fparam->mux_id)
> >                 return false;
> >
> >         val = EDMAMUX_CHCFG_ENBL | EDMAMUX_CHCFG_SOURCE(fparam-
> >slot_id);
> >         fsl_edmamux_config_chan(fsl_chan, val);
> >         return true;
> > }
> > In fact the slot_id isn't need elsewhere, and if the filter return true,
> > This channel should be to this request. So no need to save the slave id,
> Right?
> something like
> 
> static bool fsl_edma_filter_fn(struct dma_chan *chan, void *fn_param)
> {
> 	struct fsl_edma_filter_param *fparam = fn_param;
> 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> 
> 	if (fsl_chan->edmamux->mux_id != fparam->mux_id)
> 		return false;
> 	return true;
> }
> 
> in thedriver which calls this:
> 
> before prep:
> 
> 	config->slave_id = val;
> 
> 	dma_set_slave_config(chan, slave);
> 
  Do you mean the DMA_SLAVE_CONFIG device_control? Yeah, the slave driver could pass
the slave_id. But the DMA_SLAVE_CONFIG may be called more than once, and the eDMA
driver just needs to set the slave id once for any given channel, after that the 
transfer is transparent to the device. 
  On the other hand, the DMAMUX's setting procedure requires first disable the dmamux
before setting, then if it is set in DMA_SLAVE_CONFIG, the repeated setting may be
complex and unnecessary. The channel is occupied exclusively by the peripheral.
  So, according the HW feature, I think the eDMA needs only set the slave id once,
and since the of_dma helper has pass the slave id in on xlate, we can get and set
the slave id here. How do you think about this?
  Thanks!









Best Regards,
Jingchang
