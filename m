From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 May 2012 18:03:29 +0100
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <20120516110451.GA9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
Message-ID: <20120517170329.GB19548@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 12:04:51PM +0100, Russell King - ARM Linux wrote:
> This series removes the dependence on the dma_slave_config direction
> argument for the PL08x DMA engine driver, and in doing so, we end up
> with less code in the driver.

I've just been testing this on the Versatile PB926 with my only working
peripheral (PL011) and the runtime PM support which was added to the PL08x
driver is totally breaking this setup.

It's causing lockdep to spit out:

[ INFO: inconsistent lock state ]
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
init/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&port_lock_key){?.....}, at: [<c01b59ac>] uart_start+0x24/0x74
{IN-HARDIRQ-W} state was registered at:
...
  [<c01b97f8>] pl011_int+0x1c/0x4a8
...
stack backtrace:
[<c00561b4>] (trace_hardirqs_on+0x0/0x18) from [<c02dfc6c>] (_raw_spin_unlock_irq+0x30/0x64)
[<c02dfc3c>] (_raw_spin_unlock_irq+0x0/0x64) from [<c01c6214>] (__rpm_callback+0x30/0x60)
[<c01c61e4>] (__rpm_callback+0x0/0x60) from [<c01c733c>] (rpm_resume+0x3e0/0x568)
...
[<c019b7a8>] (pl08x_prep_slave_sg+0x0/0x270) from [<c01b953c>] (pl011_dma_tx_refill+0x104/0x1c8)
[<c01b9438>] (pl011_dma_tx_refill+0x0/0x1c8) from [<c01b9704>] (pl011_start_tx+0x38/0x110)

Basically, uart_start() has taken the port spinlock with IRQs disabled.
We then go through the PL011 start_tx function, eventually into the
PL08x driver to start the transmit DMA.

The PL08x driver then calls pm_runtime_get_sync(), when then invokes
__rpm_callback.  This unconditionally enables IRQs underneath the
per-port spinlock, allowing potential deadlock with PL011's interrupt
handler.

So, the only solution I can see is to strip out all the runtime PM stuff
from PL08x, which is buggy anyway.

And it's taken all afternoon to work out what's going on here... because
it can't spit that debug out because it deadlocks in the PL011 console
write function on the very same lock...  This is extremely nasty.
