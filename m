From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 15 Mar 2017 12:37:46 +0100
Subject: [PATCH] tty/serial: atmel_serial: BUG: stop DMA from transmitting
 in stop_tx
In-Reply-To: <20161213162756.16139-1-richard.genoud@gmail.com>
References: <20161213162756.16139-1-richard.genoud@gmail.com>
Message-ID: <c5c0cdcf-d4da-a8c0-4161-85535ecf88ec@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/12/2016 ? 17:27, Richard Genoud a ?crit :
> If we don't disable the transmitter in atmel_stop_tx, the DMA buffer
> continues to send data until it is emptied.
> This cause problems with the flow control (CTS is asserted and data are
> still sent).
> 
> So, disabling the transmitter in atmel_stop_tx is a sane thing to do.
> 
> Tested on at91sam9g35-cm(DMA)
> Tested for regressions on sama5d2-xplained(Fifo) and at91sam9g20ek(PDC)
> 
> Cc: <stable@vger.kernel.org> (beware, this won't apply before 4.3)
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> NB: this is not for the 4.10 merge window, I'm just sending it now to
> have some comments if someone is againts it.
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 168b10cad47b..f9d42de5ab2d 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -481,6 +481,14 @@ static void atmel_stop_tx(struct uart_port *port)
>  		/* disable PDC transmit */
>  		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
>  	}
> +
> +	/*
> +	 * Disable the transmitter.
> +	 * This is mandatory when DMA is used, otherwise the DMA buffer
> +	 * is fully transmitted.
> +	 */
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS);
> +
>  	/* Disable interrupts */
>  	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
>  
> @@ -513,6 +521,9 @@ static void atmel_start_tx(struct uart_port *port)
>  
>  	/* Enable interrupts */
>  	atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);
> +
> +	/* re-enable the transmitter */
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
>  }
>  
>  /*

Hi Richard,

I've just discovered that I have some weird behavior with this patch. On
current Linus' tree, with sama5d2 + DMA, I see some garbage characters
coming out of the console when I try to stop my system (reboot/halt) [1].

Moreover, and I do understand that it's not the problem right here, when
applied on our linux-4.4-at91 branch (our vendor tree actually), it
hangs the boot process as it seems that a burst of open/close of the
serial port happens while starting the rootfs. It's definitively my own
problem, but it can bring light to what we are seeing on Mainline...

I think that we may need to flush the DMA channel in this
atmel_stop_tx() function.

Best regards,

[1] If you want to test, you need to apply this patch for eMMC BTW:
https://patchwork.kernel.org/patch/9617489/

-- 
Nicolas Ferre
