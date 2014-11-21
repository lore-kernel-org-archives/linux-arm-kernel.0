From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 21 Nov 2014 12:53:50 +0100
Subject: [GIT PULL 2/4] ARM: tegra: Device tree changes for v3.19
In-Reply-To: <1416570832-6220-1-git-send-email-thierry.reding@gmail.com>
References: <1416570832-6220-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1416570832-6220-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Hi ARM SoC maintainers,

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.19-dt

for you to fetch changes up to aa900abe483dd66e0a6a577c55084e1e63ac6f48:

  ARM: tegra: Enable IOMMU for display controllers on Tegra124 (2014-11-21 10:53:16 +0100)

Note that this pulls in the for-3.19/iommu branch (tegra-for-3.19-iommu
tag) to resolve the dependency between the IOMMU driver addition and the
DT changes that include dt-bindings/memory/tegra*-mc.h headers.

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v3.19

The bulk of these changes add memory controller nodes for Tegra30,
Tegra114 and Tegra124. The memory controller implements an IOMMU that
the display controllers are attached to. This allows them to scan out
physically non-contiguous framebuffers and removes one of the primary
users of CMA.

The only other change adds a new MIPI pad control bank to the pin
controller on Tegra124. The corresponding driver patch for this went
into v3.18 as:

        3ccc11f6b82c pinctrl: tegra: Add MIPI pad control

----------------------------------------------------------------
Sean Paul (1):
      ARM: tegra: Add APB_MISC_GP as a MIPI pad control bank

Thierry Reding (12):
      clk: tegra: Implement memory-controller clock
      amba: Add Kconfig file
      ARM: tegra: Move AHB Kconfig to drivers/amba
      of: Add NVIDIA Tegra memory controller binding
      memory: Add NVIDIA Tegra memory controller support
      Merge branch 'for-3.19/iommu' into for-3.19/dt
      ARM: tegra: Add memory controller support for Tegra30
      ARM: tegra: Add memory controller support for Tegra114
      ARM: tegra: Add memory controller support for Tegra124
      ARM: tegra: Enable IOMMU for display controllers on Tegra30
      ARM: tegra: Enable IOMMU for display controllers on Tegra114
      ARM: tegra: Enable IOMMU for display controllers on Tegra124

 .../memory-controllers/nvidia,tegra-mc.txt         |   36 +
 arch/arm/Kconfig                                   |    3 -
 arch/arm/boot/dts/tegra114.dtsi                    |   23 +-
 arch/arm/boot/dts/tegra124.dtsi                    |   19 +-
 arch/arm/boot/dts/tegra30.dtsi                     |   25 +-
 arch/arm/mach-tegra/Kconfig                        |    9 +-
 arch/arm64/Kconfig                                 |    3 -
 drivers/Kconfig                                    |    2 +
 drivers/amba/Kconfig                               |   14 +
 drivers/clk/tegra/clk-divider.c                    |   13 +
 drivers/clk/tegra/clk-tegra114.c                   |    7 +-
 drivers/clk/tegra/clk-tegra124.c                   |    7 +-
 drivers/clk/tegra/clk-tegra20.c                    |    8 +-
 drivers/clk/tegra/clk-tegra30.c                    |    7 +-
 drivers/clk/tegra/clk.h                            |    2 +
 drivers/iommu/Kconfig                              |   12 +-
 drivers/iommu/tegra-smmu.c                         | 1602 +++++++-------------
 drivers/memory/Kconfig                             |   12 +-
 drivers/memory/Makefile                            |    3 +-
 drivers/memory/tegra/Kconfig                       |    7 +
 drivers/memory/tegra/Makefile                      |    7 +
 drivers/memory/tegra/mc.c                          |  301 ++++
 drivers/memory/tegra/mc.h                          |   53 +
 drivers/memory/tegra/tegra114.c                    |  948 ++++++++++++
 drivers/memory/tegra/tegra124.c                    |  995 ++++++++++++
 drivers/memory/tegra/tegra30.c                     |  970 ++++++++++++
 drivers/memory/tegra30-mc.c                        |  378 -----
 include/dt-bindings/clock/tegra114-car.h           |    2 +-
 include/dt-bindings/clock/tegra124-car.h           |    2 +-
 include/dt-bindings/clock/tegra20-car.h            |    2 +-
 include/dt-bindings/memory/tegra114-mc.h           |   25 +
 include/dt-bindings/memory/tegra124-mc.h           |   31 +
 include/dt-bindings/memory/tegra30-mc.h            |   24 +
 include/soc/tegra/mc.h                             |  107 ++
 34 files changed, 4131 insertions(+), 1528 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra-mc.txt
 create mode 100644 drivers/amba/Kconfig
 create mode 100644 drivers/memory/tegra/Kconfig
 create mode 100644 drivers/memory/tegra/Makefile
 create mode 100644 drivers/memory/tegra/mc.c
 create mode 100644 drivers/memory/tegra/mc.h
 create mode 100644 drivers/memory/tegra/tegra114.c
 create mode 100644 drivers/memory/tegra/tegra124.c
 create mode 100644 drivers/memory/tegra/tegra30.c
 delete mode 100644 drivers/memory/tegra30-mc.c
 create mode 100644 include/dt-bindings/memory/tegra114-mc.h
 create mode 100644 include/dt-bindings/memory/tegra124-mc.h
 create mode 100644 include/dt-bindings/memory/tegra30-mc.h
 create mode 100644 include/soc/tegra/mc.h
