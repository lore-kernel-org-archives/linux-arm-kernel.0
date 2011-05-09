From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 9 May 2011 16:39:40 +0200
Subject: [RFC] What is the preferred way to share ADC unit between	hwmon
	and input(ts) drivers?
In-Reply-To: <4DC7EB55.1040109@cam.ac.uk>
References: <4DC7EB55.1040109@cam.ac.uk>
Message-ID: <20110509143939.GG3225@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2011 at 02:25:41PM +0100, Jonathan Cameron wrote:
> On 05/06/11 18:20, Mark Brown wrote:

> > I'm not clear what an abstraction below IIO for a plain ADC would be.

> In summary what bothers me is not that IIO can't handle this - it can
> with a few minor tweaks but rather that using IIO is massive overkill.
> I can certainly see the benefit in adding what you suggest, but I'm a
> little worried the main response would be 'why are you putting
> all this stuff in place given you are just acting as distribution
> layer for adc reading?'.

Isn't that essentially what IIO is (well, there's the DAC side as well)?
You're currently focusing on distributing data to userspace but that
seems like a fixable limitation rather than anything else, I don't see a
fundamental disconnect between users.

> > I'm not personally interested in that case, but if the input device is
> > really reading from the ADC using the same ADC interface as the rest of
> > the world then presumably the abstraction mismatch would be handled
> > above IIO?

> This is my point. IIO is high performance - if there is 'above' IIO, then
> you've just wrecked one of our main reasons for existence.  IIO goes to userspace
> via the shortest possible path.

It doesn't seem terribly invasive to be able to have a choice of things
to notify, you already have to at least be able to work out which
userspace thing to tell...  It certainly doesn't seem like we'd want
another subsystem to offer a different userspace interface, or even a
reimplementation of the same userspace interface, for the generic
channels.  It also doesn't seem like kernel space is going to be
explicitly looking for low performance, in the touchscreen example you
mentioned the focus is typically very much on reducing latency.

> > I can't think what would be unusual about this from the
> > point of view of the ADC.

> I really think you have misunderstood what IIO is targeting.  It is not
> currently about providing a small layer to allow other kernel subsystems
> to access an adc - it's about two main things.  Unified consistent userspace
> interfaces and the option of a fast data path to userspace.  We can put in
> what you want and have sufficient information to do it (unlike hwmon and input
> I guess), but as yet I'm unconvinced that we should.

Well, if we don't do that I guess we have to invent another subsystem
for generic ADCs and DACs which doesn't seem ideal either, and I'd guess
a bunch of drivers (at a guess many of them) would get pushed down from
IIO into that and use some generic IIO to convertor adaption layer?

> > It's not really ADC sharing as such - there's one physical ADC but to
> > software these things look like a multi-channel ADC that happens to have
> > a single register to push data out of.  It happens to be lower volume
> > than most of the IIO ADCs but that doesn't seem like it should make too
> > much of a difference?

> We would have no problem handing the ADC's what we would need to add
> is the description layer that provides the right information to input
> and hwmon drivers sat on top + a few bits of infrastructure to connect
> it all up.  Basically anything beyond the trivial adc channels with no
> side information, would be rapidly become complex.

Can't the higher level subsystems deal with this?  It doesn't seem like
a problem the ADC layer should be worrying about.

> > I'm not clear why MFD would be useful here?  These things are single
> > function ADCs and don't always appear as part of a larger Linux device.
> > Some CPUs have these, for example, so they just appear as a memory
> > mapped platform device.  They often end up with the custom API in the
> > core MFD driver where there is one of those but that's not because the
> > MFD API is relevant.

> You may view an adc as a single device - but if you want the option in
> kernel to have it sometimes act as input and sometimes act as hwmon -
> to do it coherently you probably need to viewing it as a combined hwmon
> and input device (and IIO).  Thus it has multiple functions and so
> to my mind belongs as an mfd core and separate hwmon and input drivers.

Like I say this isn't really the model the hardware is presenting here -
it looks much more like a set of n ADC channels some of which have
fixed purposes and some of which are generic than a single ADC.

> I am thoroughly in favour of unifying code at this sort of low level for
> the various subsystems that need to read from the ADC. All I'm arguing is
> that IIO is not the right place.  What you need here is a clean abstraction
> for what is effectively reading from a device register.

> Then you need to have a 'bus' to which your hwmon / input / iio drivers
> appear to be connected.  The irq stuff can be handled using irq chips.

You could do that, but like I say if we do that then what it's
suggesting to me is that we should be pulling the chip drivers out of
IIO and pushing them down into some new subsystem, leaving IIO as a
wrapper around that subsystem for otherwise unclaimed channels (or
possibly explicitly exposed channels).

What I'm looking for here is a standard way of writing drivers for
generic ADCs and DACs.  It doesn't have to be IIO but if it isn't then
it's really suggesting to me that we need to start pushing things down
out of IIO so we have a consistent way to implement support for random
generic ADCs and DACs.
