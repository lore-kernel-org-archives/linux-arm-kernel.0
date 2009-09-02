From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 2 Sep 2009 17:12:53 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902031719.GK3838@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
Message-ID: <20090902161252.GD2367@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 12:17:19PM +0900, Harald Welte wrote:
> Hi Ben,
> Hi linux-arm-kernel list members,
> 
> as indicated before, Samsungs SoC Linux developers are currently working
> on getting more of their work ready for (and submitted to) mainline.

Whilst this looks like an improvement in the process, will this stick once
they decide to shuffle the development team(s) and/or the management after
effort has been put in to sort this out.
 
> At the end of this mail, I have included a list of current TODO items.  They
> are written with the following question im mind:  "What do we need to do in
> order to get the existing code (or new features) from samsung's 2.6.28 into
> mainline and then submitted."
> 
> We're actively looking for feedback.  you can find Samsungs current code
> in the 2.6.28-samsung branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/kki_ap/linux-2.6-samsung.git
> in case you want to review and give feedback.

I really don't have the time at the moment to go on a fishing trip into
another vendor kernel tree. There are good reasons why we try to avoid
this on public lists:

1) Everyone would end up trying to get you to review their tree which would
   limit the people reviewing the changes. Posting patches to the proper
   list ensures that they are widely reviewed and that the review process
   is public and archive

2) It avoids an automatic assumption that any changes in these trees is
   going to be noticed by the mainatiner.

3) The number of different bases means there is a risk of contaminating
   trees or ending up with many different trees using disc space.

4) It avoids the posiblity of being contaminated by accident.

