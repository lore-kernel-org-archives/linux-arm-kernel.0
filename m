From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Feb 2010 11:06:49 +0100
Subject: [PATCH 00/39] more imx patches for 2.6.34
Message-ID: <20100224100649.GA6456@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I put some more effort into bringing arch-mx2 into shape to support a
kernel built for mx21 and mx27.  Now this is nearly complete.  The only
things missing are:

 1) runtime physoffset support (patch sent[1])
 2) reorganize Kconfig stuff to allow selecting both mx21 and mx27
    (depends on 1).

This series conflicts with Sascha's mxc-master, so I merged the two
branches and resolved the conflicts.  The result is available at

  git://git.pengutronix.de/git/ukl/linux-2.6.git imx/master-merged

Best regards
Uwe

The following changes since commit 94d32f99c6aba8b702a9cf78cb328aeb7882b1e5:
  Andy Green (1):
        imx-serial-excessive-status-clearing-on-break.patch

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git imx/master

Uwe Kleine-K?nig (39):
      arm/mx2: use cpp magic to create spi_imx devices
      arm/mx2: use cpp magic to create imx_gpt devices
      arm/mx2: use cpp magic to create imx-i2c devices
      arm/mx2: use cpp magic to create imx-mmc devices
      arm/mx2: use cpp magic to create imx-ssi devices
      arm/mx2/devices: use SoC-prefixed names where possible
      arm/mx2: define seperate imx_nand devices for imx21 and imx27
      arm/mx2: use per-SOC nand device
      arm/mx2: define seperate gpio port descriptions for imx21 and imx27
      arm/mx2/devices: no need for IMX_NEEDS_DEPRECATED_SYMBOLS any more
      arm/mx2: split generic.c into mm-imx2[17].c
      arm/imx/gpio: GPIO_INT_{HIGH,LOW}_LEV are not necessarily constant
      arm/imx: use generic_handle_irq instead of open-coding it
      arm/imx/gpio: use fls to find set bits in the irq status register
      arm/imx/gpio: remove a BUG_ON in hot path
      arm/imx/audmux-v1: use SoC-prefixed names
      arm/imx/audmux-v2: use SoC-prefixed names
      arm/imx: remove "NO_PAD_CTRL" from Copyright statements
      arm/imx: let ARCH_MXC select COMMON_CLKDEV instead of each subfamily
      arm/imx: don't explicitly select GENERIC_GPIO
      arm/imx: remove MTD_XIP support
      arm/imx: remove #ifndef CONFIG_COMMON_CLKDEV block
      arm/imx: don't depend on ARCH_MXC twice
      arm/imx/irq: order definitions of MXC_GPIO_IRQS numerically
      arm/imx: choose sane CONSISTENT_DMA_SIZE if video is enabled for both mx1 and mx3
      arm/imx/dma-v1: don't use deprecated symbols DMA_BASE and MXC_INT_DMACH0
      arm/imx/dma-v1: protect #ifdef'd blocks additionally by cpu_is_...
      arm/imx/iomux-v1: rename source file and reorganize Kconfig stuff
      arm/imx/iomux-v1: make base address a runtime choice
      arm/imx/iomux-mx1: unify style and comment cleanup
      arm/imx/iomux-mx21: unify style
      arm/imx/iomux-mx25: unify style and comment cleanup
      arm/imx/iomux-mx27: unify style and comments
      arm/imx/iomux-mx2x: unify style
      arm/imx/iomux-mx3.h: unify style and comments
      arm/mx25: don't include iomux.h which is for iomux-v1 machines
      arm/imx/iomux-v1: rename header file
      arm/imx: let platform files include the SoC-specific iomux header
      arm/imx/iomux-v1: check for invalid modes in mxc_gpio_mode

 arch/arm/Kconfig                             |    3 +-
 arch/arm/mach-mx1/mach-mx1ads.c              |    2 +-
 arch/arm/mach-mx1/mach-scb9328.c             |    2 +-
 arch/arm/mach-mx2/Makefile                   |    8 +-
 arch/arm/mach-mx2/devices.c                  |  643 ++++++++++----------------
 arch/arm/mach-mx2/devices.h                  |   13 +-
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |    2 +-
 arch/arm/mach-mx2/mach-cpuimx27.c            |    5 +-
 arch/arm/mach-mx2/mach-imx27lite.c           |    2 +-
 arch/arm/mach-mx2/mach-mx21ads.c             |    4 +-
 arch/arm/mach-mx2/mach-mx27_3ds.c            |    2 +-
 arch/arm/mach-mx2/mach-mx27ads.c             |    4 +-
 arch/arm/mach-mx2/mach-mxt_td60.c            |    4 +-
 arch/arm/mach-mx2/mach-pca100.c              |    4 +-
 arch/arm/mach-mx2/mach-pcm038.c              |    4 +-
 arch/arm/mach-mx2/{generic.c => mm-imx21.c}  |   46 +--
 arch/arm/mach-mx2/{generic.c => mm-imx27.c}  |   44 +--
 arch/arm/mach-mx2/pcm970-baseboard.c         |    2 +-
 arch/arm/mach-mx25/mach-mx25pdk.c            |    2 +-
 arch/arm/plat-mxc/Kconfig                    |   13 +-
 arch/arm/plat-mxc/Makefile                   |    9 +-
 arch/arm/plat-mxc/audmux-v1.c                |   14 +-
 arch/arm/plat-mxc/audmux-v2.c                |    9 +-
 arch/arm/plat-mxc/dma-mx1-mx2.c              |  207 +++++----
 arch/arm/plat-mxc/gpio.c                     |   30 +-
 arch/arm/plat-mxc/include/mach/clock.h       |    7 -
 arch/arm/plat-mxc/include/mach/iomux-mx1.h   |  313 ++++++-------
 arch/arm/plat-mxc/include/mach/iomux-mx21.h  |  210 ++++-----
 arch/arm/plat-mxc/include/mach/iomux-mx25.h  |   22 +-
 arch/arm/plat-mxc/include/mach/iomux-mx27.h  |  372 ++++++++--------
 arch/arm/plat-mxc/include/mach/iomux-mx2x.h  |  425 +++++++++---------
 arch/arm/plat-mxc/include/mach/iomux-mx3.h   |   76 ++--
 arch/arm/plat-mxc/include/mach/iomux-mx35.h  |    2 +-
 arch/arm/plat-mxc/include/mach/iomux-v1.h    |  103 ++++
 arch/arm/plat-mxc/include/mach/iomux.h       |  128 +-----
 arch/arm/plat-mxc/include/mach/irqs.h        |   11 +-
 arch/arm/plat-mxc/include/mach/memory.h      |   15 +-
 arch/arm/plat-mxc/include/mach/mtd-xip.h     |   34 --
 arch/arm/plat-mxc/iomux-mx1-mx2.c            |  157 -------
 arch/arm/plat-mxc/iomux-v1.c                 |  238 ++++++++++
 40 files changed, 1513 insertions(+), 1678 deletions(-)
 copy arch/arm/mach-mx2/{generic.c => mm-imx21.c} (66%)
 rename arch/arm/mach-mx2/{generic.c => mm-imx27.c} (67%)
 create mode 100644 arch/arm/plat-mxc/include/mach/iomux-v1.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/mtd-xip.h
 delete mode 100644 arch/arm/plat-mxc/iomux-mx1-mx2.c
 create mode 100644 arch/arm/plat-mxc/iomux-v1.c

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/74675
    Russell doesn't want to merge it for 2.6.34, he havn't given reasons
    up to now though.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
