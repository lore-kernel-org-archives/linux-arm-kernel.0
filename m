From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 28 Feb 2016 23:03:01 +0100
Subject: [PATCH] spi: lp-8841: return correct error code from probe
In-Reply-To: <1456601577.23036.60.camel@gmail.com>
References: <1456400265-3068525-1-git-send-email-arnd@arndb.de>
 <1456601577.23036.60.camel@gmail.com>
Message-ID: <4810940.iqjRTUDvFQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 February 2016 22:32:57 Sergei Ianovich wrote:
> Hi Arnd,
> 
> On Thu, 2016-02-25 at 12:37 +0100, Arnd Bergmann wrote:
> > The spi_lp8841_rtc_probe() function misses an initialization of the
> > return code when it fails to get its memory resource, as gcc notices:
> > 
> > drivers/spi/spi-lp8841-rtc.c: In function 'spi_lp8841_rtc_probe':
> > drivers/spi/spi-lp8841-rtc.c:239:9: error: 'ret' may be used
> > uninitialized in this function [-Werror=maybe-uninitialized]
> 
> I wasn't getting this warning when I was building the driver. This
> happened because -Wmaybe-uninitialized is suppressed when
> CONFIG_CC_OPTIMIZE_FOR_SIZE is selected
> (Commit e74fc973b6e531fef1fce8b101ffff05ecfb774c "Turn off -Wmaybe-
> uninitialized when building with -Os").
> 
> A recent gcc version like 5.3.1 doesn't seem to produce much false
> positives. May it make sense to revert that commit?
> 
> The gcc-5.3.1 log for reference.

I have spent a lot of time on fixing those warning messages. I still
see tons of warnings even with the latest compilers when -Os (all
false positives) is used, and I have a branch in which I have fixed
all the ones that happen when building with -O2.

I recently submitted a patch to turn CONFIG_CC_OPTIMIZE_FOR_SIZE
into a choice statement that is not automatically set on an
allmodconfig build, which should help here, but my patch has
not yet been merged.

We have similar problems with a couple of other options that
drastically increase the false positive rate for these warnings
(GCOV_PROFILE_ALL, PROFILE_ALL_BRANCHES, UBSAN_SANTIZE_ALL, ...),
and I think our best strategy for all of these is to make sure
they are not enabled in an allmodconfig build or the typical
defconfigs, but also to hide the warnings if they are used in
a particular config.

	Arnd
