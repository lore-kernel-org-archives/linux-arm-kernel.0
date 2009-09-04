From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 4 Sep 2009 10:27:36 +0900
Subject: Samsung SoC ASOC drivers
In-Reply-To: <1b68c6790909030639i55b7f18dy6c2961a2830e4862@mail.gmail.com>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
	<20090902144700.GD4012@sirena.org.uk>
	<1b68c6790909021738o3037c9dcve6699a7b272f6742@mail.gmail.com>
	<20090903121410.GC2954@sirena.org.uk>
	<1b68c6790909030639i55b7f18dy6c2961a2830e4862@mail.gmail.com>
Message-ID: <20090904012736.GA3997@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On Thu, Sep 03, 2009 at 10:39:07PM +0900, jassi brar wrote:
> >> My plan was to submit something like smdk_wm8580.c (smdks have wm8580
> >> as the main I2S codec) which can be make menuconfig'ed for
> >> SoC-Master/Slave and source clock support.
> >
> > There shouldn't be any build time configuration for things like clock
> > mastering, the driver should just pick a good configuration and go.
> > Given the simplicity of the setup the actual board file should be pretty
> > much trivial anyway, all the real work is in the CPU support.
>
> I hope we agree the SoC-Master/Slave option should be selected in make
> menuconfig.  Direction of LRCLK, BCLK thus gets decided there.
> 
> IMHO, source of MCLK - I2SCDCLK, PCLK, SCLK_Audio(with further options) - is
> better decided during compile-time too. Otherwise, put-get-put-setrate-'ing
> different clocks, according to the LRCLK needed, in runtime will add more
> complexity than flexibility to the driver. Or so do i think.

I'm sorry to have to disagree.  The driver is compiled once into a kernel or
kernel module.  The resulting kernel module has to run on every board (mach-*)
that is out there, and at driver probe time it needs to sort out what clocking
to use and whether it's master or slave.  If there's no good way to do this
(semi)automatically, the respective configuration needs to be passed from the board level code by means of platform_data into the driver.

Yes, this will add complexity, no question.  But this is one of the differences
of working on "real" drivers for a general-purpose mainline kernel vs. working
on a driver that is only supposed to be used by one particular customer on one
particular board..

> > As far as I remember from when I worked on 5.1 support in your old BSP
> > it may be possible to cover the v4.0 in the same driver - there was a
> > great deal of compatibility. ?I've not seen the v5 datasheets so I can't
> > really comment about the level of changes there.
>
> Yes, state-machine code of v3.2 can run both v4 and v5 and 5.1channel
> support of v4 can run that of v5 too. Now v5 has got an added feature
>  - LowPowerAudioMode(LPAM) which wud rather take minor tweaks in even
> the ALSA stack to run.
> And I think we can no longer juggle and reuse the 24xx code.
> Either we manage two classes of I2S drivers - simple 2channel Vs
> sophisticated 5.1channel with h/w mixing and LPAM etc,
> Or we restructure to drivers around "library" like functionality - like PXA.

I'm personally not too much into any of those details.  Having two drivers
with one 2channel and one 5.1channel sounds a bit like the 5.1channel will
be a superset of the 2channel driver, i.e. it will (among many other things)
also implement those bits in the 2channel driver - which I believe would be
suboptimal.

> >> As a starter we cud do by converting Samsung's I2S code 24xx(and even
> >> s3c) agnostic?
> > I'm not quite sure what you mean by this?
> I meant we can atleast make names of functions and datastructures 2410 neutral,
> like changing from s3c24xx_i2s to samsung_i2s_v2 or somthing like that.
> i.e, designing around IPs rather than SoCs.
> 
> Not just for I2S, rather for entire BSP, I believe an approach with
> riddance from
> the jargon of Samsung SoCs(s3c, s5p, 2410, 24xx, 2412, 64xx etc) and centered
> around IPs rather than the SoCs wud server us better.

I like that approach, but two comments:

1) The problem is just that the samsung user manuals never specify the version
   of the IP cores, so for anyone outside samsung it is impossible to know
   those version numbers.  Maybe a publicly releaseable single page table
   listing all IP cores in the rows and have one column for every SoC would help

2) it would mean that we start with renaming many things across arch/arm code
   and in the drivers subdirectory, which is difficult to synchronize and will
   cause delays for any real development (i.e. becoming more feature-complete).

We really should focus on adding features and fixing bugs right now, rather than
thinking of the perfect solution which would hold back any real pogress.

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
