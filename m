From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Sun, 25 Apr 2010 15:25:16 -0500
Subject: [spi-devel-general] [PATCH v4 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
In-Reply-To: <m2l56d259a01004250238s99d6c869s1ee084b36f9736a0@mail.gmail.com>
References: <e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BE26@AUSP01VMBX24.collaborationhost.net>
	<20100421104651.GO19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
	<20100422175503.GE26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9410F0@AUSP01VMBX24.collaborationhost.net>
	<20100423052003.GF26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9419BC@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B0270842697636D9B794A@AUSP01VMBX24.collaborationhost.net>
	<y2x56d259a01004250229he9cb2ee3pf69669c9226f80fb@mail.gmail.com>
	<m2l56d259a01004250238s99d6c869s1ee084b36f9736a0@mail.gmail.com>
Message-ID: <0D753D10438DA54287A00B0270842697636D9B7E66@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, April 25, 2010 2:39 AM, Martin Guy wrote:
>
> Sorry about the incomplete message. Finger trouble.
>
> On 4/25/10, Martin Guy <martinwguy@gmail.com> wrote:
> ...
>>  SFRMOUT will have gone high:
>
>>         if (espi->tx  >0 && espi->tx < t->len
>>               && !(ep93xx_spi_read_u16(espi, SSPSR) & SSPSR_BSY)) {
>>                 /* More to transmit but device has gone idle means that
>>                  * SFRMOUT will have gone high */
>>                 printk("ep93xx-spi: Underrun\n");
>>         }
>
> I've also done a version that doesn't printk() in the middle of it,
> which affects timing, but counts the underruns and reports at end of
> transfer. The result is that every 512-byte block underruns at least
> once, sometimes twice.

I haven't actually looked for the underrun by checking the SSPSR_BSY
bit but my guess is actually underruns a lot more than that.  Depends
on where you are doing the check above on if you actually see it.

During the 512+2+1 message that is sent when the mmc_spi driver is
doing a block read, the 512 byte transfer goes like this:

1) 8 writes, prime the tx fifo
	SFRMOUT asserts when the first bit of the first byte starts 
	transmitting
2) Interrupt
3) 8 reads, we must have emptied the tx fifo and filled the rx fifo
	SFRMOUT de-asserts after the the last bit of the last byte is
	received
4) 8 writes, fifo's are empty so we re-fill them
	SFRMOUT asserts when the first bit of the first byte starts 
	transmitting
5) end of interupt
6) go back to 2

Basically, anytime the espi->fifo_level == 8 and we can do an 8 byte
read you have to assume that the SFRMOUT signal has already been de-
asserted.

This matches what I am seeing with the logic analyzer.

I have modifed my board so that I now have an external GPIO for the chip
select.  That chip select goes low then shortly after, the SFRMOUT signal
goes low and 8 bytes are pumped out then SFRMOUT goes back high.  A bit 
later the interrupt happens, indicated by another GPIO I toggle in the
interrupt routine.  Right before the interrupt ends I again see SFRMOUT
go low and 8 more bytes are pumped out.  The interrupt actually completes
before the data is all pumped out.  But again SFRMOUT gets de-asserted
before the next interrupt occurs.  This keeps happening until all the
data in the message is finally transferred, at which point the external
GPIO chip select is finally de-asserted.

> I'll run a few more tests, e.g. dropping the clock rate, but at this
> point I'd be inclined to declare it impossible to keep SFRMOUT low
> during a transfer, and just use the simple non-continuous code with a
> comment at the top of the file that explains why you can't use SFRMOUT
> as a chip select for devices that require CS to remain asserted for
> the duration of a transfer.

With a slow enough clock you can probably get to a point where SFRMOUT
will stay deasserted during the entire 512 byte transfer.  But it would
still de-assert during the switch to the next transfer in the message.

Regardless, I tend to agree with you.  Because of the chip design, it's
impossible (or at least you can't guarantee) to keep the SFRMOUT low
during a transfer.  Some devices can live with this others can't.  Oh well.

A Documentation/spi/ep93xx_spi.txt really should be created to note this
limitation as well as showing an example of the platform support needed to
use this driver.

Regards,
Hartley