5) It is contra to the whole Linux development process (see #1)

> We also need your feedback in which areas there might be overlap. Let's say you
> already have a touchscreen driver on top of your ADC layer, then obviously
> there is no need for Samsungs team to duplicate that work.
> 
> Currently the plan is as follows:
> 
> == core arch/arm support for 6410 ==
> 
> === DMA ===
> * check if mainline driver supports all features of samsung driver
> ** if not, add missing features to mainline driver, test and submit
> 
> === HR-TIMER ===
> * port/merge/test + submit mainline
> 
> === plat-s3c/clock.c ===
> * submit clk->owner bugfix mainline

I belive that this has been in for a while, or are you talking about
a different fix?
 
> === plat-s3c/gpio.c ===
> * off-by-one error, send fix mainline

I think this has been fixed, although if not, why hasn't this been
submitted already?
 
> === suspend-to-ram ===
> * port to mainline and test, submit mainline

I belive suspend-to-ram works for all the current in-kernel devices,
so shouldn't need any more work. If there are specific problems, please
report them so we can look at sorting them out.
 
> == drivers ==
> 
> === IDE ===
> * mainline API change
> * Samsung needs to avoid touching generic code
> * if we change generic code, make sure change is only when executed on
>   s3c SoC, rather than a compile-time define
> 
> === keypad ===
> * move s3c-keypad.h into s3c-keypad.c
> * define number of rows/columns in platform_data
> * make delay depend on platform_data rather than compiletime
> * move key_base into struct s3c_keypad
> * use standard kernel debug messages
> * get rid of TRUE/FALSE
> * move keypad_timer, is_timer_on and keypad_clock into s3c_keypad
> * submit mainlien
> 
> === adc / touchscreen ===
> * move plat-s3c24xx/adc.c to plat-s3c/adc.c

I belive this patch has already been submitted to the list, but not
sorted out.

> * update it with 6410 specific ADC extensions (12bit, faster clock, ...)
> * port existing s3c_ts driver to use s3c_adc_register()
> ** has anyone been doing wokr on this already? ben?

I have been keeping Arnaud's drviver up to date with mainline for Simtec,
but as such we've not tried submitting this as there is at least one more
driver out there (see touchscreen filters which has been already posted
to this thread).

> * introduce new 'inverted' property in toucscreen platform_data
> ** the purpose is to support machines that have the (0,0) coordinate not
>    in the top left corner but a different location of the screen
> ** use it for runtime checking, remove CONFIG_TOUCHSCREEN_NEW

I thought tslib should take care of ensuring the proper calibration of
the touchscreen, such as inversions and any other problems and thus
baking values in the driver is of no real use?
 
> === video / multimedia ===
> * needs a lot of thought
> * support standard mainlien architecture wherever possible
> ** 2D accelerated framebuffer
> ** DRI/DRM/TTM/KMS
> ** V4L

I am not reallhy sure if there is any current support for using
hardware blocks for decoding video data. I think that having some
form of framework for doing these as well as allowing blocks to be
chained togehter would be useful.

Again this is something that needs to be taken up with the relevant
community (assuming there is one) to come to a good solution.
 
> === s5m8751 PMIC ===
> * samsung has a mfd driver in their 2.6.28 based tree
> * only on special development board, not on stock SMDK
> * nonetheless, we want to submit mainline
> * lower priority, since not on SMDK

I don't see why this is being mentioned here, it isn't really part of
the requirements to get the s3c64xx/s5pc range of devices working.
 
> === SD/MMC ===
> * mainline uses existing SDHCI driver, not HSMMC

Yes, this block is basically an SDHCI system with some changes from
Samsung for the clocks. It was certainly typical of the previous
methodology to write a completely new driver where there was an
existing in kernel driver that could be modified to cover this.

As such, time was spent by myself and several others with Pierre
decoupling the SDHCI driver and adding the appropriate callbacks
to allow functions such as clock choice to be managed by the
appropriate bus glue.

> * fix mainline s3c-sdhci clock related bugs, submit mainline

It would be nice to have timely and accurate bug reports about
these issues as soon as they are detected. Finding out about
these later in a long list does not fill me with wonder and joy
about the whole process.

As far as I have been aware, I have not seen any issues with the
clocks on the s3c6410 or s3c6400 boards. I don't have anything
after this to test with.

> * add ADMA support and submit mainline

I am sure I have asked several times about the seemingly random
ADMA errors that appear on the S3C6410 (I belive the S3C6400 is
SDMA only) and what (if anything) can be done about them, which
is why the driver currently has the ADMA support disabled (and
a number of extra SDHCI debugging facilities to show state when
ADMA fails).

> * test / make sure it's feature complete: 1...n patches

I would hope this would go without saying.

> * what about 8bit MMC? add as separate patch

I belive that there is support in the MMC/SD core for this, but not
yet in the SDHCI driver. I have yet to come across any 8bit SD cards
out in the wild, so have not looked closer at this.

> * what about MMC highspeed? add as separate patch

I belive the SDHCI driver and the MMC/SD core should support high-speed
cards and do the neccessary setup for the SDHCI controller. If there is
anything else needed, then an update may be needed to the glue file.

> * fast boot for movinand? add as separate patch

As a footnote to this section, I have asked about the correct setup
data for the extended controll registers which control the clock
feedbacks in the system. Having tried several of the published
Samsung kernels (and I have no love for fishing around inside these
to try and find the correct settings from an #ifdef nightmare in
some cases) I have yet to find settings that allow for error free
operation on the SMDK6410...
 
> === NAND ===
> * mainline currently uses same driver for s3c24xx and s3c64xx
> ** samsung uses a new driver for 2450, 6400, 6410 (and later)
> * does it make sense to extend the mainline driver with new SoC support
>   or should we rather split the mainline driver?

It depends, this would better be discussed in a seperate mail about what
features in the newer devices could do with seperate support. Really this
and the comments below belong on the MTD list where the issues can be
thorougly discussed with all the developers involved with the NAND
subsytem.

> * mainline driver does not yet support 4kB page sizer with 8bit ECC
> ** requires core NAND stack changes 
> ** introduce new oobinfo structure / ioctl to keep kernel/userspace ABI stable!
> * define oob layout just in core, use chip->ecc.layout reference in s3c driver
> 
> === OneNAND ===
> * mainline onenand code is for ROM interface, does not apply to s3c64xx
> * more internal discussion before we know what to do for mainline
> 
> === IRDA ===
> * Samsung has a driver in its tree, but customer demand is close to zero
> * low priority, driver should be merged/tested in current mainline, then
>   submitted
> 
> === RTC ===
> * needs more investigation, some code is in samsung tree that is not mainline
> * what does it do, why?  something alarm related?

I belive the newer devices have a battery flat indicator, an improved tick
interrupt control, but basically this is the same block that has been in all
the Samsing based devices.
 
> === SPI ===
> * separate SPI slave mode changes from actual 64xx driver
> * start with submitting the SPI master mode driver
> * then discuss how to add slave to core Linux SPI system
> * then finally add SPI slave code to s3c driver

This needs to be taken up with the relevant maintainers. I do see there
is a lack of support for slave side SPI, but there is currently nobody
using it.
 
> === USB Gadget ===
> * there are two drivers inside Samsung, one developed by System LSI
>   and one developed by DMC Lab (Kyungmin Park's team)
> * discuss with Kyungmin Park's team, decide which driver should go ahead

How about the one that is already in mainline? I spent a lot of time working
on that driver and ensuring it was fit to submit. I'll rehash the issues
that where had when doing this;

1) No driver of any of the Samsung or my drivers would work on my SMDK6410,
   and I was told there where no more boards of a newer revision available
   to try and work out why this happened. It seems to be some form of
   hardware problem, but whether this the board or the actual sillicon on
   it was never determined.

2) All of the Samsung drivers so far have been badly documented and seem
   to have problems of their own. The first variants ignored alignment
   issues, made assumptions about when you can transfer data.

As a note, this is another case of asking questions about the hardware
and not getting a lot of useful information back. Posting a new driver
to the list as 'feedback' is hardly my idea of documentation as well as
ignoring the usual ettiquete of trying to provide patches for an extant
driver.

It seems quite clear from reading the documentation that the PIO mode
of operation simply does not work and that I need to either sort out
the upper layer's use of unaligned buffers or add bounce-buffers to
the s3c-hsotg.c driver.
 
> === USB OTG Host ===
> * Samung's current driver has a OS abstraction layer and is only glued
>   to Linux.  Reasoning was to have one driver that is chapter9 certified.
> * However, Linux mianline doesn't accept this
> * have to write new actual Linux driver

Hmm.
 
> === Watchdog ===
> * Samsung uses 24xx driver on 6410, no harware change
> * test existing mainline 24xx code on 6410
> * then send Kconfig change patch to mainline
> 
> === Sound ===
> * needs further investigation, there are many different drivers/versions/options

The ASoC system (and please, do not continue to try to add old style
ALSA driver) then it is simply core support for the master blocks and
then the board mapping files that link the CODEC and the master together.

I belive Mark Brown has already done a lot of work towards supporting the
SMDK6410's audio routing.


As a final note, myself and Simtec (my employer, if anyone didn't already
realise) have been supporting the Samsung SoC line for a long time at ours
or a 3rd party's expense. It is still sad to see that it requires third
party intervention (you) to try and get them to do things properly.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
