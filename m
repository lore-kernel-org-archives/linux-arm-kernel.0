From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 23 Apr 2010 18:01:03 -0500
Subject: [spi-devel-general] [PATCH v4 1/2] spi: implemented driver for
	Cirrus EP93xx SPI	controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D9419BC@AUSP01VMBX24.collaborationhost.net>
References: <e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BCCC@AUSP01VMBX24.collaborationhost.net>
	<z2h56d259a01004201654y93f6c533j11b5accd7e2f46e7@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BDD8@AUSP01VMBX24.collaborationhost.net>
	<n2u56d259a01004201810j22c17bcfn9fee59e9c65c4d7f@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BE26@AUSP01VMBX24.collaborationhost.net>
	<20100421104651.GO19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
	<20100422175503.GE26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9410F0@AUSP01VMBX24.collaborationhost.net>
	<20100423052003.GF26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9419BC@AUSP01VMBX24.collaborationhost.net>
Message-ID: <0D753D10438DA54287A00B0270842697636D9B794A@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 23, 2010 10:24 AM, H Hartley Sweeten wrote:
> I was able to hack your driver to keep the continuous transfer going in a
> multi-transaction message.  Unfortunately I don't have an easy way to
> generate a diff to send the necessary patch.  The hack does work with the
> sst25l driver.  It correctly detects the end of the first 4 byte transfer
> and immediately chains in the second 2 byte transfer.  It ends up looking
> like this:

Sorry for the length of this message.  I want to give as much detail as
possible so hopefully someone has an idea on this... ;-)


I modified my hack a bit so that the message transactions are dumped at
the end of all transactions in the message.  I'm using Mika's hack to
determine if the message could be continuous then displaying a debug
about the message.  By setting the 'continuous' flag to false right after
that it disables my hack to make the transaction continuous so the
message gets processed in the normal fashion.

The debug output decodes as:
  S   a transfer specific setting was made (in ep93xx_spi_process_transfer)
      NOTE: I have never actually seen this happen.
  +   start of a transfer (in ep93xx_spi_process_fransfer).
  -   end of a transfer (in ep93xx_spi_process_fransfer).
  I   entered ep93xx_spi_interrupt
  I   exited ep93xx_spi_interrupt
  C   chained to the next transfer in a continuous transaction
  nR  the n number of fifo reads (in ep93xx_spi_read_write) or just 'R' if
      only 1 byte is read; !8R if more than 8 reads were done (should never
      happen).
  nW  the n number of fifo writes (in ep93xx_spi_read_write) or just 'W' if
      only 1 byte is written; !8W if more than 8 writes were done (should 
      never happen).
  nw  the n number of fifo writes from the next transfer (in 
      ep93xx_spi_read_write) or just 'w' if only 1 byte is written; !8w if
      more than 8 writes were done (should never happen).  NOTE: this only
      occurs with doing a continuous transaction.
  F   the transfer is complete ((espi->rx == t->len) in ep93xx_spi_read_write)


For the sst25l driver, with continuous transactions disabled, I get this for
the Read-ID command (this is with SPI_DEBUG and MMC_DEBUG enabled):

spi spi0.0: setup mode 3, 8 bits/w, 20000000 Hz max --> 0
ep93xx-spi ep93xx-spi.0: 2 part continuous transaction (6 bytes) for sst25l
ep93xx-spi ep93xx-spi.0: Done: +4WI4RFi-+2WI2RFi-
sst25l spi0.0: sst25lf040a (512 KiB)
Creating 3 MTD partitions on "SPI Flash":
0x000000000000-0x000000001000 : "SPI bootstrap"
0x000000001000-0x000000002000 : "Bootstrap config"
0x000000002000-0x000000080000 : "unallocated"
ep93xx-spi ep93xx-spi.0: registered child spi0.0

With continuous transactions enabled its:

