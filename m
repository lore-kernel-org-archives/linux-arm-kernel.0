From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 Nov 2012 12:34:19 +0100
Subject: [PATCH v4] Network driver for the Armada 370 and Armada XP ARM
 Marvell SoCs
In-Reply-To: <20121103115321.GA4539@electric-eye.fr.zoreil.com>
References: <1351245804-31478-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121030105154.5b7c8e48@skate> <20121102232137.3c9da5e4@skate>
 <20121103115321.GA4539@electric-eye.fr.zoreil.com>
Message-ID: <20121113123419.4516b4b8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fran?ois,

Thanks for your detailed review. I have a few comments/questions below
on specific topics.

On Sat, 3 Nov 2012 12:53:21 +0100, Francois Romieu wrote:
> > +	if (rxq->descs == NULL) {
> > +		netdev_err(pp->dev,
> > +			   "rxQ=%d: Can't allocate %d bytes for %d RX descr\n",
> > +			   rxq->id, rxq->size * MVNETA_DESC_ALIGNED_SIZE,
> > +			   rxq->size);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	BUG_ON(rxq->descs !=
> > +	       PTR_ALIGN(rxq->descs, MVNETA_CPU_D_CACHE_LINE_SIZE));
> 
> There is no reason to crash.

Well, there is a reason: the hardware will not work properly if
rxq->descs is not aligned on a MVNETA_CPU_D_CACHE_LINE_SIZE boundary.
So one solution is to over-allocated to guarantee the alignment, but
since practically speaking MVNETA_CPU_D_CACHE_LINE_SIZE=32 and
dma_alloc_coherent() returns things that seem at least 32 bytes
aligned, it sounded overkill to include more code to fix a problem that
doesn't exist. This BUG_ON() is here solely for the purpose of noisily
letting the user know if this implicit assumption on the alignment of
dma_alloc_coherent() allocated buffer changes in the future. I can turn
this into an error if you prefer:

	if (rxq->descs != PTR_ALIGN(rxq->descs, MVNETA_CPU_D_CACHE_LINE_SIZE)) {
		netdev_err(pp->dev, "improper buffer alignement assumption, driver needs fixing\n");
		dma_free_coherent(...);
		return -EINVAL;
	}

> (...]
> > +static int mvneta_txq_init(struct mvneta_port *pp,
> > +			   struct mvneta_tx_queue *txq)
> > +{
> > +	txq->size = pp->tx_ring_size;
> > +
> > +	/* Allocate memory for TX descriptors */
> > +	txq->descs = dma_alloc_coherent(pp->dev->dev.parent,
> > +					txq->size * MVNETA_DESC_ALIGNED_SIZE,
> > +					&txq->descs_phys,
> > +					DMA_BIDIRECTIONAL);
> 
> 					&txq->descs_phys, DMA_BIDIRECTIONAL);

Aaah, thanks for pointing this one! It should have been GFP_KERNEL, not
DMA_BIDIRECTIONAL here.

> > +	if (txq->descs == NULL) {
> > +		netdev_err(pp->dev,
> > +			   "txQ=%d: Can't allocate %d bytes for %d TX descr\n",
> > +			   txq->id, txq->size * MVNETA_DESC_ALIGNED_SIZE,
> > +			   txq->size);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Make sure descriptor address is cache line size aligned  */
> > +	BUG_ON(txq->descs !=
> > +	       PTR_ALIGN(txq->descs, MVNETA_CPU_D_CACHE_LINE_SIZE));
> 
> There is no reason to crash.

Same as above :-)

> [...]
> > +static int mvneta_setup_rxqs(struct mvneta_port *pp)
> > +{
> > +	int queue;
> > +
> > +	for (queue = 0; queue < rxq_number; queue++) {
> > +		int err = mvneta_rxq_init(pp, &pp->rxqs[queue]);
> > +		if (err) {
> > +			netdev_err(pp->dev,
> > +				   "%s: can't create RxQ rxq=%d\n",
> 
> 			netdev_err(pp->dev, "%s: can't create RxQ rxq=%d\n",
> 
> > +				   __func__, queue);
> > +			mvneta_cleanup_rxqs(pp);
> > +			return -ENODEV;
> 
> mvneta_rxq_init should return a proper error code and it should be
> propagated (option: break instead of return and mvneta_setup_rxqs scoped
> err variable)

Besides turning the "return -ENODEV;" into "return err;", I don't see
what is the other problem here? mvneta_rxq_init() properly returns
-ENOMEM where there is a memory allocation failure, and
mvneta_cleanup_rxqs() properly cleans up *all* initialized rxqs. Is
there something I'm missing?

Thanks again for your review!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
