From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 25 Jan 2017 11:02:15 +0000
Subject: [STLinux Kernel] [PATCH 1/8] serial: st-asc: Ignore the parity
 error bit if 8-bit mode is enabled
In-Reply-To: <20170124134310.27512-2-lee.jones@linaro.org>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170124134310.27512-2-lee.jones@linaro.org>
Message-ID: <20170125110215.GC5680@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jan 2017, Lee Jones wrote:

> The datasheet states:
> 
> "If the MODE field selects an 8-bit frame then this [parity error] bit
>  is undefined. Software should ignore this bit when reading 8-bit frames."
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Peter Griffin <peter.griffin@linaro.org>

> ---
>  drivers/tty/serial/st-asc.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index 379e5bd..69e6232 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -287,9 +287,19 @@ static void asc_transmit_chars(struct uart_port *port)
>  static void asc_receive_chars(struct uart_port *port)
>  {
>  	struct tty_port *tport = &port->state->port;
> -	unsigned long status;
> +	unsigned long status, mode;
>  	unsigned long c = 0;
>  	char flag;
> +	bool ignore_pe = false;
> +
> +	/*
> +	 * Datasheet states: If the MODE field selects an 8-bit frame then
> +	 * this [parity error] bit is undefined. Software should ignore this
> +	 * bit when reading 8-bit frames.
> +	 */
> +	mode = asc_in(port, ASC_CTL) & ASC_CTL_MODE_MSK;
> +	if (mode == ASC_CTL_MODE_8BIT || mode == ASC_CTL_MODE_8BIT_PAR)
> +		ignore_pe = true;
>  
>  	if (port->irq_wake)
>  		pm_wakeup_event(tport->tty->dev, 0);
> @@ -299,8 +309,8 @@ static void asc_receive_chars(struct uart_port *port)
>  		flag = TTY_NORMAL;
>  		port->icount.rx++;
>  
> -		if ((c & (ASC_RXBUF_FE | ASC_RXBUF_PE)) ||
> -			status & ASC_STA_OE) {
> +		if (status & ASC_STA_OE || c & ASC_RXBUF_FE ||
> +		    (c & ASC_RXBUF_PE && !ignore_pe)) {
>  
>  			if (c & ASC_RXBUF_FE) {
>  				if (c == (ASC_RXBUF_FE | ASC_RXBUF_DUMMY_RX)) {
