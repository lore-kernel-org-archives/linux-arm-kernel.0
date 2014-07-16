From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 Jul 2014 10:16:04 -0500
Subject: [PATCH 4/5] tty: serial: 8250 core: add runtime pm
In-Reply-To: <1405521903-5877-5-git-send-email-bigeasy@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-5-git-send-email-bigeasy@linutronix.de>
Message-ID: <20140716151604.GG1365@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 16, 2014 at 04:45:02PM +0200, Sebastian Andrzej Siewior wrote:
> @@ -1280,6 +1285,7 @@ static void serial8250_stop_tx(struct uart_port *port)
>  	struct uart_8250_port *up =
>  		container_of(port, struct uart_8250_port, port);
>  
> +	pm_runtime_get_sync(port->dev);
>  	__stop_tx(up);
>  
>  	/*
> @@ -1289,6 +1295,8 @@ static void serial8250_stop_tx(struct uart_port *port)
>  		up->acr |= UART_ACR_TXDIS;
>  		serial_icr_write(up, UART_ACR, up->acr);
>  	}
> +	pm_runtime_mark_last_busy(port->dev);
> +	pm_runtime_put_autosuspend(port->dev);
>  }
>  
>  static void serial8250_start_tx(struct uart_port *port)
> @@ -1296,8 +1304,9 @@ static void serial8250_start_tx(struct uart_port *port)
>  	struct uart_8250_port *up =
>  		container_of(port, struct uart_8250_port, port);
>  
> +	pm_runtime_get_sync(port->dev);
>  	if (up->dma && !serial8250_tx_dma(up)) {
> -		return;
> +		goto out;
>  	} else if (!(up->ier & UART_IER_THRI)) {
>  		up->ier |= UART_IER_THRI;
>  		serial_port_out(port, UART_IER, up->ier);
> @@ -1318,6 +1327,9 @@ static void serial8250_start_tx(struct uart_port *port)
>  		up->acr &= ~UART_ACR_TXDIS;
>  		serial_icr_write(up, UART_ACR, up->acr);
>  	}
> +out:
> +	pm_runtime_mark_last_busy(port->dev);
> +	pm_runtime_put_autosuspend(port->dev);

I wonder if you should get_sync() on start_tx() and only
put_autosuspend() at stop_tx(). I guess the outcome would be largely the
same, no ?

well, other than in probe and other functions which need to make sure
clocks are on, but it seems unnecessary to enable/disable in every
function.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/1ce5636b/attachment.sig>
