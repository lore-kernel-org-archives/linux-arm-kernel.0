From: sean.wang@mediatek.com (Sean Wang)
Date: Fri, 20 Jul 2018 21:48:24 +0800
Subject: [SPAM]Re: [PATCH] net: mediatek: use dma_zalloc_coherent
 instead of allocator/memset
In-Reply-To: <20180720081334.GO17271@n2100.armlinux.org.uk>
References: <20180719140955.19444-1-yuehaibing@huawei.com>
 <20180719141723.GM17271@n2100.armlinux.org.uk>
 <1532019744.8953.248.camel@mtkswgap22>
 <9a4cdfc6-7487-5908-b584-f3bf6158c4d4@huawei.com>
 <20180720081334.GO17271@n2100.armlinux.org.uk>
Message-ID: <1532094504.8953.262.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-07-20 at 09:13 +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 20, 2018 at 02:30:53PM +0800, YueHaibing wrote:
> > On 2018/7/20 1:02, Sean Wang wrote:
> > > On Thu, 2018-07-19 at 15:17 +0100, Russell King - ARM Linux wrote:
> > >> On Thu, Jul 19, 2018 at 10:09:55PM +0800, YueHaibing wrote:
> > >>> Use dma_zalloc_coherent instead of dma_alloc_coherent
> > >>> followed by memset 0.
> > >>>
> > >>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > >>> ---
> > >>>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 ++-----
> > >>>  1 file changed, 2 insertions(+), 5 deletions(-)
> > >>>
> > >>> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > >>> index d8ebf0a..fbdb3e3 100644
> > >>> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > >>> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > >>> @@ -1221,14 +1221,11 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
> > >>>  	if (!ring->buf)
> > >>>  		goto no_tx_mem;
> > >>>  
> > >>> -	ring->dma = dma_alloc_coherent(eth->dev,
> > >>> -					  MTK_DMA_SIZE * sz,
> > >>> -					  &ring->phys,
> > >>> -					  GFP_ATOMIC | __GFP_ZERO);
> > >>> +	ring->dma = dma_zalloc_coherent(eth->dev, MTK_DMA_SIZE * sz,
> > >>> +					&ring->phys, GFP_ATOMIC | __GFP_ZERO);
> > >>>  	if (!ring->dma)
> > >>>  		goto no_tx_mem;
> > >>>  
> > >>> -	memset(ring->dma, 0, MTK_DMA_SIZE * sz);
> > >>
> > >> I have to wonder whether this code needs two forms of zeroing... in
> > >> the original code, __GFP_ZERO _and_ a call to memset() just in case
> > >> __GFP_ZERO failed to do its job, and in the replacement code, just
> > >> in case dma_zalloc_coherent() hasn't got the idea...
> > >>
> > >> I think you can drop the __GFP_ZERO. ;)
> > >>
> > > 
> > > Just now I did an experiment on 4.14.56 on armv7. I found that
> > > dma_zalloc_coherent does not guarantee that the buffer we get
> > > is all filled with 0.
> > > 
> > > 
> > > I really think it's a little bit weird OR what was I missing something
> > > for enabling dma_zalloc_coherent ? The result seems to tell that we
> > > can't remove freely the memset with 0 at this moment until we get a
> > > cause.
> > > 
> > 
> > That means dma_zalloc_coherent doesn't work as expect on armv7?
> 
> Can someone work out which underlying allocator is being used - the
> possibilities are:
> 
> - dma_alloc_from_dev_coherent
> - cma
> - simple
> - remap
> - pool
> 
> Looking at the code, I'd guess it's the pool allocator, as I don't see
> anything which zeros memory there, and it doesn't honor the __GFP_ZERO
> flag.  This is definitely an allocator bug.
> 

Yes, your guess is right. the allocator is from pool. I show the full
stack as below when calling dma_zalloc_coherent

[   54.358310] [<c0113ca8>] (unwind_backtrace) from [<c010e558>] (show_stack+0x20/0x24)
[   54.366012] [<c010e558>] (show_stack) from [<c0927f58>] (dump_stack+0x98/0xac)
[   54.373196] [<c0927f58>] (dump_stack) from [<c011c1f8>] (pool_allocator_alloc+0x20/0x30)
[   54.381238] [<c011c1f8>] (pool_allocator_alloc) from [<c011a238>] (__dma_alloc+0x1b8/0x344)
[   54.389538] [<c011a238>] (__dma_alloc) from [<c011a45c>] (arm_dma_alloc+0x50/0x58)
[   54.397063] [<c011a45c>] (arm_dma_alloc) from [<c05dc208>] (mtk_open+0xf4/0x710)
[   54.404416] [<c05dc208>] (mtk_open) from [<c076d110>] (__dev_open+0xdc/0x160)
[   54.411507] [<c076d110>] (__dev_open) from [<c076d530>] (__dev_change_flags+0x178/0x1c4)
[   54.419547] [<c076d530>] (__dev_change_flags) from [<c076d5a4>] (dev_change_flags+0x28/0x58)
[   54.427934] [<c076d5a4>] (dev_change_flags) from [<c07ea7c0>] (devinet_ioctl+0x630/0x720)
[   54.436062] [<c07ea7c0>] (devinet_ioctl) from [<c07ed070>] (inet_ioctl+0x210/0x3a8)
[   54.443674] [<c07ed070>] (inet_ioctl) from [<c0747094>] (sock_ioctl+0x234/0x4dc)
[   54.451029] [<c0747094>] (sock_ioctl) from [<c028206c>] (do_vfs_ioctl+0xc0/0x914)
[   54.458468] [<c028206c>] (do_vfs_ioctl) from [<c0282904>] (SyS_ioctl+0x44/0x6c)
[   54.465733] [<c0282904>] (SyS_ioctl) from [<c0101000>] (ret_fast_syscall+0x0/0x54)
