From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jul 2018 15:17:23 +0100
Subject: [PATCH] net: mediatek: use dma_zalloc_coherent instead of
 allocator/memset
In-Reply-To: <20180719140955.19444-1-yuehaibing@huawei.com>
References: <20180719140955.19444-1-yuehaibing@huawei.com>
Message-ID: <20180719141723.GM17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 10:09:55PM +0800, YueHaibing wrote:
> Use dma_zalloc_coherent instead of dma_alloc_coherent
> followed by memset 0.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index d8ebf0a..fbdb3e3 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -1221,14 +1221,11 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
>  	if (!ring->buf)
>  		goto no_tx_mem;
>  
> -	ring->dma = dma_alloc_coherent(eth->dev,
> -					  MTK_DMA_SIZE * sz,
> -					  &ring->phys,
> -					  GFP_ATOMIC | __GFP_ZERO);
> +	ring->dma = dma_zalloc_coherent(eth->dev, MTK_DMA_SIZE * sz,
> +					&ring->phys, GFP_ATOMIC | __GFP_ZERO);
>  	if (!ring->dma)
>  		goto no_tx_mem;
>  
> -	memset(ring->dma, 0, MTK_DMA_SIZE * sz);

I have to wonder whether this code needs two forms of zeroing... in
the original code, __GFP_ZERO _and_ a call to memset() just in case
__GFP_ZERO failed to do its job, and in the replacement code, just
in case dma_zalloc_coherent() hasn't got the idea...

I think you can drop the __GFP_ZERO. ;)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
