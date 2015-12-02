From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Dec 2015 22:27:02 +0100
Subject: [PATCH v2 0/7] ARM: orion5x/mv78xx0 multiplatform
Message-ID: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've updated the series slightly to leave out the last two patches for
mach-dove. I think the MULTI_IRQ_HANDLER and SPARSE_IRQ use is useful
to have for all three platforms for consistency, and the watchdog change
is required to get orion5x to work right.

Please have another look.

I've also uploaded this series to

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git multiplatform-orion-4.3

again, that version is based on v4.3, while the patches in these mails
are based on v4.4-rc3.

I've left Andrew's Ack in place, hope that's ok.

Arnd Bergmann (7):
  ARM: orion: move watchdog setup to mach-orion5x
  ARM: orion: always use MULTI_IRQ_HANDLER
  ARM: orion: use SPARSE_IRQ everywhere
  ARM: mv78xx0: clean up mach/*.h headers
  ARM: mv78xx0: multiplatform support
  ARM: orion5x: clean up mach/*.h headers
  ARM: orion5x: multiplatform support

 arch/arm/Kconfig                                   | 29 +------------
 arch/arm/configs/mv78xx0_defconfig                 |  3 ++
 arch/arm/configs/orion5x_defconfig                 |  3 ++
 arch/arm/mach-dove/cm-a510.c                       |  1 +
 arch/arm/mach-dove/common.c                        | 17 ++++++++
 arch/arm/mach-dove/dove-db-setup.c                 |  1 +
 arch/arm/mach-dove/include/mach/dove.h             |  2 +
 arch/arm/mach-dove/include/mach/entry-macro.S      | 33 ---------------
 arch/arm/mach-dove/include/mach/irqs.h             |  2 +-
 arch/arm/mach-dove/include/mach/pm.h               |  2 +-
 arch/arm/mach-dove/irq.c                           | 14 +------
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
 64 files changed, 175 insertions(+), 361 deletions(-)
 delete mode 100644 arch/arm/mach-dove/include/mach/entry-macro.S
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
