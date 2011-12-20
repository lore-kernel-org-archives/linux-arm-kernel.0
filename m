From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Dec 2011 20:00:31 +0800
Subject: [PATCH 0/12] Add clk_prepare/clk_unprepare for mxs clock api
Message-ID: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mutex locking problem on mxs platform has been reported on mailing
list for a few time.  The cause is that a mutex is being held in mxs
clock api clk_enable/clk_disable which are being called by some mxs
clock client drivers like amba-pl011 and mxs-saif in atomic context.

This series takes Russell's suggestion to:

 * Convert all mxs clock client drivers to clk_prepare/clk_unprepare.
   (I hope the series has covered all the drivers, but appreciate any
   reminding on any missing ones.)

 * Add clk_prepare/clk_unprepare for mxs clock api to contain the
   non-atomic portion of existing clk_enable/clk_disable implemention.
   (As the whole existing clk_enable/clk_disable are non-atomic,
   clk_prepare/clk_unprepare become a renaming of the existing
   clk_enable/clk_disable, and the new clk_enable/clk_disable become
   a pair of dummy functions.)

Thus, we can ensure that no mutex will be held for atomic context, and
the problem people keep reporting gets fixed with one step move toward
common clk framework while not ncessarily waiting for it.

If driver maintainers have no objection, after the review process, I
would like to send the series through arm-soc tree to ease the merge
process.

Those two patches from Richard Zhao are included here for completeness,
and they have been picked up by Sascha on imx tree.  But since imx and
mxs will both go through arm-soc, it should easy to sort out how we
should merge them.

Regards,
Shawn

Richard Zhao (2):
      clk: add helper functions clk_prepare_enable and clk_disable_unprepare
      net: fec: add clk_prepare/clk_unprepare

Shawn Guo (10):
      arm/mxs: convert platform code to clk_prepare/clk_unprepare
      dma: mxs-dma: convert to clk_prepare/clk_unprepare
      mmc: mxs-mmc: convert to clk_prepare/clk_unprepare
      mtd: gpmi-lib: convert to clk_prepare/clk_unprepare
      net: flexcan: convert to clk_prepare/clk_unprepare
      serial: mxs-auart: convert to clk_prepare/clk_unprepare
      video: mxsfb: convert to clk_prepare/clk_unprepare
      ASoC: mxs-saif: convert to clk_prepare/clk_unprepare
      clk: add config option HAVE_CLK_PREPARE into Kconfig
      arm/mxs: select HAVE_CLK_PREPARE for clock

 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-mxs/clock-mx23.c        |   10 +++++-----
 arch/arm/mach-mxs/clock-mx28.c        |   10 +++++-----
 arch/arm/mach-mxs/clock.c             |   33 +++++++++++++++++++++++----------
 arch/arm/mach-mxs/mach-mx28evk.c      |    2 +-
 arch/arm/mach-mxs/system.c            |    2 +-
 arch/arm/mach-mxs/timer.c             |    2 +-
 drivers/clk/Kconfig                   |    3 +++
 drivers/dma/mxs-dma.c                 |    8 ++++----
 drivers/mmc/host/mxs-mmc.c            |   10 +++++-----
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   12 ++++++------
 drivers/net/can/flexcan.c             |   10 +++++-----
 drivers/net/ethernet/freescale/fec.c  |   10 +++++-----
 drivers/tty/serial/mxs-auart.c        |    8 ++++----
 drivers/video/mxsfb.c                 |    8 ++++----
 include/linux/clk.h                   |   22 ++++++++++++++++++++++
 sound/soc/mxs/mxs-saif.c              |    4 ++--
 17 files changed, 97 insertions(+), 58 deletions(-)
