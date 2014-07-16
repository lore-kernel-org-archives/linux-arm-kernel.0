From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 Jul 2014 11:06:14 -0500
Subject: [PATCH 4/5] tty: serial: 8250 core: add runtime pm
In-Reply-To: <53C6A050.2050409@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-5-git-send-email-bigeasy@linutronix.de>
 <20140716151604.GG1365@saruman.home>
 <53C6A050.2050409@linutronix.de>
Message-ID: <20140716160614.GI1365@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 16, 2014 at 05:54:56PM +0200, Sebastian Andrzej Siewior wrote:
> On 07/16/2014 05:16 PM, Felipe Balbi wrote:
> > Hi,
> 
> Hi Felipe,
> 
> > On Wed, Jul 16, 2014 at 04:45:02PM +0200, Sebastian Andrzej Siewior
> > wrote:
> >> @@ -1280,6 +1285,7 @@ static void serial8250_stop_tx(struct
> >> uart_port *port) struct uart_8250_port *up = container_of(port,
> >> struct uart_8250_port, port);
> >> 
> >> +	pm_runtime_get_sync(port->dev); __stop_tx(up);
> >> 
> >> /* @@ -1289,6 +1295,8 @@ static void serial8250_stop_tx(struct
> >> uart_port *port) up->acr |= UART_ACR_TXDIS; serial_icr_write(up,
> >> UART_ACR, up->acr); } +	pm_runtime_mark_last_busy(port->dev); +
> >> pm_runtime_put_autosuspend(port->dev); }
> >> 
> >> static void serial8250_start_tx(struct uart_port *port) @@
> >> -1296,8 +1304,9 @@ static void serial8250_start_tx(struct
> >> uart_port *port) struct uart_8250_port *up = container_of(port,
> >> struct uart_8250_port, port);
> >> 
> >> +	pm_runtime_get_sync(port->dev); if (up->dma &&
> >> !serial8250_tx_dma(up)) { -		return; +		goto out; } else if
> >> (!(up->ier & UART_IER_THRI)) { up->ier |= UART_IER_THRI; 
> >> serial_port_out(port, UART_IER, up->ier); @@ -1318,6 +1327,9 @@
> >> static void serial8250_start_tx(struct uart_port *port) up->acr
> >> &= ~UART_ACR_TXDIS; serial_icr_write(up, UART_ACR, up->acr); } 
> >> +out: +	pm_runtime_mark_last_busy(port->dev); +
> >> pm_runtime_put_autosuspend(port->dev);
> > 
> > I wonder if you should get_sync() on start_tx() and only 
> > put_autosuspend() at stop_tx(). I guess the outcome would be
> > largely the same, no ?
> 
> I just opened minicom on ttyS0 and gave a try. start_tx() was invoked
> each time I pressed a key (sent a character). I haven't seen stop_tx()
> even after after I closed minicom. I guess stop_tx() is invoked if you
> switch half-duplex communication.

that's bad, I expected stop to be called also after each character.

> > well, other than in probe and other functions which need to make
> > sure clocks are on, but it seems unnecessary to enable/disable in
> > every function.
> 
> What do you have in mind? Do you plan to let the uart on while the
> minicom is attached but is doing nothing? In that case, ->startup() and
> ->shutdown() should be enough.

no the idea was to keep it on for as long as it's transferring
characters and idle it otherwise, if that can't be done easily, then I
guess your way is the only way.

> If you want to put the uart off while the port is open but idle then
> you should cover the callbacks as they are independent of each other.
> You could receive three ->set_termios() even without a single
> ->start_tx(). And as far as I understand the whole situation, you need
> to make sure the UART is "up" while you touch a single register not
> only sending characters, right?

right, for those cases, you have to get/put around function entry/exit;
I was just assuming that we didn't have to do that for each and every
callback.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/0107e0c4/attachment-0001.sig>
