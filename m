From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 1 Dec 2016 12:22:42 +0100
Subject: [PATCH] dmaengine: at_xdmac: don't restore unsaved status
In-Reply-To: <20161201104903.30019-1-alexandre.belloni@free-electrons.com>
References: <20161201104903.30019-1-alexandre.belloni@free-electrons.com>
Message-ID: <efb03206-0765-372e-2a7d-7c857e3c5bfe@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/12/2016 ? 11:49, Alexandre Belloni a ?crit :
> save_gs is supposed to save the channel status in order to be restored at
> resume time but it is never updated and is always 0. Anyway, the channel
> status is updated in the per channel loop later in the resume function.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Indeed, seems superfluous...
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

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
> 


-- 
Nicolas Ferre
