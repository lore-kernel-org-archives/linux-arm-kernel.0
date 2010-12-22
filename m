From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Dec 2010 18:20:41 +0000
Subject: [PATCH] ARM: add PrimeCell generic DMA to PL011
In-Reply-To: <AANLkTi=uhMyDySAxbZK4XKU6Z4AbkjVc29L4idc0sxLf@mail.gmail.com>
References: <1286357526-5570-1-git-send-email-linus.walleij@stericsson.com>
	<20101222141006.GA19852@n2100.arm.linux.org.uk>
	<AANLkTi=uhMyDySAxbZK4XKU6Z4AbkjVc29L4idc0sxLf@mail.gmail.com>
Message-ID: <20101222182041.GE14693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 22, 2010 at 06:09:22PM +0100, Linus Walleij wrote:
> 2010/12/22 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Wed, Oct 06, 2010 at 11:32:06AM +0200, Linus Walleij wrote:
> >> ? ? ? /*
> >> - ? ? ?* Finally, enable interrupts
> >> + ? ? ?* Finally, enable interrupts, only timeouts when using DMA
> >> + ? ? ?* if initial RX DMA job failed, start in interrupt mode
> >> + ? ? ?* as well.
> >> ? ? ? ?*/
> >> ? ? ? spin_lock_irq(&uap->port.lock);
> >> - ? ? uap->im = UART011_RXIM | UART011_RTIM;
> >> + ? ? if (uap->enable_dma && uap->rx_dma_running)
> >> + ? ? ? ? ? ? uap->im = UART011_RTIM;
> >> + ? ? else
> >> + ? ? ? ? ? ? uap->im = UART011_RXIM | UART011_RTIM;
> >> ? ? ? writew(uap->im, uap->port.membase + UART011_IMSC);
> >
> > There's a big hole here, using DMA on the receive path.
> >
> > | 3.4.4 UARTRTINTR
> > | The receive timeout interrupt is asserted when the receive FIFO is not
> > | empty, and no further data is received over a 32-bit period. The receive
> > | timeout interrupt is cleared either when the FIFO becomes empty through
> > | reading all the data (or by reading the holding register), or when a 1
> > | is written to the corresponding bit of the UARTICR register.
> >
> > There must be unread data in the FIFO for us to get a RT interrupt. ?The
> > problem is that if we have DMA enabled, then the received characters are
> > read from the FIFO as soon as they appear, and so the FIFO becomes empty,
> > which negates the conditions required for the RT interrupt to be
> > generated.
> 
> The DMA on the RX channel will not read single bytes at all,
> instead it waits until it can retrieve a burst, which is set to half
> a FIFO: src_maxburst = uap->fifosize >> 1,

I refer you to section 2.7, which describes the DMA interface.

UARTRXDMASREQ
Single character DMA transfer request, asserted by the UART. For
receive, one character consists of up to 12 bits. This signal is asserted
when the receive FIFO contains at least one character.

UARTRXDMABREQ
Burst DMA transfer request, asserted by the UART. This signal is
asserted when the receive FIFO contains more characters than the
programmed watermark level. You can program the watermark level for
each FIFO through the UARTIFLS register.

If your DMA controller is using UARTRXDMASREQ, then you'll end up DMAing
single bytes as long as the FIFO contains any bytes - thereby causing
it to be emptied completely.  As 3.4.4 says, if the FIFO is empty, you
don't get the timeout.

The PB926 doesn't specify whether it connects the burst or single-
character DMA request signal to the DMA controller - from the behaviour
I observe, I suspect it's the single character request which is.
