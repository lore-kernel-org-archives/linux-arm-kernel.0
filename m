From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:23:51 -0700
Subject: [PATCH 00/34] davinci updates for 2.6.35
Message-ID: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of updates to the TI DaVinci family is targetted for 2.6.35.

The bulk of the changes are some restructuring work to make room from
some new SoCs in this family (tnetv107x) that needed a little more
flexibility in some areas.

These are also currently included in linux-next and are available as
the davinci-next branch of the davinci git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git

Kevin



Anuj Aggarwal (1):
  davinci: edma: clear interrupt status for interrupt enabled channels
    only

Cyril Chemparathy (20):
  Davinci: allow SOCs based on other ARM CPUs
  Davinci: enable timer clock before use
  Davinci: cpintc host map configuration
  Davinci: support LPSC SwRstDisable state
  Davinci: promote da8xx_pinmux_setup()
  Davinci: tnetv107x pin list
  Davinci: tnetv107x LPSC modules
  Davinci: tnetv107x IRQ definitions
  Davinci: tnetv107x cpu types
  Davinci: configurable pll divider mask
  Davinci: gpio - minor cleanup
  Davinci: gpio - structs and functions renamed
  Davinci: gpio - register layout invariant inlines
  Davinci: gpio - controller type support
  Davinci: gpio - fine grained locking
  Davinci: eliminate pinmux offset verbosity
  Davinci: watchdog reset separation across socs
  Davinci: serial - remove unnecessary define
  Davinci: serial - use ioremap()
  Davinci: serial - conditional reset via pwremu

Kevin Hilman (2):
  davinci: misc cleanups from sparse
  davinci: sparse: gpio: void casting

Miguel Aguilar (1):
  RTC: DaVinci RTC driver

Sekhar Nori (3):
  rtc: omap: let device wakeup capability be configured from chip init
    logic
  davinci: edma: use a more intuitive name for edma_info
  davinci: edma: fix coding style issue related to usage of braces

Sergei Shtylyov (3):
  DaVinci: move AEMIF #define's to the proper headers
  DA830 EVM: use DA8XX_AEMIF_*_BASE #define's
  DaVinci: move IDE platform device to its proper place

Thomas Koeller (2):
  davinci: DM365: Allow use of GPIO64_57
  davinci: mach/common.h: add missing includes

Vipin Bhandari (2):
  davinci: da830/omap-l137 evm: add support for GPIO based MMC/SD card
    detection
  davinci: da830/omap-l137 evm: use 8-wire MMC/SD card support

 arch/arm/Kconfig                             |    1 -
 arch/arm/mach-davinci/Kconfig                |    2 +
 arch/arm/mach-davinci/board-da830-evm.c      |   44 ++-
 arch/arm/mach-davinci/board-da850-evm.c      |   20 +-
 arch/arm/mach-davinci/board-dm355-evm.c      |   11 +-
 arch/arm/mach-davinci/board-dm355-leopard.c  |   11 +-
 arch/arm/mach-davinci/board-dm365-evm.c      |    5 -
 arch/arm/mach-davinci/board-dm644x-evm.c     |   53 +--
 arch/arm/mach-davinci/board-dm646x-evm.c     |   13 +-
 arch/arm/mach-davinci/board-neuros-osd2.c    |   47 +--
 arch/arm/mach-davinci/board-sffsdr.c         |   13 +-
 arch/arm/mach-davinci/cdce949.c              |    1 +
 arch/arm/mach-davinci/clock.c                |   22 +-
 arch/arm/mach-davinci/clock.h                |    9 +-
 arch/arm/mach-davinci/common.c               |    3 +
 arch/arm/mach-davinci/cp_intc.c              |    6 +-
 arch/arm/mach-davinci/da830.c                |    3 +
 arch/arm/mach-davinci/da850.c                |    3 +
 arch/arm/mach-davinci/devices-da8xx.c        |    4 +-
 arch/arm/mach-davinci/devices.c              |   46 ++
 arch/arm/mach-davinci/dm355.c                |    9 +-
 arch/arm/mach-davinci/dm365.c                |   10 +-
 arch/arm/mach-davinci/dm644x.c               |    9 +-
 arch/arm/mach-davinci/dm646x.c               |   41 +--
 arch/arm/mach-davinci/dma.c                  |  182 ++++----
 arch/arm/mach-davinci/gpio.c                 |  154 ++++---
 arch/arm/mach-davinci/include/mach/common.h  |   11 +
 arch/arm/mach-davinci/include/mach/cp_intc.h |    2 +-
 arch/arm/mach-davinci/include/mach/cputype.h |    8 +
 arch/arm/mach-davinci/include/mach/da8xx.h   |   29 +-
 arch/arm/mach-davinci/include/mach/dm355.h   |    3 +
 arch/arm/mach-davinci/include/mach/dm365.h   |    4 +
 arch/arm/mach-davinci/include/mach/dm644x.h  |    6 +
 arch/arm/mach-davinci/include/mach/dm646x.h  |    4 +-
 arch/arm/mach-davinci/include/mach/gpio.h    |   72 ++--
 arch/arm/mach-davinci/include/mach/irqs.h    |   97 ++++
 arch/arm/mach-davinci/include/mach/mux.h     |  277 +++++++++++
 arch/arm/mach-davinci/include/mach/psc.h     |   55 ++-
 arch/arm/mach-davinci/include/mach/serial.h  |    1 -
 arch/arm/mach-davinci/include/mach/system.h  |    5 +-
 arch/arm/mach-davinci/mux.c                  |    2 +-
 arch/arm/mach-davinci/mux.h                  |    2 +-
 arch/arm/mach-davinci/psc.c                  |    3 +-
 arch/arm/mach-davinci/serial.c               |   34 +-
 arch/arm/mach-davinci/time.c                 |   15 +-
 drivers/rtc/Kconfig                          |   10 +
 drivers/rtc/Makefile                         |    1 +
 drivers/rtc/rtc-davinci.c                    |  673 ++++++++++++++++++++++++++
 drivers/rtc/rtc-omap.c                       |   12 +-
 49 files changed, 1591 insertions(+), 457 deletions(-)
 create mode 100644 drivers/rtc/rtc-davinci.c
