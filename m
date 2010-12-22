From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 22 Dec 2010 18:09:22 +0100
Subject: [PATCH] ARM: add PrimeCell generic DMA to PL011
In-Reply-To: <20101222141006.GA19852@n2100.arm.linux.org.uk>
References: <1286357526-5570-1-git-send-email-linus.walleij@stericsson.com>
	<20101222141006.GA19852@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=uhMyDySAxbZK4XKU6Z4AbkjVc29L4idc0sxLf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/22 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Oct 06, 2010 at 11:32:06AM +0200, Linus Walleij wrote:
>> ? ? ? /*
>> - ? ? ?* Finally, enable interrupts
>> + ? ? ?* Finally, enable interrupts, only timeouts when using DMA
>> + ? ? ?* if initial RX DMA job failed, start in interrupt mode
>> + ? ? ?* as well.
>> ? ? ? ?*/
>> ? ? ? spin_lock_irq(&uap->port.lock);
>> - ? ? uap->im = UART011_RXIM | UART011_RTIM;
>> + ? ? if (uap->enable_dma && uap->rx_dma_running)
>> + ? ? ? ? ? ? uap->im = UART011_RTIM;
>> + ? ? else
>> + ? ? ? ? ? ? uap->im = UART011_RXIM | UART011_RTIM;
>> ? ? ? writew(uap->im, uap->port.membase + UART011_IMSC);
>
> There's a big hole here, using DMA on the receive path.
>
> | 3.4.4 UARTRTINTR
> | The receive timeout interrupt is asserted when the receive FIFO is not
> | empty, and no further data is received over a 32-bit period. The receive
> | timeout interrupt is cleared either when the FIFO becomes empty through
> | reading all the data (or by reading the holding register), or when a 1
> | is written to the corresponding bit of the UARTICR register.
>
> There must be unread data in the FIFO for us to get a RT interrupt. ?The
> problem is that if we have DMA enabled, then the received characters are
> read from the FIFO as soon as they appear, and so the FIFO becomes empty,
> which negates the conditions required for the RT interrupt to be
> generated.

The DMA on the RX channel will not read single bytes at all,
instead it waits until it can retrieve a burst, which is set to half
a FIFO: src_maxburst = uap->fifosize >> 1,
(OK this is max burst, but of course the DMA engine will try
to configure as large transfers as possible, so in practice this
will be 8 bytes for an unmodified PL011.)

In the interactive case the RT interrupt is the most expected
execution path. If you type in a few characters
pl011_dma_rx_chars() will not recieve anything using DMA really,
it will get all characters from the FIFO after a RT interrupt.

If you feed the DMA real quick (e.g. try pasting a large buffer
into a terminal) it will run some DMA rounds of pages, then it
will stop with some characters in the FIFO, and then it will time
out, and the remaining characters are read out from the FIFO.
So the characters get in for all cases I can think of.

If it ain't working there is something more fishy to it...

> Let's say I have a login prompt on the serial port. ?I type 'root'.
> The DMA reads the contents of the FIFO into memory, and causing it to be
> emptied. ?As there's no characters in the FIFO, we don't receive a RT
> interrupt, so we don't transfer these characters into the TTY subsystem.
> The only time that the input is received is after a further ~4092 newline
> characters are submitted, at which point the DMA engine says the buffer
> is complete, and calls the RX callback. ?This sucks for interactive use
> of the port, and probably prevents it being used for any kind of
> sane protocol too.
>
> I don't see any way to bring back interactivity while keeping RX DMA
> support, so I don't think we can use DMA for the RX channel with these
> UARTs.

But I'm using this interactively on ux500, u300 (pure PL011) and
RealView PB11MPCore..?

There *may* be a corner case when you're transferring
an even multiple of the burst size though, then you can
*maybe* get into the situation you're describing. Such as
paste a buffer with n MOD 8 bytes, but I haven't
been able to provoke it :-/ (and no hardware here sadly).

In that case however, what we would could do is to have
some last fallback timer that will do what the RT interrupt
does if it doesn't eventually happen.

(Will comment more on the thread(s) soonish, just need to
put the kids to sleep.)

Yours,
Linus Walleij
