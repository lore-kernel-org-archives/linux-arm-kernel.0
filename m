From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 30 Jun 2015 15:03:07 +0200
Subject: [PATCH] dmaengine: at_xdmac: fix bug about channel configuration
In-Reply-To: <1434550946-27750-1-git-send-email-ludovic.desroches@atmel.com>
References: <1434550946-27750-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20150630130307.GO18384@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod,

If you have no objection about his patch, could you take it?

Thanks

Ludovic

On Wed, Jun 17, 2015 at 04:22:26PM +0200, Ludovic Desroches wrote:
> When using descriptor view 2 or higher, we don't write the configuration
> into AT_XDMAC_CC register because this configuration will be fetch from
> the descriptor. Unfortunately, the PROT bit is not updated with this
> method, we have to do it manually before enabling the channel.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/dma/at_xdmac.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index cf1213d..52ca1cc 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -359,18 +359,19 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
>  	 * descriptor view 2 since some fields of the configuration register
>  	 * depend on transfer size and src/dest addresses.
>  	 */
> -	if (at_xdmac_chan_is_cyclic(atchan)) {
> +	if (at_xdmac_chan_is_cyclic(atchan))
>  		reg = AT_XDMAC_CNDC_NDVIEW_NDV1;
> -		at_xdmac_chan_write(atchan, AT_XDMAC_CC, first->lld.mbr_cfg);
> -	} else if (first->lld.mbr_ubc & AT_XDMAC_MBR_UBC_NDV3) {
> +	else if (first->lld.mbr_ubc & AT_XDMAC_MBR_UBC_NDV3)
>  		reg = AT_XDMAC_CNDC_NDVIEW_NDV3;
> -	} else {
> -		/*
> -		 * No need to write AT_XDMAC_CC reg, it will be done when the
> -		 * descriptor is fecthed.
> -		 */
> +	else
>  		reg = AT_XDMAC_CNDC_NDVIEW_NDV2;
> -	}
> +	/*
> +	 * Even if the register will be updated from the configuration in the
> +	 * descriptor when using view 2 or higher, the PROT bit won't be set
> +	 * properly. This bit can be modified only by using the channel
> +	 * configuration register.
> +	 */
> +	at_xdmac_chan_write(atchan, AT_XDMAC_CC, first->lld.mbr_cfg);
>  
>  	reg |= AT_XDMAC_CNDC_NDDUP
>  	       | AT_XDMAC_CNDC_NDSUP
> -- 
> 2.2.0
> 
