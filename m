From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 17 Nov 2010 22:28:21 +0100
Subject: [PATCH 00/51] some more imx patches for 2.6.38
Message-ID: <20101117212821.GF8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Some of the patches in this series are already in Sascha's tree, I
resend them because several of them got minor fixes.

The highlights are that for most devices for i.MX1, i.MX21, i.MX25 and
i.MX27 are allocated dynamically which reduces the memory footprint of
the kernel.  Moreover I moved support for i.MX25 to mach-imx targeting a
multi-SoC-kernel for i.MX.

Later I want to do the same for mx3.  I'm not sure about mx5 though.
The discussion about integrating support for i.MX28 into mach-imx made
me questioning if this is sensible.  Well, we'll see.

Note that this series is hardly runtime tested, I only compile tested
using the available imx defconfigs and two random defconfigs for i.MX25
and mxc91231.  (I had to cherry-pick the usb build fixes already in the
usb-tree and I marked SND_IMX_SOC as broken because I was to lazy to
look for Sascha's fixes.)

The following changes since commit be6786ac738801d39cfd264ec88c352efd029578:

  Merge branch 'l2x0-pull-rmk' of git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base into devel-stable (2010-10-28 14:42:06 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git imx-for-2.6.38

Alberto Panizzo (1):
      ARM: mx3/mach-pcm037_eet: Fix section mismatch for eet_init_devices()

Uwe Kleine-K?nig (50):
      ARM: mx3: fix the last users of IMX_NEEDS_DEPRECATED_SYMBOLS
      ARM: imx: refactor the io mapping macro
      ARM: imx: use MXxy_IO_P2V macros to setup static mappings
      ARM: imx: remove last explicit users of virtual base address defines
      ARM: imx: change static io mapping to use a function
      ARM: imx/debug-macro: rework using the new io mapping macro
      ARM: imx: remove deprecated symbols as all users are gone now
      ARM: imx: dynamically allocate mxc_w1 devices
      ARM: imx: remove unused devices
      ARM: imx: dynamically allocate imx_udc device
      ARM: imx: allow specifying a dma mask when creating a platform device
      ARM: imx: dynamically allocate mx1-camera device
      ARM: imx/gpio: remove some useless casts
      ARM: imx: dynamically allocate mx2-camera device
      ARM: imx: dynamically allocate imx2-wdt devices
      ARM: imx: change the way flexcan devices are registered
      ARM: imx: dynamically register imx-fb devices
      ARM: mx3: enable SPI_IMX for better compile coverage
      ARM: imx: dynamically allocate mxc_pwm devices
      ARM: imx: dynamically register mxc-mmc devices
      ARM: imx: dynamically allocate mxc-ehci devices
      ARM: imx: dynamically allocate fsl-usb2-udc devices
      ARM: imx: dynamically allocate imx-keypad devices
      ARM: imx: dynamically allocate imx21-hcd devices
      ARM: imx: remove now empty devices.h
      ARM: imx: move registration of gpios to plat-mxc/gpio.c
      ARM: mx25: dynamically allocate mxc-ehci devices
      ARM: mx25: dynamically allocate fsl-usb2-udc devices
      ARM: mx25: dynamically allocate mxc_pwm devices
      ARM: mx25: move registration of gpios to plat-mxc/gpio.c
      ARM: mx25: dynamically allocate imx-keypad devices
      ARM: mx25: dynamically allocate imxdi_rtc devices
      ARM: mx25: dynamically allocatate imx-fb devices
      ARM: mx25: dynamically allocate imx2-wdt devices
      ARM: mx25: dynamically allocate mx2-camera devices
      ARM: mx25: remove now empty devices.h
      ARM: imx: move mx25 support to mach-imx
      ARM: imx: let IMX_HAVE_PLATFORM_IMX_FB select HAVE_FB_IMX
      ARM: imx: let the machines select SOC_IMX{21,27}
      ARM: imx: use SOC_IMX25 instead of ARCH_MX25 for multi-SoC
      ARM: mx3: move registration of gpios to plat-mxc/gpio.c
      ARM: mx3: use an MX35 constant in imx35 only code
      ARM: mx3: introduce SOC_IMX31 and SOC_IMX35
      ARM: mx3: dynamically register mxc-mmc devices
      ARM: mx3: dynamically allocate mxc_rnga devices
      ARM: mx3: dynamically allocate fsl-usb2-udc devices
      ARM: mx3: dynamically allocate mxc-ehci devices
      ARM: mx3: dynamically allocate imx2-wdt devices
      ARM: mx3: dynamically allocate imx-keypad devices
      ARM: mx3/mx35_3ds: Add watchdog support

 arch/arm/Makefile                                  |    2 +-
 arch/arm/configs/mx3_defconfig                     |    1 +
 arch/arm/mach-imx/Kconfig                          |  128 ++++-
 arch/arm/mach-imx/Makefile                         |    8 +-
 arch/arm/mach-imx/Makefile.boot                    |    4 +
 .../{mach-mx25/clock.c => mach-imx/clock-imx25.c}  |    0
 arch/arm/mach-imx/devices-imx21.h                  |   24 +
 arch/arm/mach-imx/devices-imx25.h                  |   86 +++
 arch/arm/mach-imx/devices-imx27.h                  |   35 ++
 arch/arm/mach-imx/devices.c                        |  553 --------------------
 arch/arm/mach-imx/devices.h                        |   29 -
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |   17 +-
 .../eukrea_mbimxsd25-baseboard.c}                  |    6 +-
 arch/arm/mach-imx/mach-cpuimx27.c                  |   21 +-
 .../mach-eukrea_cpuimx25.c}                        |   17 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |   12 +-
 arch/arm/mach-imx/mach-imx27lite.c                 |    1 -
 arch/arm/mach-imx/mach-mx1ads.c                    |    1 -
 arch/arm/mach-imx/mach-mx21ads.c                   |   20 +-
 arch/arm/{mach-mx25 => mach-imx}/mach-mx25_3ds.c   |   16 +-
 arch/arm/mach-imx/mach-mx27_3ds.c                  |   11 +-
 arch/arm/mach-imx/mach-mx27ads.c                   |   17 +-
 arch/arm/mach-imx/mach-mxt_td60.c                  |   11 +-
 arch/arm/mach-imx/mach-pca100.c                    |   33 +-
 arch/arm/mach-imx/mach-pcm038.c                    |   12 +-
 arch/arm/mach-imx/mach-scb9328.c                   |    1 -
 arch/arm/mach-imx/mm-imx1.c                        |    7 +-
 arch/arm/mach-imx/mm-imx21.c                       |   21 +-
 arch/arm/{mach-mx25/mm.c => mach-imx/mm-imx25.c}   |   27 +-
 arch/arm/mach-imx/mm-imx27.c                       |   21 +-
 arch/arm/mach-imx/pcm970-baseboard.c               |   12 +-
 arch/arm/mach-mx25/Kconfig                         |   34 --
 arch/arm/mach-mx25/Makefile                        |    5 -
 arch/arm/mach-mx25/Makefile.boot                   |    3 -
 arch/arm/mach-mx25/devices-imx25.h                 |   54 --
 arch/arm/mach-mx25/devices.c                       |  308 -----------
 arch/arm/mach-mx25/devices.h                       |   13 -
 arch/arm/mach-mx3/Kconfig                          |   69 ++-
 arch/arm/mach-mx3/Makefile                         |    7 +-
 arch/arm/mach-mx3/devices-imx31.h                  |   27 +
 arch/arm/mach-mx3/devices-imx35.h                  |   32 +-
 arch/arm/mach-mx3/devices.c                        |  271 +---------
 arch/arm/mach-mx3/devices.h                        |   10 -
 arch/arm/mach-mx3/mach-armadillo5x0.c              |   14 +-
 arch/arm/mach-mx3/mach-cpuimx35.c                  |   20 +-
 arch/arm/mach-mx3/mach-kzm_arm11_01.c              |    6 +-
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |   10 +-
 arch/arm/mach-mx3/mach-mx31lilly.c                 |    9 +-
 arch/arm/mach-mx3/mach-mx31lite.c                  |    5 +-
 arch/arm/mach-mx3/mach-mx31moboard.c               |   20 +-
 arch/arm/mach-mx3/mach-mx35_3ds.c                  |   11 +-
 arch/arm/mach-mx3/mach-pcm037.c                    |   23 +-
 arch/arm/mach-mx3/mach-pcm037_eet.c                |    2 +-
 arch/arm/mach-mx3/mach-pcm043.c                    |   16 +-
 arch/arm/mach-mx3/mm.c                             |   84 ++--
 arch/arm/mach-mx3/mx31lilly-db.c                   |    5 +-
 arch/arm/mach-mx3/mx31lite-db.c                    |    8 +-
 arch/arm/mach-mx3/mx31moboard-devboard.c           |   20 +-
 arch/arm/mach-mx3/mx31moboard-marxbot.c            |   21 +-
 arch/arm/mach-mx3/mx31moboard-smartbot.c           |   16 +-
 arch/arm/mach-mx5/mm.c                             |   35 +-
 arch/arm/mach-mxc91231/mm.c                        |   53 +--
 arch/arm/plat-mxc/Kconfig                          |    5 -
 arch/arm/plat-mxc/audmux-v2.c                      |    4 +-
 arch/arm/plat-mxc/devices.c                        |   23 +-
 arch/arm/plat-mxc/devices/Kconfig                  |   46 ++-
 arch/arm/plat-mxc/devices/Makefile                 |   14 +
 arch/arm/plat-mxc/devices/platform-esdhc.c         |    8 +-
 arch/arm/plat-mxc/devices/platform-fec.c           |    6 +-
 arch/arm/plat-mxc/devices/platform-flexcan.c       |   48 ++-
 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c  |   56 ++
 arch/arm/plat-mxc/devices/platform-imx-dma.c       |   18 +-
 arch/arm/plat-mxc/devices/platform-imx-fb.c        |   52 ++
 arch/arm/plat-mxc/devices/platform-imx-i2c.c       |   12 +-
 arch/arm/plat-mxc/devices/platform-imx-keypad.c    |   62 +++
 arch/arm/plat-mxc/devices/platform-imx-ssi.c       |   12 +-
 arch/arm/plat-mxc/devices/platform-imx-uart.c      |   12 +-
 arch/arm/plat-mxc/devices/platform-imx2-wdt.c      |   56 ++
 arch/arm/plat-mxc/devices/platform-imx21-hcd.c     |   41 ++
 arch/arm/plat-mxc/devices/platform-imx_udc.c       |   75 +++
 arch/arm/plat-mxc/devices/platform-imxdi_rtc.c     |   41 ++
 arch/arm/plat-mxc/devices/platform-mx1-camera.c    |   42 ++
 arch/arm/plat-mxc/devices/platform-mx2-camera.c    |   64 +++
 arch/arm/plat-mxc/devices/platform-mxc-ehci.c      |   69 +++
 arch/arm/plat-mxc/devices/platform-mxc-mmc.c       |   72 +++
 arch/arm/plat-mxc/devices/platform-mxc_nand.c      |    8 +-
 arch/arm/plat-mxc/devices/platform-mxc_pwm.c       |   60 +++
 arch/arm/plat-mxc/devices/platform-mxc_rnga.c      |   56 ++
 arch/arm/plat-mxc/devices/platform-mxc_w1.c        |   50 ++
 arch/arm/plat-mxc/devices/platform-spi_imx.c       |   12 +-
 arch/arm/plat-mxc/ehci.c                           |    8 +-
 arch/arm/plat-mxc/gpio.c                           |   97 ++++-
 arch/arm/plat-mxc/include/mach/debug-macro.S       |   23 +-
 arch/arm/plat-mxc/include/mach/devices-common.h    |  153 ++++++-
 arch/arm/plat-mxc/include/mach/hardware.h          |   87 +++-
 arch/arm/plat-mxc/include/mach/imxfb.h             |    3 +
 arch/arm/plat-mxc/include/mach/mx1.h               |  155 +-----
 arch/arm/plat-mxc/include/mach/mx21.h              |   50 +--
 arch/arm/plat-mxc/include/mach/mx25.h              |   41 +-
 arch/arm/plat-mxc/include/mach/mx27.h              |  101 +---
 arch/arm/plat-mxc/include/mach/mx2x.h              |  149 ------
 arch/arm/plat-mxc/include/mach/mx31.h              |   71 +--
 arch/arm/plat-mxc/include/mach/mx35.h              |   48 +--
 arch/arm/plat-mxc/include/mach/mx3x.h              |  182 +-------
 arch/arm/plat-mxc/include/mach/mx51.h              |   42 +--
 arch/arm/plat-mxc/include/mach/mxc91231.h          |   23 +-
 106 files changed, 2033 insertions(+), 2589 deletions(-)
 rename arch/arm/{mach-mx25/clock.c => mach-imx/clock-imx25.c} (100%)
 create mode 100644 arch/arm/mach-imx/devices-imx25.h
 delete mode 100644 arch/arm/mach-imx/devices.c
 delete mode 100644 arch/arm/mach-imx/devices.h
 rename arch/arm/{mach-mx25/eukrea_mbimxsd-baseboard.c => mach-imx/eukrea_mbimxsd25-baseboard.c} (97%)
 rename arch/arm/{mach-mx25/mach-cpuimx25.c => mach-imx/mach-eukrea_cpuimx25.c} (90%)
 rename arch/arm/{mach-mx25 => mach-imx}/mach-mx25_3ds.c (92%)
 rename arch/arm/{mach-mx25/mm.c => mach-imx/mm-imx25.c} (69%)
 delete mode 100644 arch/arm/mach-mx25/Kconfig
 delete mode 100644 arch/arm/mach-mx25/Makefile
 delete mode 100644 arch/arm/mach-mx25/Makefile.boot
 delete mode 100644 arch/arm/mach-mx25/devices-imx25.h
 delete mode 100644 arch/arm/mach-mx25/devices.c
 delete mode 100644 arch/arm/mach-mx25/devices.h
 create mode 100644 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-fb.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-keypad.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx2-wdt.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx21-hcd.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx_udc.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mx1-camera.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mx2-camera.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc-ehci.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc-mmc.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_pwm.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_rnga.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_w1.c


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
