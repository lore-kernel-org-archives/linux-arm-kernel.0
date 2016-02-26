From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 26 Feb 2016 23:22:03 +0100
Subject: [PATCH v2] dmaengine: pxa_dma: fix cyclic transfers
In-Reply-To: <1455659642-7746-1-git-send-email-robert.jarzmik@free.fr> (Robert
 Jarzmik's message of "Tue, 16 Feb 2016 22:54:02 +0100")
References: <1455659642-7746-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87a8mnun78.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> While testing audio with pxa2xx-ac97, underrun were happening while the
> user application was correctly feeding the music. Debug proved that the
> cyclic transfer is not cyclic, ie. the last descriptor did not loop on
> the first.
>
> Another issue is that the descriptor length was always set to 8192,
> because of an trivial operator issue.
>
> This was tested on a pxa27x platform.
>
> Fixes: a57e16cf0333 ("dmaengine: pxa: add pxa dmaengine driver")
> Reported-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: add the mask fix suggested by Vasily
Hi Vinod,

Could you consider this patch, it's a fix and I'd like to have it reviewed.

Cheers.

--
Robert

[1] The patch on cyclic transfers
> ---
>  drivers/dma/pxa_dma.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index 8ab4a53e5660..77c1c44009d8 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -586,6 +586,8 @@ static void set_updater_desc(struct pxad_desc_sw *sw_desc,
>  		(PXA_DCMD_LENGTH & sizeof(u32));
>  	if (flags & DMA_PREP_INTERRUPT)
>  		updater->dcmd |= PXA_DCMD_ENDIRQEN;
> +	if (sw_desc->cyclic)
> +		sw_desc->hw_desc[sw_desc->nb_desc - 2]->ddadr = sw_desc->first;
>  }
>  
>  static bool is_desc_completed(struct virt_dma_desc *vd)
> @@ -676,6 +678,10 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
>  		dev_dbg(&chan->vc.chan.dev->device,
>  			"%s(): checking txd %p[%x]: completed=%d\n",
>  			__func__, vd, vd->tx.cookie, is_desc_completed(vd));
> +		if (to_pxad_sw_desc(vd)->cyclic) {
> +			vchan_cyclic_callback(vd);
> +			break;
> +		}
>  		if (is_desc_completed(vd)) {
>  			list_del(&vd->node);
>  			vchan_cookie_complete(vd);
> @@ -1084,7 +1090,7 @@ pxad_prep_dma_cyclic(struct dma_chan *dchan,
>  		return NULL;
>  
>  	pxad_get_config(chan, dir, &dcmd, &dsadr, &dtadr);
> -	dcmd |= PXA_DCMD_ENDIRQEN | (PXA_DCMD_LENGTH | period_len);
> +	dcmd |= PXA_DCMD_ENDIRQEN | (PXA_DCMD_LENGTH & period_len);
>  	dev_dbg(&chan->vc.chan.dev->device,
>  		"%s(): buf_addr=0x%lx len=%zu period=%zu dir=%d flags=%lx\n",
>  		__func__, (unsigned long)buf_addr, len, period_len, dir, flags);

-- 
Robert
