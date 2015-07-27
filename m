From: marex@denx.de (Marek Vasut)
Date: Mon, 27 Jul 2015 19:43:32 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <CAOMqctTsA5ZxBWFTzirqhQBoR2sO6B+uMFXWMHuSVb_EygCDvw@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <201507241034.15406.marex@denx.de>
 <CAOMqctTsA5ZxBWFTzirqhQBoR2sO6B+uMFXWMHuSVb_EygCDvw@mail.gmail.com>
Message-ID: <201507271943.32453.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 27, 2015 at 11:46:25 AM, Michal Suchanek wrote:
> On 24 July 2015 at 10:34, Marek Vasut <marex@denx.de> wrote:
> > On Thursday, July 23, 2015 at 07:03:47 PM, Michal Suchanek wrote:
> > 
> > Hi!
> > 
> > [...]
> > 
> >> >>> It's probably slower to set up DMA for 2-byte commands but it might
> >> >>> work nonetheless.
> >> >> 
> >> >> It is, the overhead will be considerable. It might help the stability
> >> >> though. I'm really looking forward to the results!
> >> > 
> >> > Hello,
> >> > 
> >> > this does not quite work.
> >> > 
> >> > My test with spidev:
> >> > 
> >> > # ./spinor /dev/spidev1.0
> >> > Sending 9f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> > Received 00 ff c8 60 16 c8 60 16 c8 60 16 c8 60 16 c8 60
> >> > Sending 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> > Received 00 ff ff ff ff c8 15 c8 15 c8 15 c8 15 c8 15 c8
> >> > Sending 9f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> > Received 00 ff c8 60 16 c8 60 16 c8 60 16 c8 60 16 c8 60
> >> > 
> >> > I receive correct ID but spi-nor complains it does not know ID 00 c8
> >> > 60. IIRC garbage should be sent only at the time command is
> >> > transferred so only one byte of garbage should be received. Also the
> >> > garbage tends to be the last state of the data output - all 0 or all
> >> > 1.
> >> > So it seems using DMA for all transfers including 1-byte commands
> >> > results in (some?) received data getting an extra 00 prefix.
> >> > 
> >> > 
> >> > I also managed to lock up the controller completely since there is
> >> > some error passing the SPI speed somewhere :(
> >> > 
> >> > [ 1352.977530] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max
> >> > --> 0 [ 1352.977540] spidev spi1.0: spi mode 0
> >> > [ 1352.977576] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max
> >> > --> 0 [ 1352.977582] spidev spi1.0: msb first
> >> > [ 1352.977614] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max
> >> > --> 0 [ 1352.977620] spidev spi1.0: 0 bits per word
> >> > [ 1352.977652] spidev spi1.0: setup mode 0, 8 bits/w, 2690588672 Hz
> >> > max --> 0 [ 1352.977726] spi_master spi1: s3c64xx_spi_config:
> >> > clk_from_cmu 1 src_clk sclk_spi1 mode bpw 8
> >> > [ 1352.977753] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: xfer
> >> > bpw 8 speed -1604378624
> >> > [ 1352.977760] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
> >> > src_clk sclk_spi1 mode bpw 8
> >> > [ 1352.977781] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: using
> >> > dma [ 1352.977797] dma-pl330 121b0000.pdma: setting up request on
> >> > thread 1
> >> 
> >> Hmm, on a second thought it probably works as expected more or less.
> >> 
> >> The nonsensical value was passed from application and there is no
> >> guard against that.
> >> 
> >> Since I don't do PIO the controller remains locked up indefinitely.
> > 
> > I have to admit, I don't quite understand the above. I also don't quite
> > know what your spidev test does. Can you possibly just bind a regular
> > SPI NOR driver and run mtdtests to see if it is stable ?
> 
> Ok, so here is some summary.
> 
> I have a NOR flash attached to a s3c64xx SPI controller with 64byte
> fifo and a pl330 dma controller.
> 
> Normally DMA controller is used for transfers that do not fit into the
> FIFO.
> 
> I tried adding the flash memory ID to the spi-nor driver table and
> adding a DT node for it.
> 
> The flash is rated at 120MHz so I used that speed but the ID was
> bit-shifted and identification failed. There is DT property
> samsung,spi-feedback-delay for addressing this and at 120MHz it must
> be 2 or 3 on this board. 40MHz works with default value 0.
> 
> The next step after identification worked was to try reading the flash
> content. For this the DMA controller is used because data is
> transferred in blocks larger than 64 bytes. When reading the whole 4MB
> flash the transfer failed silently. I got a 4MB file of all ones or
> all zeroes.
> 
> It turns out that
> 
>  - the pl330 locks up when transfering large amount of data.
> Specifically, the maximum power of 2 sized transfer at 120MHz is 128
> bytes and 64k at 40MHz. Transferring more than this results in the
> pl330 locking up and never signalling completion of the transfer.

Hypothesis:
I think this might just be that the controller didn't catch all the
inbound clock ticks and thus counted less inbound data than it was
set up to receive. The controller thus waits for more data.

> Data
> is left in FIFO which causes subsequent commands to fail since garbage
> is returned instead of command reply. Also subsequent read may cause
> I/O error or or return an empty page depending on the garbage around.

So the driver for the DMA controller might need to be augmented to handle
this case -- add a timeout and in case DMA times out, drain the FIFO to
make sure subsequent transfers do not fail.

> - the I/O errors are not checked in spi-nor at all which leads to
> silent data corruption.
> 
> On a suggestion that this may improve reliability I changed the
> s3c64xx driver to use DMA for all transfers. This caused
> identification to fail in spin-nor because the ID was prefixed with
> extra 00  byte. Testing with spidev confirmed that everything is
> prefixed with extra 00.

The determinism of this is in fact excellent news.

> Also when the DMA controller locked up no
> transfers were possible anymore. When DMA was not used for sending
> commands the controller would recover on next command. I made the
> option to always use DMA configurable and it turns out that the
> returned data is prefixed with 00 only when no transfer without DMA
> was ever made. Loading the spi-nor driver with the dma-only option off
> and then with dma-only option on results in correct operation. Only
> loading the dma-only driver first causes the 00 prefix.

Can we conclude that the PIO codepath somehow programs a register somewhere
which gets rid of this 0x00 prefix ? If so, this should then also be part
of the DMA codepath, or even better, this should be set in probe() somewhere.
