From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 19:31:43 +0800
Subject: [PATCH V6 0/9] ARM: tegra: add platform suspend support
Message-ID: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces a basic functionality for Tegra to support the
platform suspend and resume.

Note: This series only adds the support for Tegra20 and Tegra30. The
Tegra114 will be supported later.

Verified on Seaboard and Cardhu.

V6:
* add more boards support by dts file

V5:
* some fixes from V4's review comments

V4:
* add tegra_pm_validate_suspend_mode() to validate the suspend mode config
  from DT
* squash the patch below into [4/9] to avoid churn after this series
  [2/3] ARM: tegra: refactor the pmc_pm_set function

V3:
* fix the PMC DT configurations for paz00 board
* add a protection for only support LP2 suspend mode

V2:
* re-order the patch sequence to make sure the suspend function can be
  enabled well after the last patch be merged
* squash the patches that defined the PM bindings for PMC and the
  implementation

Joseph Lo (9):
  gpio: tegra: add gpio wakeup source handling
  ARM: tegra: irq: add wake up handling
  ARM: dt: tegra: add bindings of power management configurations for
    PMC
  ARM: tegra: pm: add platform suspend support
  ARM: dts: tegra: add power gpio keys to DT
  ARM: dts: tegra: whistler: add wakeup source for KBC
  ARM: dts: tegra: add non-removable and keep-power-in-suspend property
    for MMC
  ARM: tegra: config: defconfig update
  ARM: dts: tegra: add the PM configurations of PMC

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  38 ++++++
 arch/arm/boot/dts/tegra114-dalmore.dts             |   1 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi         |   9 ++
 arch/arm/boot/dts/tegra20-harmony.dts              |  17 +++
 arch/arm/boot/dts/tegra20-paz00.dts                |   7 ++
 arch/arm/boot/dts/tegra20-seaboard.dts             |   8 ++
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |   6 +
 arch/arm/boot/dts/tegra20-trimslice.dts            |  20 ++++
 arch/arm/boot/dts/tegra20-ventana.dts              |  19 +++
 arch/arm/boot/dts/tegra20-whistler.dts             |  10 ++
 arch/arm/boot/dts/tegra30-beaver.dts               |   8 ++
 arch/arm/boot/dts/tegra30-cardhu-a02.dts           |   1 +
 arch/arm/boot/dts/tegra30-cardhu-a04.dts           |   1 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   8 ++
 arch/arm/configs/tegra_defconfig                   |   1 +
 arch/arm/mach-tegra/common.c                       |   3 +
 arch/arm/mach-tegra/irq.c                          |  96 ++++++++++++++-
 arch/arm/mach-tegra/irq.h                          |   6 +
 arch/arm/mach-tegra/pm.c                           |  93 ++++++++++++--
 arch/arm/mach-tegra/pm.h                           |  15 +++
 arch/arm/mach-tegra/pmc.c                          | 133 ++++++++++++++++++++-
 arch/arm/mach-tegra/pmc.h                          |  12 +-
 drivers/gpio/gpio-tegra.c                          |  21 +++-
 23 files changed, 513 insertions(+), 20 deletions(-)

-- 
1.8.2
