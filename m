From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 7 Jan 2016 10:19:09 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix double IRQ issue by setting
 IRQ_DISABLE_UNLAZY flag
In-Reply-To: <alpine.DEB.2.11.1601061103000.3689@nanos>
References: <1450875495-2229-1-git-send-email-rsahu@apm.com>
 <20160106091323.GP2940@localhost>
 <CAFd313xhh_4OFP6W2yuApM8ppYMX20DUCCQHJ9YEtCMbzr6Hgg@mail.gmail.com>
 <20160106093121.GB11778@localhost>
 <alpine.DEB.2.11.1601061103000.3689@nanos>
Message-ID: <20160107044909.GF11778@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2016 at 11:05:02AM +0100, Thomas Gleixner wrote:
> On Wed, 6 Jan 2016, Vinod Koul wrote:
> > On Wed, Jan 06, 2016 at 02:51:07PM +0530, Rameshwar Sahu wrote:
> > > >> @@ -1610,6 +1611,7 @@ static int xgene_dma_request_irqs(struct xgene_dma *pdma)
> > > >>       /* Register DMA channel rx irq */
> > > >>       for (i = 0; i < XGENE_DMA_MAX_CHANNEL; i++) {
> > > >>               chan = &pdma->chan[i];
> > > >> +             irq_set_status_flags(chan->rx_irq, IRQ_DISABLE_UNLAZY);
> > > >
> > > > Why not use irq_settings_disable_unlazy(), at least read the reference you
> > > > pointed out!
> > > 
> > > irq_settings_disable_unlazy() is helper function to test
> > > IRQ_DISABLE_UNLAZY flag is set or not, it's not for setting this flag.
> > > FYI...
> > > +static inline bool irq_settings_disable_unlazy(struct irq_desc *desc)
> > > +{
> > > + return desc->status_use_accessors & _IRQ_DISABLE_UNLAZY;
> > > +}
> > 
> > Ah yes, I saw clear API and assumed there would be set. Then I think we
> > should add a set helper as well as the usage is intended for drivers to
> > set this flag
> > 
> > Thomas,
> > 
> > Any reason why you didn't add a set helper, only test and clear?
> 
> Why would I? Those helpers are core internal and not usable in random drivers.
> 
> Drivers have irq_set_status_flags()/irq_clear_status_flags() ...

The effect of irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY) is same as
providing a helper. If your recommendation is to use this by driver then I
am find with the approach too

Thanks
-- 
~Vinod
