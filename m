From: broonie@sirena.org.uk (Mark Brown)
Date: Thu, 3 Sep 2009 13:14:10 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <1b68c6790909021738o3037c9dcve6699a7b272f6742@mail.gmail.com>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
	<20090902144700.GD4012@sirena.org.uk>
	<1b68c6790909021738o3037c9dcve6699a7b272f6742@mail.gmail.com>
Message-ID: <20090903121410.GC2954@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2009 at 09:38:48AM +0900, jassi brar wrote:

> I recently released one small but essential patch to you to make
> wm8580 generate proper clocks -- essential when wm8580 is I2S master
> -- that made me doubt if Slave support is even implemented/tested on
> SMDKs in mainline.

The change you submitted would only be required if the PLLs are in use,
and even then it only affects some PLL configurations.  

> My plan was to submit something like smdk_wm8580.c (smdks have wm8580
> as the main I2S codec) which can be make menuconfig'ed for
> SoC-Master/Slave and source clock support.

There shouldn't be any build time configuration for things like clock
mastering, the driver should just pick a good configuration and go.
Given the simplicity of the setup the actual board file should be pretty
much trivial anyway, all the real work is in the CPU support.

Also note that not all of the SMDKs are wired up the same way - for
example, the SMDK6410 connects both the DAIs on the WM8580 to the
processor but the SMDK6400 has only one of them connected (in at least
some revisions, there seem to be several floating around).

> Plus, some logical re-arrangement of i2s.c code.

Any fixes and enhancements you've got there would be great.

> >> My idea is to submit only "better enabled" I2S driver with Slave support.

> > In general it's much better (and certainly standard practice within
> > Linux) to enhance and refactor existing drivers incrementally rather
> > than provide entirely new drivers.

> I didn't exactly mean .c files.

OK - that sounds good.  When you said you're going to submit a '"better
enabled" I2S driver' it sounded like an entirely new driver rather than
enhancements to the existing driver.

> >> In the long run, I see I2S drivers segregated by the I2S spec version
> >> they implement....

> > the differences. ?Where that is the case it makes sense to try to keep
> > things together but if conditional code begins to dominate some or
> > all of the driver then that suggests forking the relevant bits.

> Ofcourse, we shudn't keep 95% identical _v20, _v32, _v40 and _v50.c
> For the time being, when our driver doesn't make use of any spec
> differentiator, all SoCs can be served with a single file.
> But as we implement more and more support to 40 (5.1channel)and 50(5.1
> channel + channel mixing) versions, we will need segregation.

As far as I remember from when I worked on 5.1 support in your old BSP
it may be possible to cover the v4.0 in the same driver - there was a
great deal of compatibility.  I've not seen the v5 datasheets so I can't
really comment about the level of changes there.

> As a starter we cud do by converting Samsung's I2S code 24xx(and even
> s3c) agnostic?

I'm not quite sure what you mean by this?
