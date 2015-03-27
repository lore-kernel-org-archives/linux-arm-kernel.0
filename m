From: moorray3@wp.pl (Jakub =?UTF-8?B?S2ljacWEc2tp?=)
Date: Fri, 27 Mar 2015 17:40:55 +0100
Subject: [PATCH v4 2/2] serial/amba-pl011: Refactor and simplify TX FIFO
 handling
In-Reply-To: <1427468371-11915-3-git-send-email-Dave.Martin@arm.com>
References: <1427468371-11915-1-git-send-email-Dave.Martin@arm.com>
 <1427468371-11915-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150327174055.1a2dc194@north>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Mar 2015 14:59:31 +0000, Dave Martin wrote:
> Commit 734745c serial/amba-pl011: Activate TX IRQ passively
> adds some unnecessary complexity and overhead in the form of
> a softirq mechanism for transmitting in the absence of interrupts.
> 
> After some discussion [1], this turns out to be unnecessary.
> 
> This patch simplifies the code flow to reduce the reliance on
> subtle behaviour and avoid fragility under future maintenance.
> 
> To this end, the TX softirq mechanism is removed and instead
> pl011_start_tx() will now simply stuff the FIFO until full
> (guaranteeing future TX IRQs), or until there are no more chars
> to write (in which case we don't care whether an IRQ happens).
> 
> [1] Thanks to Jakub Kici?ski for his input and similar patch.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  drivers/tty/serial/amba-pl011.c |  119 +++++++++------------------------------
>  1 file changed, 26 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 6f5a072..f5bd842 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
<snip>
> @@ -1247,87 +1243,54 @@ __acquires(&uap->port.lock)
>  	spin_lock(&uap->port.lock);
>  }
>  
> -/*
> - * Transmit a character
> - * There must be at least one free entry in the TX FIFO to accept the char.
> - *
> - * Returns true if the FIFO might have space in it afterwards;
> - * returns false if the FIFO definitely became full.
> - */
> -static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c)
> +static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
> +			  bool from_irq)
>  {
> +	if (unlikely(!from_irq) &&
> +	    readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
> +		return false; /* unable to transmit character */
> +
>  	writew(c, uap->port.membase + UART01x_DR);
>  	uap->port.icount.tx++;
>  
> -	if (likely(uap->tx_irq_seen > 1))
> -		return true;
> -
> -	return !(readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF);
> +	return true;
>  }
>  
> -static bool pl011_tx_chars(struct uart_amba_port *uap)
> +static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
>  {
>  	struct circ_buf *xmit = &uap->port.state->xmit;
> -	int count;
> -
> -	if (unlikely(uap->tx_irq_seen < 2))
> -		/*
> -		 * Initial FIFO fill level unknown: we must check TXFF
> -		 * after each write, so just try to fill up the FIFO.
> -		 */
> -		count = uap->fifosize;
> -	else /* tx_irq_seen >= 2 */
> -		/*
> -		 * FIFO initially at least half-empty, so we can simply
> -		 * write half the FIFO without polling TXFF.
> -
> -		 * Note: the *first* TX IRQ can still race with
> -		 * pl011_start_tx_pio(), which can result in the FIFO
> -		 * being fuller than expected in that case.
> -		 */
> -		count = uap->fifosize >> 1;
> -
> -	/*
> -	 * If the FIFO is full we're guaranteed a TX IRQ at some later point,
> -	 * and can't transmit immediately in any case:
> -	 */
> -	if (unlikely(uap->tx_irq_seen < 2 &&
> -		     readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF))
> -		return false;
> +	int count = uap->fifosize >> 1;

Dave, I'd prefer if you kept my .prev_from_irq thing.  If .start_tx()
races with the IRQ we may have a situation where the IRQ arrives
but .start_tx() already filled the FIFO.  The guarantee of half of the
FIFO being empty will not hold in this case.  That's why I use the
guarantee only if the previous load was also from FIFO.

>  	if (uap->port.x_char) {
> -		pl011_tx_char(uap, uap->port.x_char);
> +		if (!pl011_tx_char(uap, uap->port.x_char, from_irq))
> +			return;
>  		uap->port.x_char = 0;
>  		--count;
>  	}
>  	if (uart_circ_empty(xmit) || uart_tx_stopped(&uap->port)) {
>  		pl011_stop_tx(&uap->port);
> -		goto done;
> +		return;
>  	}
>  
>  	/* If we are using DMA mode, try to send some characters. */
>  	if (pl011_dma_tx_irq(uap))
> -		goto done;
> +		return;
>  
> -	while (count-- > 0 && pl011_tx_char(uap, xmit->buf[xmit->tail])) {
> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -		if (uart_circ_empty(xmit))
> +	do {
> +		if (likely(from_irq) && count-- == 0)
>  			break;
> -	}
> +
> +		if (!pl011_tx_char(uap, xmit->buf[xmit->tail], from_irq))
> +			break;
> +
> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +	} while (!uart_circ_empty(xmit));

If you add the .prev_* this loop will become even more ugly.  Feel free
to copy my code wherever you see fit.
