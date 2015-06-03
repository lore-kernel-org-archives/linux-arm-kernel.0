From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 3 Jun 2015 10:28:10 +0200
Subject: [PATCH v2] dmaengine: at_xdmac: rework slave configuration part
In-Reply-To: <20150602132208.GX3140@localhost>
References: <1433173324-13182-1-git-send-email-ludovic.desroches@atmel.com>
 <20150602132208.GX3140@localhost>
Message-ID: <20150603082810.GA11060@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 06:52:08PM +0530, Vinod Koul wrote:
> On Mon, Jun 01, 2015 at 05:40:48PM +0200, Ludovic Desroches wrote:
> > @@ -604,16 +636,18 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> >  			return NULL;
> >  		}
> >  
> > +		if (at_xdmac_compute_chan_conf(chan, direction))
> > +			return NULL;
> > +
> You forgot to release the lock. Also in prev call, you are getting the desc,
> that needs to be put back or moved before getting descriptor
> 

Right, thanks.

> >  		/* Linked list descriptor setup. */
> >  		if (direction == DMA_DEV_TO_MEM) {
> > -			desc->lld.mbr_sa = atchan->per_src_addr;
> > +			desc->lld.mbr_sa = atchan->sconfig.src_addr;
> >  			desc->lld.mbr_da = mem;
> > -			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
> >  		} else {
> >  			desc->lld.mbr_sa = mem;
> > -			desc->lld.mbr_da = atchan->per_dst_addr;
> > -			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
> > +			desc->lld.mbr_da = atchan->sconfig.dst_addr;
> >  		}
> > +		desc->lld.mbr_cfg = atchan->cfg;
> >  		dwidth = at_xdmac_get_dwidth(desc->lld.mbr_cfg);
> >  		fixed_dwidth = IS_ALIGNED(len, 1 << dwidth)
> >  			       ? at_xdmac_get_dwidth(desc->lld.mbr_cfg)
> > @@ -696,15 +730,17 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> >  			"%s: desc=0x%p, tx_dma_desc.phys=%pad\n",
> >  			__func__, desc, &desc->tx_dma_desc.phys);
> >  
> > +		if (at_xdmac_compute_chan_conf(chan, direction))
> > +			return NULL;
> same here as well
> 

In this case, lock is already released when doing this call but I
have to put back the descriptor.

Will send a v3.


Ludovic
