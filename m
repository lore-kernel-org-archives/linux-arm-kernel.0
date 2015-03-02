From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  2 Mar 2015 21:36:53 +0100
Subject: [PATCH 0/5] ARM: orion5k/mv78xx0/dove multiplatform support
Message-ID: <1425328618-894030-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

I'm trying to get all ARMv7 platforms moved over to ARCH_MULTIPLATFORM,
and while the plan for these three platforms was to do the conversion
to DT first and then to remove the board files along with all the
support files, I don't see that happening as soon as I'd hoped
for (as in, last year).

I've looked at what would be left to do for doing multiplatform with
the existing board code, and found that there is in fact very little.
This series does the complete change over to multiplatform for all
three, along with some header cleanups that fit the general purpose.

I've decided to do the patches across the platforms for better
readability, and to save everyone looking at very similar patches
three times.

This is build tested so far and survives a randconfig builder
for a few hundred builds without regressions, but I have not
done any runtime testing. Any help in testing or reviewing would
be much appreciated.

Thanks,

	Arnd

Arnd Bergmann (5):
  ARM: orion: move watchdog setup to mach-orion5x
  ARM: orion: always use MULTI_IRQ_HANDLER
  ARM: orion: use SPARSE_IRQ everywhere
  ARM: orion: clean up mach/*.h headers
  ARM: orion: multiplatform support

 arch/arm/Kconfig                                   | 39 ------------------
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
 arch/arm/mach-dove/irq.c                           | 19 +++------
 arch/arm/mach-dove/{include/mach => }/irqs.h       |  4 +-
 arch/arm/mach-dove/mpp.c                           |  2 +-
 arch/arm/mach-dove/pcie.c                          |  4 +-
 arch/arm/mach-dove/{include/mach => }/pm.h         |  4 +-
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
 arch/arm/mach-orion5x/irq.c                        | 14 +------
 arch/arm/mach-orion5x/{include/mach => }/irqs.h    |  4 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |  4 +-
 arch/arm/mach-orion5x/ls-chl-setup.c               |  3 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c               |  3 +-
 arch/arm/mach-orion5x/lsmini-setup.c               |  3 +-
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
 73 files changed, 184 insertions(+), 453 deletions(-)
 rename arch/arm/mach-dove/{include/mach => }/bridge-regs.h (96%)
 rename arch/arm/mach-dove/{include/mach => }/dove.h (99%)
 delete mode 100644 arch/arm/mach-dove/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-dove/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-dove/include/mach/uncompress.h
 rename arch/arm/mach-dove/{include/mach => }/irqs.h (95%)
 rename arch/arm/mach-dove/{include/mach => }/pm.h (97%)
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
 rename arch/arm/mach-orion5x/{include/mach => }/irqs.h (93%)
 rename arch/arm/mach-orion5x/{include/mach => }/orion5x.h (99%)

-- 
2.1.0.rc2
