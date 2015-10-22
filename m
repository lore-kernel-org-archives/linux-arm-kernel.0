From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Oct 2015 17:40:56 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.3-rc
Message-ID: <6788509.osko4XNn1O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:

  Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)

are available in the git repository at:

  git+ssh://gitolite at ra.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 55f41297576ddb7868af2f13f3a8107178dee2d0:

  Merge tag 'mvebu-fixes-4.3-2' of git://git.infradead.org/linux-mvebu into fixes (2015-10-21 17:03:37 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.3-rc

Most of the changes this time are for incorrect device nodes in various
ways, on on imx, berlin, exynos, ux500, uniphier, omap and meson.

Chen-Yu Tsai now co-maintains mach-sunxi (Allwinner).

Other bug fixes include
 * a partial revert of a broken tegra gpio patch
 * irq affinity for arm ccn
 * suspend on one Armada 385 machine
 * enable ZONE_DMA to avoid an OMAP crash for over 2GB RAM
 * turning on a regulator on beagleboard-x15 for HDMI
 * making the omap gpmc debug code visible
 * setup of orion network switch
 * a rare build regression for pxa

----------------------------------------------------------------
Alim Akhtar (1):
      ARM: dts: Fix audio card detection on Peach boards

Arnd Bergmann (8):
      Merge tag 'mvebu-fixes-4.3-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'berlin-fixes-for-4.3-1' of git://git.infradead.org/users/hesselba/linux-berlin into fixes
      Merge tag 'imx-fixes-4.3-2' of git://git.kernel.org/.../shawnguo/linux into fixes
      ARM: pxa: fix pxa3xx DFI lockup hack
      Merge tag 'omap-for-v4.3/fixes-rc5' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'omap-for-v4.3/fixes-rc6' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'samsung-fixes-2' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge tag 'mvebu-fixes-4.3-2' of git://git.infradead.org/linux-mvebu into fixes

Carlo Caione (1):
      ARM: meson6: DTS: Fix wrong reg mapping and IRQ numbers

Fabio Estevam (1):
      ARM: dts: imx7d: Fix UART2 base address

Florian Fainelli (1):
      ARM: orion: Fix DSA platform device after mvmdio conversion

Krzysztof Kozlowski (1):
      ARM: EXYNOS: Fix double of_node_put() when parsing child power domains

Linus Walleij (1):
      ARM: ux500: modify initial levelshifter status

Marcin Wojtas (1):
      ARM: mvebu: correct a385-db-ap compatible string

Masahiro Yamada (1):
      ARM: dts: uniphier: fix IRQ number for devices on PH1-LD6b ref board

Maxime Ripard (1):
      MAINTAINERS: Update Allwinner entry and add new maintainer

Pawel Moll (2):
      bus: arm-ccn: Handle correctly no-more-cpus case
      bus: arm-ccn: Fix irq affinity setting on CPU migration

Sudip Mukherjee (1):
      thermal: exynos: Fix register read in TMU

Thierry Reding (1):
      ARM: tegra: Comment out gpio-ranges properties

Thomas Hebb (1):
      ARM: dts: berlin: change BG2Q's USB PHY compatible

Tomi Valkeinen (1):
      ARM: dts: am57xx-beagle-x15: set VDD_SD to always-on

Tony Lindgren (4):
      memory: omap-gpmc: Fix unselectable debug option for GPMC
      Documentation: ARM: List new omap MMC requirements
      ARM: OMAP2+: Fix oops with LPAE and more than 2GB of memory
      ARM: OMAP2+: Fix imprecise external abort caused by bogus SRAM init

Uwe Kleine-K?nig (1):
      memory: omap-gpmc: dump "before" state before first modification

Will Deacon (1):
      drivers/perf: arm_pmu: avoid CPU device_node reference leak

 Documentation/arm/OMAP/README                     |  7 +++++++
 MAINTAINERS                                       |  5 +++--
 arch/arm/boot/dts/am57xx-beagle-x15.dts           |  3 ++-
 arch/arm/boot/dts/armada-385-db-ap.dts            |  2 +-
 arch/arm/boot/dts/berlin2q.dtsi                   |  6 +++---
 arch/arm/boot/dts/exynos5420-peach-pit.dts        |  5 +++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts         |  5 +++++
 arch/arm/boot/dts/imx7d.dtsi                      |  4 ++--
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts |  2 +-
 arch/arm/boot/dts/meson.dtsi                      | 23 ++++++++++++-----------
 arch/arm/boot/dts/omap3-evm-37xx.dts              |  2 +-
 arch/arm/boot/dts/ste-hrefv60plus.dtsi            |  2 +-
 arch/arm/boot/dts/tegra114.dtsi                   |  2 ++
 arch/arm/boot/dts/tegra124.dtsi                   |  2 ++
 arch/arm/boot/dts/tegra20.dtsi                    |  2 ++
 arch/arm/boot/dts/tegra30.dtsi                    |  2 ++
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts       |  2 +-
 arch/arm/mach-exynos/pm_domains.c                 |  8 +++-----
 arch/arm/mach-omap2/Kconfig                       |  2 ++
 arch/arm/mach-omap2/board-generic.c               | 10 ++++++++++
 arch/arm/mach-omap2/pdata-quirks.c                |  9 ++++++++-
 arch/arm/mach-pxa/pxa3xx.c                        |  9 +++++----
 arch/arm/plat-orion/common.c                      |  2 +-
 drivers/bus/arm-ccn.c                             |  5 +++--
 drivers/memory/Kconfig                            | 12 +++++++++---
 drivers/memory/omap-gpmc.c                        |  2 +-
 drivers/perf/arm_pmu.c                            | 10 ++++++++--
 drivers/thermal/samsung/exynos_tmu.c              |  2 +-
 28 files changed, 103 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/arm/OMAP/README
