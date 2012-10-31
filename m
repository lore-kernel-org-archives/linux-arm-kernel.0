From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Oct 2012 16:36:15 +0000
Subject: [PATCH] fix DEBUG_LL DCC race condition
In-Reply-To: <20121029151832.GA2162@sig21.net>
References: <20121029151832.GA2162@sig21.net>
Message-ID: <20121031163615.GQ21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 04:18:32PM +0100, Johannes Stezenbach wrote:
> Trying to boot a kernel with I- and D-caches disabled
> sometimes hangs when DEBUG_LL output to DCC is enabled.
> Apparently the JTAG debugger sometimes reads the
> DCC register before busyuart could see the wDTRfull flag,
> thus busyuart spins in an endless loop.

This makes no sense.  Why is busyuart spinning if it does _not_ see a
full flag?  busyuart is supposed to spin _if_ the UART has data to be
sent.  It's not supposed to spin if the data has been sent.

> The reason seems to be a misunderstanding of the purpose
> of the busyuart macro.  For UART, waituart waits until
> there is space in the FIFO, and busyuart waits until
> the FIFO is empty (all data is sent).
> For DCC, busyuart should be identical to waituart since
> there is no FIFO.

Not quite.  waituart is supposed to check that the flow control allows
the character to be sent _or_ it's supposed to do nothing.  Look at
the 8250 implementation debug-8250.S - this is the first implementation,
authored by me, and therefore is the definitive implementation for this
stuff.
