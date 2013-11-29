From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Nov 2013 14:41:57 +0000
Subject: [PATCH] dma: pl330: ensure DMA descriptors are zero-initialised
In-Reply-To: <1385729844.1871.24.camel@smile>
References: <1385725828-836-1-git-send-email-will.deacon@arm.com>
 <1385729844.1871.24.camel@smile>
Message-ID: <20131129144157.GD31000@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 12:57:50PM +0000, Shevchenko, Andriy wrote:
> On Fri, 2013-11-29 at 11:50 +0000, Will Deacon wrote:
> > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > index 98641eaca080..79e52a94f054 100644
> > --- a/drivers/dma/pl330.c
> > +++ b/drivers/dma/pl330.c
> > @@ -2492,14 +2492,8 @@ static dma_cookie_t pl330_tx_submit(struct dma_async_tx_descriptor *tx)
> >  
> >  static inline void _init_desc(struct dma_pl330_desc *desc)
> >  {
> > -	desc->pchan = NULL;
> >  	desc->req.x = &desc->px;
> >  	desc->req.token = desc;
> > -	desc->rqcfg.swap = SWAP_NO;
> > -	desc->rqcfg.privileged = 0;
> > -	desc->rqcfg.insnaccess = 0;
> > -	desc->rqcfg.scctl = SCCTRL0;
> > -	desc->rqcfg.dcctl = DCCTRL0;
> >  	desc->req.cfg = &desc->rqcfg;
> >  	desc->req.xfer_cb = dma_pl330_rqcb;
> >  	desc->txd.tx_submit = pl330_tx_submit;
> > @@ -2517,7 +2511,7 @@ static int add_desc(struct dma_pl330_dmac *pdmac, gfp_t flg, int count)
> >  	if (!pdmac)
> >  		return 0;
> >  
> > -	desc = kmalloc(count * sizeof(*desc), flg);
> > +	desc = kzalloc(count * sizeof(*desc), flg);
> 
> Maybe kcalloc() ?

Yup, that could work. I'll include that in v2 pending any other comments.

Cheers,

Will
