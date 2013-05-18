From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 May 2013 21:26:04 +0100
Subject: [RFC 4/4] DRM: tda998x: add missing include
In-Reply-To: <5197D6C1.3060702@gmail.com>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194644.2a02a4fc@armhf>
 <CAF6AEGtx7RbvKEEc5uSFvz-2uveB1cnJNf_ESn6JYhfte5UmZQ@mail.gmail.com>
 <20130518205845.2dfe9fe5@armhf> <5197D6C1.3060702@gmail.com>
Message-ID: <20130518202604.GM18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 18, 2013 at 09:30:09PM +0200, Sebastian Hesselbarth wrote:
> The device for tda998x yes, but not the driver. Anyway, Russel decided
> to have tda998x probed by his drm_driver.

For the simple reason that _that_ is how DRM slave encoders work.
Sometimes, reading the code of the subsystem you're using is well
worth the effort.

If Jean-Francois would like to read drm_encoder_slave.c, then it will
be found that in order to use the TDA998x driver, which is itself a
DRM slave encoder, you must use drm_i2c_encoder_init().  In order to
use that, you must provide the I2C adapter structure, and a board
info structure.

If you don't want to do that, your options are:
(a) you don't use the existing TDA998x DRM slave encoder, and instead
    write your own TDA998x driver, which will likely be justifyable
    rejected, or
(b) you propose a new DRM interface to allow DRM components to be
    registered independently, without reference to a core drm_device
    structure.

> The connection of Dove LCD and tda998x is _not_ Cubox specific, it is
> also on the D2Plug. To be precise, even "Dove LCD" is not Dove specific
> as you can find the very same controller on other Marvell SoCs with
> little differences.

Well, to spoil the argument a little, actually, the interconnection
between the two is in no way "standardized".  There's many different
ways to wire the two chips together and have it work - because the
TDA998x chips have a set of input muxes and swaps which allow you to
connect the red, green, blue high/low nibbles in various ways and
still have a correctly working system.  The TDA998x connectivity is
_highly_ configuable.

So, just because one board connects LCD_D0 (red bit 0) to a particular
pin on the TDA998x does not mean that another board does it that way
too.

So Jean-Francois is quite correct that this data needs to be provided
by the board in some manner.  The question is - how to do that sensibly.

One possible stop-gap solution is to provide a default set which just
happens to match the cubox, and allow OF to override it. :)

> There is so much to take care of like pixel format on lcd pins driving
> an external encoder (_not_ only tda998x), what gpio pin is connected to
> TDA interrupt line, one or two lcds, ...

Luckily, drivers/gpu/drm/i2c/tda998x.c does not make use of the IRQ
signal at present - it's fairly basic and it currently operates by
polling.  Eventually, this could change of course. :)

I think people need to keep a sense of perspective here: this is all
entirely "new" stuff which is still being actively developed.  It is
not fully polished.  We've not had a true open source TDA998x driver
before 3.9 (that's when it was introduced.)  It has teething problems
at the moment, but I'm working with the authors to resolve these issues.
I'm also still working on the DRM driver.

For example, I've been playing with the RGB888 cursor support today,
which seems to be suffering from a one pixel error in the hotspot
location.  I've not got to the bottom of it, but that kind of error
_is_ important to understand and resolve, because it means that
things like drawing programmes become unusable.

What I'm starting to suspect is a bug in the X server causing this
and not either my DRM driver or Xorg driver.
