From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 1 Dec 2016 13:56:24 +0100
Subject: [PATCH] dmaengine: at_xdmac: don't restore unsaved status
In-Reply-To: <20161201104903.30019-1-alexandre.belloni@free-electrons.com>
References: <20161201104903.30019-1-alexandre.belloni@free-electrons.com>
Message-ID: <20161201125624.4sno2gwt6dnwucv2@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 11:49:03AM +0100, Alexandre Belloni wrote:
> save_gs is supposed to save the channel status in order to be restored at
> resume time but it is never updated and is always 0. Anyway, the channel
> status is updated in the per channel loop later in the resume function.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> ---
>  drivers/dma/at_xdmac.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index b7d7f2d443a1..8c1abb794340 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -221,7 +221,6 @@ struct at_xdmac {
>  	int			irq;
>  	struct clk		*clk;
>  	u32			save_gim;
> -	u32			save_gs;
>  	struct dma_pool		*at_xdmac_desc_pool;
>  	struct at_xdmac_chan	chan[0];
>  };
> @@ -1896,7 +1895,6 @@ static int atmel_xdmac_resume(struct device *dev)
>  	}
>  
>  	at_xdmac_write(atxdmac, AT_XDMAC_GIE, atxdmac->save_gim);
> -	at_xdmac_write(atxdmac, AT_XDMAC_GE, atxdmac->save_gs);
>  	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
>  		atchan = to_at_xdmac_chan(chan);
>  		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->save_cc);
> -- 
> 2.10.2
> 
