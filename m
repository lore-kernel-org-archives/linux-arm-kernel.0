From: vkoul@infradead.org (Vinod Koul)
Date: Thu, 07 Jul 2011 07:36:00 +0530
Subject: [PATCH] dmaengine: mxs-dma: skip request_irq for NO_IRQ
In-Reply-To: <20110707001530.GE4034@S2100-06.ap.freescale.net>
References: <20110630052855.GE25931@S2100-06.ap.freescale.net>
	<1309421193-7785-1-git-send-email-shawn.guo@linaro.org>
	<20110707001530.GE4034@S2100-06.ap.freescale.net>
Message-ID: <1310004360.20150.16.camel@psiaudioba-mobl1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-07-07 at 08:15 +0800, Shawn Guo wrote:
> On Thu, Jun 30, 2011 at 04:06:33PM +0800, Shawn Guo wrote:
> > In general, the mxs-dma users get separate irq for each channel,
> > but gpmi is special one which has only one irq shared by all gpmi
> > channels.  It causes mxs_dma channel allocation function fail for
> > all other gpmi channels except the first one calling into the
> > function.
> > 
> > The patch gets request_irq call skipped for NO_IRQ case, and leaves
> > this gpmi specific quirk to gpmi driver to sort out.  It will fix
> > above problem if gpmi driver sets chan_irq as gpmi irq for only one
> > channel and NO_IRQ for all the rest channels.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > ---
> 
> Hi Vinod,
> 
> Can you please take this patch?
> 
> Regards,
> Shawn
Looks okay to me. Have queued it up and should show up in my tree latest by early next week.
I am on road, hence the delay...


> >  drivers/dma/mxs-dma.c |   10 ++++++----
> >  1 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> > index 88aad4f..2870d91 100644
> > --- a/drivers/dma/mxs-dma.c
> > +++ b/drivers/dma/mxs-dma.c
> > @@ -327,10 +327,12 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
> >  
> >  	memset(mxs_chan->ccw, 0, PAGE_SIZE);
> >  
> > -	ret = request_irq(mxs_chan->chan_irq, mxs_dma_int_handler,
> > -				0, "mxs-dma", mxs_dma);
> > -	if (ret)
> > -		goto err_irq;
> > +	if (mxs_chan->chan_irq != NO_IRQ) {
> > +		ret = request_irq(mxs_chan->chan_irq, mxs_dma_int_handler,
> > +					0, "mxs-dma", mxs_dma);
> > +		if (ret)
> > +			goto err_irq;
> > +	}
> >  
> >  	ret = clk_enable(mxs_dma->clk);
> >  	if (ret)
> > -- 
> > 1.7.4.1
> > 
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
~Vinod Koul
Intel Corp.
