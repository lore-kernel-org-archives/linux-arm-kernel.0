From: marex@denx.de (Marek Vasut)
Date: Fri, 24 Jul 2015 10:34:15 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <CAOMqctREShUrBR=aQM2Vc6MhVezCP9rnNfUNq=m2-GH_gbYxFw@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <CAOMqctRnh2RsUYiRr2-+wucaq5NArTNrzPpqdPs+ETrFe9UrZA@mail.gmail.com>
 <CAOMqctREShUrBR=aQM2Vc6MhVezCP9rnNfUNq=m2-GH_gbYxFw@mail.gmail.com>
Message-ID: <201507241034.15406.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 23, 2015 at 07:03:47 PM, Michal Suchanek wrote:

Hi!

[...]

> >>> It's probably slower to set up DMA for 2-byte commands but it might
> >>> work nonetheless.
> >> 
> >> It is, the overhead will be considerable. It might help the stability
> >> though. I'm really looking forward to the results!
> > 
> > Hello,
> > 
> > this does not quite work.
> > 
> > My test with spidev:
> > 
> > # ./spinor /dev/spidev1.0
> > Sending 9f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > Received 00 ff c8 60 16 c8 60 16 c8 60 16 c8 60 16 c8 60
> > Sending 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > Received 00 ff ff ff ff c8 15 c8 15 c8 15 c8 15 c8 15 c8
> > Sending 9f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > Received 00 ff c8 60 16 c8 60 16 c8 60 16 c8 60 16 c8 60
> > 
> > I receive correct ID but spi-nor complains it does not know ID 00 c8 60.
> > IIRC garbage should be sent only at the time command is transferred so
> > only one byte of garbage should be received. Also the garbage tends to
> > be the last state of the data output - all 0 or all 1.
> > So it seems using DMA for all transfers including 1-byte commands
> > results in (some?) received data getting an extra 00 prefix.
> > 
> > 
> > I also managed to lock up the controller completely since there is
> > some error passing the SPI speed somewhere :(
> > 
> > [ 1352.977530] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max -->
> > 0 [ 1352.977540] spidev spi1.0: spi mode 0
> > [ 1352.977576] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max -->
> > 0 [ 1352.977582] spidev spi1.0: msb first
> > [ 1352.977614] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max -->
> > 0 [ 1352.977620] spidev spi1.0: 0 bits per word
> > [ 1352.977652] spidev spi1.0: setup mode 0, 8 bits/w, 2690588672 Hz max
> > --> 0 [ 1352.977726] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
> > src_clk sclk_spi1 mode bpw 8
> > [ 1352.977753] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: xfer
> > bpw 8 speed -1604378624
> > [ 1352.977760] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
> > src_clk sclk_spi1 mode bpw 8
> > [ 1352.977781] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: using
> > dma [ 1352.977797] dma-pl330 121b0000.pdma: setting up request on thread
> > 1
> 
> Hmm, on a second thought it probably works as expected more or less.
> 
> The nonsensical value was passed from application and there is no
> guard against that.
> 
> Since I don't do PIO the controller remains locked up indefinitely.

I have to admit, I don't quite understand the above. I also don't quite know
what your spidev test does. Can you possibly just bind a regular SPI NOR driver 
and run mtdtests to see if it is stable ?
