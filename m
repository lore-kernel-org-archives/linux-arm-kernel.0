From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 3 Sep 2009 09:38:48 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902144700.GD4012@sirena.org.uk>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
	<20090902144700.GD4012@sirena.org.uk>
Message-ID: <1b68c6790909021738o3037c9dcve6699a7b272f6742@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 2, 2009 at 11:47 PM, Mark Brown<broonie@sirena.org.uk> wrote:
> On Wed, Sep 02, 2009 at 10:44:35PM +0900, jassi brar wrote:
>
>> Yes, none of mainline SMDK supports SoC-Slave mode or sourcing I2S IP with
>> various possible clocks(PCLK, EPLL, CDCLK) etc yet. Samsung tree has
>> implemented
>> and fully tested these features for 6410, 6440 and C100.
>
> There's existing users in mainline with the S3C24xx working as slave,
> including some for which I have hardware so I'm fairly confident that
> that should work.
>
> I've also had reports that the S3C64xx works as slave in mainline, the
> code certainly claims that it should work.

Ofcourse, i can see Neo1973 implement SoC-Slave mode. There is no
reason why some users won't have 6410 running in Slave mode too at
their end.
I recently released one small but essential patch to you to make
wm8580 generate proper clocks -- essential when wm8580 is I2S master
-- that made me doubt if Slave support is even implemented/tested on
SMDKs in mainline.

My plan was to submit something like smdk_wm8580.c (smdks have wm8580
as the main I2S codec) which can be make menuconfig'ed for
SoC-Master/Slave and source clock support.
Plus, some logical re-arrangement of i2s.c code.
How about that?

>> My idea is to submit only "better enabled" I2S driver with Slave support.
> In general it's much better (and certainly standard practice within
> Linux) to enhance and refactor existing drivers incrementally rather
> than provide entirely new drivers.
I didn't exactly mean .c files.

>?The idea is to avoid confusion
> between the variants and issues that can come from replacing one
>set of problems with another.
got it.


>> In the long run, I see I2S drivers segregated by the I2S spec version
>> they implement....
>> S3C2410 has I2S-2.0, S3C6410 has I2S-3.2 and I2S-4.0, S5P6440 has
>> I2S-4.0, S5PC100 has
>> I2S-3.2 and I2S-5.1 and so on. That is, we have something like
>> samsung-i2s_v20.c, samsung-i2s_v32.c,
>> samsung-i2s_v40.c, samsung-i2s_v51.c.
>
> It really depends on how much difference there is between the blocks at
> what point it becomes worth forking a new driver - in many cases the
> newer blocks are close to register compatible with the older ones so
> a forked driver would have more in common with the original driver than
> the differences. ?Where that is the case it makes sense to try to keep
> things together but if conditional code begins to dominate some or
> all of the driver then that suggests forking the relevant bits.
Ofcourse, we shudn't keep 95% identical _v20, _v32, _v40 and _v50.c
For the time being, when our driver doesn't make use of any spec
differentiator, all SoCs can be served with a single file.
But as we implement more and more support to 40 (5.1channel)and 50(5.1
channel + channel mixing) versions, we will need segregation.
Ofcourse, intersection cud always be separated out, as does PXA.
But as i  said - In the long run.
As a starter we cud do by converting Samsung's I2S code 24xx(and even
s3c) agnostic?
