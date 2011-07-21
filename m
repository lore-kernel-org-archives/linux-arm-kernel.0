From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 12:29:20 +0100
Subject: [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <CABb+yY2obv5JMBiRSXS-4tSCYX+7nVVaA0Q7gurA+NndrGVuvA@mail.gmail.com>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
	<1311158773-30314-3-git-send-email-boojin.kim@samsung.com>
	<CABb+yY2_XKyCr2mEzqd0bCYJk3U7+sg8Xz4b4ma2KB1BconYOw@mail.gmail.com>
	<20110721081138.GL26574@n2100.arm.linux.org.uk>
	<CABb+yY2obv5JMBiRSXS-4tSCYX+7nVVaA0Q7gurA+NndrGVuvA@mail.gmail.com>
Message-ID: <20110721112920.GM26574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 02:44:28PM +0530, Jassi Brar wrote:
> On Thu, Jul 21, 2011 at 1:41 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jul 21, 2011 at 12:47:49AM +0530, Jassi Brar wrote:
> >> On Wed, Jul 20, 2011 at 4:16 PM, Boojin Kim <boojin.kim@samsung.com> wrote:
> >> > + ? ? ? ? ? ? ? if (slave_config->direction == DMA_TO_DEVICE) {
> >> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->dst_addr)
> >> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->fifo_addr = slave_config->dst_addr;
> >> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->dst_addr_width)
> >> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->burst_sz = __ffs(slave_config->dst_addr_width);
> >> > + ? ? ? ? ? ? ? } else if (slave_config->direction == DMA_FROM_DEVICE) {
> >> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->src_addr)
> >> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->fifo_addr = slave_config->src_addr;
> >> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->src_addr_width)
> >> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->burst_sz = __ffs(slave_config->src_addr_width);
> >> > + ? ? ? ? ? ? ? }
> >> PL330 has fixed channels to peripherals.
> >> So FIFO addresses(burst_sz too?) should already be set via platform data.
> >> Client drivers shouldn't bother.
> >
> > That's utter crap, and isn't what the DMA engine API is about.
> >
> > The above looks correctly implemented. ?Slave DMA engine users are
> > supposed to supply the device DMA register address via this
> > DMA_SLAVE_CONFIG call. ?Doing this via platform data for the DMA
> > device is braindead.
> 
> Rather than have 32 client drivers expect fifo_address from the
> platform and then
> provide to the DMAC, IMHO it is better for a single driver(DMAC) to
> get 32 addresses
> from the platform.
> Esp when the DMAC driver already expect similar h/w parameter -- *direction*.

Conversely, when a platform doesn't know where the FIFOs are because
they're located inside the actual devices, and the device driver does,
then it makes much more sense for the device driver to provide the
DMA engine with the bus address of that.

Does your hardware have a hardware block from the device itself containing
all the systems FIFOs ?

> I don't understand why is 'fifo_address' a property much different
> than 'direction' of the channel ?

Some channels can do memory-to-peripheral and peripheral-to-memory
transfers.  Some peripherals provide a single set of DMA request/ack
lines to perform this function.  Some peripherals have different
addresses for the TX and RX FIFOs within the device.

> If a channel is flexible enough to change it's 'fifo_address', most
> probably it could also change direction of transfers.

There are DMA engines and setups where that's true.

>  So, why do we want to take seriously 'fifo_address' provided by the
> client drivers and not the 'direction' ?

The direction in the DMA slave config call I believe to be an annoying
overdesign which shouldn't be there - the DMA slave config call should
configure the DMA channel for the peripherals characteristics.

The actual channel direction should be setup at preparation time along
with the DMA buffer mapping etc.
