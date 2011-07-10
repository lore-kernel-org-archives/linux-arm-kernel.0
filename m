From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 10 Jul 2011 18:26:26 +0900
Subject: [PATCH 02/10] ASoc: mxs: add mxs-saif driver
In-Reply-To: <CAA+hA=SBP3Qv0x-9KQMR+iT9nT1E6_HamyM7zeNd1p8rfE6V0g@mail.gmail.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-3-git-send-email-b29396@freescale.com>
	<20110709025252.GC26900@sirena.org.uk>
	<CAA+hA=S0HTqNt+OxprdaqZMF8_9NF8G54UKJprcWc2DCbGf0xA@mail.gmail.com>
	<20110710083359.GB23199@opensource.wolfsonmicro.com>
	<CAA+hA=SBP3Qv0x-9KQMR+iT9nT1E6_HamyM7zeNd1p8rfE6V0g@mail.gmail.com>
Message-ID: <20110710092623.GB23521@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 04:58:10PM +0800, Dong Aisheng wrote:
> 2011/7/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Sun, Jul 10, 2011 at 04:17:13PM +0800, Dong Aisheng wrote:

> >> The problem is that the codec may use the MCLK supplied by SAIF as its
> >> system clock for normal operations such as i2c r/w.

> > That may be true for your particular system but it is not going to be
> > true in general - most devices can handle having their MCLK removed.

> Yes, if i cover that, that may make driver a little complicated.
> Should i do that now or as the next work?

It should simply be a case of adding handling of setting the sysclk to 0
(this is how ASoC indicates clocks should be disabled).  The machine
driver is then responsible for making sure it does the refcounting
properly, and for your system where the clock is enabled all the time
that's just a case of enabling on startup and disabling on remove.

> Also i still do not have such type of codecs integrated on hand.

That's fine, audio hardware is so flexible that it's unreasonable to
expect that all possible systems have been tested.  So long as the code
looks sensible it should be fine and if there are problems people can
always come back and fix them.

> > This is the same issue as the above one with repeated enables? ?You
> > should delegate the rate selection and ideally also the enable control
> > to the machine driver, it can set something in its probe() function.

> Not the same one. The repeated enables is a bug.(Will fix)

Yes, but both are a result of the requirements of your CODEC?  Just
trying to understand if the I2S controller needs this itself or if it's
only for the CODEC.
