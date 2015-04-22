From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Apr 2015 23:11:08 -0700
Subject: [GIT PULL 1/9] ARM: SoC fixes for v4.1
In-Reply-To: <1429683076-19881-1-git-send-email-olof@lixom.net>
References: <1429683076-19881-1-git-send-email-olof@lixom.net>
Message-ID: <1429683076-19881-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the usual "low-priority fixes that didn't make it into the last
few -rcs, with a twist: We had a fixes pull request that I didn't send
in time to get into 4.0, so we'll send some of them to Greg for -stable as
well.

Contents here is as usual not all that controversial:

- A handful of randconfig fixes from Arnd, in particular for older Samsung
platforms
- Exynos fixes, !SMP building, DTS updates for MMC and lid switch
- Kbuild fix to create output subdirectory for DTB files
- Misc minor fixes for OMAP


Conflicts: None

----------------------------------------------------------------

The following changes since commit f614c8178b0696d070b23f36a2a27b5128f6c372:

  Merge branch 'parisc-4.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to cdaa8cf34863028dab238e1498555bf12d693244:

  Merge branch 'fixes' into next/fixes-non-critical

----------------------------------------------------------------

Andreas Faerber (2):
      ARM: dts: fix mmc node updates for exynos5250-spring
      ARM: dts: fix lid and power pin-functions for exynos5250-spring

Arnd Bergmann (7):
      ARM: S3C64XX: add I2C dependencies where needed
      ARM: S3C64XX: fix building without CONFIG_PM_SLEEP
      ARM: S3C64XX: fix __initdata section mismatch
      ARM: S3C24XX: use SAMSUNG_WAKEMASK for s3c2416
      ARM: S3C24XX: fix building without PM_SLEEP
      ARM: S3C24XX: fix header file inclusions
      ARM: S3C24XX: avoid a Kconfig warning

Bartlomiej Zolnierkiewicz (1):
      ARM: EXYNOS: Fix build breakage cpuidle on !SMP

Felipe Balbi (1):
      MAINTAINERS: add OMAP defconfigs under OMAP SUPPORT

Gregory CLEMENT (1):
      ARM: mvebu: Disable CPU Idle on Armada 38x

Julia Lawall (1):
      ARM: cns3xxx: don't export static symbol

Keerthy (1):
      ARM: dts: DRA7: Add bandgap and related thermal nodes

Kishon Vijay Abraham I (2):
      ARM: dts: am4372: Add "ti,am437x-ocp2scp" as compatible string for OCP2SCP
      bus: ocp2scp: SYNC2 value should be changed to 0x6

Nathan Rossi (1):
      kbuild: Create directory for target DTB

Nicolas Ferre (1):
      ARM: at91/dt: sama5d3 xplained: add phy address for macb1

Nishanth Menon (1):
      ARM: dts: am57xx-beagle-x15: Add thermal map to include fan and tmp102

Olof Johansson (5):
      Merge tag 'omap-for-v4.1/fixes-0' of git://git.kernel.org/.../tmlind/linux-omap into next/fixes-non-critical
      Merge tag 'mvebu-fixes-4.0' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'samsung-fixes-2' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge tag 'samsung-fixes-v4.1' of git://git.kernel.org/.../kgene/linux-samsung into next/fixes-non-critical
      Merge branch 'fixes' into next/fixes-non-critical

Paul Walmsley (1):
      ARM: OMAP1: PM: fix some build warnings on 1510-only Kconfigs

Praneeth Bajjuri (1):
      ARM: DRA7: Enable Cortex A15 errata 798181

Stefan Agner (1):
      ARM: OMAP2+: remove superfluous NULL pointer check

Stefan Hengelein (1):
      ARM: OMAP4: remove dead kconfig option OMAP4_ERRATA_I688

Tony Lindgren (1):
      Merge branch 'omap-for-v4.1/ocp2scp' into omap-for-v4.1/fixes-not-urgent


 .../devicetree/bindings/bus/omap-ocp2scp.txt    |  3 +-
 MAINTAINERS                                     |  2 +
 arch/arm/boot/dts/am4372.dtsi                   |  4 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts         | 49 ++++++++++++++
 arch/arm/boot/dts/at91-sama5d3_xplained.dts     |  6 ++
 arch/arm/boot/dts/dra7.dtsi                     | 23 +++++++
 arch/arm/boot/dts/dra72x.dtsi                   |  5 ++
 arch/arm/boot/dts/dra74x.dtsi                   |  5 ++
 arch/arm/boot/dts/exynos5250-spring.dts         | 20 ++----
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi        |  4 +-
 arch/arm/mach-cns3xxx/pm.c                      |  1 -
 arch/arm/mach-exynos/exynos.c                   |  2 +-
 arch/arm/mach-exynos/pm.c                       |  2 +
 arch/arm/mach-mvebu/pmsu.c                      | 16 ++++-
 arch/arm/mach-omap1/pm.c                        | 51 +++++++--------
 arch/arm/mach-omap2/Kconfig                     | 22 +------
 arch/arm/mach-omap2/common.c                    |  1 -
 arch/arm/mach-omap2/common.h                    |  3 -
 arch/arm/mach-omap2/io.c                        |  2 -
 arch/arm/mach-omap2/mux.c                       |  2 +-
 arch/arm/mach-omap2/omap-secure.h               |  7 --
 arch/arm/mach-omap2/omap4-common.c              | 69 --------------------
 arch/arm/mach-omap2/sleep44xx.S                 |  2 -
 arch/arm/mach-s3c24xx/Kconfig                   | 19 +++---
 arch/arm/mach-s3c24xx/Makefile                  |  3 +-
 arch/arm/mach-s3c24xx/include/mach/pm-core.h    | 24 ++++++-
 arch/arm/mach-s3c24xx/pm-s3c2416.c              |  3 +-
 arch/arm/mach-s3c24xx/pm.c                      |  6 +-
 arch/arm/mach-s3c24xx/s3c2410.c                 |  2 +-
 arch/arm/mach-s3c24xx/s3c2412.c                 |  2 +-
 arch/arm/mach-s3c24xx/s3c2416.c                 |  2 +-
 arch/arm/mach-s3c24xx/s3c2440.c                 |  4 +-
 arch/arm/mach-s3c24xx/s3c2442.c                 |  4 +-
 arch/arm/mach-s3c24xx/s3c244x.c                 |  7 +-
 arch/arm/mach-s3c64xx/Kconfig                   |  4 +-
 arch/arm/mach-s3c64xx/Makefile                  |  3 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c           |  2 +-
 arch/arm/mach-s3c64xx/pm.c                      |  2 +
 arch/arm/plat-samsung/include/plat/pm.h         | 14 +++-
 arch/arm/plat-samsung/pm-debug.c                |  1 +
 arch/arm/plat-samsung/pm.c                      | 20 ------
 drivers/bus/omap-ocp2scp.c                      | 34 ++++++++++
 drivers/cpuidle/cpuidle-exynos.c                |  3 +-
 scripts/Makefile.lib                            |  3 +-
 44 files changed, 254 insertions(+), 209 deletions(-)
