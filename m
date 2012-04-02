From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 2 Apr 2012 23:00:34 +0300
Subject: [BUG?] vic MULTI_IRQ_HANDLER (was [PATCH] ep93xx: Implement
 double buffering for M2M DMA channels)
In-Reply-To: <CACb=_tQ4pSXtmKnqM23p97iyRbnrdZicw6ao68t2KjL46srAuQ@mail.gmail.com>
References: <ADE657CA350FB648AAC2C43247A983F0020698409ABF@AUSP01VMBX24.collaborationhost.net>
 <CACb=_tQ4pSXtmKnqM23p97iyRbnrdZicw6ao68t2KjL46srAuQ@mail.gmail.com>
Message-ID: <20120402200034.GL5812@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 07:16:11PM +0100, Jamie Iles wrote:
> > 1) Are interrupts supposed to be still enabled when vic_handle_irq is called to
> > handle the pending interrupts the first time? If they "are" disabled, what is
> > re-enabling them and causing the timer interrupt to start a new iteration?
> 
> No, I believe that at this point IRQ's should be disabled.  This gets
> called very early by the entry macros, and not much has run before
> this gets called.  I can only guess that something inside one of the
> interrupt handlers is reenabling interrupts for some period.

I finally managed to dig up my old TS-7260 board which has SPI eeprom and this
is much easier to debug as the traffic is minimal compared to MMC over SPI.

I added some debug code once I was able to reproduce this and here's the trace
with my added comments.

[  176.860000] dma dma1chan0: M2M: submit: control=0xb40500c
[  176.860000] dma dma1chan1: M2M: submit: control=0xb80280c

Here we submit both RX and TX requests.

[  176.860000] VIC0: start <stat=0x60000>

We got immediately two interrupts as the transfer size is pretty small. The
stat field shows that both bits 17 and 18 are set (DMA RX and TX interrupts).
We are now at the beginning of handle_one_vic().

[  176.860000] VIC0: <IRQ17>

We start processing the first (RX) interrupt here.

[  176.860000] dma dma1chan0: <IRQ17>
[  176.860000] dma dma1chan0: M2M: begin intr: control=0xb40500c
[  176.860000] dma dma1chan0: M2M: DONE end intr: control=0xb405000
[  176.860000] dma dma1chan0: </IRQ17>

The interrupt was handled by the ep93xx_dma driver for RX channel.

[  176.860000] VIC0: start <stat=0x40000>

Another call to handle_one_vic() starts here and it shows that bit 18 is set
(DMA TX interrupt).

[  176.860000] VIC0: <IRQ18>

and we start processing that.

[  176.860000] dma dma1chan1: <IRQ18>

The dma driver prints out that it started to handle the interrupt.

Now, I added WARN_ON_ONCE(irq == 18) at the beginning of the handler which
shows the situation nicely. Comments in the backtrace should be read starting
from the bottom (ep93xx_dma_tx_submit). I also numbered them.

[  176.860000] ------------[ cut here ]------------
[  176.860000] WARNING: at drivers/dma/ep93xx_dma.c:748 ep93xx_dma_interrupt+0x16c/0x194()
[  176.860000] Modules linked in:
[  176.860000] [<c0019e74>] (unwind_backtrace+0x0/0xf0) from [<c0022724>] (warn_slowpath_common+0x48/0x60)
[  176.860000] [<c0022724>] (warn_slowpath_common+0x48/0x60) from [<c0022758>] (warn_slowpath_null+0x1c/0x24)
[  176.860000] [<c0022758>] (warn_slowpath_null+0x1c/0x24) from [<c01cfa64>] (ep93xx_dma_interrupt+0x16c/0x194)
[  176.860000] [<c01cfa64>] (ep93xx_dma_interrupt+0x16c/0x194) from [<c005a960>] (handle_irq_event_percpu+0x50/0x1a8)
[  176.860000] [<c005a960>] (handle_irq_event_percpu+0x50/0x1a8) from [<c005aaf4>] (handle_irq_event+0x3c/0x5c)
[  176.860000] [<c005aaf4>] (handle_irq_event+0x3c/0x5c) from [<c005ca24>] (handle_level_irq+0x90/0x11c)
[  176.860000] [<c005ca24>] (handle_level_irq+0x90/0x11c) from [<c005a2a4>] (generic_handle_irq+0x2c/0x40)
[  176.860000] [<c005a2a4>] (generic_handle_irq+0x2c/0x40) from [<c001528c>] (handle_IRQ+0x30/0x84)
[  176.860000] [<c001528c>] (handle_IRQ+0x30/0x84) from [<c0008608>] (vic_handle_irq+0x108/0x1f8)
[  176.860000] [<c0008608>] (vic_handle_irq+0x108/0x1f8) from [<c0014054>] (__irq_svc+0x34/0x60)

