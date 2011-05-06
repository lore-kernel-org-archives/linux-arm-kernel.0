From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 6 May 2011 18:20:02 +0100
Subject: [RFC] What is the preferred way to share ADC unit between
	hwmon and input(ts) drivers?
In-Reply-To: <4DC421F3.40404@cam.ac.uk>
References: <4DB4C252.30005@emcraft.com> <20110425110230.GD4768@sirena.org.uk>
	<4DC3FB15.5090307@cam.ac.uk>
	<1304691206.2256.55.camel@team-embedded-2>
	<20110506142316.GP23729@opensource.wolfsonmicro.com>
	<4DC4108D.6020601@cam.ac.uk> <20110506155636.GA23646@sirena.org.uk>
	<4DC421F3.40404@cam.ac.uk>
Message-ID: <20110506172002.GB23646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2011 at 05:29:39PM +0100, Jonathan Cameron wrote:

> Currently at least, IIO sits at the same level as input and hwmon. We
> are interested in handling parts that are too fast / too complicated or just
> plain don't fit in one of those.  It would be easy enough to add what you
> are talking about, but in the same fashion as in theory input could add
> interfaces for hwmon if they wanted to.  The question is whether this a
> job for IIO or should be abstracted below this level (and I agree there
> is scope for abstraction here).  I'm a little worried that if we put
> it in IIO it will result in bloat away from the core aims of handling
> the many weird and wonderful sensors out there in a coherent way.

I'm not clear what an abstraction below IIO for a plain ADC would be.

> Input is trickier as the data paths for IIO and input
> are deliberately rather different due to different requirements.
> Yes we could write a driver that hooks in at a low level, but that
> would then break the IIO data flow.

I'm not personally interested in that case, but if the input device is
really reading from the ADC using the same ADC interface as the rest of
the world then presumably the abstraction mismatch would be handled
above IIO?  I can't think what would be unusual about this from the
point of view of the ADC.

> Basically, yes - we could bludgeon support for ADC in kernel sharing
> into IIO, but its not all that close to our current scope.  If anyone

It's not really ADC sharing as such - there's one physical ADC but to
software these things look like a multi-channel ADC that happens to have
a single register to push data out of.  It happens to be lower volume
than most of the IIO ADCs but that doesn't seem like it should make too
much of a difference?

> wants to look at that, feel free, but I still feel that this sits
> better in mfd.

I'm not clear why MFD would be useful here?  These things are single
function ADCs and don't always appear as part of a larger Linux device.
Some CPUs have these, for example, so they just appear as a memory
mapped platform device.  They often end up with the custom API in the
core MFD driver where there is one of those but that's not because the
MFD API is relevant. 

>                 Often you will be sharing interrupts as well and they
> may well be a mix of ADC and non ADC sources.

You will generally be sharing an interrupt, yes.  I'm not sure what you
mean by a mix of ADC and non-ADC sources, though - the devices I'm
thinking of really are just ADCs.
