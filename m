From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 6 Jun 2017 14:34:07 +0100
Subject: [PATCH v4 16/28] tty: serial: owl: Implement console driver
In-Reply-To: <20170606005426.26446-17-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-17-afaerber@suse.de>
Message-ID: <20170606143407.56d15c3c@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +static void owl_uart_set_termios(struct uart_port *port,
> +				 struct ktermios *termios,
> +				 struct ktermios *old)
> +{
> +	struct owl_uart_port *owl_port = to_owl_uart_port(port);
> +	unsigned int baud;
> +	u32 ctl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	/* We don't support modem control lines. */
> +	termios->c_cflag &= ~(HUPCL | CMSPAR);
> +	termios->c_cflag |= CLOCAL;

CLOCAL and HUPCL are software not hardware properties so are probably
best not forced (it'll confuse some apps if you do)
> +
> +	/* We don't support BREAK character recognition. */
> +	termios->c_iflag &= ~(IGNBRK | BRKINT);

Ditto these


You do clear CMSPAR which is right if not supported but then later on we
have:

> +	if (termios->c_cflag & PARENB) {
> +		if (termios->c_cflag & CMSPAR) {
> +			if (termios->c_cflag & PARODD)
> +				ctl |= OWL_UART_CTL_PRS_MARK;
> +			else
> +				ctl |= OWL_UART_CTL_PRS_SPACE;
> +		} else if (termios->c_cflag & PARODD)
> +			ctl |= OWL_UART_CTL_PRS_ODD;
> +		else
> +			ctl |= OWL_UART_CTL_PRS_EVEN;
> +	} else
> +		ctl |= OWL_UART_CTL_PRS_NONE;


Which seems to indicate you do support CMSPAR so shouldn't be clearing it.

> +
> +	if (termios->c_cflag & CRTSCTS)
> +		ctl |= OWL_UART_CTL_AFE;
> +	else
> +		ctl &= ~OWL_UART_CTL_AFE;
> +
> +	owl_uart_write(port, ctl, OWL_UART_CTL);
> +
> +	baud = uart_get_baud_rate(port, termios, old, 9600, 3200000);
> +	owl_uart_change_baudrate(owl_port, baud);

You should re-encode the resulting baud rate into the termios

        /* Don't rewrite B0 */
        if (tty_termios_baud_rate(termios))
                tty_termios_encode_baud_rate(termios, baud, baud);
