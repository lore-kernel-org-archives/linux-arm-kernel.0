From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 23 Jul 2015 19:03:47 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <CAOMqctRnh2RsUYiRr2-+wucaq5NArTNrzPpqdPs+ETrFe9UrZA@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <201507221024.05496.marex@denx.de>
 <CAOMqctTyHF1ciN3-0yg1smYJ5kbuwfT_kmavTL8ARuZ69wSgAg@mail.gmail.com>
 <201507221101.56441.marex@denx.de>
 <CAOMqctRnh2RsUYiRr2-+wucaq5NArTNrzPpqdPs+ETrFe9UrZA@mail.gmail.com>
Message-ID: <CAOMqctREShUrBR=aQM2Vc6MhVezCP9rnNfUNq=m2-GH_gbYxFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 July 2015 at 18:46, Michal Suchanek <hramrach@gmail.com> wrote:
> On 22 July 2015 at 11:01, Marek Vasut <marex@denx.de> wrote:
>> On Wednesday, July 22, 2015 at 10:38:14 AM, Michal Suchanek wrote:
>>> On 22 July 2015 at 10:24, Marek Vasut <marex@denx.de> wrote:
>>> > On Wednesday, July 22, 2015 at 10:18:04 AM, Michal Suchanek wrote:
>>> >> On 22 July 2015 at 09:58, Marek Vasut <marex@denx.de> wrote:
>>> >> > On Wednesday, July 22, 2015 at 09:45:27 AM, Michal Suchanek wrote:
>>> >> >> On 22 July 2015 at 09:33, Marek Vasut <marex@denx.de> wrote:
>>> >> >> > On Wednesday, July 22, 2015 at 09:30:54 AM, Michal Suchanek wrote:
>>> >> >> >> On 22 July 2015 at 06:49, Vinod Koul <vinod.koul@intel.com> wrote:
>>> >> >> >> > On Tue, Jul 21, 2015 at 10:14:11AM +0200, Michal Suchanek wrote:
>>> >> >> >> >> > Or alternatively we could publish the limitations of the
>>> >> >> >> >> > channel using capabilities so SPI knows I have a dmaengine
>>> >> >> >> >> > channel and it can transfer max N length transfers so would
>>> >> >> >> >> > be able to break rather than guessing it or coding in DT.
>>> >> >> >> >> > Yes it may come from DT but that should be dmaengine driver
>>> >> >> >> >> > rather than client driver :)
>>> >> >> >> >> >
>>> >> >> >> >> > This can be done by dma_get_slave_caps(chan, &caps)
>>> >> >> >> >> >
>>> >> >> >> >> > And we add max_length as one more parameter to existing set
>>> >> >> >> >> >
>>> >> >> >> >> > Also all this could be handled in generic SPI-dmaengine layer
>>> >> >> >> >> > so that individual drivers don't have to code it in
>>> >> >> >> >> >
>>> >> >> >> >> > Let me know if this idea is okay, I can push the dmaengine
>>> >> >> >> >> > bits...
>>> >> >> >> >>
>>> >> >> >> >> It would be ok if there was a fixed limit. However, the limit
>>> >> >> >> >> depends on SPI slave settings. Presumably for other buses using
>>> >> >> >> >> the dmaengine the limit would depend on the bus or slave
>>> >> >> >> >> settings as well. I do not see a sane way of passing this all
>>> >> >> >> >> the way to the dmaengine driver.
>>> >> >> >> >
>>> >> >> >> > I don't see why this should be client (SPI) dependent. The max
>>> >> >> >> > length supported is a dmaengine constraint, typically flowing
>>> >> >> >> > from max blocks/length it can transfer. Know this limit can
>>> >> >> >> > allow clients to split transfers.
>>> >> >> >>
>>> >> >> >> In practice on the board I have the maximum transfer length before
>>> >> >> >> it fails depends on SPI bus speed which is set up per slave. I
>>> >> >> >> did not try searching the space of possible settings thorougly
>>> >> >> >> and settled for a setting that gives reasonable speed and
>>> >> >> >> transfer length.
>>> >> >> >
>>> >> >> > This looks more like a signal integrity issue though.
>>> >> >>
>>> >> >> It certainly does on the surface. However, when wrong data is
>>> >> >> delivered over the SPI bus (such as when I use wrong phase setting)
>>> >> >> the SPI controller happily delivers wrong data over PIO.
>>> >> >>
>>> >> >> The failure I am seeing is that the pl330 DMA program which
>>> >> >> repeatedly waits for data from the SPI controller never finishes the
>>> >> >> read loop and does not signal the interrupt. It seems it also leaves
>>> >> >> some data in a FIFO somewhere so next command on the flash returns
>>> >> >> garbage and fails.
>>> >> >
>>> >> > I observed something similar on MXS (mx28) SPI block. Do you use mixed
>>> >> > PIO/DMA mode perhaps ?
>>> >>
>>> >> The SPI driver uses PIO for short transfers and DMA for transfers
>>> >> longer than the controller FIFO. This seems to be the standard way to
>>> >> do things.It works flawlessly so long as submitting overly long DMA
>>> >> programs is avoided.
>>> >
>>> > Can you try doing JUST DMA, no PIO ? I remember seeing some bus
>>> > synchronisation issues when I did mixed PIO/DMA on the MXS and it was
>>> > nasty to track down. Just give pure DMA a go to see if the thing
>>> > stabilizes somehow.
>>>
>>> It's probably slower to set up DMA for 2-byte commands but it might
>>> work nonetheless.
>>
>> It is, the overhead will be considerable. It might help the stability
>> though. I'm really looking forward to the results!
>>
>
> Hello,
>
> this does not quite work.
>
> My test with spidev:
>
> # ./spinor /dev/spidev1.0
> Sending 9f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Received 00 ff c8 60 16 c8 60 16 c8 60 16 c8 60 16 c8 60
> Sending 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Received 00 ff ff ff ff c8 15 c8 15 c8 15 c8 15 c8 15 c8
> Sending 9f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Received 00 ff c8 60 16 c8 60 16 c8 60 16 c8 60 16 c8 60
>
> I receive correct ID but spi-nor complains it does not know ID 00 c8 60.
> IIRC garbage should be sent only at the time command is transferred so
> only one byte of garbage should be received. Also the garbage tends to
> be the last state of the data output - all 0 or all 1.
> So it seems using DMA for all transfers including 1-byte commands
> results in (some?) received data getting an extra 00 prefix.
>

> I also managed to lock up the controller completely since there is
> some error passing the SPI speed somewhere :(
>
> [ 1352.977530] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max --> 0
> [ 1352.977540] spidev spi1.0: spi mode 0
> [ 1352.977576] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max --> 0
> [ 1352.977582] spidev spi1.0: msb first
> [ 1352.977614] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max --> 0
> [ 1352.977620] spidev spi1.0: 0 bits per word
> [ 1352.977652] spidev spi1.0: setup mode 0, 8 bits/w, 2690588672 Hz max --> 0
> [ 1352.977726] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
> src_clk sclk_spi1 mode bpw 8
> [ 1352.977753] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: xfer
> bpw 8 speed -1604378624
> [ 1352.977760] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
> src_clk sclk_spi1 mode bpw 8
> [ 1352.977781] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: using dma
> [ 1352.977797] dma-pl330 121b0000.pdma: setting up request on thread 1

Hmm, on a second thought it probably works as expected more or less.

The nonsensical value was passed from application and there is no
guard against that.

Since I don't do PIO the controller remains locked up indefinitely.

Thanks

Michal
