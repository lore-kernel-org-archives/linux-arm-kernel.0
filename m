From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Dec 2010 14:10:06 +0000
Subject: [PATCH] ARM: add PrimeCell generic DMA to PL011
In-Reply-To: <1286357526-5570-1-git-send-email-linus.walleij@stericsson.com>
References: <1286357526-5570-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101222141006.GA19852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 11:32:06AM +0200, Linus Walleij wrote:
>  	/*
> -	 * Finally, enable interrupts
> +	 * Finally, enable interrupts, only timeouts when using DMA
> +	 * if initial RX DMA job failed, start in interrupt mode
> +	 * as well.
>  	 */
>  	spin_lock_irq(&uap->port.lock);
> -	uap->im = UART011_RXIM | UART011_RTIM;
> +	if (uap->enable_dma && uap->rx_dma_running)
> +		uap->im = UART011_RTIM;
> +	else
> +		uap->im = UART011_RXIM | UART011_RTIM;
>  	writew(uap->im, uap->port.membase + UART011_IMSC);

There's a big hole here, using DMA on the receive path.

| 3.4.4 UARTRTINTR
| The receive timeout interrupt is asserted when the receive FIFO is not
| empty, and no further data is received over a 32-bit period. The receive
| timeout interrupt is cleared either when the FIFO becomes empty through
| reading all the data (or by reading the holding register), or when a 1
| is written to the corresponding bit of the UARTICR register.

There must be unread data in the FIFO for us to get a RT interrupt.  The
problem is that if we have DMA enabled, then the received characters are
read from the FIFO as soon as they appear, and so the FIFO becomes empty,
which negates the conditions required for the RT interrupt to be
generated.

Let's say I have a login prompt on the serial port.  I type 'root'.
The DMA reads the contents of the FIFO into memory, and causing it to be
emptied.  As there's no characters in the FIFO, we don't receive a RT
interrupt, so we don't transfer these characters into the TTY subsystem.
The only time that the input is received is after a further ~4092 newline
characters are submitted, at which point the DMA engine says the buffer
is complete, and calls the RX callback.  This sucks for interactive use
of the port, and probably prevents it being used for any kind of
sane protocol too.

I don't see any way to bring back interactivity while keeping RX DMA
support, so I don't think we can use DMA for the RX channel with these
UARTs.
