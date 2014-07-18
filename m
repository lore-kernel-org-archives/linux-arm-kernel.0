From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Jul 2014 16:45:34 +0200
Subject: [GIT PULL 1/7] ARM: tegra: move fuse code out of arch/arm
Message-ID: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.17-fuse-move

for you to fetch changes up to 2fa937a767bd0933dfe6017cabd038ce52594171:

  soc/tegra: fuse: fix dummy functions (2014-07-17 14:38:29 +0200)

----------------------------------------------------------------
ARM: tegra: move fuse code out of arch/arm

This branch moves code related to the Tegra fuses out of arch/arm and
into a centralized location which could be shared with ARM64. It also
adds support for reading the fuse data through sysfs.

Included is also some preparatory work that moves Tegra-related header
files from include/linux to include/soc/tegra as suggested by Arnd.

Furthermore the Tegra chip ID is now retrieved using a function rather
than a variable so that sanity checks can be done. This is convenient
in subsequent patches that will move some of the code that's currently
called from Tegra machine setup into regular initcalls so that it can
be reused on 64-bit ARM. The sanity checks help with verifying that no
code tries to obtain the Tegra chip ID before the underlying driver is
properly initialized.

----------------------------------------------------------------
Peter De Schrijver (5):
      ARM: tegra: export apb dma readl/writel
      ARM: tegra: move fuse exports to soc/tegra/fuse.h
      soc/tegra: Add efuse driver for Tegra
      soc/tegra: Add efuse and apbmisc bindings
      soc/tegra: fuse: move APB DMA into Tegra20 fuse driver

Stephen Warren (1):
      soc/tegra: fuse: fix dummy functions

