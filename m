From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Jun 2014 15:23:45 -0600
Subject: [GIT PULL 2/3] ARM: tegra: move fuse code out of arch/arm
In-Reply-To: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1403558626-13422-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch moves code related to the Tegra fuses out of arch/arm and
into a centralized location which could be shared with ARM64. It also
adds support for reading the fuse data through sysfs.

This is a separate branch because it will be a dependency for the
upcoming XUSB padctrl driver, which is in turn a dependency for Tegra124
SATA, XHCI, and PCIe support.

----------------------------------------------------------------

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.17-fuse-move

for you to fetch changes up to d97f79366c566b2986cf6a142eb4d04a6eb4e970:

  misc: fuse: fix dummy functions

----------------------------------------------------------------

Peter De Schrijver (6):
      ARM: tegra: export apb dma readl/writel
      ARM: tegra: move fuse exports to tegra-soc.h
      misc: fuse: Add efuse driver for Tegra
      ARM: tegra: Add efuse and apbmisc bindings
      ARM: tegra: build new fuse driver in drivers/misc
      misc: fuse: move APB DMA into Tegra20 fuse driver

Stephen Warren (1):
      misc: fuse: fix dummy functions

 .../ABI/testing/sysfs-driver-tegra-fuse         |  11 +
 .../bindings/fuse/nvidia,tegra20-fuse.txt       |  40 +++
 .../bindings/misc/nvidia,tegra20-apbmisc.txt    |  13 +
 arch/arm/boot/dts/tegra114.dtsi                 |  15 ++
 arch/arm/boot/dts/tegra124.dtsi                 |  15 ++
 arch/arm/boot/dts/tegra20.dtsi                  |  15 ++
 arch/arm/boot/dts/tegra30.dtsi                  |  15 ++
 arch/arm/mach-tegra/Makefile                    |   5 -
 arch/arm/mach-tegra/apbio.c                     | 206 ---------------
 arch/arm/mach-tegra/apbio.h                     |  22 --
 arch/arm/mach-tegra/cpuidle.c                   |   2 +-
 arch/arm/mach-tegra/flowctrl.c                  |   2 +-
 arch/arm/mach-tegra/fuse.c                      | 252 -------------------
 arch/arm/mach-tegra/fuse.h                      |  79 ------
 arch/arm/mach-tegra/hotplug.c                   |   2 +-
 arch/arm/mach-tegra/platsmp.c                   |   2 +-
 arch/arm/mach-tegra/pm.c                        |   2 +-
 arch/arm/mach-tegra/pmc.c                       |   2 +-
 arch/arm/mach-tegra/powergate.c                 |   2 +-
 arch/arm/mach-tegra/reset-handler.S             |   2 +-
 arch/arm/mach-tegra/reset.c                     |   2 +-
 arch/arm/mach-tegra/sleep-tegra30.S             |   2 +-
 arch/arm/mach-tegra/tegra.c                     |   7 +-
 drivers/misc/Makefile                           |   1 +
 drivers/misc/fuse/Makefile                      |   1 +
 drivers/misc/fuse/tegra/Makefile                |   8 +
 drivers/misc/fuse/tegra/fuse-tegra.c            | 154 ++++++++++++
 drivers/misc/fuse/tegra/fuse-tegra20.c          | 214 ++++++++++++++++
 drivers/misc/fuse/tegra/fuse-tegra30.c          | 223 ++++++++++++++++
 drivers/misc/fuse/tegra/fuse.h                  |  71 ++++++
 .../misc/fuse/tegra/speedo-tegra114.c           |  53 ++--
 drivers/misc/fuse/tegra/speedo-tegra124.c       | 167 ++++++++++++
 .../misc/fuse/tegra/speedo-tegra20.c            |  42 ++--
 .../misc/fuse/tegra/speedo-tegra30.c            | 173 +++++++------
 drivers/misc/fuse/tegra/tegra-apbmisc.c         | 110 ++++++++
 include/linux/tegra-soc.h                       |  42 ++++
 36 files changed, 1262 insertions(+), 712 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-tegra-fuse
 create mode 100644 Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt
 create mode 100644 Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt
 delete mode 100644 arch/arm/mach-tegra/apbio.c
 delete mode 100644 arch/arm/mach-tegra/apbio.h
 delete mode 100644 arch/arm/mach-tegra/fuse.c
 delete mode 100644 arch/arm/mach-tegra/fuse.h
 create mode 100644 drivers/misc/fuse/Makefile
 create mode 100644 drivers/misc/fuse/tegra/Makefile
 create mode 100644 drivers/misc/fuse/tegra/fuse-tegra.c
 create mode 100644 drivers/misc/fuse/tegra/fuse-tegra20.c
 create mode 100644 drivers/misc/fuse/tegra/fuse-tegra30.c
 create mode 100644 drivers/misc/fuse/tegra/fuse.h
 rename arch/arm/mach-tegra/tegra114_speedo.c => drivers/misc/fuse/tegra/speedo-tegra114.c (55%)
 create mode 100644 drivers/misc/fuse/tegra/speedo-tegra124.c
 rename arch/arm/mach-tegra/tegra20_speedo.c => drivers/misc/fuse/tegra/speedo-tegra20.c (67%)
 rename arch/arm/mach-tegra/tegra30_speedo.c => drivers/misc/fuse/tegra/speedo-tegra30.c (52%)
 create mode 100644 drivers/misc/fuse/tegra/tegra-apbmisc.c
