From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Mar 2014 18:59:57 +0100
Subject: [GIT PULL] Samsung clock changes for v3.15
Message-ID: <1395079197-13598-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tfiga/samsung-clk.git tags/for_3.15/samsung-clk

for you to fetch changes up to 70d1cf1c85486753fec0c60a9a093bdfe42b89b4:

  Merge branch 'for_3.15/misc' into samsung-next (2014-03-17 13:00:01 +0100)

----------------------------------------------------------------

Samsung clock patches for v3.15.

Due to dependencies, most of the patches already went through linux-samsung
tree, so this pull request is rather small. It contains various patches
collected since the last merge window:

1) non-critical fixes (without need to push to stable):

220b0cc clk: samsung: Initialize clock table with error pointers
58d83cb clk: exynos-5420: Fix VPLL lock offset
3299bc3 clk: samsung: fixed compiler warning [-Wpointer-to-int-cast]

2) clock driver extensions:

db40d0c clk: samsung exynos5250/5420: Add gate clock for SSS module
d8b9731 clk/samsung: add support for multiple clock providers
45af130 clk/samsung: add support for pll2550xx
adec437 clk/samsung: add support for pll2650xx

The patches are based on clk-s3c24xx branch of linux-samsung tree, due to
dependencies of further patches on S3C24xx clock driver and clock PM
refactor.

----------------------------------------------------------------
Heiko Stuebner (12):
      clk: samsung: add pll_6552 variant for s3c2416
      clk: samsung: add plls used by the s3c2443
      dt-bindings: add binding for clock-controller of s3c2443 and following
      clk: samsung: add clock-driver for s3c2416, s3c2443 and s3c2450
      ARM: S3C24XX: prevent conflicts between ccf and non-ccf s3c24xx-socs
      ARM: dts: add clock data for s3c2416
      ARM: S3C24XX: Convert s3c2416 and s3c2443 to common clock framework
      ARM: S3C24XX: only store clock registers when old clock code is active
      clk: samsung: add plls used by the early s3c24xx cpus
      dt-bindings: add documentation for s3c2412 clock controller
      clk: samsung: add clock controller driver for s3c2412
      ARM: S3C24XX: convert s3c2412 to common clock framework

Naveen Krishna Chatradhi (1):
      clk: samsung exynos5250/5420: Add gate clock for SSS module

Pankaj Dubey (2):
      clk/samsung: add support for pll2550xx
      clk: samsung: fixed compiler warning [-Wpointer-to-int-cast]

Rahul Sharma (2):
      clk/samsung: add support for multiple clock providers
      clk/samsung: add support for pll2650xx

Sachin Kamat (1):
      clk: exynos-5420: Fix VPLL lock offset

Tomasz Figa (14):
      clk: exynos4: Remove remnants of non-DT support
      clk: samsung: Provide common helpers for register save/restore
      clk: samsung: exynos4: Move suspend/resume handling to SoC driver
      clk: samsung: exynos5250: Move suspend/resume handling to SoC driver
      clk: samsung: exynos5420: Move suspend/resume handling to SoC driver
      clk: samsung: s3c64xx: Move suspend/resume handling to SoC driver
      clk: samsung: Drop old suspend/resume code
      clk: samsung: exynos4: Add remaining suspend/resume handling
      ARM: EXYNOS: Drop legacy Exynos4 clock suspend/resume code
      clk: samsung: Initialize clock table with error pointers
      Merge branch 'for_3.15/misc' into samsung-clk-next
      Merge branch 'for_3.15/misc' into samsung-next
      Merge branch 'for_3.15/exynos5260' into samsung-next
      Merge branch 'for_3.15/misc' into samsung-next

 .../devicetree/bindings/clock/exynos5250-clock.txt |   1 +
 .../bindings/clock/samsung,s3c2412-clock.txt       |  50 ++
 .../bindings/clock/samsung,s3c2443-clock.txt       |  56 ++
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |  13 +
 arch/arm/boot/dts/s3c2416.dtsi                     |  42 ++
 arch/arm/mach-exynos/pm.c                          | 148 +---
 arch/arm/mach-s3c24xx/Kconfig                      |  24 +-
 arch/arm/mach-s3c24xx/Makefile                     |   7 +-
 arch/arm/mach-s3c24xx/clock-s3c2412.c              | 761 ---------------------
 arch/arm/mach-s3c24xx/clock-s3c2416.c              | 171 -----
 arch/arm/mach-s3c24xx/clock-s3c2443.c              | 212 ------
 arch/arm/mach-s3c24xx/common-s3c2443.c             | 675 ------------------
 arch/arm/mach-s3c24xx/common.c                     |  27 +-
 arch/arm/mach-s3c24xx/common.h                     |  10 +
 arch/arm/mach-s3c24xx/mach-jive.c                  |   9 +-
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |  39 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |   9 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |   9 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c              |   9 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                 |   9 +-
 arch/arm/mach-s3c24xx/pm.c                         |  13 +-
 arch/arm/mach-s3c24xx/s3c2412.c                    |  43 --
 drivers/clk/samsung/Makefile                       |   2 +
 drivers/clk/samsung/clk-exynos4.c                  | 213 ++++--
 drivers/clk/samsung/clk-exynos5250.c               |  71 +-
 drivers/clk/samsung/clk-exynos5420.c               |  75 +-
 drivers/clk/samsung/clk-exynos5440.c               |  18 +-
 drivers/clk/samsung/clk-pll.c                      | 489 ++++++++++++-
 drivers/clk/samsung/clk-pll.h                      |   8 +
 drivers/clk/samsung/clk-s3c2412.c                  | 274 ++++++++
 drivers/clk/samsung/clk-s3c2443.c                  | 466 +++++++++++++
 drivers/clk/samsung/clk-s3c64xx.c                  | 121 +++-
 drivers/clk/samsung/clk.c                          | 190 +++--
 drivers/clk/samsung/clk.h                          |  72 +-
 include/dt-bindings/clock/exynos5250.h             |   1 +
 include/dt-bindings/clock/s3c2412.h                |  73 ++
 include/dt-bindings/clock/s3c2443.h                |  92 +++
 37 files changed, 2202 insertions(+), 2300 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2412-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2443-clock.txt
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2412.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2416.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2443.c
 delete mode 100644 arch/arm/mach-s3c24xx/common-s3c2443.c
 create mode 100644 drivers/clk/samsung/clk-s3c2412.c
 create mode 100644 drivers/clk/samsung/clk-s3c2443.c
 create mode 100644 include/dt-bindings/clock/s3c2412.h
 create mode 100644 include/dt-bindings/clock/s3c2443.h
