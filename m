From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 30 Aug 2018 11:53:29 +0800
Subject: [PATCH 0/5] net: mvneta: some bug fix and trivial improvement
In-Reply-To: <20180829165131.52798cd6@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
 <20180829162932.6015e89d@xhacker.debian>
 <20180829130836.GD1955@lunn.ch>
 <20180829165131.52798cd6@xhacker.debian>
Message-ID: <20180830115329.280943ef@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Aug 2018 16:51:31 +0800 Jisheng Zhang wrote:

> On Wed, 29 Aug 2018 16:40:24 +0800 Jisheng Zhang wrote:
> 
> > On Wed, 29 Aug 2018 16:25:57 +0800
> > Jisheng Zhang wrote:
> >   
> > > patch1 fixes rx_offset_correction set and usage. Because the
> > > rx_offset_correction is RX packet offset correction for platforms,
> > > it's not related with SW BM, instead, it's only related with the
> > > platform's NET_SKB_PAD.
> > > 
> > > patch2 fixes the wrong function to unmap rx buf    
> > 
> > I have question about the following two commits:
> > 
> > 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor"), it cause
> > a waste, for normal 1500 MTU, before this patch we allocate 1920Bytes for rx
> > after this patch, we always allocate PAGE_SIZE bytes, if PAGE_SIZE=4096, we
> > waste 53% memory for each rx buf. I'm not sure whether the performance
> > improvement deserve the pay.
> > 
> > 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
> > mentions that "With system having a small memory (around 256MB), the state
> > "cannot allocate memory to refill with new buffer" is reach pretty quickly"
> > is it due to the memory waste as said above? Anyway, by this commit, we
> > want to improve the situation on a small memory system, so should we firstly
> > revert commit 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")?

Any comments? 

Now I believe the situation is due to the memory waste introduced by 7e47fd84b56b
With linux 4.18, I tried to limit berlin platforms available memory to 256MB,
I didn't see "cannot allocate memory to refill with new buffer".

Thanks

> >   
> 
> If maintainers decide to revert the two commits: 7e47fd84b56b and 562e2f467e71
> then, patch1,2,3 are useless, we can drop them. Only patch4 and patch5 are
> still useful.
> 
> Thanks
> 
> > Any comments are welcome!
> > 
> > Thanks
> > 
> >   
> > > 
> > > patch3 removes the NETIF_F_GRO check ourself, because the net subsystem
> > > will handle it for us.
> > > 
> > > patch4 enables NETIF_F_RXCSUM by default, since the driver and HW
> > > supports the feature.
> > > 
> > > patch5 is a trivial optimization, to reduce smp_processor_id() calling
> > > in mvneta_tx_done_gbe.
> > > 
> > > Jisheng Zhang (5):
> > >   net: mvneta: fix rx_offset_correction set and usage
> > >   net: mvneta: fix the wrong function to unmap rx buf
> > >   net: mvneta: Don't check NETIF_F_GRO ourself
> > >   net: mvneta: enable NETIF_F_RXCSUM by default
> > >   net: mvneta: reduce smp_processor_id() calling in mvneta_tx_done_gbe
> > > 
> > >  drivers/net/ethernet/marvell/mvneta.c | 49 ++++++++++++---------------
> > >  1 file changed, 22 insertions(+), 27 deletions(-)
> > >     
> >   
> 
