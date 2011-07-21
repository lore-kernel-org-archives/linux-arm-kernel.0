From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 16:23:42 +0100
Subject: [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <CABb+yY2p8VNSvhv+LjoYnunrYS8+3+841bKM-4aUsg5vNx=Mig@mail.gmail.com>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
	<1311158773-30314-3-git-send-email-boojin.kim@samsung.com>
	<CABb+yY2_XKyCr2mEzqd0bCYJk3U7+sg8Xz4b4ma2KB1BconYOw@mail.gmail.com>
	<20110721081138.GL26574@n2100.arm.linux.org.uk>
	<CABb+yY2obv5JMBiRSXS-4tSCYX+7nVVaA0Q7gurA+NndrGVuvA@mail.gmail.com>
	<20110721112920.GM26574@n2100.arm.linux.org.uk>
	<CABb+yY2p8VNSvhv+LjoYnunrYS8+3+841bKM-4aUsg5vNx=Mig@mail.gmail.com>
Message-ID: <20110721152342.GE28942@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 08:42:40PM +0530, Jassi Brar wrote:
> On Thu, Jul 21, 2011 at 4:59 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Does your hardware have a hardware block from the device itself containing
> > all the systems FIFOs ?
> I am not sure what you ask, but let me say what I know.
> In this case atleast, all PL330 DMA channels have fixed source/destination
> address on the device side. So it's not like developer doesn't know
> fifo_addr here.

Even so, your approach is _conceptually_ wrong.  Think about it.

You declare your devices giving the bus address where they're located.
So, lets say for argument that your UART is located at 0x10001000.

Your UART driver knows that the FIFO register is at offset 0x20 from
the base address.  Your platform data provides the UART driver with a
DMA match function and data specific for that match function.  This
data encodes the specific DMA channel.

Now, why should you have to encode into the DMA drivers platform data
that DMA channel X has its FIFO at 0x10001020?  Not only do you have
to declare the base address of the UART but also you have to know the
offset into the UART.

Why not just let the UART driver - which knows that the base address
is 0x10001000, and the FIFO is at offset 0x20 above that - tell the
DMA driver that's where the FIFO is located?

Finally, your specific SoC may have a PL330, which may have FIFOs tied
to specific DMA request signals.  That's an _implementation_ _detail_.
That doesn't mean that's always going to be the case.

I've heard that ARM Ltd may start using the PL330 on their evaluation
boards.  They have a habbit of muxing several DMA request signals to
several different peripherals.  Will I need to rewrite all the Samsung
users of PL330 when that happens because they've decided they don't
like the DMA engine API and have gone off and done their own thing
instead?

So no, encoding the FIFO addresses into platform data for the DMA
controller is brain dead and totally the wrong thing to do.  And when
you come to moving stuff over to DT, you'll see that's even more true
there.

So don't make the mistake now.  Do things sensibly and follow the DMA
engine API.  Arrange for all your drivers to call DMA_SLAVE_CONFIG
with the address of the FIFO.
