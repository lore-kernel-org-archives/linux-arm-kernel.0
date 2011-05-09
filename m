From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Mon, 09 May 2011 14:25:41 +0100
Subject: [RFC] What is the preferred way to share ADC unit between	hwmon
	and input(ts) drivers?
In-Reply-To: <20110506172002.GB23646@sirena.org.uk>
References: <4DB4C252.30005@emcraft.com> <20110425110230.GD4768@sirena.org.uk>
	<4DC3FB15.5090307@cam.ac.uk>
	<1304691206.2256.55.camel@team-embedded-2>
	<20110506142316.GP23729@opensource.wolfsonmicro.com>
	<4DC4108D.6020601@cam.ac.uk> <20110506155636.GA23646@sirena.org.uk>
	<4DC421F3.40404@cam.ac.uk> <20110506172002.GB23646@sirena.org.uk>
Message-ID: <4DC7EB55.1040109@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/11 18:20, Mark Brown wrote:
> On Fri, May 06, 2011 at 05:29:39PM +0100, Jonathan Cameron wrote:
> 
>> Currently at least, IIO sits at the same level as input and hwmon. We
>> are interested in handling parts that are too fast / too complicated or just
>> plain don't fit in one of those.  It would be easy enough to add what you
>> are talking about, but in the same fashion as in theory input could add
>> interfaces for hwmon if they wanted to.  The question is whether this a
>> job for IIO or should be abstracted below this level (and I agree there
>> is scope for abstraction here).  I'm a little worried that if we put
>> it in IIO it will result in bloat away from the core aims of handling
>> the many weird and wonderful sensors out there in a coherent way.
> 
> I'm not clear what an abstraction below IIO for a plain ADC would be.
In summary what bothers me is not that IIO can't handle this - it can
with a few minor tweaks but rather that using IIO is massive overkill.
I can certainly see the benefit in adding what you suggest, but I'm a
little worried the main response would be 'why are you putting
all this stuff in place given you are just acting as distribution
layer for adc reading?'.

Basically my worry is bloat - IIO can't be everything

Perhaps I will have a moment to give this a go on top of IIO and
see whether it is simpler than I currently think...
> 
>> Input is trickier as the data paths for IIO and input
>> are deliberately rather different due to different requirements.
>> Yes we could write a driver that hooks in at a low level, but that
>> would then break the IIO data flow.
> 
> I'm not personally interested in that case, but if the input device is
> really reading from the ADC using the same ADC interface as the rest of
> the world then presumably the abstraction mismatch would be handled
> above IIO?
This is my point. IIO is high performance - if there is 'above' IIO, then
you've just wrecked one of our main reasons for existence.  IIO goes to userspace
via the shortest possible path.

The only valid hook in point would be to divert right at the bottom from our
slow read route (read_raw in the patches currently under review).  The burden
of ensuring that multiple drivers from different subsystems could safely
manipulate this would be pushed to the drivers.
> I can't think what would be unusual about this from the
> point of view of the ADC.
I really think you have misunderstood what IIO is targeting.  It is not
currently about providing a small layer to allow other kernel subsystems
to access an adc - it's about two main things.  Unified consistent userspace
interfaces and the option of a fast data path to userspace.  We can put in
what you want and have sufficient information to do it (unlike hwmon and input
I guess), but as yet I'm unconvinced that we should.
> 
>> Basically, yes - we could bludgeon support for ADC in kernel sharing
>> into IIO, but its not all that close to our current scope.  If anyone
> 
> It's not really ADC sharing as such - there's one physical ADC but to
> software these things look like a multi-channel ADC that happens to have
> a single register to push data out of.  It happens to be lower volume
> than most of the IIO ADCs but that doesn't seem like it should make too
> much of a difference?
We would have no problem handing the ADC's what we would need to add
is the description layer that provides the right information to input
and hwmon drivers sat on top + a few bits of infrastructure to connect
it all up.  Basically anything beyond the trivial adc channels with no
side information, would be rapidly become complex.
> 
>> wants to look at that, feel free, but I still feel that this sits
>> better in mfd.
> 
> I'm not clear why MFD would be useful here?  These things are single
> function ADCs and don't always appear as part of a larger Linux device.
> Some CPUs have these, for example, so they just appear as a memory
> mapped platform device.  They often end up with the custom API in the
> core MFD driver where there is one of those but that's not because the
> MFD API is relevant.
You may view an adc as a single device - but if you want the option in
kernel to have it sometimes act as input and sometimes act as hwmon -
to do it coherently you probably need to viewing it as a combined hwmon
and input device (and IIO).  Thus it has multiple functions and so
to my mind belongs as an mfd core and separate hwmon and input drivers.

I agree we would be replicating a few bits of IIO (basically just the
iio_chan_spec structures for describing channels) and a few callback
functions.
> 
>>                 Often you will be sharing interrupts as well and they
>> may well be a mix of ADC and non ADC sources.
> 
> You will generally be sharing an interrupt, yes.  I'm not sure what you
> mean by a mix of ADC and non-ADC sources, though - the devices I'm
> thinking of really are just ADCs.
Fair enough, but on some PMICs for example IIRC that isn't the case.

I am thoroughly in favour of unifying code at this sort of low level for
the various subsystems that need to read from the ADC. All I'm arguing is
that IIO is not the right place.  What you need here is a clean abstraction
for what is effectively reading from a device register.

Then you need to have a 'bus' to which your hwmon / input / iio drivers
appear to be connected.  The irq stuff can be handled using irq chips.

And please note, this is not a general purpose bit of code covering all adcs.
There are certainly cases that would benefit, but it's no where near all of
them.

All comments on what is currently in IIO welcomed of course!

Jonathan
