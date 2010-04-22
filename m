From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 22 Apr 2010 12:39:17 -0500
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <x2g56d259a01004220728i7f07d492t4c4f63e0ef2e38d9@mail.gmail.com>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
	<20100421071629.GL19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C84DA@AUSP01VMBX24.collaborationhost.net>
	<20100421165420.GP19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8CDD@AUSP01VMBX24.collaborationhost.net>
	<x2g56d259a01004220728i7f07d492t4c4f63e0ef2e38d9@mail.gmail.com>
Message-ID: <0D753D10438DA54287A00B0270842697636D940C95@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin,

I'm replying to both of your previous messages.

On Thursday, April 22, 2010 7:28 AM, Martin Guy wrote:
> On 4/22/10, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>>  First, every spi transaction, including a single byte transfer, is
>>  going to generate at least two interrupts.  One when the interrupts
>>  are first enabled because the TX FIFO is empty.  And a second when
>>  that byte has been transferred and the TX FIFO is again empty.
>>
>>  The first interrupt can be prevented by priming the TX FIFO before
>>  enabling the interrupts.  All you need to do is call ep93xx_spi_read_write
>>  right before ep93xx_spi_enable_interrupts.
>
> Nice. That increases the data throughput from 367 to 372 kB/sec and
> reduces the CPU usage from 61 to 60.2% for large transfers

I figured "priming the fifo" before turning the transfer over to the
interrupt handler would help.

On Thursday, April 22, 2010 7:12 AM, Martin Guy wrote:
>>  Second, at high clock rates the RX FIFO will actually start to
>>  fill as you are putting data into the TX FIFO.  If you add an inner
>>  reader loop to the writer loop in ep93xx_spi_read_write you can
>>  take advantage of this and reduce the number of interrupts generated
>>  for large transfers.
>>
>>  For instance the mmc_spi driver regularly does 3 transfer messages
>>  where the last transfer is a 512 byte read.  With your current v4
>>  driver this message averages 69 interrupts to complete.  By adding
>>  the inner reader it reduces the number of interrupts to an average
>>  of 40.
>
> I assume you mean something like
>
>        /* read as long as RX FIFO has frames in it */
>        while (ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) {
>                ep93xx_do_read(espi, t);
>                espi->fifo_level--;
>        }
>
>        /* write as long as TX FIFO has room */
>        while (espi->fifo_level < SPI_FIFO_SIZE && espi->tx < t->len) {
>                ep93xx_do_write(espi, t);
>                espi->fifo_level++;
>+
>+               while (ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) {
>+                       ep93xx_do_read(espi, t);
>+                       espi->fifo_level--;
>+               }
>        }

Exactly what I did.

> Well, you're gonna love this :)
>
> I've run some timing tests on this, and it turns out to give the same
> data transfer speed but take more system CPU time: 64% instead of 60%,
> i.e it is slower.
>
> You are seeing a lower interrupt count, not because more useful work
> is being done in each interrupt, but only because the extra code in
> the inner loop makes the interrupt routine slower. Bear with me...
> 
> I'm using v4 with mika's continuity hack compiled for speed not space
> and averaging the vmstat "sy" output column over 50 seconds while
> block-reading 20 meg with dd from /dev/mmcblk0 to /dev/null using a
> fairly old Sandisk 1MB SD card and clocking at 3.7 MHz.
> All tests report 367 or 368 kB/sec; the variability of the system time
> average in successive runs is about 1%
> 
> Figures are (commas separate values from successive runs)
> v4 with Mika's hack:
>      61.9,60.2%  234724,234727 irq/MB
> with "while" reader in write loop:
>      63.4,64.5%  197772,97801 irq/MB
> with "if" reader in while loop:
>      61.9,62.5%  197845,197847  irq/MB
> with an "if" reader after the write loop:
>      66.0,67.1%  278207,277166 irq/MB
> with a "while" reader after the write loop:
>      67.0%  275000 irq/MB

I am surprised my this :-(.  I thought getting rid of the extra
interrupt context switches would help the data transfer time.  Oh well...

> Further, on a suspicion about the silliness of the per-transfer
> bits_per_word being checked right down the bottom of the lowest lever
> byte-read/writing routine instead of once per transfer, I split
> ep93xx_spi_read and _write into 8 and 16-bit variants, and checked
> t->bits_per_word once outside the read and write loops.
> 
> This gives:
>      60.0% 59.3%  285906 irq/MB

It looks like splitting the 8/16-bit read/write routines does help
with cpu usage compared to the tests above.  Was the data transfer
(kB/sec) any better?

> Note: it takes *more* interrupts to transfer a megabyte when the
> interrupt routine is more efficient!
> 
> The reason is that almost all of those interrupts happen while waiting
> for the last 4, 3, 2 or 1 bytes of a transfer to arrive in the RX
> FIFO. On this dreadful chip there is no interrupt mechanism to say
> "the TX buffer is empty and the received data has finished arriving".
> There is only "the TX buffer is half empty or less" and "the RX buffer
> is half full or more", so repeated interrupts now perform the function
> that the old busy-wait loop performed in v1.

Agree.  Kind of a pain...

> This is another good reason to unite multiple transfers into one
> continuous stream, to have less of this effective busy-waiting with
> interrupts spinning madly.

Yes.  Too bad we can't also combine multiple messages that might be in
the queue...

But, if this gets to complicated it might not be worth holding off
getting it merged, at least into linux-next or possibly into the
staging branch.  At that point it will be easier to provide patches.
I still have one hanging for Mika to expand the chip select options.

> It now occurs to me that another step in CPU efficiency could be had
> by abusing the receive-fifo-is-half-full interrupt to signal the
> completion of a transfer. This would only work for transfers of four
> or more words and would need some careful jiggery-pokery at end of
> transfer to turn the tx-fifo-is-half-empty interrupt enable off and
> ensure that exactly four words would end up in the RX FIFO.

That might work but I think it could break horribly.  The "jiggery-pokery"
could end up being pretty messy.

But, the tx-fifo-is-half-empty might be what is needed to handle the
multiple transfer merging.  We know the driver is finished transfering
the data to the fifo when (espi->tx == t->len).  At this point we are
just wating for the last (fifo_level) bytes to come in on the rx fifo,
this could be anything from 1 to 8 bytes.  If it's <= 4 the next interrupt
will be a tx-fifo-is-half-empty which is killing us trying to pull those
last bytes out of the rx fifo.  So how about something like this@the
end of ep93xx_spi_read_write:

	if (can_continue && espi->tx == t->len) {
		if (fifo_level < SPI_FIFO_SIZE/2) {
			/*
			 * Pull the next transfer out of the queue and
			 * use it to finish filling the tx fifo.  The
			 * next interrupt will complete this transfer.
			 * We then need to continue with the next transfer.
			 */
		}
	}

> It's a horrible thought, and I suspect that the DMA engine is the real answer.

The DMA engine might help but it's not here yet....

Regards,
Hartley
