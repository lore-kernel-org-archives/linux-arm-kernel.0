From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 22 Mar 2011 16:59:07 +0000
Subject: [PATCH] Input: tca6416-keypad: Change to module_init()
In-Reply-To: <AANLkTiniBVWhSiNZMRYbO857D_Vj03KxH4qYqkVo-11J@mail.gmail.com>
References: <20110322142619.1109.89105.sendpatchset@t400s>
	<20110322142855.GB2202@sirena.org.uk>
	<20110322143307.GB24004@linux-sh.org>
	<AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
	<20110322153226.GC30303@linux-sh.org>
	<AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com>
	<20110322155730.GD30303@linux-sh.org>
	<AANLkTi=Fjc2f837ifH152Rh8W0PfiZvViYaLe=8XZo4Z@mail.gmail.com>
	<20110322163144.GC2202@sirena.org.uk>
	<AANLkTiniBVWhSiNZMRYbO857D_Vj03KxH4qYqkVo-11J@mail.gmail.com>
Message-ID: <20110322165907.GG22583@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 01:51:02AM +0900, Magnus Damm wrote:

> I'm not sure if this is i2c specific though - in general you probably
> need to register the parent bus driver first.

This was my original question - I'm not aware of any reason why you
should need to register the driver for the specific bus first, it seems
odd.

> I've seen some SH-Mobile designs with PMICs, and they all use a
> dedicated i2c bus.

It's the most common bus for PMICs but some use SPI for performance
reasons, especially if they integrate other mixed signal functionality
such as touchscreen controllers that might be high volume.

> > In general embedded platforms register I2C early as things like PMICs
> > typically hang off them. ?Grant was trying to push people to use
> > deferred registration for this stuff but it didn't happen yet and I'd
> > personally be more comfortable with more infastructure supporting that.

> The dependency tracking is a bit primitive with only initcalls. I
> wouldn't mind something like this:

That's not a general solution as it doesn't cover things like cross
dependencies between devices on the same bus type.  You really want to
be able to say "I depend on this set of other devices" somehow, the
proposal from Grant that I'm talking about was to only register devices
once their dependencies had appeared which solves the issue but is a bit
manual for the board files.
