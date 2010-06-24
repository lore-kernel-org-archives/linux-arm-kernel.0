From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:48:56 +0200
Subject: No subject
Message-ID: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this is the next step in the project "clean up the imx port" targeting
2.6.36.  The highlights this time are:

 - Unification of mach-mx2 and mach-mx1 into mach-imx
 - start allocating devices dynamically
   This should reduce the memory footprint because (in the end) no
   unused struct platform_device, struct resource or struct
   $platformdatafordriverX are kept in memory.  This also cleans up
   with naming conflicts.

This is intermixed with various fixes and simplifications.

I have to admit that some patches could have squashed but squashing them
now would be more work that it's worth so I kept them as they are now.

The patches are based on 67a3e12b05e055c0415c556a315a3d3eb637e29e

  Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)

and are available in the git repository at:
  git://git.pengutronix.de/git/ukl/linux-2.6.git imx/for-2.6.36

plus sent as a reply to this mail.  Shortlog and diffstat are to be
found below.

Have fun
Uwe

Uwe Kleine-K?nig (61):
      ARM: mx3: rename mach-mx35pdk.c to mach-mx35_3ds.c matching its arch number
      ARM: mx25: rename mach-mx25pdk.c to mach-mx25_3ds.c matching its arch number
      ARM: mx1: don't use deprecated symbol names
      ARM: mx1/scb9328: fix type of uart1_mxc_exit to make compiler happy
      ARM: mx2/mx27_3ds: document alternative names and remove empty header
      ARM: imx: remove empty and unused board headers
      ARM: mx3/kzm_arm11_01: fold board header in its only user
      ARM: mx2/mx21ads: fold board header in its only user
      ARM: mx2/mx27ads: fold board header in its only user
      ARM: mx3/qong: get rid of nearly empty header
      ARM: mx3/mx31_3ds: fold board header in its only user
      ARM: mx3/mx31ads: fold board header in its only user
      ARM: mxc: grammar fix
      ARM: imx: rename mach dir for mx21 and mx27 to mach-imx
      ARM: imx/mx1: fold crm_regs.h into its only consumer
      ARM: imx: get rid of mxc_gpio_init
      ARM: imx: fold serial.c into devices.c
      ARM: imx1: rename imx_csi_device to match its .name
      ARM: imx1: rename imx_i2c_device to follow a common naming scheme
      ARM: imx1: rename imx_uart[12]_device to follow a common naming scheme
      ARM: mx3: mx31lilly: fix build error for !CONFIG_USB_ULPI
      ARM: imx: rename mxc_uart_devicex to follow a common naming scheme
      ARM: imx: move mx1 support to mach-imx
      ARM: imx: Kconfig: use an if block instead of a depend for many symbols
      ARM: imx: prepare deprecating ARCH_MX1, MACH_MX2, MACH_MX21 and MACH_MX27
      ARM: imx: prepare deprecating ARCH_MX1, MACH_MX2, MACH_MX21 and MACH_MX27
      ARM: imx: new Kconfig symbol and feature test macro for DMA on mx1 and mx2
      ARM: imx: new helper function imx_add_platform_device
      MTD: mxc_nand: make bit fields unsigned to please sparse
      ARM: imx: remove paragraphs with old address of the FSF
      ARM: mx25: remove paragraphs with old address of the FSF
      ARM: mx3: remove paragraphs with old address of the FSF
      ARM: mxc91231: remove paragraphs with old address of the FSF
      ARM: mxc: remove paragraphs with old address of the FSF
      ARM: imx: Change the way nand devices are registered (generic part)
      ARM: imx: Change the way nand devices are registered (imx21)
      ARM: imx: Change the way nand devices are registered (imx25)
      ARM: imx: Change the way nand devices are registered (imx27)
      ARM: imx: Change the way nand devices are registered (imx31)
      ARM: imx: Change the way nand devices are registered (imx35)
      ARM: imx: dynamically register imx-i2c devices (generic part)
      ARM: imx: dynamically register imx-i2c devices (imx1)
      ARM: imx: dynamically register imx-i2c devices (imx21)
      ARM: imx: dynamically register imx-i2c devices (imx25)
      ARM: imx: dynamically register imx-i2c devices (imx27)
      ARM: imx: dynamically register imx-i2c devices (imx31)
      ARM: imx: dynamically register imx-i2c devices (imx35)
      ARM: imx: dynamically register spi_imx devices (generic part)
      ARM: imx: dynamically register spi_imx devices (imx21)
      ARM: imx: dynamically register spi_imx devices (imx25)
      ARM: imx: dynamically register spi_imx devices (imx27)
      ARM: imx: dynamically register spi_imx devices (imx31)
      ARM: imx: dynamically register spi_imx devices (imx35)
      ARM: imx: dynamically register imx-uart devices (generic part)
      ARM: imx: dynamically register imx-uart devices (imx1)
      ARM: imx: dynamically register imx-uart devices (imx21)
      ARM: imx: dynamically register imx-uart devices (imx25)
      ARM: imx: dynamically register imx-uart devices (imx27)
      ARM: imx: dynamically register imx-uart devices (imx31)
      ARM: imx: dynamically register imx-uart devices (imx35)
      ARM: mx3: complement uart init routine with an exit routine

 arch/arm/Makefile                                  |    4 +-
 arch/arm/mach-imx/Kconfig                          |  186 +++++++++++
 arch/arm/{mach-mx2 => mach-imx}/Makefile           |   18 +-
 arch/arm/{mach-mx2 => mach-imx}/Makefile.boot      |    4 +
 .../{mach-mx1/clock.c => mach-imx/clock-imx1.c}    |   50 +++-
 .../clock_imx21.c => mach-imx/clock-imx21.c}       |    0
 .../clock_imx27.c => mach-imx/clock-imx27.c}       |    0
 .../{mach-mx2/cpu_imx27.c => mach-imx/cpu-imx27.c} |    0
 arch/arm/mach-imx/devices-imx1.h                   |   18 +
 arch/arm/mach-imx/devices-imx21.h                  |   30 ++
 arch/arm/mach-imx/devices-imx27.h                  |   38 +++
 arch/arm/{mach-mx2 => mach-imx}/devices.c          |  250 +++++++++------
 arch/arm/{mach-mx2 => mach-imx}/devices.h          |   30 +--
 .../{plat-mxc/dma-mx1-mx2.c => mach-imx/dma-v1.c}  |    4 +-
 .../eukrea_mbimx27-baseboard.c                     |   19 +-
 arch/arm/mach-imx/include/mach/dma-mx1-mx2.h       |   10 +
 .../include/mach/dma-v1.h}                         |   10 +-
 arch/arm/{mach-mx2 => mach-imx}/mach-cpuimx27.c    |   25 +-
 arch/arm/{mach-mx2 => mach-imx}/mach-imx27lite.c   |   11 +-
 arch/arm/{mach-mx1 => mach-imx}/mach-mx1ads.c      |   34 +-
 arch/arm/{mach-mx2 => mach-imx}/mach-mx21ads.c     |   58 +++-
 arch/arm/{mach-mx2 => mach-imx}/mach-mx27_3ds.c    |   17 +-
 arch/arm/{mach-mx2 => mach-imx}/mach-mx27ads.c     |   76 +++--
 arch/arm/{mach-mx2 => mach-imx}/mach-mxt_td60.c    |   36 +--
 arch/arm/{mach-mx2 => mach-imx}/mach-pca100.c      |   23 +-
 arch/arm/{mach-mx2 => mach-imx}/mach-pcm038.c      |   33 +--
 arch/arm/{mach-mx1 => mach-imx}/mach-scb9328.c     |   21 +-
 .../arm/{mach-mx1/generic.c => mach-imx/mm-imx1.c} |   23 +-
 arch/arm/{mach-mx2 => mach-imx}/mm-imx21.c         |    5 +-
 arch/arm/{mach-mx2 => mach-imx}/mm-imx27.c         |    5 +-
 .../ksym_mx1.c => mach-imx/mx1-camera-fiq-ksym.c}  |    0
 .../mx1_camera_fiq.S => mach-imx/mx1-camera-fiq.S} |    0
 arch/arm/{mach-mx2 => mach-imx}/pcm970-baseboard.c |    0
 arch/arm/mach-mx1/Kconfig                          |   19 -
 arch/arm/mach-mx1/Makefile                         |   15 -
 arch/arm/mach-mx1/Makefile.boot                    |    4 -
 arch/arm/mach-mx1/crm_regs.h                       |   55 ---
 arch/arm/mach-mx1/devices.c                        |  242 --------------
 arch/arm/mach-mx1/devices.h                        |    7 -
 arch/arm/mach-mx2/Kconfig                          |  116 -------
 arch/arm/mach-mx2/serial.c                         |  141 --------
 arch/arm/mach-mx25/Kconfig                         |    2 +
 arch/arm/mach-mx25/Makefile                        |    2 +-
 arch/arm/mach-mx25/devices-imx25.h                 |   38 +++
 arch/arm/mach-mx25/devices.c                       |  231 +-------------
 arch/arm/mach-mx25/devices.h                       |   12 -
 .../mach-mx25/{mach-mx25pdk.c => mach-mx25_3ds.c}  |   21 +-
 arch/arm/mach-mx25/mm.c                            |    7 +-
 arch/arm/mach-mx3/Kconfig                          |   26 ++
 arch/arm/mach-mx3/Makefile                         |    2 +-
 arch/arm/mach-mx3/devices-imx31.h                  |   38 +++
 arch/arm/mach-mx3/devices-imx35.h                  |   32 ++
 arch/arm/mach-mx3/devices.c                        |  247 +--------------
 arch/arm/mach-mx3/devices.h                        |   13 -
 arch/arm/mach-mx3/mach-armadillo5x0.c              |   17 +-
 arch/arm/mach-mx3/mach-kzm_arm11_01.c              |   31 ++-
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |   64 +++--
 arch/arm/mach-mx3/mach-mx31ads.c                   |   55 +++-
 arch/arm/mach-mx3/mach-mx31lilly.c                 |   47 ++--
 arch/arm/mach-mx3/mach-mx31lite.c                  |   17 +-
 arch/arm/mach-mx3/mach-mx31moboard.c               |   50 ++--
 .../mach-mx3/{mach-mx35pdk.c => mach-mx35_3ds.c}   |   16 +-
 arch/arm/mach-mx3/mach-pcm037.c                    |   31 +-
 arch/arm/mach-mx3/mach-pcm037_eet.c                |    7 +-
 arch/arm/mach-mx3/mach-pcm043.c                    |   25 +-
 arch/arm/mach-mx3/mach-qong.c                      |   16 +-
 arch/arm/mach-mx3/mm.c                             |    7 +-
 arch/arm/mach-mx3/mx31lilly-db.c                   |   14 +-
 arch/arm/mach-mx3/mx31lite-db.c                    |   15 +-
 arch/arm/mach-mx3/mx31moboard-devboard.c           |   10 +-
 arch/arm/mach-mx3/mx31moboard-marxbot.c            |    4 -
 arch/arm/mach-mx3/mx31moboard-smartbot.c           |   11 +-
 arch/arm/mach-mx5/devices.c                        |    2 +-
 arch/arm/mach-mx5/mm.c                             |    3 +
 arch/arm/mach-mxc91231/crm_regs.h                  |    5 -
 arch/arm/mach-mxc91231/devices.c                   |    2 +-
 arch/arm/mach-mxc91231/mm.c                        |    8 +-
 arch/arm/plat-mxc/Kconfig                          |   10 +-
 arch/arm/plat-mxc/Makefile                         |    4 +-
 arch/arm/plat-mxc/audmux-v1.c                      |    4 -
 arch/arm/plat-mxc/audmux-v2.c                      |    4 -
 arch/arm/plat-mxc/devices.c                        |   33 ++
 arch/arm/plat-mxc/devices/Kconfig                  |   11 +
 arch/arm/plat-mxc/devices/Makefile                 |    4 +
 arch/arm/plat-mxc/devices/platform-imx-i2c.c       |   29 ++
 arch/arm/plat-mxc/devices/platform-imx-uart.c      |   60 ++++
 arch/arm/plat-mxc/devices/platform-mxc_nand.c      |   44 +++
 arch/arm/plat-mxc/devices/platform-spi_imx.c       |   30 ++
 arch/arm/plat-mxc/ehci.c                           |    4 -
 .../arm/plat-mxc/include/mach/board-armadillo5x0.h |   15 -
 .../plat-mxc/include/mach/board-eukrea_cpuimx27.h  |    2 +-
 arch/arm/plat-mxc/include/mach/board-kzmarm11.h    |   39 ---
 arch/arm/plat-mxc/include/mach/board-mx21ads.h     |   52 ---
 arch/arm/plat-mxc/include/mach/board-mx27ads.h     |  344 --------------------
 arch/arm/plat-mxc/include/mach/board-mx27lite.h    |   14 -
 arch/arm/plat-mxc/include/mach/board-mx27pdk.h     |   14 -
 arch/arm/plat-mxc/include/mach/board-mx31_3ds.h    |   59 ----
 arch/arm/plat-mxc/include/mach/board-mx31ads.h     |  117 -------
 arch/arm/plat-mxc/include/mach/board-mx31lilly.h   |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31lite.h    |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31moboard.h |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx35pdk.h     |   22 --
 arch/arm/plat-mxc/include/mach/board-pcm037.h      |   22 --
 arch/arm/plat-mxc/include/mach/board-pcm038.h      |    2 +-
 arch/arm/plat-mxc/include/mach/board-pcm043.h      |   22 --
 arch/arm/plat-mxc/include/mach/board-qong.h        |   17 -
 arch/arm/plat-mxc/include/mach/devices-common.h    |   42 +++
 arch/arm/plat-mxc/include/mach/iomux-mxc91231.h    |    4 -
 arch/arm/plat-mxc/include/mach/mx1.h               |   28 +-
 arch/arm/plat-mxc/include/mach/mx25.h              |   28 ++-
 arch/arm/plat-mxc/include/mach/mx27.h              |    4 +-
 arch/arm/plat-mxc/include/mach/mx31.h              |    4 +-
 arch/arm/plat-mxc/include/mach/mx35.h              |    4 +-
 arch/arm/plat-mxc/include/mach/mx3_camera.h        |    4 -
 arch/arm/plat-mxc/include/mach/mxc91231.h          |    4 -
 arch/arm/plat-mxc/include/mach/mxc_nand.h          |    6 +-
 arch/arm/plat-mxc/include/mach/system.h            |    4 -
 arch/arm/plat-mxc/include/mach/timex.h             |    4 -
 arch/arm/plat-mxc/include/mach/uncompress.h        |    4 -
 arch/arm/plat-mxc/include/mach/vmalloc.h           |    4 -
 arch/arm/plat-mxc/irq.c                            |    3 -
 arch/arm/plat-mxc/system.c                         |    4 -
 arch/arm/plat-mxc/tzic.c                           |    2 -
 123 files changed, 1424 insertions(+), 2478 deletions(-)
 create mode 100644 arch/arm/mach-imx/Kconfig
 rename arch/arm/{mach-mx2 => mach-imx}/Makefile (55%)
 rename arch/arm/{mach-mx2 => mach-imx}/Makefile.boot (67%)
 rename arch/arm/{mach-mx1/clock.c => mach-imx/clock-imx1.c} (90%)
 rename arch/arm/{mach-mx2/clock_imx21.c => mach-imx/clock-imx21.c} (100%)
 rename arch/arm/{mach-mx2/clock_imx27.c => mach-imx/clock-imx27.c} (100%)
 rename arch/arm/{mach-mx2/cpu_imx27.c => mach-imx/cpu-imx27.c} (100%)
 create mode 100644 arch/arm/mach-imx/devices-imx1.h
 create mode 100644 arch/arm/mach-imx/devices-imx21.h
 create mode 100644 arch/arm/mach-imx/devices-imx27.h
 rename arch/arm/{mach-mx2 => mach-imx}/devices.c (73%)
 rename arch/arm/{mach-mx2 => mach-imx}/devices.h (54%)
 rename arch/arm/{plat-mxc/dma-mx1-mx2.c => mach-imx/dma-v1.c} (99%)
 rename arch/arm/{mach-mx2 => mach-imx}/eukrea_mbimx27-baseboard.c (93%)
 create mode 100644 arch/arm/mach-imx/include/mach/dma-mx1-mx2.h
 rename arch/arm/{plat-mxc/include/mach/dma-mx1-mx2.h => mach-imx/include/mach/dma-v1.h} (93%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-cpuimx27.c (90%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-imx27lite.c (86%)
 rename arch/arm/{mach-mx1 => mach-imx}/mach-mx1ads.c (81%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mx21ads.c (77%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mx27_3ds.c (85%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mx27ads.c (82%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mxt_td60.c (86%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-pca100.c (93%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-pcm038.c (91%)
 rename arch/arm/{mach-mx1 => mach-imx}/mach-scb9328.c (89%)
 rename arch/arm/{mach-mx1/generic.c => mach-imx/mm-imx1.c} (68%)
 rename arch/arm/{mach-mx2 => mach-imx}/mm-imx21.c (95%)
 rename arch/arm/{mach-mx2 => mach-imx}/mm-imx27.c (95%)
 rename arch/arm/{mach-mx1/ksym_mx1.c => mach-imx/mx1-camera-fiq-ksym.c} (100%)
 rename arch/arm/{mach-mx1/mx1_camera_fiq.S => mach-imx/mx1-camera-fiq.S} (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/pcm970-baseboard.c (100%)
 delete mode 100644 arch/arm/mach-mx1/Kconfig
 delete mode 100644 arch/arm/mach-mx1/Makefile
 delete mode 100644 arch/arm/mach-mx1/Makefile.boot
 delete mode 100644 arch/arm/mach-mx1/crm_regs.h
 delete mode 100644 arch/arm/mach-mx1/devices.c
 delete mode 100644 arch/arm/mach-mx1/devices.h
 delete mode 100644 arch/arm/mach-mx2/Kconfig
 delete mode 100644 arch/arm/mach-mx2/serial.c
 create mode 100644 arch/arm/mach-mx25/devices-imx25.h
 rename arch/arm/mach-mx25/{mach-mx25pdk.c => mach-mx25_3ds.c} (91%)
 create mode 100644 arch/arm/mach-mx3/devices-imx31.h
 create mode 100644 arch/arm/mach-mx3/devices-imx35.h
 rename arch/arm/mach-mx3/{mach-mx35pdk.c => mach-mx35_3ds.c} (89%)
 create mode 100644 arch/arm/plat-mxc/devices/Kconfig
 create mode 100644 arch/arm/plat-mxc/devices/Makefile
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-i2c.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-uart.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_nand.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-spi_imx.c
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-armadillo5x0.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-kzmarm11.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx21ads.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx27ads.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx27lite.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx27pdk.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx31_3ds.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx31ads.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx35pdk.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-pcm037.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-pcm043.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-qong.h
 create mode 100644 arch/arm/plat-mxc/include/mach/devices-common.h
