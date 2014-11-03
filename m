From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 3 Nov 2014 12:12:44 +0100
Subject: [PATCH v4 02/58] serial: at91: Use dmaengine_slave_config API
In-Reply-To: <1414531573-18807-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1414531573-18807-1-git-send-email-maxime.ripard@free-electrons.com>
 <1414531573-18807-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5457632C.5020002@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/10/2014 22:25, Maxime Ripard :
> We are removing the dmaengine_device_control API, that shouldn't even have been
> exposed in the first place. Change the callers to use the proper API.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, Maxime. Do I have to carry the patch myself or is it part of a
series?

Bye,

> ---
>  drivers/tty/serial/atmel_serial.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index edde3eca055d..10e6b382d68f 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -862,9 +862,8 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
>  	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>  	config.dst_addr = port->mapbase + ATMEL_US_THR;
>  
> -	ret = dmaengine_device_control(atmel_port->chan_tx,
> -					DMA_SLAVE_CONFIG,
> -					(unsigned long)&config);
> +	ret = dmaengine_slave_config(atmel_port->chan_tx,
> +				     &config);
>  	if (ret) {
>  		dev_err(port->dev, "DMA tx slave configuration failed\n");
>  		goto chan_err;
> @@ -1026,9 +1025,8 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>  	config.src_addr = port->mapbase + ATMEL_US_RHR;
>  
> -	ret = dmaengine_device_control(atmel_port->chan_rx,
> -					DMA_SLAVE_CONFIG,
> -					(unsigned long)&config);
> +	ret = dmaengine_slave_config(atmel_port->chan_rx,
> +				     &config);
>  	if (ret) {
>  		dev_err(port->dev, "DMA rx slave configuration failed\n");
>  		goto chan_err;
> 


-- 
Nicolas Ferre
