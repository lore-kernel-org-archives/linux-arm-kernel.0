From: robert.jarzmik@free.fr (=Robert Jarzmik)
Date: Mon, 24 Nov 2014 23:08:15 +0100
Subject: [PATCH] serial: pxa: hold port.lock when reporting modem line
 changes
In-Reply-To: <1416815313-20891-1-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Mon, 24 Nov 2014 10:48:33 +0300")
References: <1416815313-20891-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <87389845gw.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 2f4c329..b59dcb1 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -223,6 +223,7 @@ static void serial_pxa_start_tx(struct uart_port *port)
>  	}
>  }
>  
> +/* should hold up->port.lock */
>  static inline void check_modem_status(struct uart_pxa_port *up)
>  {
>  	int status;
> @@ -258,7 +259,9 @@ static inline irqreturn_t serial_pxa_irq(int irq, void
>  *dev_id)
The spin_lock() should be here I think. As the spinlock price has to be paid,
let's have the whole function under spinlock().

>  	lsr = serial_in(up, UART_LSR);
>  	if (lsr & UART_LSR_DR)
>  		receive_chars(up, &lsr);
> +	spin_lock(&up->port.lock);
>  	check_modem_status(up);
> +	spin_unlock(&up->port.lock);
>  	if (lsr & UART_LSR_THRE)
>  		transmit_chars(up);
The spin_unlock() should be there, after transmission IMO.

Cheers.

-- 
Robert