Thierry Reding (3):
      ARM: tegra: Move includes to include/soc/tegra
      ARM: tegra: Sort includes alphabetically
      ARM: tegra: Use a function to get the chip ID

 Documentation/ABI/testing/sysfs-driver-tegra-fuse  |  11 +
 .../bindings/fuse/nvidia,tegra20-fuse.txt          |  40 ++++
 .../bindings/misc/nvidia,tegra20-apbmisc.txt       |  13 ++
 arch/arm/boot/dts/tegra114.dtsi                    |  15 ++
 arch/arm/boot/dts/tegra124.dtsi                    |  15 ++
 arch/arm/boot/dts/tegra20.dtsi                     |  15 ++
 arch/arm/boot/dts/tegra30.dtsi                     |  15 ++
 arch/arm/mach-tegra/Makefile                       |   5 -
 arch/arm/mach-tegra/apbio.c                        | 206 -----------------
 arch/arm/mach-tegra/apbio.h                        |  22 --
 arch/arm/mach-tegra/board-paz00.c                  |   3 +-
 arch/arm/mach-tegra/cpuidle-tegra114.c             |  10 +-
 arch/arm/mach-tegra/cpuidle-tegra20.c              |  16 +-
 arch/arm/mach-tegra/cpuidle-tegra30.c              |  10 +-
 arch/arm/mach-tegra/cpuidle.c                      |   7 +-
 arch/arm/mach-tegra/flowctrl.c                     |  11 +-
 arch/arm/mach-tegra/fuse.c                         | 252 ---------------------
 arch/arm/mach-tegra/fuse.h                         |  79 -------
 arch/arm/mach-tegra/hotplug.c                      |  14 +-
 arch/arm/mach-tegra/io.c                           |   8 +-
 arch/arm/mach-tegra/irq.c                          |   8 +-
 arch/arm/mach-tegra/platsmp.c                      |  29 +--
 arch/arm/mach-tegra/pm-tegra20.c                   |   1 +
 arch/arm/mach-tegra/pm-tegra30.c                   |   1 +
 arch/arm/mach-tegra/pm.c                           |  33 +--
 arch/arm/mach-tegra/pmc.c                          |   9 +-
 arch/arm/mach-tegra/powergate.c                    |  15 +-
 arch/arm/mach-tegra/reset-handler.S                |   7 +-
 arch/arm/mach-tegra/reset.c                        |  11 +-
 arch/arm/mach-tegra/sleep-tegra30.S                |   7 +-
 arch/arm/mach-tegra/tegra.c                        |  28 +--
 drivers/amba/tegra-ahb.c                           |   3 +-
 drivers/clk/tegra/clk-periph-gate.c                |   3 +-
 drivers/clk/tegra/clk-tegra30.c                    |   5 +-
 drivers/clk/tegra/clk.c                            |   3 +-
 drivers/gpu/drm/tegra/gr3d.c                       |   3 +-
 drivers/gpu/drm/tegra/sor.c                        |   3 +-
 drivers/iommu/tegra-smmu.c                         |   3 +-
 drivers/misc/fuse/Makefile                         |   1 +
 drivers/pci/host/pci-tegra.c                       |   5 +-
 drivers/soc/Makefile                               |   1 +
 drivers/soc/tegra/Makefile                         |   1 +
 drivers/soc/tegra/fuse/Makefile                    |   8 +
 drivers/soc/tegra/fuse/fuse-tegra.c                | 156 +++++++++++++
 drivers/soc/tegra/fuse/fuse-tegra20.c              | 215 ++++++++++++++++++
 drivers/soc/tegra/fuse/fuse-tegra30.c              | 224 ++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h                      |  71 ++++++
 .../soc/tegra/fuse/speedo-tegra114.c               |  56 +++--
 drivers/soc/tegra/fuse/speedo-tegra124.c           | 168 ++++++++++++++
 .../soc/tegra/fuse/speedo-tegra20.c                |  45 ++--
 .../soc/tegra/fuse/speedo-tegra30.c                | 176 +++++++-------
 drivers/soc/tegra/fuse/tegra-apbmisc.c             | 112 +++++++++
 include/linux/tegra-soc.h                          |  22 --
 include/{linux/tegra-ahb.h => soc/tegra/ahb.h}     |   6 +-
 .../{linux/tegra-cpuidle.h => soc/tegra/cpuidle.h} |   6 +-
 include/soc/tegra/fuse.h                           |  66 ++++++
 .../tegra-powergate.h => soc/tegra/powergate.h}    |   6 +-
 57 files changed, 1436 insertions(+), 848 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-tegra-fuse
 create mode 100644 Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt
 create mode 100644 Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt
 delete mode 100644 arch/arm/mach-tegra/apbio.c
 delete mode 100644 arch/arm/mach-tegra/apbio.h
 delete mode 100644 arch/arm/mach-tegra/fuse.c
 delete mode 100644 arch/arm/mach-tegra/fuse.h
 create mode 100644 drivers/misc/fuse/Makefile
 create mode 100644 drivers/soc/tegra/Makefile
 create mode 100644 drivers/soc/tegra/fuse/Makefile
 create mode 100644 drivers/soc/tegra/fuse/fuse-tegra.c
 create mode 100644 drivers/soc/tegra/fuse/fuse-tegra20.c
 create mode 100644 drivers/soc/tegra/fuse/fuse-tegra30.c
 create mode 100644 drivers/soc/tegra/fuse/fuse.h
 rename arch/arm/mach-tegra/tegra114_speedo.c => drivers/soc/tegra/fuse/speedo-tegra114.c (55%)
 create mode 100644 drivers/soc/tegra/fuse/speedo-tegra124.c
 rename arch/arm/mach-tegra/tegra20_speedo.c => drivers/soc/tegra/fuse/speedo-tegra20.c (67%)
 rename arch/arm/mach-tegra/tegra30_speedo.c => drivers/soc/tegra/fuse/speedo-tegra30.c (52%)
 create mode 100644 drivers/soc/tegra/fuse/tegra-apbmisc.c
 delete mode 100644 include/linux/tegra-soc.h
 rename include/{linux/tegra-ahb.h => soc/tegra/ahb.h} (86%)
 rename include/{linux/tegra-cpuidle.h => soc/tegra/cpuidle.h} (86%)
 create mode 100644 include/soc/tegra/fuse.h
 rename include/{linux/tegra-powergate.h => soc/tegra/powergate.h} (96%)