3. And here we start to handle the second interrupt.

[  176.860000] Exception stack(0xc503bde0 to 0xc503be28)
[  176.860000] bde0: 00000000 00000000 c503be18 20000013 00000040 00000011 c503a000 c0454ef8
[  176.860000] be00: c0459940 c043e2d8 00000000 c0459964 00000102 c503be28 c0028218 c002822c
[  176.860000] be20: 20000013 ffffffff
[  176.860000] [<c0014054>] (__irq_svc+0x34/0x60) from [<c002822c>] (__do_softirq+0x58/0x13c)
[  176.860000] [<c002822c>] (__do_softirq+0x58/0x13c) from [<c00286fc>] (irq_exit+0x54/0x60)

2. This is where the first interrupt is finished and it shows that irq_exit()
allows softirqs to run (enabling hardirqs). So we get another interrupt (as
the line is still active for IRQ18 which we didn't handle yet).

[  176.860000] [<c00286fc>] (irq_exit+0x54/0x60) from [<c0015290>] (handle_IRQ+0x34/0x84)
[  176.860000] [<c0015290>] (handle_IRQ+0x34/0x84) from [<c0008608>] (vic_handle_irq+0x108/0x1f8)
[  176.860000] [<c0008608>] (vic_handle_irq+0x108/0x1f8) from [<c0014054>] (__irq_svc+0x34/0x60)
[  176.860000] Exception stack(0xc503beb0 to 0xc503bef8)
[  176.860000] bea0:                                     c503bef0 00000000 ffffffff c503a030
[  176.860000] bec0: 60000013 00000002 c506cf58 60000013 c5147f30 c513d805 c5137dbc c5137dac
[  176.860000] bee0: 00000001 c503bef8 c0332b08 c0332b0c 60000013 ffffffff
[  176.860000] [<c0014054>] (__irq_svc+0x34/0x60) from [<c0332b0c>] (_raw_spin_unlock_irqrestore+0x10/0x38)

1. First interrupt happens here.

[  176.860000] [<c0332b0c>] (_raw_spin_unlock_irqrestore+0x10/0x38) from [<c01cf2fc>] (ep93xx_dma_tx_submit+0x6c/0x90)
[  176.860000] [<c01cf2fc>] (ep93xx_dma_tx_submit+0x6c/0x90) from [<c02130cc>] (ep93xx_spi_work+0x478/0x5d8)
[  176.860000] [<c02130cc>] (ep93xx_spi_work+0x478/0x5d8) from [<c0035888>] (process_one_work+0x128/0x398)
[  176.860000] [<c0035888>] (process_one_work+0x128/0x398) from [<c0037c14>] (worker_thread+0x160/0x340)
[  176.860000] [<c0037c14>] (worker_thread+0x160/0x340) from [<c003bf60>] (kthread+0x90/0x9c)
[  176.860000] [<c003bf60>] (kthread+0x90/0x9c) from [<c0015370>] (kernel_thread_exit+0x0/0x8)
[  176.860000] ---[ end trace e258991e05d70c3d ]---


[  176.860000] dma dma1chan1: M2M: begin intr: control=0xb80280c
[  176.860000] dma dma1chan1: M2M: DONE end intr: control=0xb802800
[  176.860000] dma dma1chan1: </IRQ18>

Now back to the trace we see that IRQ18 is now handled and we return from
there.

[  176.860000] VIC0: </IRQ18>
[  176.860000] VIC0: finished <stat=0x0, loops=1, handled=1>
[  177.150000] VIC0: </IRQ17>

At this point we are back in the first vic_handle_irq() where the stat still
shows that there is an interupt 18 pending (which we handled already).

[  177.150000] VIC0: <IRQ18>
[  177.150000] dma dma1chan1: <IRQ18>
[  177.150000] dma dma1chan1: got interrupt while active list is empty

And the driver complains that we already handled that interrupt.

[  177.150000] VIC0: </IRQ18>
[  177.150000] VIC0: finished <stat=0x0, loops=2, handled=1>

Sorry if the above is bit messy - I didn't find any other way to present this.

Anyway it looks like handle_IRQ() enables interrupts when it is finished with
the current interrupt which then causes hw to interrupt second time resulting
failure in case of ep93xx.
