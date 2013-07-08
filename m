From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 8 Jul 2013 22:25:38 +0200
Subject: MTD EEPROM support and driver integration
In-Reply-To: <20130708083426.GO27646@sirena.org.uk>
References: <20130705201118.GM2959@lukather> <5811519.oHVuMujf0I@wuerfel>
 <20130706120112.GA11069@lukather> <8997501.Dchyii8uWX@wuerfel>
 <20130708083426.GO27646@sirena.org.uk>
Message-ID: <20130708202538.GK11243@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 09:34:26AM +0100, Mark Brown wrote:
> On Sat, Jul 06, 2013 at 09:06:49PM +0200, Arnd Bergmann wrote:
> > On Saturday 06 July 2013 14:01:12 Maxime Ripard wrote:
> 
> > > > > > a) like interrupts, regs, dmas, clocks, pinctrl, reset, pwm: fixed property names
> 
> > > > > >       regmap = <&at25 0xstart 0xlen>;
> > > > > >       regmap-names = "mac-address";
> 
> > > > > > b) like gpio, regulator: variable property names
> 
> > > > > >       mac-storage = <&at25 0xstart 0xlen>;
> 
> > > > > > It's unfortunate that we already have examples of both. They are largely
> > > > > > equivalent, but the tendency is towards the first.
> 
> > > > > I don't have a strong feeling for one against another, so whatever works
> > > > > best. Both solutions will be a huge improvement anyway 
> 
> > > > > Just out of curiosity, is there any advantages besides having a fixed
> > > > > property name to the first solution?
> 
> > > > I think it's mostly for consistency: trying to get most subsystems to
> > > > do it the same way to make it easier for people to write dts files.
> 
> > > > A lesser point is that it simplifies the driver code if you don't
> > > > have to pass a name.
> 
> On the other hand something with human readable names is much more
> legible if humans ever have to read or write the DT bindings.  This
> mostly applies when there are many instances of the property (for
> example, many devices have lots of power supplies) or when some
> instances of the property are optional (for example, many devices can
> use GPIOs for many different functions but usually not all of them are
> connected and there's no particular order in which they might get
> connected).

I guess we would have only a few of these in our cases, so it doesn't
really qualify for the "many instances" I guess, but I do find the
GPIO/regulator-like properties more intuitive and more readable as
well.

> > > So that leave us with mainly one path to achieve this goal:
> > >   - Add a regmap-mtd backend
> > >   - Add DT parsing code for regmap
> > >   - Move the EEPROM drivers from misc to mtd
> 
> > Yes, I think that would be good. For the last step, we definitely need
> > buy-in from Wolfgand and Jean, as they are maintaining the current eeprom
> > drivers.
> 
> I'd really like to see more discussion of this "DT parsing code for
> regmap" idea...  I've missed almost all the context here.

The context was that I found we lack a way to simply express the need
for one driver to get a value from an EEPROM-like device, for example to
get a MAC Address, or a serial number, in a generic way, without having
to poke directly with some custom function that would be exported by the
EEPROM driver.

And the lack of infrastructure/framework to handle the EEPROM right now
only make the thing a bit harder.

What we've been discussing so far is that:
  - To have a common framework we could base our work on, we could move
    the EEPROM drivers from drivers/misc/eeprom to MTD
  - To declare the ranges that needed to be used by a driver that was
    needing a value from one of those MTD drivers, we would use regmap
    with a MTD backend
  - And since we actually need to declare which ranges and in which
    device one driver would have to retrieve this value from, we were
    actually in need of DT bindings.

This is pretty much the only context involved, and we are at the early
stage of the discussion, so any comment is very welcome :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/9469b2a1/attachment.sig>
