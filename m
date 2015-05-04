From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  4 May 2015 13:46:38 +0200
Subject: [PATCH 0/8] soc/tegra: More unification and cleanup for 64-bit
Message-ID: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

This set of patches restricts the legacy code to 32-bit ARM for the PMC
and FUSE drivers and follows up by adding Tegra210 support. Note how in
particular the FUSE driver required quite a few changes to unify it for
all SoC families. This makes it easier to test and extend in the future
as new SoC support is added.

Mark, you requested the restriction of the legacy compatibility code in
an earlier version that Paul posted. Can you take a look at this series
and see if it matches your expectations? I've kept soc_is_tegra() to be
consistent across all generations, but legacy code paths are guarded by
an IS_ENABLED(CONFIG_ARM). I think that's a good compromise between the
options that had been discussed earlier, but let me know if you want to
see this done differently.

Thierry

Thierry Reding (8):
  soc/tegra: pmc: Restrict legacy code to 32-bit ARM
  soc/tegra: pmc: Add Tegra210 support
  soc/tegra: Add Tegra132 support
  soc/tegra: Add Tegra210 support
  soc/tegra: fuse: Restrict legacy code to 32-bit ARM
  soc/tegra: fuse: Unify Tegra20 and Tegra30 drivers
  soc/tegra: fuse: Add Tegra210 support
  soc/tegra: fuse: Rename core_* to soc_*

 arch/arm/mach-tegra/iomap.h              |   3 -
 drivers/soc/tegra/common.c               |   2 +
 drivers/soc/tegra/fuse/Makefile          |   2 +
 drivers/soc/tegra/fuse/fuse-tegra.c      | 255 ++++++++++++++++++++++++-------
 drivers/soc/tegra/fuse/fuse-tegra20.c    | 172 ++++++++-------------
 drivers/soc/tegra/fuse/fuse-tegra30.c    | 221 +++++++++------------------
 drivers/soc/tegra/fuse/fuse.h            |  95 ++++++++----
 drivers/soc/tegra/fuse/speedo-tegra114.c |  22 +--
 drivers/soc/tegra/fuse/speedo-tegra124.c |  26 ++--
 drivers/soc/tegra/fuse/speedo-tegra20.c  |  28 ++--
 drivers/soc/tegra/fuse/speedo-tegra210.c | 184 ++++++++++++++++++++++
 drivers/soc/tegra/fuse/speedo-tegra30.c  |  48 +++---
 drivers/soc/tegra/fuse/tegra-apbmisc.c   |  76 +++++++--
 drivers/soc/tegra/pmc.c                  | 104 +++++++++++--
 include/soc/tegra/fuse.h                 |   6 +-
 include/soc/tegra/pmc.h                  |   5 +
 16 files changed, 815 insertions(+), 434 deletions(-)
 create mode 100644 drivers/soc/tegra/fuse/speedo-tegra210.c

-- 
2.3.5
