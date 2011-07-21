From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 21 Jul 2011 20:42:40 +0530
Subject: [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <20110721112920.GM26574@n2100.arm.linux.org.uk>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
	<1311158773-30314-3-git-send-email-boojin.kim@samsung.com>
	<CABb+yY2_XKyCr2mEzqd0bCYJk3U7+sg8Xz4b4ma2KB1BconYOw@mail.gmail.com>
	<20110721081138.GL26574@n2100.arm.linux.org.uk>
	<CABb+yY2obv5JMBiRSXS-4tSCYX+7nVVaA0Q7gurA+NndrGVuvA@mail.gmail.com>
	<20110721112920.GM26574@n2100.arm.linux.org.uk>
Message-ID: <CABb+yY2p8VNSvhv+LjoYnunrYS8+3+841bKM-4aUsg5vNx=Mig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 4:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> >> PL330 has fixed channels to peripherals.
>> >> So FIFO addresses(burst_sz too?) should already be set via platform data.
>> >> Client drivers shouldn't bother.
>> >
>> > That's utter crap, and isn't what the DMA engine API is about.
>> >
>> > The above looks correctly implemented. ?Slave DMA engine users are
>> > supposed to supply the device DMA register address via this
>> > DMA_SLAVE_CONFIG call. ?Doing this via platform data for the DMA
>> > device is braindead.
>>
>> Rather than have 32 client drivers expect fifo_address from the
>> platform and then
>> provide to the DMAC, IMHO it is better for a single driver(DMAC) to
>> get 32 addresses
>> from the platform.
>> Esp when the DMAC driver already expect similar h/w parameter -- *direction*.
>
> Conversely, when a platform doesn't know where the FIFOs are because
> they're located inside the actual devices, and the device driver does,
> then it makes much more sense for the device driver to provide the
> DMA engine with the bus address of that.
Yes, that is a case to consider.
Perhaps we already do something like that while setting i2c addresses
of attached devices in board files... and similarly it might be possible for the
developer to know what the fifo address is going to be after the device
is up and running esp when it is interfaced with an internal component
like DMA.

>
> Does your hardware have a hardware block from the device itself containing
> all the systems FIFOs ?
I am not sure what you ask, but let me say what I know.
In this case atleast, all PL330 DMA channels have fixed source/destination
address on the device side. So it's not like developer doesn't know
fifo_addr here.


>> I don't understand why is 'fifo_address' a property much different
>> than 'direction' of the channel ?
>
> Some channels can do memory-to-peripheral and peripheral-to-memory
> transfers. ?Some peripherals provide a single set of DMA request/ack
> lines to perform this function. ?Some peripherals have different
> addresses for the TX and RX FIFOs within the device.
Likewise we had something like that for I2S IP of S3C2440(or A0 ?)
a single fifo address shared by TX and RX channel.
Depending if it's full/half duplex capable we can have both or one
'virtual' channel active at a time.

>
>> If a channel is flexible enough to change it's 'fifo_address', most
>> probably it could also change direction of transfers.
>
> There are DMA engines and setups where that's true.
Of course, and I think this 'runtime' configuration should be done
only for such cases.

thnx
