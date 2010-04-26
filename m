From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 26 Apr 2010 13:02:58 +0300
Subject: [spi-devel-general] [PATCH v4 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D9B7E66@AUSP01VMBX24.collaborationhost.net>
References: <20100421104651.GO19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
	<20100422175503.GE26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9410F0@AUSP01VMBX24.collaborationhost.net>
	<20100423052003.GF26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9419BC@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B0270842697636D9B794A@AUSP01VMBX24.collaborationhost.net>
	<y2x56d259a01004250229he9cb2ee3pf69669c9226f80fb@mail.gmail.com>
	<m2l56d259a01004250238s99d6c869s1ee084b36f9736a0@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D9B7E66@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100426100258.GG26418@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I just answer to this last message as it seems that continuous
transfer is really not a 100% solid solution; It makes things more
complicated than need to be and benefit for that is probably not
worth the additional complexity. Feel free to disagree :)

On Sun, Apr 25, 2010 at 03:25:16PM -0500, H Hartley Sweeten wrote:
> On Sunday, April 25, 2010 2:39 AM, Martin Guy wrote:
> > I'll run a few more tests, e.g. dropping the clock rate, but at this
> > point I'd be inclined to declare it impossible to keep SFRMOUT low
> > during a transfer, and just use the simple non-continuous code with a
> > comment at the top of the file that explains why you can't use SFRMOUT
> > as a chip select for devices that require CS to remain asserted for
> > the duration of a transfer.
> 
> With a slow enough clock you can probably get to a point where SFRMOUT
> will stay deasserted during the entire 512 byte transfer.  But it would
> still de-assert during the switch to the next transfer in the message.
> 
> Regardless, I tend to agree with you.  Because of the chip design, it's
> impossible (or at least you can't guarantee) to keep the SFRMOUT low
> during a transfer.  Some devices can live with this others can't.  Oh well.

For the MMC over SPI at least we really cannot ever make fully
compliant solution with SFRMOUT because, during init phase protocol
sends CMD0 (reset) with chipselect active high (SPI_CS_HIGH). This
forces SD/MMC card to SPI mode. However, many cards seem to work
without any chipselect logic at all (with Sim.One for example).

> A Documentation/spi/ep93xx_spi.txt really should be created to note this
> limitation as well as showing an example of the platform support needed to
> use this driver.

Do we all agree that we can live with GPIOs as chipselect? Or do
we continue investigation to make it work with boards that use
SFRMOUT as CS?

I have following plans for v5 (in case we don't care about SFRMOUT).
Before doing the changes I would like to hear your opinnion.

	- prime the FIFO first in every transfer (Hartley's suggestion)
	- address review comments for v4
	- add Martin's patch for clearing SSPICR only if we get ROR
	- add necessary documentation under Documentation/spi/ep93xx_spi.txt

Thanks,
MW
