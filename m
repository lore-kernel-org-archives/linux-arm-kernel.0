From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 23 Nov 2015 15:42:21 +0100
Subject: [PATCH 2/2] dmaengine: at_xdmac: fix spurious flag status for
 mem2mem transfers
In-Reply-To: <1448284184-15171-2-git-send-email-ludovic.desroches@atmel.com>
References: <1448284184-15171-1-git-send-email-ludovic.desroches@atmel.com>
 <1448284184-15171-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <565325CD.30608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 23/11/2015 14:09, Ludovic Desroches a ?crit :
> When setting the channel configuration register, the perid field is not
> set to 0 since it is useless for mem2mem transfers. Unfortunately, a
> device has 0 as perid. It could cause spurious flags status because
> the controller could mix some events from the two channels.
> For that reason, use the highest perid value for mem2mem transfers since it
> doesn't match the perid of other devices.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Indeed: thanks Ludovic:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/dma/at_xdmac.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index d09277f..b90e62f 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -863,8 +863,12 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
>  	 * access. Hopefully we can access DDR through both ports (at least on
>  	 * SAMA5D4x), so we can use the same interface for source and dest,
>  	 * that solves the fact we don't know the direction.
> +	 * ERRATA: Even if useless for memory transfers, the PERID has to not
> +	 * match the one of another channel. If not, it could lead to spurious
> +	 * flag status.
>  	 */
> -	u32			chan_cc = AT_XDMAC_CC_DIF(0)
> +	u32			chan_cc = AT_XDMAC_CC_PERID(0x3f)
> +					| AT_XDMAC_CC_DIF(0)
>  					| AT_XDMAC_CC_SIF(0)
>  					| AT_XDMAC_CC_MBSIZE_SIXTEEN
>  					| AT_XDMAC_CC_TYPE_MEM_TRAN;
> @@ -1039,8 +1043,12 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  	 * access DDR through both ports (at least on SAMA5D4x), so we can use
>  	 * the same interface for source and dest, that solves the fact we
>  	 * don't know the direction.
> +	 * ERRATA: Even if useless for memory transfers, the PERID has to not
> +	 * match the one of another channel. If not, it could lead to spurious
> +	 * flag status.
>  	 */
> -	u32			chan_cc = AT_XDMAC_CC_DAM_INCREMENTED_AM
> +	u32			chan_cc = AT_XDMAC_CC_PERID(0x3f)
> +					| AT_XDMAC_CC_DAM_INCREMENTED_AM
>  					| AT_XDMAC_CC_SAM_INCREMENTED_AM
>  					| AT_XDMAC_CC_DIF(0)
>  					| AT_XDMAC_CC_SIF(0)
> @@ -1140,8 +1148,12 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
>  	 * access. Hopefully we can access DDR through both ports (at least on
>  	 * SAMA5D4x), so we can use the same interface for source and dest,
>  	 * that solves the fact we don't know the direction.
> +	 * ERRATA: Even if useless for memory transfers, the PERID has to not
> +	 * match the one of another channel. If not, it could lead to spurious
> +	 * flag status.
>  	 */
> -	u32			chan_cc = AT_XDMAC_CC_DAM_UBS_AM
> +	u32			chan_cc = AT_XDMAC_CC_PERID(0x3f)
> +					| AT_XDMAC_CC_DAM_UBS_AM
>  					| AT_XDMAC_CC_SAM_INCREMENTED_AM
>  					| AT_XDMAC_CC_DIF(0)
>  					| AT_XDMAC_CC_SIF(0)
> 


-- 
Nicolas Ferre
