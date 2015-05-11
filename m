From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 11 May 2015 17:09:30 +0100
Subject: [PATCH v4 REPOST] Revert "serial/amba-pl011: Leave the TX IRQ
 alone when the UART is not open"
In-Reply-To: <1431090470-1394-1-git-send-email-Dave.Martin@arm.com>
References: <1431090470-1394-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <5550D43A.4090200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 05/08/2015 02:07 PM, Dave P Martin wrote:
> This reverts commit f2ee6dfa0e8597eea8b98d240b0033994e20d215.
> 
> Jakub Kici?ski observed that this patch can cause the pl011
> driver to hang if if the only process with a pl011 port open is
> killed by a signal, pl011_shutdown() can get called with an
> arbitrary amount of data still in the FIFO.
> 
> Calling _shutdown() with the TX FIFO non-empty is questionable
> behaviour and my itself be a bug.
> 
> Since the affected patch was speculative anyway, and brings limited
> benefit, the simplest course is to remove the assumption that TXIS
> will always be left asserted after the port is shut down.

I see that you have queued it for Linus already, so I guess it will hit
4.1-rc4 anyway, but just to give more rationale:
This revert fixes a reboot issue with PL011 and systemd on the AMD
Seattle board. Reboot (or shutdown) was fine with 4.0, but started to
hang after the first characters following the reboot or shutdown command
with 4.1-rc1. So this very patch actually fixes a 4.1 regression and has
to be in the release.
So actually nothing to do for you (given that tty-linus will be the
branch for your next 4.1-rc pull request), just to make sure that you
don't still drop the patch.

Cheers,
Andre.

> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
>  drivers/tty/serial/amba-pl011.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> The original patch was a misguided optimisation and introduces a bug
> that can lead to driver deadlock.  Some people are hitting this in
> v4.0-rc1/2.
> 
> The revert is straightfoward: please consider applying it for v4.1.
> 
> This revert has already been posted to linux-serial and applied in
> tty-next, but is not yet scheduled for v4.1.
> 
> Thanks
> ---Dave
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 5a4e9d5..6f5a072 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1639,6 +1639,9 @@ static int pl011_startup(struct uart_port *port)
>  
>  	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
>  
> +	/* Assume that TX IRQ doesn't work until we see one: */
> +	uap->tx_irq_seen = 0;
> +
>  	spin_lock_irq(&uap->port.lock);
>  
>  	/* restore RTS and DTR */
> @@ -1702,7 +1705,7 @@ static void pl011_shutdown(struct uart_port *port)
>  	spin_lock_irq(&uap->port.lock);
>  	uap->im = 0;
>  	writew(uap->im, uap->port.membase + UART011_IMSC);
> -	writew(0xffff & ~UART011_TXIS, uap->port.membase + UART011_ICR);
> +	writew(0xffff, uap->port.membase + UART011_ICR);
>  	spin_unlock_irq(&uap->port.lock);
>  
>  	pl011_dma_shutdown(uap);
> 
