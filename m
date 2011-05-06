From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 6 May 2011 16:56:36 +0100
Subject: [RFC] What is the preferred way to share ADC unit between
	hwmon and input(ts) drivers?
In-Reply-To: <4DC4108D.6020601@cam.ac.uk>
References: <4DB4C252.30005@emcraft.com> <20110425110230.GD4768@sirena.org.uk>
	<4DC3FB15.5090307@cam.ac.uk>
	<1304691206.2256.55.camel@team-embedded-2>
	<20110506142316.GP23729@opensource.wolfsonmicro.com>
	<4DC4108D.6020601@cam.ac.uk>
Message-ID: <20110506155636.GA23646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2011 at 04:15:25PM +0100, Jonathan Cameron wrote:

> We can add in kernel hooks to IIO (would be easy enough -
> for low rate stuff). I'd be happy to accept patches for this (it's not
> a priority for any current active developers as far as I know).

The fact that the interface is stuck in staging has been putting me off
looking at this, building on top of staging would be a step back for the
uses I have.  I'd guess that most of the existing users have no other
option than to use IIO which isn't the case for this sort of user.

> However, that's silly if all you want is to pass it directly to input and hwmon.
> Just write a driver that registers both interfaces directly.
> If one of the adc channels needs stuff from IIO, add that as well.

The pattern that's present in a lot of PMICs it that there's an AUXADC
which is used for voltage/temperature monitoring (typically exposed by
hwmon and power) and can also be used for random inputs (in the style of
IIO).  The AUXADC is logically just a bunch of random ADC channels that
needs some software on top of it to provide semantics, which sounds a
lot like IIO.

Currently you end up with a part-specific ADC interface that some of the
other drivers are consumers for.  I'd really expect that IIO would be
able to save everyone having to reinvent this per chip.
