From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 11:41:25 +0200
Subject: [PATCH 0/7] ARM: ux500: cleanup of CPU id handling
Message-ID: <20160624094132.1852086-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I stumbled over the cpu_is_u*() function in ux500 and decided to
see if I could simplify that code a bit. I ended up with a
significant reduction of code in arch/arm/mach-ux500/.

The new version is compile-tested with lots of randconfig builds,
but I did not run it on actual hardware, so it needs to be
tested by someone who has access to at least one of the
machines.

I had an earlier series to cleanup the ux500 platform data,
and this is based on top of those changes but should also be
easy to rebase as a standalone series. It's probably best
to merge both patch sets as a single branch for v4.8 through
the arm-soc tree, provided the testing is successful.

Patch 6/7 is the only one that should be user-visible, so
please review carefully if the change is desired or not.

	Arnd

Arnd Bergmann (7):
  ARM: ux500: move l2x0 init to .init_irq
  ARM: ux500: use CLK_OF_DECLARE()
  ARM: ux500: remove cpu_is_u* helpers
  ARM: ux500: consolidate soc_device code in id.c
  ARM: ux500: call ux500_setup_id later
  ARM: ux500: move soc_id driver to drivers/soc
  ARM: ux500: consolidate base platform files

 MAINTAINERS                             |   1 -
 arch/arm/mach-ux500/Makefile            |   3 +-
 arch/arm/mach-ux500/cache-l2x0.c        |  67 ----------
 arch/arm/mach-ux500/cpu-db8500.c        | 124 ++++++++++++------
 arch/arm/mach-ux500/cpu.c               | 148 ---------------------
 arch/arm/mach-ux500/id.c                | 116 -----------------
 arch/arm/mach-ux500/id.h                | 144 ---------------------
 arch/arm/mach-ux500/platsmp.c           |   1 -
 arch/arm/mach-ux500/setup.h             |  11 --
 drivers/clk/ux500/u8500_of_clk.c        |  16 +--
 drivers/clk/ux500/u8540_clk.c           |  16 +--
 drivers/clk/ux500/u9540_clk.c           |   4 +-
 drivers/soc/Kconfig                     |   1 +
 drivers/soc/Makefile                    |   1 +
 drivers/soc/ux500/Kconfig               |   7 +
 drivers/soc/ux500/ux500-soc-id.c        | 222 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-ux500.h |  17 ---
 17 files changed, 326 insertions(+), 573 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/cache-l2x0.c
 delete mode 100644 arch/arm/mach-ux500/cpu.c
 delete mode 100644 arch/arm/mach-ux500/id.c
 delete mode 100644 arch/arm/mach-ux500/id.h
 create mode 100644 drivers/soc/ux500/Kconfig
 create mode 100644 drivers/soc/ux500/ux500-soc-id.c
 delete mode 100644 include/linux/platform_data/clk-ux500.h

-- 
2.9.0
