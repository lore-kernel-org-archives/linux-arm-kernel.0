From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jul 2014 11:18:48 -0500
Subject: [PATCH 4/5] tty: serial: 8250 core: add runtime pm
In-Reply-To: <53C7F4A3.5080508@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-5-git-send-email-bigeasy@linutronix.de>
 <20140716151604.GG1365@saruman.home>
 <53C6A050.2050409@linutronix.de>
 <20140716160614.GI1365@saruman.home>
 <53C7EC6F.6060902@hurleysoftware.com>
 <20140717154300.GA16623@linutronix.de>
 <20140717160206.GI10459@saruman.home>
 <53C7F4A3.5080508@linutronix.de>
Message-ID: <20140717161848.GK10459@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 17, 2014 at 06:06:59PM +0200, Sebastian Andrzej Siewior wrote:
> On 07/17/2014 06:02 PM, Felipe Balbi wrote:
> >> diff --git a/drivers/tty/serial/8250/8250_core.c
> >> b/drivers/tty/serial/8250/8250_core.c index 2e4a93b..480a1c0
> >> 100644 --- a/drivers/tty/serial/8250/8250_core.c +++
> >> b/drivers/tty/serial/8250/8250_core.c @@ -1283,6 +1283,9 @@
> >> static inline void __stop_tx(struct uart_8250_port *p) if (p->ier
> >> & UART_IER_THRI) { p->ier &= ~UART_IER_THRI; serial_out(p,
> >> UART_IER, p->ier); + +		pm_runtime_mark_last_busy(p->port.dev); +
> >> pm_runtime_put_autosuspend(p->port.dev); } }
> >> 
> >> @@ -1310,12 +1313,12 @@ static void serial8250_start_tx(struct
> >> uart_port *port) struct uart_8250_port *up = container_of(port,
> >> struct uart_8250_port, port);
> >> 
> >> -	pm_runtime_get_sync(port->dev); if (up->dma &&
> >> !serial8250_tx_dma(up)) { goto out; } else if (!(up->ier &
> >> UART_IER_THRI)) { up->ier |= UART_IER_THRI; +
> >> pm_runtime_get_sync(port->dev); serial_port_out(port, UART_IER,
> >> up->ier);
> >> 
> >> if (up->bugs & UART_BUG_TXEN) { unsigned char lsr;
> > 
> > this looks better. So we get on start_tx() and put on stop_tx().
> > 
> >> @@ -1500,9 +1503,10 @@ void serial8250_tx_chars(struct
> >> uart_8250_port *up) uart_write_wakeup(port);
> >> 
> >> DEBUG_INTR("THRE..."); - +#if 0 if (uart_circ_empty(xmit)) 
> >> __stop_tx(up); +#endif } EXPORT_SYMBOL_GPL(serial8250_tx_chars);
> > 
> > is it so that start_tx() gets called one and stop_tx() might be
> > called N times ? That looks unbalanced to me. If the calls are
> > balanced, then you shouldn't need to care because pm_runtime will
> > handle reference counting for you, right?
> 
> No, this is okay. If you look, it checks for "up->ier &
> UART_IER_THRI". On the second invocation it will see that this bit is
> already set and therefore won't call get_sync() for the second time.
> That bit is removed in the _stop_tx() path.

oh, right. But that's actually unnecessary. Calling pm_runtime_get()
multiple times will just increment the usage counter multiple times,
which means you can call __stop_tx() multiple times too and everything
gets balanced, right ?

> >> and now I need to come up with something that is not if (port !=
> >> omap) for that #if 0 block. The code disables the TX FIFO empty
> >> interrupt once the transfer is complete. I want to call
> >> __stop_tx() once the tx fifo is empty. Felipe, Would a check for
> >> dev->power.use_autosuspend be the right thing to do?
> > 
> > probably not, as that's internal to the pm_runtime code. But I
> > wonder if start/stop tx calls are balanced, if they are then we're
> > good. Unless I'm missing something else.
> 
> Do you have other ideas? It doesn't look like this is exported at all.
> If we call _stop_tx() right away, then we have 64 bytes in the TX fifo
> in the worst case. They should be gone "soon" but the HW-flow control
> may delay it (in theory for a long time)).

this can be problematic, specially for OMAP which can go into OFF while
idle. Whatever is in the FIFO would get lost. It seems like omap-serial
solved this within transmit_chars().

See how transmit_chars() is called from within IRQ handler with clocks
enabled then it conditionally calls serial_omap_stop_tx() which will
pm_runtime_get_sync() -> do_the_harlem_shake() ->
pm_runtime_put_autosuspend(). That leaves one unbalanced
pm_runtime_get() which is balanced when we're exitting the IRQ handler.

This seems work fine and dandy without DMA, but for DMA work, I think we
need to make sure this IP stays powered until we get DMA completion
callback. But that's future, I guess.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/ca4927f5/attachment-0001.sig>
