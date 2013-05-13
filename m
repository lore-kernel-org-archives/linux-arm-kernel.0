From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 13 May 2013 23:18:51 +0200
Subject: [PATCH V2 00/10] mmc_of_parse() adaptations,
 DT support for Sheevaplugs
Message-ID: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While adding DT support for the Sheevaplugs by Globalscale Technologies
(Kirkwood), it turned out that the DT binding of mvsdio lacked features to
properly support the hardware (active high/low of CD and WP pins could not
be described in DT).

This is standard functionality provided by the mmc_of_parse() helper
function.  However, mmc_of_parse() may allocate GPIO lines.  If the
allocation fails, it outputs an error, but does not return an error to its
caller.  Therefore, a proposal to handle errors in mmc_of_parse() is made.

The patch set is structured as follows:

1   Adapt mmc_of_parse() to return errors
2-6 Handle errors in current drivers using mmc_of_parse() (compile tested
    only)
7-8 Convert mvsdio and respective dts files to mmc_of_parse() (tested on
    kirkwood)
9   Add dts files for (eSATA) Sheevaplug
10  Add DT support for (eSATA) Sheevaplug


I could only test on an eSATA Sheevaplug. I found patches with
different LEDs for the Sheevaplug.  Thus, I would highly appreciate if
someone with the hardware could give this a spin on a non-eSATA
version.  Some additional testing of the change detect and write
protect behaviour for mvsdio can't hurt either.  I hope that there aren't
board revisions with different CD/WP pins out there.

Simon Baatz (10):
  mmc: return mmc_of_parse() errors to caller
  mmc: sh_mmcif: handle mmc_of_parse() errors during probe
  mmc: tmio-mmc: handle mmc_of_parse() errors during probe
  mmc: mxcmmc: handle mmc_of_parse() errors during probe
  mmc: sdhi-pxav3: handle mmc_of_parse() errors during probe
  mmc: tegra: handle mmc_of_parse() errors during probe
  ARM: mvebu: Use standard MMC binding for all users of mvsdio
  mmc: mvsdio: use standard MMC device-tree binding parser
    mmc_of_parse()
  ARM: Kirkwood: Add dts files for Sheevaplug and eSATA Sheevaplug
  ARM: Kirkwood: add DT support for Sheevaplug and Sheevaplug eSATA

 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/armada-370-db.dts                |    1 +
 arch/arm/boot/dts/armada-370-mirabox.dts           |    1 +
 arch/arm/boot/dts/armada-370-rd.dts                |    1 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |    4 +
 arch/arm/boot/dts/armada-xp-db.dts                 |    1 +
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |    1 +
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |    2 +
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |    2 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  |   97 ++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |   40 ++++++++
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          |   45 +++++++++
 arch/arm/boot/dts/kirkwood-topkick.dts             |    1 +
 arch/arm/boot/dts/kirkwood.dtsi                    |    4 +
 arch/arm/mach-kirkwood/Kconfig                     |    7 ++
 arch/arm/mach-kirkwood/Makefile                    |    1 +
 arch/arm/mach-kirkwood/board-dt.c                  |    4 +
 arch/arm/mach-kirkwood/board-sheevaplug.c          |   27 ++++++
 arch/arm/mach-kirkwood/common.h                    |    5 +
 drivers/mmc/core/host.c                            |   24 ++++-
 drivers/mmc/host/mvsdio.c                          |   73 ++++++++-------
 drivers/mmc/host/mxcmmc.c                          |    4 +-
 drivers/mmc/host/sdhci-pxav3.c                     |    7 +-
 drivers/mmc/host/sdhci-tegra.c                     |    9 +-
 drivers/mmc/host/sh_mmcif.c                        |    7 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |    4 +-
 include/linux/mmc/host.h                           |    2 +-
 27 files changed, 328 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug.dts
 create mode 100644 arch/arm/mach-kirkwood/board-sheevaplug.c

-- 
1.7.9.5
