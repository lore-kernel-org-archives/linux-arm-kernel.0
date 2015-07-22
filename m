From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 22 Jul 2015 10:18:04 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <201507220958.00231.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com>
 <201507220933.19752.marex@denx.de>
 <CAOMqctTmRy0gOchdUQ+VnoV-oJz0v9NpUPLi1pxO_O9QrLXsZA@mail.gmail.com>
 <201507220958.00231.marex@denx.de>
Message-ID: <CAOMqctQ13JE+GHyj+hU4XL3Uz4+Yt_X6BFU=NO8jXcpRtzMyzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2015 at 09:58, Marek Vasut <marex@denx.de> wrote:
> On Wednesday, July 22, 2015 at 09:45:27 AM, Michal Suchanek wrote:
>> On 22 July 2015 at 09:33, Marek Vasut <marex@denx.de> wrote:
>> > On Wednesday, July 22, 2015 at 09:30:54 AM, Michal Suchanek wrote:
>> >> On 22 July 2015 at 06:49, Vinod Koul <vinod.koul@intel.com> wrote:
>> >> > On Tue, Jul 21, 2015 at 10:14:11AM +0200, Michal Suchanek wrote:
>> >> >> > Or alternatively we could publish the limitations of the channel
>> >> >> > using capabilities so SPI knows I have a dmaengine channel and it
>> >> >> > can transfer max N length transfers so would be able to break
>> >> >> > rather than guessing it or coding in DT. Yes it may come from DT
>> >> >> > but that should be dmaengine driver rather than client driver :)
>> >> >> >
>> >> >> > This can be done by dma_get_slave_caps(chan, &caps)
>> >> >> >
>> >> >> > And we add max_length as one more parameter to existing set
>> >> >> >
>> >> >> > Also all this could be handled in generic SPI-dmaengine layer so
>> >> >> > that individual drivers don't have to code it in
>> >> >> >
>> >> >> > Let me know if this idea is okay, I can push the dmaengine bits...
>> >> >>
>> >> >> It would be ok if there was a fixed limit. However, the limit depends
>> >> >> on SPI slave settings. Presumably for other buses using the dmaengine
>> >> >> the limit would depend on the bus or slave settings as well. I do not
>> >> >> see a sane way of passing this all the way to the dmaengine driver.
>> >> >
>> >> > I don't see why this should be client (SPI) dependent. The max length
>> >> > supported is a dmaengine constraint, typically flowing from max
>> >> > blocks/length it can transfer. Know this limit can allow clients to
>> >> > split transfers.
>> >>
>> >> In practice on the board I have the maximum transfer length before it
>> >> fails depends on SPI bus speed which is set up per slave. I did not
>> >> try searching the space of possible settings thorougly and settled for
>> >> a setting that gives reasonable speed and transfer length.
>> >
>> > This looks more like a signal integrity issue though.
>>
>> It certainly does on the surface. However, when wrong data is
>> delivered over the SPI bus (such as when I use wrong phase setting)
>> the SPI controller happily delivers wrong data over PIO.
>>
>> The failure I am seeing is that the pl330 DMA program which repeatedly
>> waits for data from the SPI controller never finishes the read loop
>> and does not signal the interrupt. It seems it also leaves some data
>> in a FIFO somewhere so next command on the flash returns garbage and
>> fails.
>
> I observed something similar on MXS (mx28) SPI block. Do you use mixed
> PIO/DMA mode perhaps ?

The SPI driver uses PIO for short transfers and DMA for transfers
longer than the controller FIFO. This seems to be the standard way to
do things.It works flawlessly so long as submitting overly long DMA
programs is avoided.

> Do you have the option to connect a bus analyzer?
> I can probably offer you some tools, I'm in Prague ...

The flash chip is accessible when removing the bottom cover. It is
VSOP8 package slightly lower than SOP8 so attaching clips to it might
be a bit problematic. That's the only accessible part. Everything
other than SPI is inside the SoC.

Since SPI has no verification whatsoever the chip might be completely
dead and you can still read fine all zeroes or all ones when
attempting a read from it. I observed this behaviour when I used a
flash chip in a socket and it was not firmly seated. It was with a
different SPI controller, though.

Thanks

Michal
