From: martinwguy@gmail.com (Martin Guy)
Date: Thu, 22 Apr 2010 15:11:42 +0100
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D8C8CDD@AUSP01VMBX24.collaborationhost.net>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
	<20100421071629.GL19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C84DA@AUSP01VMBX24.collaborationhost.net>
	<20100421165420.GP19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8CDD@AUSP01VMBX24.collaborationhost.net>
Message-ID: <g2t56d259a01004220711saff1b824p5f3cc76cab649a6b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/22/10, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>  I have added some debug messages to the driver trying to figure out
>  how to chain the transfers in a message together in order to keep
>  the SFRM signal asserted for the entire message.  I still haven't
>  worked out a good solution but I did notice something else.
>
>  First, every spi transaction, including a single byte transfer, is
>  going to generate at least two interrupts.  One when the interrupts
>  are first enabled because the TX FIFO is empty.  And a second when
>  that byte has been transferred and the TX FIFO is again empty.
>
>  The first interrupt can be prevented by priming the TX FIFO before
>  enabling the interrupts.  All you need to do is call ep93xx_spi_read_write
>  right before ep93xx_spi_enable_interrupts.


>  Second, at high clock rates the RX FIFO will actually start to
>  fill as you are putting data into the TX FIFO.  If you add an inner
>  reader loop to the writer loop in ep93xx_spi_read_write you can
>  take advantage of this and reduce the number of interrupts generated
>  for large transfers.
>
>  For instance the mmc_spi driver regularly does 3 transfer messages
>  where the last transfer is a 512 byte read.  With your current v4
>  driver this message averages 69 interrupts to complete.  By adding
>  the inner reader it reduces the number of interrupts to an average
>  of 40.

I assume you mean something like

        /* read as long as RX FIFO has frames in it */
        while (ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) {
                ep93xx_do_read(espi, t);
                espi->fifo_level--;
        }

        /* write as long as TX FIFO has room */
        while (espi->fifo_level < SPI_FIFO_SIZE && espi->tx < t->len) {
                ep93xx_do_write(espi, t);
                espi->fifo_level++;
+
+               while (ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) {
+                       ep93xx_do_read(espi, t);
+                       espi->fifo_level--;
+               }
        }

Well, you're gonna love this :)

I've run some timing tests on this, and it turns out to give the same
data transfer speed but take more system CPU time: 64% instead of 60%,
i.e it is slower.

You are seeing a lower interrupt count, not because more useful work
is being done in each interrupt, but only because the extra code in
the inner loop makes the interrupt routine slower. Bear with me...

I'm using v4 with mika's continuity hack compiled for speed not space
and averaging the vmstat "sy" output column over 50 seconds while
block-reading 20 meg with dd from /dev/mmcblk0 to /dev/null using a
fairly old Sandisk 1MB SD card and clocking at 3.7 MHz.
All tests report 367 or 368 kB/sec; the variability of the system time
average in successive runs is about 1%

Figures are (commas separate values from successive runs)
v4 with Mika's hack:
     61.9,60.2%  234724,234727 irq/MB
with "while" reader in write loop:
     63.4,64.5%  197772,97801 irq/MB
with "if" reader in while loop:
     61.9,62.5%  197845,197847  irq/MB
with an "if" reader after the write loop:
     66.0,67.1%  278207,277166 irq/MB
with a "while" reader after the write loop:
     67.0%  275000 irq/MB

Further, on a suspicion about the silliness of the per-transfer
bits_per_word being checked right down the bottom of the lowest lever
byte-read/writing routine instead of once per transfer, I split
ep93xx_spi_read and _write into 8 and 16-bit variants, and checked
t->bits_per_word once outside the read and write loops.

This gives:
     60.0% 59.3%  285906 irq/MB

Note: it takes *more* interrupts to transfer a megabyte when the
interrupt routine is more efficient!

The reason is that almost all of those interrupts happen while waiting
for the last 4, 3, 2 or 1 bytes of a transfer to arrive in the RX
FIFO. On this dreadful chip there is no interrupt mechanism to say
"the TX buffer is empty and the received data has finished arriving".
There is only "the TX buffer is half empty or less" and "the RX buffer
is half full or more", so repeated interrupts now perform the function
that the old busy-wait loop performed in v1.

This is another good reason to unite multiple transfers into one
continuous stream, to have less of this effective busy-waiting with
interrupts spinning madly.

It now occurs to me that another step in CPU efficiency could be had
by abusing the receive-fifo-is-half-full interrupt to signal the
completion of a transfer. This would only work for transfers of four
or more words and would need some careful jiggery-pokery at end of
transfer to turn the tx-fifo-is-half-empty interrupt enable off and
ensure that exactly four words would end up in the RX FIFO.
It's a horrible thought, and I suspect that the DMA engine is the real answer.

   M
