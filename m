From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Mon, 10 Oct 2016 16:42:13 +0530
Subject: [PATCH] tty: serial: fsl_lpuart: Fix Tx DMA edge case
In-Reply-To: <1475791984-17705-1-git-send-email-aaron.brice@datasoft.com>
References: <1475791984-17705-1-git-send-email-aaron.brice@datasoft.com>
Message-ID: <6d198918-c5a8-45e6-a2a8-5af5de61abce@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/16 03:43, Aaron Brice wrote:

> In the case where head == 0 on the circular buffer, there should be one
> DMA buffer, not two.  The second zero-length buffer would break the
> lpuart driver, transfer would never complete.

Tested-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>

>
> Signed-off-by: Aaron Brice <aaron.brice@datasoft.com>
> ---
>   drivers/tty/serial/fsl_lpuart.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index de9d510..76103f2 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -328,7 +328,7 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
>   
>   	sport->dma_tx_bytes = uart_circ_chars_pending(xmit);
>   
> -	if (xmit->tail < xmit->head) {
> +	if (xmit->tail < xmit->head || xmit->head == 0) {
>   		sport->dma_tx_nents = 1;
>   		sg_init_one(sgl, xmit->buf + xmit->tail, sport->dma_tx_bytes);
>   	} else {
> @@ -359,7 +359,6 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
>   	sport->dma_tx_in_progress = true;
>   	sport->dma_tx_cookie = dmaengine_submit(sport->dma_tx_desc);
>   	dma_async_issue_pending(sport->dma_tx_chan);
> -
>   }
>   
>   static void lpuart_dma_tx_complete(void *arg)
