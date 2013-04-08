From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 8 Apr 2013 14:52:42 +0200
Subject: [GIT PULL] ux500 multiplatform tags
Message-ID: <CACRpkdbPZ5Nvv9+Bz9UE-U6-9QpqAr6UKGyYrTAxj78SJaknvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks and Sam,

These are the two multiplatform tags for MFD and ARM SoC.

As agreed there is one tag for a number of MFD patches that
remove the <mach/*> dependencies from the DB8500 PRCMU
driver, then another tag dependent on the former that from that
point switches to multiplatform.

Below are two tags on git request-pull formar: the first one
is for *both* trees, MFD and ARM SoC, the second is only
for ARM SoC.

I have moved a few hunks and introduced a new patch in the
MFD series to make things compile and bisect properly.
Notably the patch "mfd: db8500-prcmu: drop unused includes"
is a new one, but the end result is textually equivalent to what
has already been posted so I consider this a reviewed patch
set and the split as plain mechanics.

Please pull your applicable branches!

Yours,
Linus Walleij


MFD tag:


The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-multiplatform-mfd

for you to fetch changes up to 55b175d7e6327939df82592ef279c534da323354:

  ARM: ux500: split out prcmu initialization (2013-04-08 13:58:15 +0200)

----------------------------------------------------------------
MFD portions of the ux500 multiplatform branch.
A second tag for the ARM SoC tree will build upon
this one. This mainly removes the header file
dependencies from the PRCMU driver in the MFD
subsystem, and moves the PM functions to the
machine.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: ux500: split out prcmu initialization

Linus Walleij (4):
      mfd: prcmu: pass a base and size with the early initcall
      mfd: db8500-prcmu: get base address from resource
      ARM: ux500: move PM-related PRCMU functions to machine
      mfd: db8500-prcmu: drop unused includes

 arch/arm/mach-ux500/Makefile                   |   2 +-
 arch/arm/mach-ux500/board-mop500.c             |  58 -----
 arch/arm/mach-ux500/cpu-db8500.c               |   2 -
 arch/arm/mach-ux500/cpu.c                      |  21 +-
 arch/arm/mach-ux500/cpuidle.c                  |   3 +-
 arch/arm/mach-ux500/devices-db8500.c           |   2 +
 arch/arm/mach-ux500/include/mach/hardware.h    |   2 -
 arch/arm/mach-ux500/include/mach/irqs-db8500.h |  25 --
 arch/arm/mach-ux500/pm.c                       | 167 +++++++++++++
 drivers/mfd/db8500-prcmu.c                     | 316 ++++++++++++-------------
 drivers/mfd/dbx500-prcmu-regs.h                | 204 +++++++---------
 include/linux/mfd/db8500-prcmu.h               |  10 +-
 include/linux/mfd/dbx500-prcmu.h               |  38 +--
 include/linux/platform_data/arm-ux500-pm.h     |  21 ++
 14 files changed, 454 insertions(+), 417 deletions(-)
 create mode 100644 arch/arm/mach-ux500/pm.c
 create mode 100644 include/linux/platform_data/arm-ux500-pm.h


ARM SoC tag:

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-multiplatform-asoc

for you to fetch changes up to f6f1bdac9d3006e246e82672322dcd7e7e0863fd:

  ARM: ux500: build hotplug.o for ARMv7-a (2013-04-08 13:59:54 +0200)

----------------------------------------------------------------
Ux500 multiplatform support.
This tag builds upon the MFD-specific base
tag "ux500-multiplatform-mfd". This removes
all <mach/*> dependencies and makes the ux500
fully multi-platform.

----------------------------------------------------------------
Arnd Bergmann (7):
      ARM: ux500: split out prcmu initialization
      ARM: ux500: move mach/msp.h to <linux/platform_data/*>
      staging: ste_rmi4: kill platform_data hack
      ARM: ux500: make irqs.h local to platform
      ARM: ux500: make remaining headers local
      ARM: ux500: move to multiplatform
      ARM: ux500: build hotplug.o for ARMv7-a

Linus Walleij (8):
      mfd: prcmu: pass a base and size with the early initcall
      mfd: db8500-prcmu: get base address from resource
      ARM: ux500: move PM-related PRCMU functions to machine
      mfd: db8500-prcmu: drop unused includes
      ARM: ux500: move debugmacro to debug includes
      ARM: ux500: make debug macro stand-alone
      clk: ux500: pass clock base adresses in init call
      ARM: ux500: get rid of <mach/[hardware|db8500-regs].h>

 arch/arm/Kconfig                                   |  15 -
 arch/arm/Kconfig.debug                             |   8 +
 arch/arm/include/debug/ux500.S                     |  48 ++++
 arch/arm/mach-ux500/Kconfig                        |  14 +
 arch/arm/mach-ux500/Makefile                       |   4 +-
 arch/arm/mach-ux500/board-mop500-audio.c           |   7 +-
 arch/arm/mach-ux500/board-mop500-pins.c            |   2 -
 arch/arm/mach-ux500/board-mop500-sdi.c             |   4 +-
 arch/arm/mach-ux500/board-mop500-u8500uib.c        |   9 +-
 arch/arm/mach-ux500/board-mop500-uib.c             |   1 -
 arch/arm/mach-ux500/board-mop500.c                 |  66 +----
 arch/arm/mach-ux500/board-mop500.h                 |   4 +-
 arch/arm/mach-ux500/cache-l2x0.c                   |   2 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |  12 +-
 arch/arm/mach-ux500/cpu.c                          |  33 ++-
 arch/arm/mach-ux500/cpuidle.c                      |   5 +-
 .../mach-ux500/{include/mach => }/db8500-regs.h    |  28 ++
 arch/arm/mach-ux500/devices-common.c               |   3 +-
 arch/arm/mach-ux500/devices-db8500.c               |   8 +-
 arch/arm/mach-ux500/devices-db8500.h               |   3 +-
 arch/arm/mach-ux500/devices.c                      |   5 +-
 arch/arm/mach-ux500/{include/mach => }/devices.h   |   0
 arch/arm/mach-ux500/hotplug.c                      |   2 +-
 arch/arm/mach-ux500/id.c                           |   4 +-
 arch/arm/mach-ux500/include/mach/debug-macro.S     |  39 ---
 arch/arm/mach-ux500/include/mach/hardware.h        |  47 ---
 arch/arm/mach-ux500/include/mach/timex.h           |   6 -
 arch/arm/mach-ux500/include/mach/uncompress.h      |  57 ----
 .../{include/mach => }/irqs-board-mop500.h         |   0
 .../mach-ux500/{include/mach => }/irqs-db8500.h    |  25 --
 arch/arm/mach-ux500/{include/mach => }/irqs.h      |   6 +-
 arch/arm/mach-ux500/platsmp.c                      |   4 +-
 arch/arm/mach-ux500/pm.c                           | 167 +++++++++++
 arch/arm/mach-ux500/{include/mach => }/setup.h     |   0
 arch/arm/mach-ux500/timer.c                        |   6 +-
 arch/arm/mach-ux500/usb.c                          |   2 +-
 drivers/clk/ux500/clk-prcc.c                       |   1 -
 drivers/clk/ux500/u8500_clk.c                      | 142 ++++-----
 drivers/clocksource/clksrc-dbx500-prcmu.c          |   3 -
 drivers/crypto/ux500/cryp/cryp.c                   |   2 -
 drivers/crypto/ux500/cryp/cryp_core.c              |   1 -
 drivers/crypto/ux500/hash/hash_core.c              |   1 -
 drivers/mfd/db8500-prcmu.c                         | 316 ++++++++++-----------
 drivers/mfd/dbx500-prcmu-regs.h                    | 204 ++++++-------
 drivers/staging/ste_rmi4/Makefile                  |   1 -
 .../staging/ste_rmi4/board-mop500-u8500uib-rmi4.c  |  31 --
 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c      |  31 +-
 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.h      |   1 -
 include/linux/mfd/db8500-prcmu.h                   |  10 +-
 include/linux/mfd/dbx500-prcmu.h                   |  38 +--
 include/linux/platform_data/arm-ux500-pm.h         |  21 ++
 .../linux/platform_data/asoc-ux500-msp.h           |   0
 include/linux/platform_data/clk-ux500.h            |   3 +-
 sound/soc/ux500/mop500_ab8500.c                    |   2 -
 sound/soc/ux500/ux500_msp_dai.c                    |   4 +-
 sound/soc/ux500/ux500_msp_i2s.c                    |   4 +-
 sound/soc/ux500/ux500_msp_i2s.h                    |   2 -
 57 files changed, 699 insertions(+), 765 deletions(-)
 create mode 100644 arch/arm/include/debug/ux500.S
 rename arch/arm/mach-ux500/{include/mach => }/db8500-regs.h (88%)
 rename arch/arm/mach-ux500/{include/mach => }/devices.h (100%)
 delete mode 100644 arch/arm/mach-ux500/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-ux500/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/uncompress.h
 rename arch/arm/mach-ux500/{include/mach => }/irqs-board-mop500.h (100%)
 rename arch/arm/mach-ux500/{include/mach => }/irqs-db8500.h (83%)
 rename arch/arm/mach-ux500/{include/mach => }/irqs.h (93%)
 create mode 100644 arch/arm/mach-ux500/pm.c
 rename arch/arm/mach-ux500/{include/mach => }/setup.h (100%)
 delete mode 100644 drivers/staging/ste_rmi4/board-mop500-u8500uib-rmi4.c
 create mode 100644 include/linux/platform_data/arm-ux500-pm.h
 rename arch/arm/mach-ux500/include/mach/msp.h =>
include/linux/platform_data/asoc-ux500-msp.h (100%)
