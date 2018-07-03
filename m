From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Jul 2018 16:31:37 +0100
Subject: [RFC net-next 15/15] net: lora: Add Semtech SX1301
In-Reply-To: <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
Message-ID: <20180703153137.GB13744@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 05:09:38PM +0200, Andreas F?rber wrote:
> Am 03.07.2018 um 16:50 schrieb Mark Brown:

> >> 2) This SPI device is in turn exposing the two SPI masters that you
> >> already found below, and I didn't see a sane way to split that code out
> >> into drivers/spi/, so it's in drivers/net/lora/ here - has there been
> >> any precedence either way?

> > A MFD?

> I know of mfd, but how would the the the net vs. spi pieces interact
> then? Some functions would need to be exported then or is there an
> easier way without needing to set a cross-module API in stone?

It's an in-kernel ABI it's not exactly set in stone but yeah, you'll
need some interface.  A lot of devices work by having the children know
that they're part of a MFD and fish things out of the parent device,
either the pdata or (in the common case where the MFD bit mostly just
instantiates subdevices and holds a regmap) with dev_get_regmap().

> > A register map would work just as well here, we already have plenty of
> > devices that abstract at this level (most obviously the I2C/SPI devices
> > that use it to offer both interfaces with a single core driver).

> The address and data registers together form a two-byte SPI message!

> It is transmitted by writing to the CS register.

> The received data is afterwards available in another register.

Right, but it seems from the code that the hardware understands that
it's formatting register I/O and not just shifting in and out a byte
stream which is what a SPI controller does.  I'd not be surprised to
learn that the register you're calling a chip select register is a
strobe that initiates the transfer (and that this may be some of the
difficulty you're having with handling it in the way the framework
expects), the pattern with writing 1 followed immediately by 0 is a bit
of a flag here.

I've seen such before hardware where I know it was intentionally
designed that way so it wouldn't be totally surprising.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180703/dd8f2013/attachment.sig>
