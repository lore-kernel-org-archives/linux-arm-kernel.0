From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 3 Sep 2009 22:39:07 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090903121410.GC2954@sirena.org.uk>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
	<20090902144700.GD4012@sirena.org.uk>
	<1b68c6790909021738o3037c9dcve6699a7b272f6742@mail.gmail.com>
	<20090903121410.GC2954@sirena.org.uk>
Message-ID: <1b68c6790909030639i55b7f18dy6c2961a2830e4862@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 3, 2009 at 9:14 PM, Mark Brown<broonie@sirena.org.uk> wrote:
> On Thu, Sep 03, 2009 at 09:38:48AM +0900, jassi brar wrote:
>
>> I recently released one small but essential patch to you to make
>> wm8580 generate proper clocks -- essential when wm8580 is I2S master
>> -- that made me doubt if Slave support is even implemented/tested on
>> SMDKs in mainline.
>
> The change you submitted would only be required if the PLLs are in use,
> and even then it only affects some PLL configurations.

If a machine has a dedicated OSC attached to MCLK of the I2S Codec
chip, most probably
the user want to use that while running in SoC-Slave mode -- why
bother SoC output even I2SCDCLK?
And the 12MHz OSC input doesn't do any good if not refined via the WM8580 PLLs.
So, on SMDK6410, I believe anyone who wants to run SoC-Slave mode will end up
making use of the WM8580 PLLs.
Btw, without the patch i measured error in LRCLK noticable for a
"customer demand"
 --- 41 instead of 44.1 the standard in mp3 playbacks.
Anyways.....


>> My plan was to submit something like smdk_wm8580.c (smdks have wm8580
>> as the main I2S codec) which can be make menuconfig'ed for
>> SoC-Master/Slave and source clock support.
>
> There shouldn't be any build time configuration for things like clock
> mastering, the driver should just pick a good configuration and go.
> Given the simplicity of the setup the actual board file should be pretty
> much trivial anyway, all the real work is in the CPU support.
I hope we agree the SoC-Master/Slave option should be selected in make
menuconfig.
Direction of LRCLK, BCLK thus gets decided there.

IMHO, source of MCLK - I2SCDCLK, PCLK, SCLK_Audio(with further
options) - is better
decided during compile-time too. Otherwise, put-get-put-setrate-'ing
different clocks, according
to the LRCLK needed, in runtime will add more complexity than
flexibility to the driver. Or so do i think.

>> >> In the long run, I see I2S drivers segregated by the I2S spec version
>> >> they implement....
>
>> > the differences. ?Where that is the case it makes sense to try to keep
>> > things together but if conditional code begins to dominate some or
>> > all of the driver then that suggests forking the relevant bits.
>
>> Ofcourse, we shudn't keep 95% identical _v20, _v32, _v40 and _v50.c
>> For the time being, when our driver doesn't make use of any spec
>> differentiator, all SoCs can be served with a single file.
>> But as we implement more and more support to 40 (5.1channel)and 50(5.1
>> channel + channel mixing) versions, we will need segregation.
>
> As far as I remember from when I worked on 5.1 support in your old BSP
> it may be possible to cover the v4.0 in the same driver - there was a
> great deal of compatibility. ?I've not seen the v5 datasheets so I can't
> really comment about the level of changes there.
Yes, state-machine code of v3.2 can run both v4 and v5 and 5.1channel
support of v4 can run that of v5 too. Now v5 has got an added feature
 - LowPowerAudioMode(LPAM) which wud rather take minor tweaks in even
the ALSA stack to run.
And I think we can no longer juggle and reuse the 24xx code.
Either we manage two classes of I2S drivers - simple 2channel Vs
sophisticated 5.1channel with h/w mixing and LPAM etc,
Or we restructure to drivers around "library" like functionality - like PXA.

>> As a starter we cud do by converting Samsung's I2S code 24xx(and even
>> s3c) agnostic?
> I'm not quite sure what you mean by this?
I meant we can atleast make names of functions and datastructures 2410 neutral,
like changing from s3c24xx_i2s to samsung_i2s_v2 or somthing like that.
i.e, designing around IPs rather than SoCs.

Not just for I2S, rather for entire BSP, I believe an approach with
riddance from
the jargon of Samsung SoCs(s3c, s5p, 2410, 24xx, 2412, 64xx etc) and centered
around IPs rather than the SoCs wud server us better.
That way, just like SoC silicon, Linux bsp will also be a matter of simply
compiling a particular version of each device IP.
