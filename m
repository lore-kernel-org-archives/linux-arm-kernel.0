From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:37:48 +0100
Subject: [PATCH 0/7] ARM: mmp multiplatform support
Message-ID: <1448465875-435039-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've posted this before, this is basically unchanged from the last time
earlier this year, and I'd like to put this into the next/multiplatform
branch of arm-soc for a 4.5 merge. Let me know if you have any concerns
or objections.

Arnd Bergmann (7):
  clk: mmp: stop using platform headers
  ARM: make xscale iwmmxt code multiplatform aware
  ARM: mohawk: allow building with MMU disabled
  ARM: mmp: remove remaining legacy pxa-dma support
  ARM: mmp: make plat-pxa build standalone
  ARM: mmp: make all header files local
  ARM: mmp: move into ARCH_MULTIPLATFORM

 arch/arm/Kconfig                                   | 16 --------
 arch/arm/include/asm/cputype.h                     | 22 +++++++++--
 arch/arm/kernel/xscale-cp0.c                       |  7 ++++
 arch/arm/mach-mmp/Kconfig                          | 36 +++++++++++++----
 arch/arm/mach-mmp/Makefile                         |  1 +
 arch/arm/mach-mmp/{include/mach => }/addr-map.h    |  2 -
 arch/arm/mach-mmp/aspenite.c                       |  8 ++--
 arch/arm/mach-mmp/avengers_lite.c                  |  8 ++--
 arch/arm/mach-mmp/brownstone.c                     |  8 ++--
 arch/arm/mach-mmp/clock-mmp2.c                     |  6 ++-
 arch/arm/mach-mmp/clock-pxa168.c                   |  6 ++-
 arch/arm/mach-mmp/clock-pxa910.c                   |  6 ++-
 arch/arm/mach-mmp/clock.c                          |  2 +-
 arch/arm/mach-mmp/clock.h                          |  2 -
 arch/arm/mach-mmp/common.c                         |  4 +-
 arch/arm/mach-mmp/common.h                         |  3 --
 arch/arm/mach-mmp/{include/mach => }/cputype.h     |  0
 arch/arm/mach-mmp/devices.c                        |  8 ++--
 arch/arm/mach-mmp/{include/mach => }/devices.h     |  0
 arch/arm/mach-mmp/flint.c                          |  8 ++--
 arch/arm/mach-mmp/gplugd.c                         |  6 +--
 arch/arm/mach-mmp/include/mach/dma.h               | 13 -------
 arch/arm/mach-mmp/include/mach/hardware.h          |  4 --
 arch/arm/mach-mmp/include/mach/regs-smc.h          | 37 ------------------
 arch/arm/mach-mmp/include/mach/uncompress.h        | 45 ----------------------
 arch/arm/mach-mmp/{include/mach => }/irqs.h        |  0
 arch/arm/mach-mmp/jasper.c                         |  8 ++--
 arch/arm/mach-mmp/{include/mach => }/mfp-mmp2.h    |  2 +-
 arch/arm/mach-mmp/{include/mach => }/mfp-pxa168.h  |  2 +-
 arch/arm/mach-mmp/{include/mach => }/mfp-pxa910.h  |  2 +-
 arch/arm/mach-mmp/{include/mach => }/mfp.h         |  0
 arch/arm/mach-mmp/mmp2.c                           | 23 +++++------
 arch/arm/mach-mmp/{include/mach => }/mmp2.h        |  3 +-
 arch/arm/mach-mmp/pm-mmp2.c                        | 12 +++---
 arch/arm/mach-mmp/{include/mach => }/pm-mmp2.h     |  2 +-
 arch/arm/mach-mmp/pm-pxa910.c                      | 12 +++---
 arch/arm/mach-mmp/{include/mach => }/pm-pxa910.h   |  0
 arch/arm/mach-mmp/pxa168.c                         | 29 +++++++-------
 arch/arm/mach-mmp/{include/mach => }/pxa168.h      |  5 ++-
 arch/arm/mach-mmp/pxa910.c                         | 24 ++++++------
 arch/arm/mach-mmp/{include/mach => }/pxa910.h      |  3 +-
 arch/arm/mach-mmp/{include/mach => }/regs-apbc.h   |  4 +-
 arch/arm/mach-mmp/{include/mach => }/regs-apmu.h   |  4 +-
 arch/arm/mach-mmp/{include/mach => }/regs-icu.h    |  4 +-
 arch/arm/mach-mmp/{include/mach => }/regs-timers.h |  4 +-
 arch/arm/mach-mmp/{include/mach => }/regs-usb.h    |  0
 arch/arm/mach-mmp/tavorevb.c                       |  8 ++--
 arch/arm/mach-mmp/teton_bga.c                      | 10 ++---
 arch/arm/mach-mmp/{include/mach => }/teton_bga.h   |  2 -
 arch/arm/mach-mmp/time.c                           | 11 +++---
 arch/arm/mach-mmp/ttc_dkb.c                        | 10 ++---
 arch/arm/mm/idmap.c                                |  2 +-
 arch/arm/mm/mmu.c                                  |  2 +-
 arch/arm/mm/proc-mohawk.S                          |  2 +
 arch/arm/plat-pxa/Makefile                         |  3 +-
 arch/arm/plat-pxa/ssp.c                            |  1 -
 drivers/clk/mmp/clk-mmp2.c                         | 12 +++---
 drivers/clk/mmp/clk-pxa168.c                       | 12 +++---
 drivers/clk/mmp/clk-pxa910.c                       | 14 +++----
 include/linux/clk/mmp.h                            | 17 ++++++++
 60 files changed, 225 insertions(+), 282 deletions(-)
 rename arch/arm/mach-mmp/{include/mach => }/addr-map.h (96%)
 rename arch/arm/mach-mmp/{include/mach => }/cputype.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/devices.h (100%)
 delete mode 100644 arch/arm/mach-mmp/include/mach/dma.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-smc.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/uncompress.h
 rename arch/arm/mach-mmp/{include/mach => }/irqs.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp-mmp2.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp-pxa168.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp-pxa910.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/mfp.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/mmp2.h (99%)
 rename arch/arm/mach-mmp/{include/mach => }/pm-mmp2.h (98%)
 rename arch/arm/mach-mmp/{include/mach => }/pm-pxa910.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/pxa168.h (98%)
 rename arch/arm/mach-mmp/{include/mach => }/pxa910.h (98%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-apbc.h (88%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-apmu.h (91%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-icu.h (96%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-timers.h (93%)
 rename arch/arm/mach-mmp/{include/mach => }/regs-usb.h (100%)
 rename arch/arm/mach-mmp/{include/mach => }/teton_bga.h (92%)
 create mode 100644 include/linux/clk/mmp.h

-- 
2.1.0.rc2