spi spi0.0: setup mode 3, 8 bits/w, 20000000 Hz max --> 0
ep93xx-spi ep93xx-spi.0: 2 part continuous transaction (6 bytes) for sst25l
ep93xx-spi ep93xx-spi.0: Done: 4W2wI4RFC2RFi
sst25l spi0.0: sst25lf040a (512 KiB)
Creating 3 MTD partitions on "SPI Flash":
0x000000000000-0x000000001000 : "SPI bootstrap"
0x000000001000-0x000000002000 : "Bootstrap config"
0x000000002000-0x000000080000 : "unallocated"
ep93xx-spi ep93xx-spi.0: registered child spi0.0

The '+' and '-' are missing since the transfer is started in ep93xx_spi_process_messange
and then handed off to the interrupt routine without first calling ep93xx_spi_process_transfer.
You can see the 2 bytes of the second transfer getting chained to the first 4 bytes
during the priming of the fifo.  Then after the interrupt the first 4 reads finish
the first transaction.  The next transaction is then chained in and also finishes
(2 reads) then the interrupt completes.  Message done!

With the mmc_spi driver the output is WAY to long to post. But, with continuous
transactions disabled the card works fine.  With continuous transactions enabled
it doesn't for some reason.

I have looked over the output a number of times and it appears the continuous transfer
works correctly.  There are 3 that happen when the mmc_spi driver has the spi clock
set to 400000 Hz max, I believe this is while the upper layers are detecting/configuring
the card.  One happens after a CMD10 and is a "mmc_spi: read block, 16 bytes" and is a
16+2 byte message.  This is followed by a CMD9 then another "mmc_spi: read block, 16 bytes"
which is another 16+2 byte message.  Then there is a CMD55 and a CMD51.  The CMD51 does
a 9 byte message then a 1 byte message followed by a "mmc_spi: read block, 8 bytes".
That's followed by 4 separate 1 byte messages then an 8+2 byte message.  All of these
n+m messages appear to work fine as a continuous transfer.

Shortly after this the following is output:

mmc0: new SD card on SPI
mmcblk0: mmc0:0000 S064B 60.6 MiB (ro)
 mmcblk0:

Right after that there is a CMD18.  I think this is where the upper layer is trying to
read the partition table.  This is where it getting interesting compared to the non-
continuous transfer.

mmcblk0: mmc0:0000 S064B 60.6 MiB (ro)
 mmcblk0:
mmc0: starting CMD18 arg 00000000 flags 000000b5
mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 10000
mmc0:     CMD12 arg 00000000 flags 0000049d
mmc_spi spi0.1:   mmc_spi: CMD18, resp R1
ep93xx-spi ep93xx-spi.0: 1 part transaction (9 bytes) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +8WI8RWiIRFi-
ep93xx-spi ep93xx-spi.0: 1 part transaction (1 byte) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +WIRFi-
mmc_spi spi0.1:     mmc_spi: read block, 512 bytes
ep93xx-spi ep93xx-spi.0: 1 part transaction (1 byte) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +WIRFi-
ep93xx-spi ep93xx-spi.0: 1 part transaction (1 byte) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +WIRFi-
ep93xx-spi ep93xx-spi.0: 1 part transaction (1 byte) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +WIRFi-
ep93xx-spi ep93xx-spi.0: 1 part transaction (1 byte) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +WIRFi-
ep93xx-spi ep93xx-spi.0: 3 part continuous transaction (515 bytes) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: 8WI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
                               I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R2wFC2RwFCiIRFi
mmc_spi spi0.1:     mmc_spi: read block, 512 bytes
ep93xx-spi ep93xx-spi.0: 1 part transaction (1 byte) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +WIRFi-
ep93xx-spi ep93xx-spi.0: 1 part transaction (1 byte) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +WIRFi-
ep93xx-spi ep93xx-spi.0: 3 part continuous transaction (515 bytes) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: 8WI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8WiI8R8Wi
					 I8R2wFC2RwFCiIRFi
mmc_spi spi0.1: read - crc error: crc_val=0x0000, computed=0x8258 len=512
mmc_spi spi0.1: read status -84
mmc_spi spi0.1:   mmc_spi: CMD12, resp R1B
ep93xx-spi ep93xx-spi.0: 1 part transaction (29 bytes) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +8WI8R8WiI8R8WiI8R5WiI5RFi-
mmc_spi spi0.1: setup mode 3, 8 bits/w, 20000000 Hz max --> 0
mmc0: req done (CMD18): 0: 00000000 00000000 00000000 00000000
mmc0:     512 bytes transferred: -84
mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
mmcblk0: retrying using single block read

