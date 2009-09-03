From: broonie@sirena.org.uk (Mark Brown)
Date: Thu, 3 Sep 2009 16:18:13 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <1b68c6790909030639i55b7f18dy6c2961a2830e4862@mail.gmail.com>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
	<20090902144700.GD4012@sirena.org.uk>
	<1b68c6790909021738o3037c9dcve6699a7b272f6742@mail.gmail.com>
	<20090903121410.GC2954@sirena.org.uk>
	<1b68c6790909030639i55b7f18dy6c2961a2830e4862@mail.gmail.com>
Message-ID: <20090903151812.GE2954@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2009 at 10:39:07PM +0900, jassi brar wrote:
> On Thu, Sep 3, 2009 at 9:14 PM, Mark Brown<broonie@sirena.org.uk> wrote:

> > The change you submitted would only be required if the PLLs are in use,
> > and even then it only affects some PLL configurations.

> So, on SMDK6410, I believe anyone who wants to run SoC-Slave mode will end up
> making use of the WM8580 PLLs.

Historically the SMDK drivers in the BSPs have always run the CODEC as
slave; I've never been sure why.  I believe most of the other users are
using a crystal that directly generates the rates they need.

> > There shouldn't be any build time configuration for things like clock
> > mastering, the driver should just pick a good configuration and go.

> I hope we agree the SoC-Master/Slave option should be selected in make
> menuconfig.
> Direction of LRCLK, BCLK thus gets decided there.

The machine driver should just pick a suitable configuration and go with
it.  This isn't something which users should need to be concerned about
having to configure - it's way more detail than they need to know to get
audio working, it just makes support harder.  If someone is interested
in playing about with these options they can always go and edit the
source code but it's a very niche use case.

> IMHO, source of MCLK - I2SCDCLK, PCLK, SCLK_Audio(with further
> options) - is better
> decided during compile-time too. Otherwise, put-get-put-setrate-'ing
> different clocks, according
> to the LRCLK needed, in runtime will add more complexity than
> flexibility to the driver. Or so do i think.

If you're talking about the CPU DAI then all this stuff needs to be
decided at runtime - compile time selection causes lots of problems.  It
means that it's not possible to build kernels which will run on boards
with different configurations, nor is it possible to have a single
machine using multiple I2S ports with different configurations.

If you're talking about the machine driver then yes, this should just be
fixed in the source code as discussed above.

> Yes, state-machine code of v3.2 can run both v4 and v5 and 5.1channel
> support of v4 can run that of v5 too. Now v5 has got an added feature
>  - LowPowerAudioMode(LPAM) which wud rather take minor tweaks in even
> the ALSA stack to run.
> And I think we can no longer juggle and reuse the 24xx code.
> Either we manage two classes of I2S drivers - simple 2channel Vs
> sophisticated 5.1channel with h/w mixing and LPAM etc,

This sounds like there's a break at version 5, then.  Though it may also
be the case that you want to represent the new parts of the V5 block as
a separate driver, keeping the I2S-specific block isolated.  Like I say,
it's a bit hard to comment in detail about the v5 block without seeing
any information about it.

> Or we restructure to drivers around "library" like functionality - like PXA.

That sounds like it's worth looking into, but depending on how big the
differences are there may be no advantages.  Note that the library stuff
for PXA isn't about sharing the code between multiple devices, it's
about exporting the same device via two different APIs.

> >> As a starter we cud do by converting Samsung's I2S code 24xx(and even
> >> s3c) agnostic?
> > I'm not quite sure what you mean by this?

> I meant we can atleast make names of functions and datastructures 2410 neutral,
> like changing from s3c24xx_i2s to samsung_i2s_v2 or somthing like that.
> i.e, designing around IPs rather than SoCs.

I don't have any massive problem with doing this but if you wish to do
this be sure to ensure that big reformatting changes such as this are
isolated from all other changes.  Part of the reason nothing's ever been
changed is that changes like this are very disruptive relative to their
benefits.
