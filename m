From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Jul 2014 16:45:35 +0200
Subject: [GIT PULL 2/7] ARM: tegra: core code changes for 3.17
In-Reply-To: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
References: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1405694740-4090-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit dd849e581d7d23e1729c23bb2d6b85360ce4dd9d:

  Merge branch 'for-3.17/fuse-move' into for-3.17/soc (2014-07-17 14:58:18 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.17-soc

for you to fetch changes up to 7232398abc6a7186e315425638c367d50c674718:

  ARM: tegra: Convert PMC to a driver (2014-07-17 14:58:43 +0200)

----------------------------------------------------------------
ARM: tegra: core code changes for 3.17

Some of the code that's currently called from the Tegra machine setup
code is moved to regular initcalls. To catch dependency violations, the
various code paths now WARN if they're called to early. Not all of the
potential candidates are converted yet, but those that were have been
verified to work across all supported Tegra generations.

A new function, soc_is_tegra(), is also provided to make sure that the
initcalls can abort early if they aren't run on Tegra, which can happen
for multi-platform builds.

Finally this also moves out the PMC driver to drivers/soc/tegra so that
it can be shared with 64-bit ARM.

This is based on the for-3.17/fuse-move branch. The split is somewhat
arbitrary but allows the dependents of the for-3.17/fuse-move to pull
in as little code as necessary.

----------------------------------------------------------------
Thierry Reding (5):
      soc/tegra: Implement runtime check for Tegra SoCs
      ARM: tegra: Setup CPU hotplug in a pure initcall
      ARM: tegra: Always lock the CPU reset vector
      soc/tegra: fuse: Set up in early initcall
      ARM: tegra: Convert PMC to a driver

 arch/arm/mach-tegra/Makefile             |   2 -
 arch/arm/mach-tegra/board.h              |   7 -
 arch/arm/mach-tegra/hotplug.c            |  16 +-
 arch/arm/mach-tegra/platsmp.c            |   2 +-
 arch/arm/mach-tegra/pm.c                 |  32 +-
 arch/arm/mach-tegra/pm.h                 |  10 +-
 arch/arm/mach-tegra/pmc.c                | 414 -------------
 arch/arm/mach-tegra/pmc.h                |  49 --
 arch/arm/mach-tegra/powergate.c          | 516 -----------------
 arch/arm/mach-tegra/reset.c              |  10 +-
 arch/arm/mach-tegra/sleep.h              |   3 -
 arch/arm/mach-tegra/tegra.c              |   9 +-
 drivers/clk/tegra/clk-tegra30.c          |   2 +-
 drivers/gpu/drm/tegra/gr3d.c             |   2 +-
 drivers/gpu/drm/tegra/sor.c              |   2 +-
 drivers/pci/host/pci-tegra.c             |   2 +-
 drivers/soc/tegra/Makefile               |   3 +
 drivers/soc/tegra/common.c               |  30 +
 drivers/soc/tegra/fuse/fuse-tegra.c      |  11 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c   |   7 +-
 drivers/soc/tegra/pmc.c                  | 957 +++++++++++++++++++++++++++++++
 include/soc/tegra/common.h               |  14 +
 include/soc/tegra/fuse.h                 |   1 -
 include/soc/tegra/pm.h                   |  38 ++
 include/soc/tegra/{powergate.h => pmc.h} |  31 +-
 25 files changed, 1132 insertions(+), 1038 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/pmc.c
 delete mode 100644 arch/arm/mach-tegra/pmc.h
 delete mode 100644 arch/arm/mach-tegra/powergate.c
 create mode 100644 drivers/soc/tegra/common.c
 create mode 100644 drivers/soc/tegra/pmc.c
 create mode 100644 include/soc/tegra/common.h
 create mode 100644 include/soc/tegra/pm.h
 rename include/soc/tegra/{powergate.h => pmc.h} (82%)
