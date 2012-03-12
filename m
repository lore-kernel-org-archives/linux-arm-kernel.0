From: neidhard.kim@lge.com (Kim, Jong-Sung)
Date: Mon, 12 Mar 2012 20:22:07 +0900
Subject: [PATCH] serial: PL011: clear pending interrupts
In-Reply-To: <20120312083221.GW17370@n2100.arm.linux.org.uk>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
 <20120312083221.GW17370@n2100.arm.linux.org.uk>
Message-ID: <01e101cd0042$5bf692a0$13e3b7e0$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/drivers/tty/serial/amba-pl011.c
> > b/drivers/tty/serial/amba-pl011.c index 6800f5f..ff3fed0 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -224,6 +224,11 @@ static int pl011_fifo_to_tty(struct uart_amba_port
> *uap)
> >  		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
> >  	}
> >
> 
> What if we really do end up receiving some characters here?

Maybe the character is handled on next upcoming RTIS or RXIS in normal.
However, I agree with you there is possibility of already asserted RXIS at
this point. (with debugger?) In such a case, we may lose Rx interrupts
forever because it's not level-triggered, and the ISR lacks error interrupt
handling. Correct me if something wrong.
Thank you for your comment, Russell.

> 
> > +	/* RXIS but RXFE? Just clear the interrupt */
> > +	if(unlikely(fifotaken == 0))
> > +		writew(UART011_RTIS | UART011_RXIS,
> > +		       uap->port.membase + UART011_ICR);
