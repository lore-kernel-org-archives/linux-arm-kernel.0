From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 30 Mar 2011 11:03:02 +0200
Subject: [PATCH V3 2/6] dmaengine: change the flags of request_irq()
In-Reply-To: <1301474413-28821-3-git-send-email-b32955@freescale.com>
References: <1301474413-28821-1-git-send-email-b32955@freescale.com>
	<1301474413-28821-3-git-send-email-b32955@freescale.com>
Message-ID: <19858.61894.956256.280158@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> The GPMI may have many DMA channels, such as the imx23 has
> four DMA channels. All these DMA channels share the same interrupt.
> So change the flags from '0' to IRQF_SHARED, else there will be
> an EBUSY error returns.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/dma/mxs-dma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index 88aad4f..0ee5b52 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -328,7 +328,7 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
>  	memset(mxs_chan->ccw, 0, PAGE_SIZE);
>  
>  	ret = request_irq(mxs_chan->chan_irq, mxs_dma_int_handler,
> -				0, "mxs-dma", mxs_dma);
> +				IRQF_SHARED, "mxs-dma", mxs_dma);
>  	if (ret)
>  		goto err_irq;
>  
IMO this is wrong. The interrupt is requested with all the same
parameters for each DMA channel. So, actually it is not a shared IRQ,
but an IRQ with the same handler registered multiple times, which is
just nonsense.

Instead of declaring it as shared, it would be more sensible to only
register it for the first channel. Otherwise the handler will be
called multiple times in case of an interrupt with only the first
invocation doing all the work and the subsequent invocations just
returning without doing anything.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
