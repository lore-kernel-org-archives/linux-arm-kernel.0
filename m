From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 12 Feb 2015 16:33:19 +0100
Subject: [PATCH] dmaengine: at_xdmac: fix for chan conf simplification
In-Reply-To: <1423755030-14257-1-git-send-email-ludovic.desroches@atmel.com>
References: <1423755030-14257-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <54DCC7BF.6010001@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/02/2015 16:30, Ludovic Desroches a ?crit :
> When simplificating the channel configuration, the cyclic case has been
> forgotten. It leads to use bad configuration causing many bugs.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Oh, yes indeed, pretty important:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Bye,

> ---
>  drivers/dma/at_xdmac.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 710546d..895b8bd 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -664,7 +664,6 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
>  	struct at_xdmac_desc	*first = NULL, *prev = NULL;
>  	unsigned int		periods = buf_len / period_len;
>  	int			i;
> -	u32			cfg;
>  
>  	dev_dbg(chan2dev(chan), "%s: buf_addr=%pad, buf_len=%zd, period_len=%zd, dir=%s, flags=0x%lx\n",
>  		__func__, &buf_addr, buf_len, period_len,
> @@ -700,17 +699,17 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
>  		if (direction == DMA_DEV_TO_MEM) {
>  			desc->lld.mbr_sa = atchan->per_src_addr;
>  			desc->lld.mbr_da = buf_addr + i * period_len;
> -			cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
> +			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
>  		} else {
>  			desc->lld.mbr_sa = buf_addr + i * period_len;
>  			desc->lld.mbr_da = atchan->per_dst_addr;
> -			cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
> +			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
>  		}
>  		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV1
>  			| AT_XDMAC_MBR_UBC_NDEN
>  			| AT_XDMAC_MBR_UBC_NSEN
>  			| AT_XDMAC_MBR_UBC_NDE
> -			| period_len >> at_xdmac_get_dwidth(cfg);
> +			| period_len >> at_xdmac_get_dwidth(desc->lld.mbr_cfg);
>  
>  		dev_dbg(chan2dev(chan),
>  			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
> 


-- 
Nicolas Ferre
