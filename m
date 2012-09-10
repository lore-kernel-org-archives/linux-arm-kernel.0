From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 10 Sep 2012 10:56:01 -0700
Subject: [PATCH 09/14] tty/serial/amba-pl011: Implement clear_irqs callback
In-Reply-To: <20120910121702.550b8a90@pyramind.ukuu.org.uk>
References: <20120910040802.GA1261@lizard> <20120910041404.GI29537@lizard>
 <20120910121702.550b8a90@pyramind.ukuu.org.uk>
Message-ID: <20120910175601.GA13164@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 12:17:02PM +0100, Alan Cox wrote:
[...]
> > +static void pl011_clear_irqs(struct uart_port *port)
> > +{
> > +	struct uart_amba_port *uap = (struct uart_amba_port *)port;
> > +	unsigned char __iomem *regs = uap->port.membase;
> > +
> > +	writew(readw(regs + UART011_MIS), regs + UART011_ICR);
> > +	/*
> > +	 * There is no way to clear TXIM, this is "ready to transmit IRQ", so
> > +	 * we simply mask it. ops->start_tx will unmask it.
> > +	 */
> 
> Not if you race here with the transmit start it won't.

True, the race is possible. But I guess there will be no harm: only non-polling
code uses ->start_tx(), but then we don't care, the port is used for NMI
debugger, so the worst that can happen, is that we'll get another NMI just
after the race, and so we'll mask it again.

And once we release the port from KDB, we never call this function anymore
(since normal IRQ routine will be called instead).

I guess I need to add some commens about this.

Thanks!
