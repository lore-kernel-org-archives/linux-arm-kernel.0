From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 3 Jul 2018 18:40:41 +0200
Subject: [RFC net-next 15/15] net: lora: Add Semtech SX1301
In-Reply-To: <20180703153137.GB13744@sirena.org.uk>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
 <20180703153137.GB13744@sirena.org.uk>
Message-ID: <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 03.07.2018 um 17:31 schrieb Mark Brown:
> On Tue, Jul 03, 2018 at 05:09:38PM +0200, Andreas F?rber wrote:
>> Am 03.07.2018 um 16:50 schrieb Mark Brown:
>>> A register map would work just as well here, we already have plenty of
>>> devices that abstract at this level (most obviously the I2C/SPI devices
>>> that use it to offer both interfaces with a single core driver).
> 
>> The address and data registers together form a two-byte SPI message!
> 
>> It is transmitted by writing to the CS register.
> 
>> The received data is afterwards available in another register.
> 
> Right, but it seems from the code that the hardware understands that
> it's formatting register I/O and not just shifting in and out a byte
> stream which is what a SPI controller does.  I'd not be surprised to
> learn that the register you're calling a chip select register is a
> strobe that initiates the transfer (and that this may be some of the
> difficulty you're having with handling it in the way the framework
> expects), the pattern with writing 1 followed immediately by 0 is a bit
> of a flag here.

Yeah, the current implementation assumes exactly that. :)

> I've seen such before hardware where I know it was intentionally
> designed that way so it wouldn't be totally surprising.

If we don't implement a spi_controller here, then IIUC we can't have
multiple spi_device implementations for the devices on the receiving
end, as they rely on a spi_controller for their APIs.

Do you have an alternative solution for abstraction? A regmap would seem
to require putting everything into a monolithic SX1301 driver despite
those connected chipsets actually being regular, external SPI chips that
could also be attached to non-SX1301 SPI masters.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
