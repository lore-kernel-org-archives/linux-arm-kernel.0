From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 30 Aug 2018 11:40:42 +0800
Subject: [PATCH 2/5] net: mvneta: fix the wrong function to unmap rx buf
In-Reply-To: <87a7p5jzp3.fsf@bootlin.com>
References: <20180829162456.2bd69796@xhacker.debian>
 <20180829162751.018acbb6@xhacker.debian>
 <87a7p5jzp3.fsf@bootlin.com>
Message-ID: <20180830114042.1f9900d6@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Aug 2018 11:21:12 +0200 Gregory CLEMENT  wrote:

> Hi Jisheng,
>  
>  On mer., ao?t 29 2018, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> 
> > Commit 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")
> > always allocate one page for each rx descriptor, so the rx is mapped
> > with dmap_map_page() now, but the unmap routine isn't updated at the
> > same time.
> >
> > Fix this by using dma_unmap_page() in corresponding places.
> >
> > Fixes: 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > index 0ce94f6587a5..d9206094fce3 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -1890,8 +1890,9 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
> >  		if (!data || !(rx_desc->buf_phys_addr))
> >  			continue;
> >  
> > -		dma_unmap_single(pp->dev->dev.parent, rx_desc->buf_phys_addr,
> > -				 MVNETA_RX_BUF_SIZE(pp->pkt_size), DMA_FROM_DEVICE);
> > +		dma_unmap_page(pp->dev->dev.parent, rx_desc->buf_phys_addr,
> > +			       MVNETA_RX_BUF_SIZE(pp->pkt_size),
> > +			       DMA_FROM_DEVICE);
> >  		__free_page(data);
> >  	}
> >  }  
> This one can be called when the allocation is done in with HWBM in this
> case which use a dma_map_single.

oops, thanks for the catch. will fix it in v2

> 
> Gregory
> 
> 
> 
> > @@ -2008,8 +2009,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
> >  				skb_add_rx_frag(rxq->skb, frag_num, page,
> >  						frag_offset, frag_size,
> >  						PAGE_SIZE);
> > -				dma_unmap_single(dev->dev.parent, phys_addr,
> > -						 PAGE_SIZE, DMA_FROM_DEVICE);
> > +				dma_unmap_page(dev->dev.parent, phys_addr,
> > +					       PAGE_SIZE, DMA_FROM_DEVICE);
> >  				rxq->left_size -= frag_size;
> >  			}
> >  		} else {
> > @@ -2039,9 +2040,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
> >  						frag_offset, frag_size,
> >  						PAGE_SIZE);
> >  
> > -				dma_unmap_single(dev->dev.parent, phys_addr,
> > -						 PAGE_SIZE,
> > -						 DMA_FROM_DEVICE);
> > +				dma_unmap_page(dev->dev.parent, phys_addr,
> > +					       PAGE_SIZE, DMA_FROM_DEVICE);
> >  
> >  				rxq->left_size -= frag_size;
> >  			}
> > -- 
> > 2.18.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel  
> 
