From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 17:03:34 +0200
Subject: [RFC PATCH v3 0/2] drivers: mfd: Versatile Express SPC support
In-Reply-To: <1371646530.3867.12.camel@hornet>
References: <1370512763-32200-1-git-send-email-lorenzo.pieralisi@arm.com>
 <201306191437.20759.arnd@arndb.de> <1371646530.3867.12.camel@hornet>
Message-ID: <201306191703.35182.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Pawel Moll wrote:
> > That would end up eliminating the sysreg driver, aside from maybe
> > a one-line change to the syscon driver to allow it to probe the
> > right device.
> 
> ... but sysreg does more than just that. In particular it provides a
> pseudo-gpio controller (I don't think you want to hide this behind the
> syscon) and it can act as a bridge to the configuration bus - see
> below. In short - no, I don't think sysreg driver can disappear. It can
> be reduced in size, yes.

As I said, the gpio part can be a separate driver that just handles
gpio, and I think the configuration bridge can be part of the
vexpress-config driver, building on top of syscon. I'm not completely
sure about the latter part.

> > > > 3. Move vexpress-config into drivers/bus as it is (however I see no one
> > > > in MAINTAINERS for this directory)
> > > ISTR that Arnd originally created that directory, so he may help here.
> > > Arnd also had some concerns about implementing this code as a bus,
> > > mostly about it not being a discoverable bus. IMHO that's a valid
> > > concern, and this is why you ended up putting it under MFD which can be
> > > seen as some sort of platform devices bus. But I still believe the bus
> > > API would make this code look cleaner and easier to maintain.
> > 
> > Sorry, I don't see why it would be a bus. I assume that there is code
> > missing somewhere that is not yet merged, right?
> 
> Well, different VE components (configuration microcontrollers on
> motherboard and daughterboards in particular) talk to each other over a
> bus (an SPI derivative, in case you were wondering). So there is a bus.
> A non-discoverable one, but it does 42 (approximately ;-) different
> things. We already have: clk, hwmon, regulator and reset drivers using
> it.

Ah, got it. In this case I think what you are looking for is a custom
'regmap' interface that abstracts those devices. Regmap can already
cover i2c, spi and mmio based sets of registers (syscon is one example
for mmio), and IIRC there is a simple way of extending it to other
register-level interfaces like this one.

> And, to make things more complicated, the SPC in question, can act as a
> bridge to some of the functions as well. What's a difference? About
> 190ms, in at least one case - accessing the energy monitor data (hwmon)
> can take up to 200ms going through sysreg and about 10ms going through
> SPC. And there are people interesting in getting this numbers as often
> as possible. But (obviously, to make things even more complex() only the
> daughterboard's components can be accessed through it. Eg. the
> motherboard clock generators must still be accessed through sysregs.
> Hope you see why the problem is not trivial.

Yes, it definitely needs some detailed analysis, but I think regmap is
a good fit to simplify this code. Please have a look at that and tell
me if you see problems with it.

	Arnd
