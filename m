From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 27 Feb 2018 13:27:43 +0530
Subject: [GIT PULL 1/3] DaVinci SoC support updates for v4.17
Message-ID: <20180227075745.23970-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.17/soc

for you to fetch changes up to 96c081735d5197d9d4fa0b6ce84cffa3bb197474:

  ARM: davinci: move davinci_clk_init() to init_time (2018-02-19 16:25:15 +0530)

----------------------------------------------------------------
Miscellaneous DaVinci SoC support improvements for v4.17

* rationalization of con_id names for phy clocks to make DT conversion easy

* A patch to move away from syscon as platform device. This is needed for
  common clock framework conversion as well as helps get rid of
  syscon_regmap_lookup_by_pdevname() by removing the last known user.

* convert mach-davinci to use reset support available in watchdog driver

* a non-critical warning fix. It has been around since beginning so not sending
  as a standalone fix for -rc cycle.

* moving mach-davinci clock init to .init_time() for legacy boot. This is
  again in preparation for CCF conversion.

----------------------------------------------------------------
David Lechner (4):
      phy: da8xx-usb: rename clock con_ids
      ARM: da8xx: use platform data for CFGCHIP syscon regmap
      ARM: davinci: remove watchdog reset
      ARM: davinci: move davinci_clk_init() to init_time

Sekhar Nori (1):
      ARM: davinci: board-da830-evm: fix unused const variable warning

 arch/arm/mach-davinci/board-da830-evm.c     | 35 ++++++++---------
 arch/arm/mach-davinci/board-da850-evm.c     |  7 +---
 arch/arm/mach-davinci/board-dm355-evm.c     |  3 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |  3 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |  3 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |  3 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    | 21 +++++++----
 arch/arm/mach-davinci/board-mityomapl138.c  |  7 +---
 arch/arm/mach-davinci/board-neuros-osd2.c   |  3 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |  7 +---
 arch/arm/mach-davinci/board-sffsdr.c        |  3 +-
 arch/arm/mach-davinci/clock.h               |  3 --
 arch/arm/mach-davinci/da830.c               |  7 +++-
 arch/arm/mach-davinci/da850.c               |  7 +++-
 arch/arm/mach-davinci/da8xx-dt.c            |  3 +-
 arch/arm/mach-davinci/davinci.h             |  4 ++
 arch/arm/mach-davinci/devices-da8xx.c       | 58 ++++++++++++-----------------
 arch/arm/mach-davinci/devices.c             |  7 +---
 arch/arm/mach-davinci/dm355.c               |  8 +++-
 arch/arm/mach-davinci/dm365.c               |  8 +++-
 arch/arm/mach-davinci/dm644x.c              |  8 +++-
 arch/arm/mach-davinci/dm646x.c              | 22 +++++------
 arch/arm/mach-davinci/include/mach/common.h |  2 -
 arch/arm/mach-davinci/include/mach/da8xx.h  |  7 +++-
 arch/arm/mach-davinci/time.c                | 57 ----------------------------
 arch/arm/mach-davinci/usb-da8xx.c           | 18 ++++++---
 drivers/phy/ti/phy-da8xx-usb.c              | 16 ++++----
 include/linux/platform_data/phy-da8xx-usb.h | 21 +++++++++++
 28 files changed, 153 insertions(+), 198 deletions(-)
 create mode 100644 include/linux/platform_data/phy-da8xx-usb.h
