From: sean.wang@mediatek.com (Sean Wang)
Date: Fri, 20 Jul 2018 01:02:24 +0800
Subject: [SPAM]Re: [PATCH] net: mediatek: use dma_zalloc_coherent
 instead of allocator/memset
In-Reply-To: <20180719141723.GM17271@n2100.armlinux.org.uk>
References: <20180719140955.19444-1-yuehaibing@huawei.com>
 <20180719141723.GM17271@n2100.armlinux.org.uk>
Message-ID: <1532019744.8953.248.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-07-19 at 15:17 +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 19, 2018 at 10:09:55PM +0800, YueHaibing wrote:
> > Use dma_zalloc_coherent instead of dma_alloc_coherent
> > followed by memset 0.
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > index d8ebf0a..fbdb3e3 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > @@ -1221,14 +1221,11 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
> >  	if (!ring->buf)
> >  		goto no_tx_mem;
> >  
> > -	ring->dma = dma_alloc_coherent(eth->dev,
> > -					  MTK_DMA_SIZE * sz,
> > -					  &ring->phys,
> > -					  GFP_ATOMIC | __GFP_ZERO);
> > +	ring->dma = dma_zalloc_coherent(eth->dev, MTK_DMA_SIZE * sz,
> > +					&ring->phys, GFP_ATOMIC | __GFP_ZERO);
> >  	if (!ring->dma)
> >  		goto no_tx_mem;
> >  
> > -	memset(ring->dma, 0, MTK_DMA_SIZE * sz);
> 
> I have to wonder whether this code needs two forms of zeroing... in
> the original code, __GFP_ZERO _and_ a call to memset() just in case
> __GFP_ZERO failed to do its job, and in the replacement code, just
> in case dma_zalloc_coherent() hasn't got the idea...
> 
> I think you can drop the __GFP_ZERO. ;)
> 

Just now I did an experiment on 4.14.56 on armv7. I found that
dma_zalloc_coherent does not guarantee that the buffer we get
is all filled with 0.


I really think it's a little bit weird OR what was I missing something
for enabling dma_zalloc_coherent ? The result seems to tell that we
can't remove freely the memset with 0 at this moment until we get a
cause.


my test code is

         ring->dma = dma_zalloc_coherent(eth->dev,
                                          MTK_DMA_SIZE * sz,
                                          &ring->phys,
                                          GFP_ATOMIC);
        if (!ring->dma)
                goto no_tx_mem;

        print_hex_dump(KERN_INFO, "mtk_tx_alloc:",
                       DUMP_PREFIX_OFFSET, 16, 1,
                       ring->dma, MTK_DMA_SIZE * sz, false);

        memset(ring->dma, 0, MTK_DMA_SIZE * sz);

        print_hex_dump(KERN_INFO, "mtk_tx_alloc2:",
                       DUMP_PREFIX_OFFSET, 16, 1,
                       ring->dma, MTK_DMA_SIZE * sz, false);


and the output 

...

[  259.610413] mtk_tx_alloc:00000f40: 00 00 00 00 50 1f 00 bc 00 00 00 c0 00 00 00 00
[  259.617934] mtk_tx_alloc:00000f50: 00 00 00 00 60 1f 00 bc 00 00 00 c0 00 00 00 00
[  259.625470] mtk_tx_alloc:00000f60: 00 00 00 00 70 1f 00 bc 00 00 00 c0 00 00 00 00
[  259.633005] mtk_tx_alloc:00000f70: 00 00 00 00 80 1f 00 bc 00 00 00 c0 00 00 00 00
[  259.640539] mtk_tx_alloc:00000f80: 00 00 00 00 90 1f 00 bc 00 00 00 c0 00 00 00 00
[  259.648073] mtk_tx_alloc:00000f90: 00 00 00 00 a0 1f 00 bc 00 00 00 c0 00 00 00 00
[  259.655590] mtk_tx_alloc:00000fa0: 00 00 00 00 b0 1f 00 bc 00 00 00 c0 00 00 00 00
[  259.663124] mtk_tx_alloc:00000fb0: 00 00 00 00 c0 1f 00 bc 00 00 00 c0 00 00 00 00
[  259.670660] mtk_tx_alloc:00000fc0: 00 00 00 00 d0 1f 00 bc 00 00 00 c0 00 00 00 00
[  259.678196] mtk_tx_alloc:00000fd0: 00 00 00 00 e0 1f 00 bc 00 00 00 c0 00 00 00 00
[  259.685713] mtk_tx_alloc:00000fe0: 00 00 00 00 f0 1f 00 bc 00 00 00 c0 00 00 00 00
[  259.693247] mtk_tx_alloc:00000ff0: 02 c0 90 ad 00 10 00 bc 00 40 5a c0 00 00 00 02
[  259.700782] mtk_tx_alloc2:00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.708405] mtk_tx_alloc2:00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.716013] mtk_tx_alloc2:00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.723634] mtk_tx_alloc2:00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.731253] mtk_tx_alloc2:00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.738875] mtk_tx_alloc2:00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.746481] mtk_tx_alloc2:00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.754103] mtk_tx_alloc2:00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.761723] mtk_tx_alloc2:00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.769344] mtk_tx_alloc2:00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.776951] mtk_tx_alloc2:000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

....


	Sean
