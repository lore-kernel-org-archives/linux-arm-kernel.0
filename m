From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Mar 2014 07:32:16 +0900
Subject: [GIT PULL 3/4] Samsung PM updates for v3.15
Message-ID: <532B6C70.6060002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8460dc7f2777d564b4cf094721e9de6e6657e11c:

   Merge branch 'v3.15-next/cleanup-samsung-2' into 
v3.15-next/s2r-pm-samsung-2 (2014-03-21 04:04:15 +0900)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-pm-2

for you to fetch changes up to 8dec067dc9c59f9fdcaf4357c22994cde3647eb8:

   ARM: EXYNOS: Fix compilation error in cpuidle.c (2014-03-21 07:17:17 
+0900)

----------------------------------------------------------------
Samsung PM related 2nd updates for v3.15

 From Tomasz Figa <t.figa@samsung.com>:
Current Samsung PM code is heavily unprepared for multiplatform
systems. The design implies accessing functions and global
variables defined in particular mach- subdirectory from common
code in plat-, which is not allowed when building ARCH_MULTIPLATFORM.
In addition there is a lot of forced code unification, which makes
common function handle any possible quirks of all supported SoCs.
In the end this design turned out to not work too well, ending with
a lot of empty functions exported from mach-, just because code in
common pm.c calls them. Moreover, recent trend of moving lower level
suspend/resume code to proper drivers, like pinctrl or clk, made a
lot of code there redundant, especially on DT-only platforms like
Exynos.

Note that this branch is based on previous tags/samsung-pm-1 and merge
tags/samsung-cleanup-2 because of fix build error from recent changes
of <linux/serial_s3c.h>

----------------------------------------------------------------
Mark Brown (2):
       serial: s3c: Fix build of header without serial_core.h preinclusion
       ARM: S3C64XX: Fix build for implicit serial_s3c.h inclusion

Tomasz Figa (14):
       ARM: EXYNOS: Do not resume l2x0 if not enabled before suspend
       ARM: SAMSUNG: Add soc_is_s3c2410() helper
       ARM: SAMSUNG: Save UART DIVSLOT register based on SoC type
       ARM: SAMSUNG: Use debug_ll_addr() to get UART base address
       ARM: SAMSUNG: Consolidate PM debug functions
       ARM: SAMSUNG: Move Samsung PM debug code into separate file
       ARM: SAMSUNG: Move common save/restore helpers to separate file
       ARM: SAMSUNG: Move s3c_pm_check_* prototypes to plat/pm-common.h
       ARM: EXYNOS: Fix abuse of CONFIG_PM
       ARM: EXYNOS: Remove PM initcalls and useless indirection
       ARM: EXYNOS: Stop using legacy Samsung PM code
       ARM: EXYNOS: Allow wake-up using GIC interrupts
       ARM: S5P64X0: Explicitly include linux/serial_s3c.h in mach/pm-core.h
       ARM: EXYNOS: Fix compilation error in cpuidle.c

  arch/arm/mach-exynos/Kconfig                   |  16 +--
  arch/arm/mach-exynos/Makefile                  |   2 +-
  arch/arm/mach-exynos/common.c                  |   1 +
  arch/arm/mach-exynos/common.h                  |  14 ++
  arch/arm/mach-exynos/cpuidle.c                 |   3 +-
  arch/arm/mach-exynos/include/mach/pm-core.h    |  75 -----------
  arch/arm/mach-exynos/pm.c                      | 172 
+++++++++++++++++++------
  arch/arm/mach-exynos/regs-pmu.h                |   2 +
  arch/arm/mach-exynos/sleep.S                   |  85 ++++++++++++
  arch/arm/mach-s3c64xx/include/mach/pm-core.h   |   2 +
  arch/arm/mach-s3c64xx/pm.c                     |   1 -
  arch/arm/mach-s5p64x0/include/mach/pm-core.h   |   2 +
  arch/arm/mach-s5p64x0/pm.c                     |   1 -
  arch/arm/plat-samsung/Makefile                 |   2 +
  arch/arm/plat-samsung/include/plat/cpu.h       |   6 +
  arch/arm/plat-samsung/include/plat/pm-common.h | 110 ++++++++++++++++
  arch/arm/plat-samsung/include/plat/pm.h        |  80 +-----------
  arch/arm/plat-samsung/pm-check.c               |   2 +-
  arch/arm/plat-samsung/pm-common.c              |  75 +++++++++++
  arch/arm/plat-samsung/pm-debug.c               |  97 ++++++++++++++
  arch/arm/plat-samsung/pm.c                     | 144 ---------------------
  arch/arm/plat-samsung/s5p-sleep.S              |  43 -------
  include/linux/serial_s3c.h                     |   2 +
  23 files changed, 537 insertions(+), 400 deletions(-)
  delete mode 100644 arch/arm/mach-exynos/include/mach/pm-core.h
  create mode 100644 arch/arm/mach-exynos/sleep.S
  create mode 100644 arch/arm/plat-samsung/include/plat/pm-common.h
  create mode 100644 arch/arm/plat-samsung/pm-common.c
  create mode 100644 arch/arm/plat-samsung/pm-debug.c
