From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Fri, 06 May 2011 17:29:39 +0100
Subject: [RFC] What is the preferred way to share ADC unit between	hwmon
	and input(ts) drivers?
In-Reply-To: <20110506155636.GA23646@sirena.org.uk>
References: <4DB4C252.30005@emcraft.com> <20110425110230.GD4768@sirena.org.uk>
	<4DC3FB15.5090307@cam.ac.uk>
	<1304691206.2256.55.camel@team-embedded-2>
	<20110506142316.GP23729@opensource.wolfsonmicro.com>
	<4DC4108D.6020601@cam.ac.uk> <20110506155636.GA23646@sirena.org.uk>
Message-ID: <4DC421F3.40404@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/11 16:56, Mark Brown wrote:
> On Fri, May 06, 2011 at 04:15:25PM +0100, Jonathan Cameron wrote:
> 
>> We can add in kernel hooks to IIO (would be easy enough -
>> for low rate stuff). I'd be happy to accept patches for this (it's not
>> a priority for any current active developers as far as I know).
> 
> The fact that the interface is stuck in staging has been putting me off
> looking at this, building on top of staging would be a step back for the
> uses I have.  I'd guess that most of the existing users have no other
> option than to use IIO which isn't the case for this sort of user.
Sure - this sort of user isn't what I at least conceive IIO as being for.
> 
>> However, that's silly if all you want is to pass it directly to input and hwmon.
>> Just write a driver that registers both interfaces directly.
>> If one of the adc channels needs stuff from IIO, add that as well.
> 
> The pattern that's present in a lot of PMICs it that there's an AUXADC
> which is used for voltage/temperature monitoring (typically exposed by
> hwmon and power) and can also be used for random inputs (in the style of
> IIO).  The AUXADC is logically just a bunch of random ADC channels that
> needs some software on top of it to provide semantics, which sounds a
> lot like IIO.
> 
> Currently you end up with a part-specific ADC interface that some of the
> other drivers are consumers for.  I'd really expect that IIO would be
> able to save everyone having to reinvent this per chip.
Currently at least, IIO sits at the same level as input and hwmon. We
are interested in handling parts that are too fast / too complicated or just
plain don't fit in one of those.  It would be easy enough to add what you
are talking about, but in the same fashion as in theory input could add
interfaces for hwmon if they wanted to.  The question is whether this a
job for IIO or should be abstracted below this level (and I agree there
is scope for abstraction here).  I'm a little worried that if we put
it in IIO it will result in bloat away from the core aims of handling
the many weird and wonderful sensors out there in a coherent way.

So you could write a hwmon driver that talks through an iio driver
(easy enough to do I think - though only a small subset of stuff would
be supported). It's also low rate so the iio and hwmon interfaces
wouldn't get in each others way very much.

Input is trickier as the data paths for IIO and input
are deliberately rather different due to different requirements.
Yes we could write a driver that hooks in at a low level, but that
would then break the IIO data flow.

Basically, yes - we could bludgeon support for ADC in kernel sharing
into IIO, but its not all that close to our current scope.  If anyone
wants to look at that, feel free, but I still feel that this sits
better in mfd.  Often you will be sharing interrupts as well and they
may well be a mix of ADC and non ADC sources.