At this point everything just goes nuts.  There are a bunch of CMD17 then CMD13.

mmc0: starting CMD17 arg 00000000 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 10000
mmc_spi spi0.1:   mmc_spi: CMD17, resp R1
ep93xx-spi ep93xx-spi.0: 1 part transaction (9 bytes) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +8WI8RWiIRFi-
mmc_spi spi0.1:   ... CMD17 response SPI_R1: resp 0004 00000000
mmc_spi spi0.1: setup mode 3, 8 bits/w, 20000000 Hz max --> 0
mmc0: req done (CMD17): -38: 00000004 00000000 00000000 00000000
mmc0:     0 bytes transferred: 0
mmc0: starting CMD13 arg 00000000 flags 00000195
mmc_spi spi0.1:   mmc_spi: CMD13, resp R2/R5
ep93xx-spi ep93xx-spi.0: 1 part transaction (18 bytes) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +8WI8R8WiI8R2WiI2RFi-
mmc_spi spi0.1:   ... CMD13 response SPI_R2/R5: resp 0004 00000000
mmc_spi spi0.1: setup mode 3, 8 bits/w, 20000000 Hz max --> 0
mmc0: req done (CMD13): -38: 00000004 00000000 00000000 00000000
mmcblk0: error -38 sending status comand
mmcblk0: error -38 sending read/write command, response 0x4, card status 0x4
end_request: I/O error, dev mmcblk0, sector 0

The only difference appears the be the arg for CMD17 and the end_request output:

mmc0: starting CMD17 arg 00000000 flags 000000b5
...
end_request: I/O error, dev mmcblk0, sector 0
mmc0: starting CMD17 arg 00000200 flags 000000b5
...
end_request: I/O error, dev mmcblk0, sector 1
mmc0: starting CMD17 arg 00000400 flags 000000b5
...
end_request: I/O error, dev mmcblk0, sector 2
mmc0: starting CMD17 arg 00000600 flags 000000b5
...
end_request: I/O error, dev mmcblk0, sector 3
mmc0: starting CMD17 arg 00000800 flags 000000b5
...
end_request: I/O error, dev mmcblk0, sector 4
mmc0: starting CMD17 arg 00000a00 flags 000000b5
...
end_request: I/O error, dev mmcblk0, sector 5
mmc0: starting CMD17 arg 00000c00 flags 000000b5
...
end_request: I/O error, dev mmcblk0, sector 6
mmc0: starting CMD17 arg 00000e00 flags 000000b5
...
end_request: I/O error, dev mmcblk0, sector 7

Then there is a:

Buffer I/O error on device mmcblk0, logical block 0
mmc0: starting CMD18 arg 00000000 flags 000000b5
mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 10000
mmc0:     CMD12 arg 00000000 flags 0000049d
mmc_spi spi0.1:   mmc_spi: CMD18, resp R1
ep93xx-spi ep93xx-spi.0: 1 part transaction (9 bytes) for mmc_spi
ep93xx-spi ep93xx-spi.0: Done: +8WI8RWiIRFi-
mmc_spi spi0.1:   ... CMD18 response SPI_R1: resp 0004 00000000
mmc_spi spi0.1: setup mode 3, 8 bits/w, 20000000 Hz max --> 0
mmc0: req done (CMD18): -38: 00000004 00000000 00000000 00000000
mmc0:     0 bytes transferred: 0
mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
mmcblk0: retrying using single block read

Followed by all the CMD17 stuff above again.  Then it ends with:

Buffer I/O error on device mmcblk0, logical block 0
 unable to read partition table

I can't see any reason why the continuous transfer would cause a
crc error.  Even if it did I can't see why the single block reads
would all fail, all of then are composed of 1 transfer messages.

Anyone have some suggestions?

Again, sorry for the long message.

Regards,
Hartley
