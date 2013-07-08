From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Jul 2013 09:34:26 +0100
Subject: MTD EEPROM support and driver integration
In-Reply-To: <8997501.Dchyii8uWX@wuerfel>
References: <20130705201118.GM2959@lukather> <5811519.oHVuMujf0I@wuerfel>
 <20130706120112.GA11069@lukather> <8997501.Dchyii8uWX@wuerfel>
Message-ID: <20130708083426.GO27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 06, 2013 at 09:06:49PM +0200, Arnd Bergmann wrote:
> On Saturday 06 July 2013 14:01:12 Maxime Ripard wrote:

> > > > > a) like interrupts, regs, dmas, clocks, pinctrl, reset, pwm: fixed property names

> > > > >       regmap = <&at25 0xstart 0xlen>;
> > > > >       regmap-names = "mac-address";

> > > > > b) like gpio, regulator: variable property names

> > > > >       mac-storage = <&at25 0xstart 0xlen>;

> > > > > It's unfortunate that we already have examples of both. They are largely
> > > > > equivalent, but the tendency is towards the first.

> > > > I don't have a strong feeling for one against another, so whatever works
> > > > best. Both solutions will be a huge improvement anyway 

> > > > Just out of curiosity, is there any advantages besides having a fixed
> > > > property name to the first solution?

> > > I think it's mostly for consistency: trying to get most subsystems to
> > > do it the same way to make it easier for people to write dts files.

> > > A lesser point is that it simplifies the driver code if you don't
> > > have to pass a name.

On the other hand something with human readable names is much more
legible if humans ever have to read or write the DT bindings.  This
mostly applies when there are many instances of the property (for
example, many devices have lots of power supplies) or when some
instances of the property are optional (for example, many devices can
use GPIOs for many different functions but usually not all of them are
connected and there's no particular order in which they might get
connected).

> > So that leave us with mainly one path to achieve this goal:
> >   - Add a regmap-mtd backend
> >   - Add DT parsing code for regmap
> >   - Move the EEPROM drivers from misc to mtd

> Yes, I think that would be good. For the last step, we definitely need
> buy-in from Wolfgand and Jean, as they are maintaining the current eeprom
> drivers.

I'd really like to see more discussion of this "DT parsing code for
regmap" idea...  I've missed almost all the context here.

> We also have a bunch of OTP drivers spread around the kernel, it probably
> makes sense to consolidate them at the same time, at least on the DT binding
> side if not the device drivers.

I'm not sure how viable this is, the OTP interfaces aren't that
consistent and are frequently embedded in random PMICs or whatever.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/b9a08d28/attachment.sig>
