From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Mar 2012 10:11:00 +0000
Subject: [PATCH] serial: PL011: clear pending interrupts
In-Reply-To: <20120312083221.GW17370@n2100.arm.linux.org.uk>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
 <20120312083221.GW17370@n2100.arm.linux.org.uk>
Message-ID: <20120312101100.GA8649@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 08:32:21AM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 12, 2012 at 09:25:50AM +0100, Linus Walleij wrote:
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > index 6800f5f..ff3fed0 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -224,6 +224,11 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
> >  		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
> >  	}
> >  
> 
> What if we really do end up receiving some characters here?
> 
> > +	/* RXIS but RXFE? Just clear the interrupt */
> > +	if(unlikely(fifotaken == 0))
> > +		writew(UART011_RTIS | UART011_RXIS,
> > +		       uap->port.membase + UART011_ICR);

BTW, I don't see why we need any of this stuff.

The problem as described is that the interrupt handler is called with one
of the receive flags set (UART011_RTIS or UART011_RXIS) but with
UART01x_FR_RXFE clear.

The problem report indicates that this is caused when we switch from FIFO
mode to non-FIFO mode, and the FIFO contained some unread characters.

That can only happen once we've enabled interrupts in the IMSC register,
which doesn't happen until later in the startup function.

So:

        spin_lock_irq(&uap->port.lock);
        uap->im = UART011_RTIM;
        if (!pl011_dma_rx_running(uap))
                uap->im |= UART011_RXIM;
        writew(uap->im, uap->port.membase + UART011_IMSC);
        spin_unlock_irq(&uap->port.lock);

clearing the transmit/receive interrupts here _before_ we unmask them
should be sufficient.

As we never turn the FIFO off after that point, we can't then cause the
condition.  So I don't see any point in adding stuff to the interrupt
handling for this.
