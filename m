From: laforge@gnumonks.org (Harald Welte)
Date: Wed, 2 Sep 2009 12:17:19 +0900
Subject: Samsung S3C6410 mainline merge coordination
Message-ID: <20090902031719.GK3838@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,
Hi linux-arm-kernel list members,

as indicated before, Samsungs SoC Linux developers are currently working
on getting more of their work ready for (and submitted to) mainline.

At the end of this mail, I have included a list of current TODO items.  They
are written with the following question im mind:  "What do we need to do in
order to get the existing code (or new features) from samsung's 2.6.28 into
mainline and then submitted."

We're actively looking for feedback.  you can find Samsungs current code
in the 2.6.28-samsung branch of
git://git.kernel.org/pub/scm/linux/kernel/git/kki_ap/linux-2.6-samsung.git
in case you want to review and give feedback.

We also need your feedback in which areas there might be overlap. Let's say you
already have a touchscreen driver on top of your ADC layer, then obviously
there is no need for Samsungs team to duplicate that work.

Currently the plan is as follows:

== core arch/arm support for 6410 ==

=== DMA ===
* check if mainline driver supports all features of samsung driver
** if not, add missing features to mainline driver, test and submit

=== HR-TIMER ===
* port/merge/test + submit mainline

=== plat-s3c/clock.c ===
* submit clk->owner bugfix mainline

=== plat-s3c/gpio.c ===
* off-by-one error, send fix mainline

=== suspend-to-ram ===
* port to mainline and test, submit mainline


== drivers ==

=== IDE ===
* mainline API change
* Samsung needs to avoid touching generic code
* if we change generic code, make sure change is only when executed on
  s3c SoC, rather than a compile-time define

=== keypad ===
* move s3c-keypad.h into s3c-keypad.c
* define number of rows/columns in platform_data
* make delay depend on platform_data rather than compiletime
* move key_base into struct s3c_keypad
* use standard kernel debug messages
* get rid of TRUE/FALSE
* move keypad_timer, is_timer_on and keypad_clock into s3c_keypad
* submit mainlien

=== adc / touchscreen ===
* move plat-s3c24xx/adc.c to plat-s3c/adc.c
* update it with 6410 specific ADC extensions (12bit, faster clock, ...)
* port existing s3c_ts driver to use s3c_adc_register()
** has anyone been doing wokr on this already? ben?
* introduce new 'inverted' property in toucscreen platform_data
** the purpose is to support machines that have the (0,0) coordinate not
   in the top left corner but a different location of the screen
** use it for runtime checking, remove CONFIG_TOUCHSCREEN_NEW

=== video / multimedia ===
* needs a lot of thought
* support standard mainlien architecture wherever possible
** 2D accelerated framebuffer
** DRI/DRM/TTM/KMS
** V4L

=== s5m8751 PMIC ===
* samsung has a mfd driver in their 2.6.28 based tree
* only on special development board, not on stock SMDK
* nonetheless, we want to submit mainline
* lower priority, since not on SMDK

=== SD/MMC ===
* mainline uses existing SDHCI driver, not HSMMC
* fix mainline s3c-sdhci clock related bugs, submit mainline
* add ADMA support and submit mainline
* test / make sure it's feature complete: 1...n patches
* what about 8bit MMC? add as separate patch
* what about MMC highspeed? add as separate patch
* fast boot for movinand? add as separate patch

=== NAND ===
* mainline currently uses same driver for s3c24xx and s3c64xx
** samsung uses a new driver for 2450, 6400, 6410 (and later)
* does it make sense to extend the mainline driver with new SoC support
  or should we rather split the mainline driver?
* mainline driver does not yet support 4kB page sizer with 8bit ECC
** requires core NAND stack changes 
** introduce new oobinfo structure / ioctl to keep kernel/userspace ABI stable!
* define oob layout just in core, use chip->ecc.layout reference in s3c driver

=== OneNAND ===
* mainline onenand code is for ROM interface, does not apply to s3c64xx
* more internal discussion before we know what to do for mainline

=== IRDA ===
* Samsung has a driver in its tree, but customer demand is close to zero
* low priority, driver should be merged/tested in current mainline, then
  submitted

=== RTC ===
* needs more investigation, some code is in samsung tree that is not mainline
* what does it do, why?  something alarm related?

=== SPI ===
* separate SPI slave mode changes from actual 64xx driver
* start with submitting the SPI master mode driver
* then discuss how to add slave to core Linux SPI system
* then finally add SPI slave code to s3c driver

=== USB Gadget ===
* there are two drivers inside Samsung, one developed by System LSI
  and one developed by DMC Lab (Kyungmin Park's team)
* discuss with Kyungmin Park's team, decide which driver should go ahead

=== USB OTG Host ===
* Samung's current driver has a OS abstraction layer and is only glued
  to Linux.  Reasoning was to have one driver that is chapter9 certified.
* However, Linux mianline doesn't accept this
* have to write new actual Linux driver

=== Watchdog ===
* Samsung uses 24xx driver on 6410, no harware change
* test existing mainline 24xx code on 6410
* then send Kconfig change patch to mainline

=== Sound ===
* needs further investigation, there are many different drivers/versions/options

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
