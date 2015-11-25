From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:49:12 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
Message-ID: <1448466557-435335-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've posted these before and now gotten around to a rebase and
want to include them in the arm-soc next/multiplatform branch for
4.5.

Originally the plan for these platforms was to convert all of
them to DT and use only mach-mvebu. That has not happened,
so I would do it this way instead so we can at least have
them in a single kernel.

Let me know if there are any concerns or objections.

Arnd Bergmann (5):
  ARM: orion: move watchdog setup to mach-orion5x
  ARM: orion: always use MULTI_IRQ_HANDLER
  ARM: orion: use SPARSE_IRQ everywhere
  ARM: orion: clean up mach/*.h headers
  ARM: orion: multiplatform support

 arch/arm/Kconfig                                   | 40 ------------------
 arch/arm/configs/dove_defconfig                    |  2 +
 arch/arm/configs/mv78xx0_defconfig                 |  3 ++
 arch/arm/configs/orion5x_defconfig                 |  3 ++
 arch/arm/mach-dove/Kconfig                         | 15 +++++--
 arch/arm/mach-dove/Makefile                        |  2 +
 .../arm/mach-dove/{include/mach => }/bridge-regs.h |  4 +-
 arch/arm/mach-dove/cm-a510.c                       |  4 +-
 arch/arm/mach-dove/common.c                        |  4 +-
 arch/arm/mach-dove/dove-db-setup.c                 |  3 +-
 arch/arm/mach-dove/{include/mach => }/dove.h       |  4 +-
 arch/arm/mach-dove/include/mach/entry-macro.S      | 33 ---------------
 arch/arm/mach-dove/include/mach/hardware.h         | 19 ---------
 arch/arm/mach-dove/include/mach/uncompress.h       | 36 ----------------
 arch/arm/mach-dove/irq.c                           | 22 ++++------
 arch/arm/mach-dove/{include/mach => }/irqs.h       |  4 +-
 arch/arm/mach-dove/mpp.c                           |  2 +-
 arch/arm/mach-dove/pcie.c                          |  4 +-
 arch/arm/mach-dove/{include/mach => }/pm.h         |  6 +--
 arch/arm/mach-mv78xx0/Kconfig                      | 15 +++++--
 arch/arm/mach-mv78xx0/Makefile                     |  2 +
 .../mach-mv78xx0/{include/mach => }/bridge-regs.h  |  4 +-
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c          |  3 +-
 arch/arm/mach-mv78xx0/common.c                     |  4 +-
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c           |  3 +-
 arch/arm/mach-mv78xx0/include/mach/entry-macro.S   | 41 ------------------
 arch/arm/mach-mv78xx0/include/mach/hardware.h      | 14 -------
 arch/arm/mach-mv78xx0/include/mach/uncompress.h    | 46 ---------------------
 arch/arm/mach-mv78xx0/irq.c                        | 35 +++++++++++++++-
 arch/arm/mach-mv78xx0/{include/mach => }/irqs.h    |  4 +-
 arch/arm/mach-mv78xx0/mpp.c                        |  2 +-
 arch/arm/mach-mv78xx0/{include/mach => }/mv78xx0.h |  4 +-
 arch/arm/mach-mv78xx0/pcie.c                       |  2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c         |  3 +-
 arch/arm/mach-orion5x/Kconfig                      | 18 ++++++--
 arch/arm/mach-orion5x/Makefile                     |  2 +
 arch/arm/mach-orion5x/board-d2net.c                |  2 +-
 arch/arm/mach-orion5x/board-dt.c                   |  4 +-
 arch/arm/mach-orion5x/board-mss2.c                 |  4 +-
 arch/arm/mach-orion5x/board-rd88f5182.c            |  2 +-
 .../mach-orion5x/{include/mach => }/bridge-regs.h  |  4 +-
 arch/arm/mach-orion5x/common.c                     | 20 +++++++--
 arch/arm/mach-orion5x/db88f5281-setup.c            |  3 +-
 arch/arm/mach-orion5x/dns323-setup.c               |  3 +-
 arch/arm/mach-orion5x/include/mach/entry-macro.S   | 25 -----------
 arch/arm/mach-orion5x/include/mach/hardware.h      | 14 -------
 arch/arm/mach-orion5x/include/mach/uncompress.h    | 48 ----------------------
 arch/arm/mach-orion5x/irq.c                        | 13 +-----
 arch/arm/mach-orion5x/{include/mach => }/irqs.h    |  4 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |  4 +-
 arch/arm/mach-orion5x/ls-chl-setup.c               |  3 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c               |  3 +-
 arch/arm/mach-orion5x/mpp.c                        |  2 +-
 arch/arm/mach-orion5x/mv2120-setup.c               |  3 +-
 arch/arm/mach-orion5x/net2big-setup.c              |  3 +-
 arch/arm/mach-orion5x/{include/mach => }/orion5x.h |  4 +-
 arch/arm/mach-orion5x/pci.c                        |  2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |  3 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |  3 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c            |  3 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c       |  3 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c     |  3 +-
 arch/arm/mach-orion5x/ts209-setup.c                |  3 +-
 arch/arm/mach-orion5x/ts409-setup.c                |  3 +-
 arch/arm/mach-orion5x/ts78xx-setup.c               |  3 +-
 arch/arm/mach-orion5x/tsx09-common.c               |  2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c              |  3 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c           |  3 +-
 arch/arm/plat-orion/common.c                       | 21 ----------
 arch/arm/plat-orion/include/plat/common.h          |  2 -
 arch/arm/plat-orion/irq.c                          |  1 -
 arch/arm/plat-orion/mpp.c                          |  1 -
 72 files changed, 185 insertions(+), 454 deletions(-)
 rename arch/arm/mach-dove/{include/mach => }/bridge-regs.h (96%)
 rename arch/arm/mach-dove/{include/mach => }/dove.h (99%)
 delete mode 100644 arch/arm/mach-dove/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-dove/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-dove/include/mach/uncompress.h
 rename arch/arm/mach-dove/{include/mach => }/irqs.h (96%)
 rename arch/arm/mach-dove/{include/mach => }/pm.h (95%)
 rename arch/arm/mach-mv78xx0/{include/mach => }/bridge-regs.h (92%)
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/uncompress.h
 rename arch/arm/mach-mv78xx0/{include/mach => }/irqs.h (95%)
 rename arch/arm/mach-mv78xx0/{include/mach => }/mv78xx0.h (98%)
 rename arch/arm/mach-orion5x/{include/mach => }/bridge-regs.h (92%)
 delete mode 100644 arch/arm/mach-orion5x/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-orion5x/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/uncompress.h
 rename arch/arm/mach-orion5x/{include/mach => }/irqs.h (94%)
 rename arch/arm/mach-orion5x/{include/mach => }/orion5x.h (99%)

-- 
2.1.0.rc2
