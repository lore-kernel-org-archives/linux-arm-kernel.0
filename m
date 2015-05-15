From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 23:13:39 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.1-rc3
Message-ID: <2561875.CIr2FDrpsL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 56523eefaa13e567ccae83dc0cab635aa8221eed:

  Merge tag 'samsung-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into fixes (2015-05-15 17:14:48 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.1-rc3

Nothing frightening this time, just smaller fixes in a number of places.

The other changes contained here are:

MAINTAINERS file updates:
- The mach-gemini maintainer is back in action and has a new git tree
- Krzysztof Kozlowski has volunteered to be a new co-maintainer
  for the samsung platforms
- updates to the files that belong to Marvell mvebu

Bug fixes:
- The largest changes are on omap2, but are only to avoid some
  harmless warnings and to fix reset on omap4
- a small regression fix on tegra
- multiple fixes for incorrect IRQ affinity on vexpress
- the missing system controller on arm64 juno is added
- one revert of a patch that was accidentally applied
  twice for mach-rockchip
- two clock related DT fixes for mvebu
- a workaround for suspend with old DT binaries on new
  exynos kernels
- Another fix for suspend on exynos, needs to be backported.

----------------------------------------------------------------
Arnd Bergmann (5):
      Merge tag 'tegra-for-4.1-fixes-for-rc3' of git://git.kernel.org/.../tegra/linux into fixes
      Merge tag 'omap-for-v4.1/fixes-rc2' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'v4.1-rockchip-socfixes2' of git://git.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'mvebu-fixes-4.1-2' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'samsung-fixes-2' of git://git.kernel.org/.../kgene/linux-samsung into fixes

Benoit Parrot (1):
      ARM: AM43xx: hwmod: add VPFE hwmod entries

Gregory CLEMENT (2):
      ARM: mvebu: Fix the main PLL frequency on Armada 375, 38x and 39x SoCs
      MAINTAINERS: Add dts entries for some of the Marvell SoCs

Hans Ulli Kroll (2):
      ARM: Gemini: Maintainers update
      ARM: gemini: fix compiler warning due wrong data type

Heiko Stuebner (1):
      Revert "ARM: rockchip: fix undefined instruction of reset_ctrl_regs"

Javier Martinez Canillas (1):
      ARM: dts: Add keep-power-in-suspend to WiFi SDIO node for Peach Boards

Julien Grall (1):
      ARM: EXYNOS: Don't try to initialize suspend on old DT

Krzysztof Kozlowski (4):
      ARM: EXYNOS: Fix dereference of ERR_PTR returned by of_genpd_get_from_provider
      ARM: EXYNOS: Fix failed second suspend on Exynos4
      ARM: EXYNOS: Use of_machine_is_compatible instead of soc_is_exynos4
      MAINTAINERS: ARM: EXYNOS: Add Krzysztof Kozlowski as co-maintainer

Robert Schwebel (2):
      ARM: vexpress/ca9: Add unified-cache property to l2 cache node
      ARM: vexpress/ca9: Add interrupt-affinity to the PMU node

Sebastian Hesselbarth (1):
      ARM: dove: Add clock-names to CuBox Si5351 clk generator

Sudeep Holla (2):
      ARM64: juno: add sp810 support and fix sp804 clock frequency
      ARM: vexpress/tc2: Add interrupt-affinity to the PMU node

Tero Kristo (2):
      ARM: OMAP4+: PRM: add support for passing status register/bit info to reset
      ARM: AM33xx+: hwmod: re-use omap4 implementations for reset functionality

Tomeu Vizoso (1):
      ARM: tegra: Correct which USB controller has the UTMI pad registers

Tony Lindgren (2):
      ARM: OMAP2+: Remove bogus struct clk comparison for timer clock
      Merge tag 'for-v4.1-rc/omap-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.1/fixes

 MAINTAINERS                                   | 13 ++++-
 arch/arm/boot/dts/armada-375.dtsi             |  2 +-
 arch/arm/boot/dts/armada-38x.dtsi             |  2 +-
 arch/arm/boot/dts/armada-39x.dtsi             |  2 +-
 arch/arm/boot/dts/dove-cubox.dts              |  1 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |  1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |  1 +
 arch/arm/boot/dts/tegra124.dtsi               |  8 +--
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts    |  1 +
 arch/arm/boot/dts/vexpress-v2p-ca9.dts        | 11 +++--
 arch/arm/mach-exynos/common.h                 |  2 +
 arch/arm/mach-exynos/exynos.c                 | 27 +++++++++++
 arch/arm/mach-exynos/platsmp.c                | 39 +--------------
 arch/arm/mach-exynos/pm_domains.c             |  4 +-
 arch/arm/mach-exynos/suspend.c                |  7 ++-
 arch/arm/mach-gemini/common.h                 |  4 +-
 arch/arm/mach-gemini/reset.c                  |  4 +-
 arch/arm/mach-omap2/omap_hwmod.c              | 68 ++++++--------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    | 70 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h                |  3 +-
 arch/arm/mach-omap2/prminst44xx.c             | 20 +++-----
 arch/arm/mach-omap2/timer.c                   | 13 ++---
 arch/arm/mach-rockchip/pm.c                   | 26 ----------
 arch/arm/mach-rockchip/pm.h                   |  4 --
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 31 ++++++++++--
 25 files changed, 199 insertions(+), 165 deletions(-)
