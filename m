From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Dec 2016 11:40:51 +0000
Subject: [PATCH linux v1 4/4] arm: dts: Add dt-binding to support seven
 segment display on zaius
In-Reply-To: <20161214110635.GB14217@n2100.armlinux.org.uk>
References: <1481702104-8617-1-git-send-email-jaghu@google.com>
 <1481702104-8617-5-git-send-email-jaghu@google.com>
 <3917905.e4iOqADnVQ@wuerfel> <10697525.O7CkPN6Gfl@wuerfel>
 <20161214110635.GB14217@n2100.armlinux.org.uk>
Message-ID: <20161214114051.GC14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 11:06:35AM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 14, 2016 at 10:00:46AM +0100, Arnd Bergmann wrote:
> > On Wednesday, December 14, 2016 9:55:47 AM CET Arnd Bergmann wrote:
> > > According to your introductory mail, the interface is assumed to be
> > > a 74HC164. Should we use that ID in the compatible string?
> > > 
> > > We can always add other strings later if we want to support multiple
> > > wire formats.
> > 
> > Actually, looking up 74hc164, that seems to be a gpio expander,
> > so maybe a more flexible way to do the same is to put a driver
> > for the expander into drivers/gpio/ and have the main driver
> > access the outputs of that using the gpiolib interface.
> 
> There already is - drivers/gpio/gpio-74x164.c

Looking at this more, it's a SPI driver, presumably because the first
case where it appeared was on a SPI bus.

However, it's not a SPI device as such, it's a piece of standard,
general purpose logic that's been around for many years, pre-dating
the SPI bus.

Now, as for DT, we have this "DT represents the hardware, not the
implementation" edict, which now brings up an interesting problem.

If we want to use this driver in its existing form, we need to:

- declare in DT a spi-gpio driver to provide a SPI bus on the GPIO
  pins connected to the 74HC164.
- attach the 74HC164 to the SPI bus.

The problem with that is it's not representative of the hardware -
what we're saying is that we want to reuse our existing implementation
and make DT conform to the implementation.  At that point, we might as
well scrap our "DT is implementation independent" edict above.

What if, tomorrow, we end up with 74HC164 connected to via a different
method?

I think a much more sensible approach would be to turn the GPIO side
of the 74x164 driver into a library, which can be re-used by multiple
bus-specific drivers - one for SPI which allows it to be used in its
current form, one for our platform bus which takes the GPIO lines for
the data, clock and clear signals.

I also don't see why they shouldn't use the same compatible - they're
the same _device_ at the end of the day, just wired up differently.
It makes the binding documentation a little fun wrt what are required
and optional properties, but nothing that shouldn't be too difficult.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
