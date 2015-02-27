From: Leilei.Zhao@atmel.com (Zhao, Leilei)
Date: Fri, 27 Feb 2015 07:38:11 +0000
Subject: [PATCH 1/5] tty/serial: at91: correct check of buf used in DMA
In-Reply-To: <54EEE792.9060706@suse.cz>
References: <1424933725-16242-1-git-send-email-leilei.zhao@atmel.com>
 <1424933725-16242-2-git-send-email-leilei.zhao@atmel.com>
 <54EEE792.9060706@suse.cz>
Message-ID: <C2F288CD23A3A94D985CB167373816C92AC7E162@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks

Best Regards
Zhao Leilei

-----Original Message-----
From: Jiri Slaby [mailto:jirislaby at gmail.com] On Behalf Of Jiri Slaby
Sent: Thursday, February 26, 2015 17:30
To: Zhao, Leilei; Ferre, Nicolas; gregkh at linuxfoundation.org; linux-serial at vger.kernel.org
Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 1/5] tty/serial: at91: correct check of buf used in DMA

On 02/26/2015, 07:55 AM, Leilei Zhao wrote:
> We only use buf of ring In DMA rx function while using buf of xmit in 
> DMA tx function. So here we need definitively to check the buf of ring 
> which is corresponding to DMA rx function.
> 
> Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/tty/serial/atmel_serial.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c 
> b/drivers/tty/serial/atmel_serial.c
> index 846552b..460903c 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1027,7 +1027,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	spin_lock_init(&atmel_port->lock_rx);
>  	sg_init_table(&atmel_port->sg_rx, 1);
>  	/* UART circular rx buffer is an aligned page. */
> -	BUG_ON((int)port->state->xmit.buf & ~PAGE_MASK);
> +	BUG_ON((int)ring->buf & ~PAGE_MASK);

Please use PAGE_ALIGNED. This will also make the bad (int) cast to dismiss.

thanks,
--
js
suse labs
