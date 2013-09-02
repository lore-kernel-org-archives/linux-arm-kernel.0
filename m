From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Mon, 2 Sep 2013 07:32:53 +0000
Subject: [PATCH v4 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20130902063721.GK7376@intel.com>
References: <1376633274-17850-1-git-send-email-b35083@freescale.com>
 <20130828081742.GC11414@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E8520A8C7@039-SN1MPN1-003.039d.mgd.msft.net>
 <20130902045050.GE7376@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E8520D0D4@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130902063721.GK7376@intel.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E8520F101@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Monday, September 02, 2013 2:37 PM
> To: Lu Jingchang-B35083
> Cc: shawn.guo at linaro.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; devicetree at vger.kernel.org
> Subject: Re: [PATCH v4 3/3] dma: Add Freescale eDMA engine driver support
> 
> On Mon, Sep 02, 2013 at 07:10:53AM +0000, Lu Jingchang-B35083 wrote:
> > > -----Original Message-----
> > > From: Vinod Koul [mailto:vinod.koul at intel.com]
> > > Sent: Monday, September 02, 2013 12:51 PM
> > > To: Lu Jingchang-B35083
> > > Cc: shawn.guo at linaro.org; linux-kernel at vger.kernel.org; linux-arm-
> > > kernel at lists.infradead.org; devicetree at vger.kernel.org
> > > Subject: Re: [PATCH v4 3/3] dma: Add Freescale eDMA engine driver
> support
> > >
> > > On Thu, Aug 29, 2013 at 03:32:04AM +0000, Lu Jingchang-B35083 wrote:
> > >
> > > Please use a right MUA and wrap your lines at 80chars...
> 
> > > > [Lu Jingchang]
> > > No need to put your name :)
> > [Lu Jingchang-b35083]
> > Aha, the Microsoft Outlook adds this automatically with default option.
> You can change that!!
Thanks.
> > >
> > > > > > +static bool fsl_edma_filter_fn(struct dma_chan *chan, void
> > > *fn_param)
> > > > > > +{
> > > > > > +	struct fsl_edma_filter_param *fparam = fn_param;
> > > > > > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > > > > > +
> > > > > > +	if (fsl_chan->edmamux->mux_id != fparam->mux_id)
> > > > > > +		return false;
> > > > > > +
> > > > > > +	fsl_chan->slot_id = fparam->slot_id;
> > > > > > +	chan->private = fn_param;
> > > > > why do you need to use chan->private?
> > > > [Lu Jingchang]
> > > > The private used here is to store the slot_id information, which
> must
> > > be used
> > > > by the DMAMUX in alloc_chan_resources function. Thanks.
> > > Why dont you pass this in struct dma_slave_config memeber slave_id
> for
> > > this.
> > [Lu Jingchang-b35083]
> > I will drop this private and setup the slave_id directly in the filter
> function.
> why in filter? before calling prepare function you can set the slave
> config
How about change the filter_fn to follow:
static bool fsl_edma_filter_fn(struct dma_chan *chan, void *fn_param)
{
        struct fsl_edma_filter_param *fparam = fn_param;
        struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
        unsigned char val;

        if (fsl_chan->edmamux->mux_id != fparam->mux_id)
                return false;

        val = EDMAMUX_CHCFG_ENBL | EDMAMUX_CHCFG_SOURCE(fparam->slot_id);
        fsl_edmamux_config_chan(fsl_chan, val);
        return true;
}
In fact the slot_id isn't need elsewhere, and if the filter return true, 
This channel should be to this request. So no need to save the slave id, Right?



Best Regareds,
Jingchang
