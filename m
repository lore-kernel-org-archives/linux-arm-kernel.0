From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 4 Jun 2015 21:22:01 +0530
Subject: [PATCH 1/2] dmaengine: at_xdmac: lock fixes
In-Reply-To: <20150604150946.GA17733@odux.rfo.atmel.com>
References: <1433343154-5613-1-git-send-email-ludovic.desroches@atmel.com>
 <20150604141938.GO3140@localhost>
 <20150604150946.GA17733@odux.rfo.atmel.com>
Message-ID: <20150604155201.GP3140@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 05:09:46PM +0200, Ludovic Desroches wrote:
> > > @@ -591,11 +592,13 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> > >  		       unsigned int sg_len, enum dma_transfer_direction direction,
> > >  		       unsigned long flags, void *context)
> > >  {
> > > -	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
> > > -	struct at_xdmac_desc	*first = NULL, *prev = NULL;
> > > -	struct scatterlist	*sg;
> > > -	int			i;
> > > -	unsigned int		xfer_size = 0;
> > > +	struct at_xdmac_chan		*atchan = to_at_xdmac_chan(chan);
> > > +	struct at_xdmac_desc		*first = NULL, *prev = NULL;
> > > +	struct scatterlist		*sg;
> > > +	int				i;
> > > +	unsigned int			xfer_size = 0;
> > > +	unsigned long			irqflags;
> > > +	struct dma_async_tx_descriptor	*ret = NULL;
> > This doesnt comply with stable rules, and you should not keep this in fixes
> > either :(
> > 
> >   - It cannot contain any "trivial" fixes in it (spelling changes,
> >     whitespace cleanups, etc).
> 
> Ok I understand, so what is the way to manage this case? I did
> "whitespace cleanup" because of
> +   struct dma_async_tx_descriptor  *ret = NULL;
> which breaks previous indentation, so in my mind it was not cleanup.
> 
> Do I need to send you a patch to correct identation due to this fix or to send
> a specific patch for stable without identation change?
I think only adding the last line should do, in whatever indentation you
prefer

Later on if you want to align them to whatever alignment you prefer send a
follow on patch

Also on 2nd patch, it looks good, but was wondering if you could split it
up. This will help folks backporting the changes to stable as well

Thanks
-- 
~Vinod
