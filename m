From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Jul 2013 19:05:06 +0200
Subject: MTD EEPROM support and driver integration
In-Reply-To: <20130709145510.GZ27646@sirena.org.uk>
References: <20130705201118.GM2959@lukather> <5811519.oHVuMujf0I@wuerfel>
 <20130706120112.GA11069@lukather> <8997501.Dchyii8uWX@wuerfel>
 <20130708083426.GO27646@sirena.org.uk>
 <20130708202538.GK11243@lukather>
 <20130709145510.GZ27646@sirena.org.uk>
Message-ID: <20130711170506.GZ11243@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Jul 09, 2013 at 03:55:10PM +0100, Mark Brown wrote:
> On Mon, Jul 08, 2013 at 10:25:38PM +0200, Maxime Ripard wrote:
> > On Mon, Jul 08, 2013 at 09:34:26AM +0100, Mark Brown wrote:
> 
> > > I'd really like to see more discussion of this "DT parsing code for
> > > regmap" idea...  I've missed almost all the context here.
> 
> > The context was that I found we lack a way to simply express the need
> > for one driver to get a value from an EEPROM-like device, for example to
> > get a MAC Address, or a serial number, in a generic way, without having
> > to poke directly with some custom function that would be exported by the
> > EEPROM driver.
> 
> This sort of information is often stored in places like flash partitions
> too.  Are we sure that regmap is a good place to be hooking in here?
> The use case is sane, and being able to use regmap to do some of it
> seems sensible (I've seen people use OTP in PMICs for similar purposes)
> but perhaps an additional layer of abstraction on top makes sense.

Ah, I didn't thought it could be stored into a partition. Ok, so using
an intermediate abstraction for this makes sense (probably using regmap
for all the accesses that are relevant, like i2c, spi or mmio)

> > What we've been discussing so far is that:
> >   - To have a common framework we could base our work on, we could move
> >     the EEPROM drivers from drivers/misc/eeprom to MTD
> >   - To declare the ranges that needed to be used by a driver that was
> >     needing a value from one of those MTD drivers, we would use regmap
> >     with a MTD backend
> >   - And since we actually need to declare which ranges and in which
> >     device one driver would have to retrieve this value from, we were
> >     actually in need of DT bindings.
> 
> > This is pretty much the only context involved, and we are at the early
> > stage of the discussion, so any comment is very welcome :)
> 
> If this stuff is being represented in MTD doesn't MTD already have
> adequate abstractions for saying "this region in flash".  But otherwise
> this seems fine, it's not a generic regmap DT binding but instead rather
> more specific than that.

Yes, since we seem to be going to a point where regmap will be a
convenience in this case, we probably won't need a generic regmap
binding, but rather a generic way to define a range and offset into a
referenced device.

Arnd, the others, is this ok for you?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130711/7299fbd3/attachment.sig>
