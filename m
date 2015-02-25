From: ezequiel.garcia@imgtec.com (Ezequiel Garcia)
Date: Wed, 25 Feb 2015 08:45:12 -0300
Subject: [PATCH 0/7] New eFuse subsystem
Message-ID: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces a new driver subsystem, meant to support eFuse
(alias OTP, one-time-programmable) devices.

The motivation behind this work is to have a common place for drivers
that are currently more or less scattered: the tegra efuses are in
drivers/soc/ and the sunxi efuses in drivers/misc/eeprom.

For now, there's no proposal for a generic efuse API. Instead, we simply
group the drivers together.

This patchset is the result of the initial submission for IMG Pistachio
eFuse support [1]. Our first proposal was to follow the Tegra efuse, and
put the Pistachio efuse in drivers/soc. After some discussion we finally
agreed [2] to first create an efuse directoy, and then put all efuse drivers
in it.

As always, all comments are welcome!

[1] http://www.spinics.net/lists/devicetree/msg59246.html
[2] http://www.spinics.net/lists/arm-kernel/msg389325.html

Ezequiel Garcia (7):
  soc: tegra: Add missing include linux/types.h
  soc: tegra: Move the fuse header to a separate directory
  drivers: Introduce new eFuse subsystem stub
  efuse: Move Tegra efuse driver
  ARM: tegra: Make sure efuse is always selected
  efuse: Move Sunxi fuse driver
  ARM: sunxi: Rename EFUSE_SUNXI option in defconfigs

 arch/arm/configs/multi_v7_defconfig                |  2 +-
 arch/arm/configs/sunxi_defconfig                   |  2 +-
 arch/arm/mach-tegra/Kconfig                        |  1 +
 arch/arm/mach-tegra/cpuidle.c                      |  3 +--
 arch/arm/mach-tegra/flowctrl.c                     |  3 +--
 arch/arm/mach-tegra/hotplug.c                      |  2 +-
 arch/arm/mach-tegra/platsmp.c                      |  2 +-
 arch/arm/mach-tegra/pm.c                           |  2 +-
 arch/arm/mach-tegra/reset-handler.S                |  3 +--
 arch/arm/mach-tegra/reset.c                        |  3 +--
 arch/arm/mach-tegra/sleep-tegra30.S                |  3 +--
 arch/arm/mach-tegra/tegra.c                        |  2 +-
 drivers/Kconfig                                    |  2 ++
 drivers/Makefile                                   |  1 +
 drivers/ata/ahci_tegra.c                           |  2 +-
 drivers/clk/tegra/clk-periph-gate.c                |  3 +--
 drivers/clk/tegra/clk.c                            |  3 +--
 drivers/efuse/Kconfig                              | 22 ++++++++++++++++++++++
 drivers/efuse/Makefile                             |  2 ++
 drivers/{misc/eeprom => efuse}/sunxi_sid.c         |  0
 drivers/{soc/tegra/fuse => efuse/tegra}/Makefile   |  0
 .../{soc/tegra/fuse => efuse/tegra}/fuse-tegra.c   |  2 +-
 .../{soc/tegra/fuse => efuse/tegra}/fuse-tegra20.c |  3 +--
 .../{soc/tegra/fuse => efuse/tegra}/fuse-tegra30.c |  3 +--
 drivers/{soc/tegra/fuse => efuse/tegra}/fuse.h     |  0
 .../tegra/fuse => efuse/tegra}/speedo-tegra114.c   |  3 +--
 .../tegra/fuse => efuse/tegra}/speedo-tegra124.c   |  3 +--
 .../tegra/fuse => efuse/tegra}/speedo-tegra20.c    |  3 +--
 .../tegra/fuse => efuse/tegra}/speedo-tegra30.c    |  3 +--
 .../tegra/fuse => efuse/tegra}/tegra-apbmisc.c     |  3 +--
 drivers/gpu/drm/nouveau/nouveau_platform.c         |  2 +-
 drivers/misc/eeprom/Kconfig                        | 13 -------------
 drivers/misc/eeprom/Makefile                       |  1 -
 drivers/soc/tegra/Makefile                         |  2 --
 drivers/soc/tegra/pmc.c                            |  2 +-
 drivers/thermal/tegra_soctherm.c                   |  3 +--
 include/{soc/tegra/fuse.h => linux/efuse/tegra.h}  |  2 ++
 37 files changed, 55 insertions(+), 56 deletions(-)
 create mode 100644 drivers/efuse/Kconfig
 create mode 100644 drivers/efuse/Makefile
 rename drivers/{misc/eeprom => efuse}/sunxi_sid.c (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/Makefile (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra.c (99%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra20.c (99%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra30.c (99%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse.h (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra114.c (98%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra124.c (99%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra20.c (99%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra30.c (99%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/tegra-apbmisc.c (98%)
 rename include/{soc/tegra/fuse.h => linux/efuse/tegra.h} (98%)

-- 
2.3.0
