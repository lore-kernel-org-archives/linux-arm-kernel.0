From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 21:19:19 +0200
Subject: [GIT PULL] ARM: SoC fixes for v4.6
Message-ID: <5881090.Jr4ohpX5Vx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0b24f7a8d6e0d17bcf24433ce5827841a05b5b46:

  Merge tag 'mvebu-fixes-4.6-1' of git://git.infradead.org/linux-mvebu into fixes (2016-04-12 12:35:07 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 978fa436231a834dc686292efc7d944d9013e035:

  drivers: firmware: psci: unify enable-method binding on ARM {64,32}-bit systems (2016-04-26 12:46:08 +0200)

----------------------------------------------------------------
Here are the latest bug fixes for ARM SoCs, mostly addressing
recent regressions. Changes are across several platforms, so
I'm listing every change separately here.

Regressions since 4.5:

 - A correction of the psci firmware DT binding, to prevent
   users from relying on unintended semantics

 - Actually getting the newly merged clock driver for some OMAP
   platforms to work (a fairly large chunk in one file)

 - A revert of patches for the Qualcomm BAM, these need to be
   reworked for 4.7 to avoid breaking boards other than the one
   they were intended for

 - A correction for the I2C device nodes on the Socionext Uniphier
   platform

 - i.MX SDHCI was broken for non-DT platforms due to a change
   with the setting of the DMA mask

 - A revert of a patch that accidentally added a nonexisting
   clock on the Rensas "Porter" board

 - A couple of OMAP fixes that are all related to suspend after
   the power domain changes for dra7

 - On Mediatek, revert part of the power domain initialization
   changes that broke mt8173-evb

Fixes for older bugs:

 - Workaround for an "external abort" in the omap34xx
   suspend/resume code.

 - The USB1/eSATA should not be listed as an excon device on
   am57xx-beagle-x15 (broken since v4.0)

 - A v4.5 regression in the TI AM33xx and AM43XX DT specifying
   incorrect DMA request lines for the GPMC

 - The jiffies calibration on Renesas platforms was incorrect
   for some modern CPU cores.

 - A hardware errata woraround for clockdomains on TI DRA7

----------------------------------------------------------------
Alexander Kurz (1):
      ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask

Andy Gross (2):
      Revert "dts: msm8974: Add blsp2_bam dma node"
      Revert "dts: msm8974: Add dma channels for blsp2_i2c1 node"

Arnd Bergmann (1):
      Merge tag 'qcom-fixes-for-4.6-rc2' of git://git.kernel.org/.../agross/linux into fixes

Dave Gerlach (1):
      ARM: OMAP3: Fix external abort on 36xx waking from off mode idle

Franklin S Cooper Jr (2):
      ARM: dts: am33xx: Fix GPMC dma properties
      ARM: dts: am437x: Fix GPMC dma properties

Geert Uytterhoeven (1):
      ARM: shmobile: timer: Fix preset_lpj leading to too short delays

James Liao (1):
      Revert "soc: mediatek: SCPSYS: Fix double enabling of regulators"

Keerthy (2):
      ARM: dts: dra7: Correct clock tree for sys_32k_ck
      ARM: DRA7: clockdomain: Implement timer workaround for errata i874

Kevin Hilman (6):
      Merge tag 'v4.6-soc-fixes' of https://github.com/mbgg/linux-mediatek into fixes
      Merge tag 'omap-for-v4.6/fixes-rc2-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'renesas-fixes-for-v4.6' of git://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'omap-for-v4.6/fixes-rc3' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'imx-fixes-4.6' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.6/dt-ti81xx-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Masahiro Yamada (1):
      arm64: dts: uniphier: fix I2C nodes of PH1-LD20

Nishanth Menon (3):
      ARM: OMAP: DRA7: wakeupgen: Skip SAR save for wakeupgen
      ARM: OMAP: DRA7: Provide proper class to omap2_set_globals_tap
      ARM: OMAP: Catch callers of revision information prior to it being populated

Roger Quadros (1):
      ARM: dts: am57xx-beagle-x15: remove extcon_usb1

Sjoerd Simons (2):
      ARM: dts: r8a7791: Don't disable referenced optional clocks
      Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"

Sudeep Holla (1):
      drivers: firmware: psci: unify enable-method binding on ARM {64,32}-bit systems

Tony Lindgren (4):
      ARM: dts: Add clocks for dm814x ADPLL
      Merge branch 'fixes-rc2' into omap-for-v4.6/fixes
      Merge tag 'for-v4.6-rc/omap-fixes-b' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.6/fixes
      Revert "ARM: OMAP: Catch callers of revision information prior to it being populated"
---
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 -
 arch/arm/boot/dts/am33xx.dtsi                      |   2 +-
 arch/arm/boot/dts/am4372.dtsi                      |   2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |  17 --
 arch/arm/boot/dts/dm814x-clocks.dtsi               | 243 ++++++++++++++++++---
 arch/arm/boot/dts/dra62x-clocks.dtsi               |  26 +++
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  18 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  14 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   1 +
 arch/arm/boot/dts/r8a7791-porter.dts               |  14 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |   5 +-
 .../mach-imx/devices/platform-sdhci-esdhc-imx.c    |   5 +-
 arch/arm/mach-omap2/clockdomains7xx_data.c         |   2 +-
 arch/arm/mach-omap2/io.c                           |   3 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |   7 +
 arch/arm/mach-omap2/pm34xx.c                       |  23 +-
 arch/arm/mach-shmobile/timer.c                     |  28 +--
 .../boot/dts/socionext/uniphier-ph1-ld20-ref.dts   |   1 -
 .../boot/dts/socionext/uniphier-ph1-ld20.dtsi      |  20 +-
 drivers/firmware/psci.c                            |   2 +-
 drivers/soc/mediatek/mtk-scpsys.c                  |  11 +-
 21 files changed, 310 insertions(+), 135 deletions(-)
