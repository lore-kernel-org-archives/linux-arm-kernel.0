From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  4 Dec 2014 16:45:49 +0100
Subject: [GIT PULL v3 1/4] ARM: tegra: IOMMU support for v3.19
In-Reply-To: <1416570832-6220-1-git-send-email-thierry.reding@gmail.com>
References: <1416570832-6220-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1417707950-7633-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 0690cbd2e55a72a8eae557c389d1a136ed9fa142:

  powerpc/iommu: Rename iommu_[un]map_sg functions (2014-11-18 11:30:01 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.19-iommu

for you to fetch changes up to 8918465163171322c77a19d5258a95f56d89d2e4:

  memory: Add NVIDIA Tegra memory controller support (2014-12-04 16:11:47 +0100)

Here's a version of the pull request rebased on top of Joerg's core
branch from the IOMMU tree. It has the advantage of having resolved
the merge conflicts and the disadvantage of pulling in v3.18-rc3.
It also contains an updated commit description with some details
that ensued from a discussion regarding the DT binding as well as
the memory-client to SWGROUP mapping tables.

This pull request also contains fixes for a build error reported by the
0-day builder as well as a couple of issues in the IOMMU domain detach
path that I've found since v2 while doing extensive driver unload and
reload stress testing.

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: IOMMU support for v3.19

This adds the driver pieces required for IOMMU support on Tegra30,
Tegra114 and Tegra124.

----------------------------------------------------------------
Thierry Reding (6):
      Merge branch 'core' of git://git.kernel.org/.../joro/iommu
      clk: tegra: Implement memory-controller clock
      amba: Add Kconfig file
      ARM: tegra: Move AHB Kconfig to drivers/amba
      of: Add NVIDIA Tegra memory controller binding
      memory: Add NVIDIA Tegra memory controller support

 .../memory-controllers/nvidia,tegra-mc.txt         |   36 +
 arch/arm/Kconfig                                   |    3 -
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
 drivers/iommu/tegra-smmu.c                         | 1610 +++++++-------------
 drivers/memory/Kconfig                             |   12 +-
 drivers/memory/Makefile                            |    3 +-
 drivers/memory/tegra/Kconfig                       |    7 +
 drivers/memory/tegra/Makefile                      |    7 +
 drivers/memory/tegra/mc.c                          |  301 ++++
 drivers/memory/tegra/mc.h                          |   40 +
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
 31 files changed, 4084 insertions(+), 1503 deletions(-)
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
