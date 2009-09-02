From: broonie@sirena.org.uk (Mark Brown)
Date: Wed, 2 Sep 2009 15:47:00 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
Message-ID: <20090902144700.GD4012@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 10:44:35PM +0900, jassi brar wrote:

> Yes, none of mainline SMDK supports SoC-Slave mode or sourcing I2S IP with
> various possible clocks(PCLK, EPLL, CDCLK) etc yet. Samsung tree has
> implemented
> and fully tested these features for 6410, 6440 and C100.

There's existing users in mainline with the S3C24xx working as slave,
including some for which I have hardware so I'm fairly confident that
that should work.

I've also had reports that the S3C64xx works as slave in mainline, the
code certainly claims that it should work.  At the minute it's limited
to only one of the external clock sources and one of the internal clock
sources, though (I'd need to go and look to see which).

> My idea is to submit only "better enabled" I2S driver with Slave support.

In general it's much better (and certainly standard practice within
Linux) to enhance and refactor existing drivers incrementally rather
than provide entirely new drivers.  The idea is to avoid confusion
between the variants and issues that can come from replacing one set of
problems with another.

Sometimes a flag day is unavoidable but it's best to at least explore
other options first.

> In the long run, I see I2S drivers segregated by the I2S spec version
> they implement....
> S3C2410 has I2S-2.0, S3C6410 has I2S-3.2 and I2S-4.0, S5P6440 has
> I2S-4.0, S5PC100 has
> I2S-3.2 and I2S-5.1 and so on. That is, we have something like
> samsung-i2s_v20.c, samsung-i2s_v32.c,
> samsung-i2s_v40.c, samsung-i2s_v51.c.

It really depends on how much difference there is between the blocks at
what point it becomes worth forking a new driver - in many cases the
newer blocks are close to register compatible with the older ones so
a forked driver would have more in common with the original driver than
the differences.  Where that is the case it makes sense to try to keep
things together but if conditional code begins to dominate some or all
of the driver then that suggests forking the relevant bits.

One example of what may end up making most sense is that we get a driver
per variant but also a core which factors out all the bits that stay the
same between different variants (possibly multiple versions thereof).

> SoC specific register addresses and other peculiarities maybe
> differentiated by defines in coresp. header files.
> Let Samsung come with as many SoCs as it wishes, I2S support will
> simply end up in header files. Also, that we

Build time stuff like this does greatly increase the number of
configurations that need to be compiled in order to achieve build
coverage which is a bit of a problem, not just for testing but also for
things like distro kernels.  There's limitations due to the underlying
arch/arm stuff but we'd want to at least track what that can do and not
introduce any new limits in the audio drivers.

> Whereas, mainline s3c-i2s approach currently concentrates on
> extracting common code in one file(s3c-i2s-v2.c) or so do i think.

Pretty much since for the v2-v4 range the differences are mostly in the
addition of new features and compatibility is fairly strong.  Like I
say, if it gets to be more trouble than it's worth to maintain things
like this that's the time to start splitting out separate drivers.
