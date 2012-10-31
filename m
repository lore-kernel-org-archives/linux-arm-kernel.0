From: js@sig21.net (Johannes Stezenbach)
Date: Wed, 31 Oct 2012 18:08:54 +0100
Subject: [PATCH] fix DEBUG_LL DCC race condition
In-Reply-To: <20121031163615.GQ21164@n2100.arm.linux.org.uk>
References: <20121029151832.GA2162@sig21.net>
 <20121031163615.GQ21164@n2100.arm.linux.org.uk>
Message-ID: <20121031170853.GA20498@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 04:36:15PM +0000, Russell King - ARM Linux wrote:
> On Mon, Oct 29, 2012 at 04:18:32PM +0100, Johannes Stezenbach wrote:
> > Trying to boot a kernel with I- and D-caches disabled
> > sometimes hangs when DEBUG_LL output to DCC is enabled.
> > Apparently the JTAG debugger sometimes reads the
> > DCC register before busyuart could see the wDTRfull flag,
> > thus busyuart spins in an endless loop.
> 
> This makes no sense.  Why is busyuart spinning if it does _not_ see a
> full flag?  busyuart is supposed to spin _if_ the UART has data to be
> sent.  It's not supposed to spin if the data has been sent.

Maybe my wording didn't make it clear that the current code
spins if the data has been sent (which indeed does not
make sense).  My fix changes it to spin _until_ the data has been send.

> > The reason seems to be a misunderstanding of the purpose
> > of the busyuart macro.  For UART, waituart waits until
> > there is space in the FIFO, and busyuart waits until
> > the FIFO is empty (all data is sent).
> > For DCC, busyuart should be identical to waituart since
> > there is no FIFO.
> 
> Not quite.  waituart is supposed to check that the flow control allows
> the character to be sent _or_ it's supposed to do nothing.  Look at
> the 8250 implementation debug-8250.S - this is the first implementation,
> authored by me, and therefore is the definitive implementation for this
> stuff.

OK, in the case of DCC "flow-control" would mean JTAG has
read the DCC register.  So it seems correct that both
busyuart and waituart do the same:  wait for empty DCC register.
But I agree that the double wait is superflous, waituart
could be changed to do nothing.  This would be in line with
debug-8250.S which doesn't check for space in the FIFO
in waituart.

I'll send an updated patch.

Thanks,
Johannes
