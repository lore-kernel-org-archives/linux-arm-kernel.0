From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 2 Jul 2017 22:27:22 +0200
Subject: [PATCH v4 16/28] tty: serial: owl: Implement console driver
In-Reply-To: <20170606143407.56d15c3c@lxorguk.ukuu.org.uk>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-17-afaerber@suse.de>
 <20170606143407.56d15c3c@lxorguk.ukuu.org.uk>
Message-ID: <d3c107f3-5df6-a771-2510-ef5578216d0f@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 15:34 schrieb Alan Cox:
>> +static void owl_uart_set_termios(struct uart_port *port,
>> +				 struct ktermios *termios,
>> +				 struct ktermios *old)
>> +{
>> +	struct owl_uart_port *owl_port = to_owl_uart_port(port);
>> +	unsigned int baud;
>> +	u32 ctl;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&port->lock, flags);
>> +
>> +	/* We don't support modem control lines. */
>> +	termios->c_cflag &= ~(HUPCL | CMSPAR);
>> +	termios->c_cflag |= CLOCAL;
> 
> CLOCAL and HUPCL are software not hardware properties so are probably
> best not forced (it'll confuse some apps if you do)
>> +
>> +	/* We don't support BREAK character recognition. */
>> +	termios->c_iflag &= ~(IGNBRK | BRKINT);
> 
> Ditto these

Fixed. These were obviously forward-ported from the vendor tree.

https://github.com/LeMaker/linux-actions/blob/linux-3.10.y/arch/arm/mach-owl/serial-owl.c

> You do clear CMSPAR which is right if not supported but then later on we
> have:
> 
>> +	if (termios->c_cflag & PARENB) {
>> +		if (termios->c_cflag & CMSPAR) {
>> +			if (termios->c_cflag & PARODD)
>> +				ctl |= OWL_UART_CTL_PRS_MARK;
>> +			else
>> +				ctl |= OWL_UART_CTL_PRS_SPACE;
>> +		} else if (termios->c_cflag & PARODD)
>> +			ctl |= OWL_UART_CTL_PRS_ODD;
>> +		else
>> +			ctl |= OWL_UART_CTL_PRS_EVEN;
>> +	} else
>> +		ctl |= OWL_UART_CTL_PRS_NONE;
> 
> 
> Which seems to indicate you do support CMSPAR so shouldn't be clearing it.

Again that's what the original code was like.

Since these register values do exist, I would rather not rip the code
out, unless it's wrong. In my testing, not clearing CMSPAR works so far.

>> +	baud = uart_get_baud_rate(port, termios, old, 9600, 3200000);
>> +	owl_uart_change_baudrate(owl_port, baud);
> 
> You should re-encode the resulting baud rate into the termios
> 
>         /* Don't rewrite B0 */
>         if (tty_termios_baud_rate(termios))
>                 tty_termios_encode_baud_rate(termios, baud, baud);

Added, thanks.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
