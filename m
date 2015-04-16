From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 16 Apr 2015 17:07:56 +0200
Subject: [PATCH] tty/serial: at91: maxburst was missing for dma transfers
In-Reply-To: <1429196292-8134-1-git-send-email-ludovic.desroches@atmel.com>
References: <1429196292-8134-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <552FD04C.2030507@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 16/04/2015 16:58, Ludovic Desroches a ?crit :
> Maxburst was not set when doing the dma slave configuration. This value
> is checked by the recently introduced xdmac. It causes an error when
> doing the slave configuration and so prevents from using dma.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: <stable@vger.kernel.org> # 3.12 and later

Indeed, thanks!
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/tty/serial/atmel_serial.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 4e959c4..6afce7e 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -880,6 +880,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
>  	config.direction = DMA_MEM_TO_DEV;
>  	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>  	config.dst_addr = port->mapbase + ATMEL_US_THR;
> +	config.dst_maxburst = 1;
>  
>  	ret = dmaengine_slave_config(atmel_port->chan_tx,
>  				     &config);
> @@ -1059,6 +1060,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	config.direction = DMA_DEV_TO_MEM;
>  	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>  	config.src_addr = port->mapbase + ATMEL_US_RHR;
> +	config.src_maxburst = 1;
>  
>  	ret = dmaengine_slave_config(atmel_port->chan_rx,
>  				     &config);
> 


-- 
Nicolas Ferre
