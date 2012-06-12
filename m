From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jun 2012 13:30:43 +0100
Subject: [PATCH v8 00/13] Per sub-architecture SMP operations
Message-ID: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a small departure from the earlier series, which
was trying to introduce a SoC descriptor. Instead, this one focusses
on SMP operations, and only this, as per Arnd's request.

Each platforms exports a "struct smp_ops" that is pointed to by their
mach_desc. The last patch consolidates the definition of pen_release
into the SMP code, though this is arguably wrong (most platforms
shouldn't need the whole pen_release thing at all).

Patches against v3.5-rc2. Tested on VExpress (Cortex A15).

Also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git smp_ops-v3.5-rc2

Changelog:

>From v7:
- Dropped soc_desc, and focussed only on smp_ops
- Fixed CONFIG_HOTPLUG_CPU typo (courtesy of Shawn Guo)
- Marked {realview,vexpress}_cpu_die() as __cpuinit
- Added support for spear13xx
- Added pen_release consolidation (based on Arnd Bergman's patch)

>From v6:
- Dropped the dummy_* stuff
- Support for a number of new platforms
- Added the soc_hotplug_ops() macro to hide some #ifdef-ery away
- More exynos[ 45] churn
- Fixed section mismatches

>From v5:
- Added support for highbank and imx6q
- Added support for new shmobile SMP platform
- Add dummy_cpu_kill, dummy_cpu_disable and cpu_lowpower

>From v4:
- Added an SMP registration interface and moved all SMP structures to
  smp.c. The end result is much cleaner.
- Cleaned up patch 2 (leftovers from a previous rework)
- NVIDIA/EXYNOS4 naming cleanup.

>From v3:
- Converted all SMP platforms
- Added some cleanup as a last patch

>From v2:
- Split the SMP ops between init and runtime operations in order to
  have separate lifetimes for the different structures. This is not
  perfect though, as it still allows an __init function to make it to
  a runtime structure (all smp_*_ops structures are __initdata in
  order to be able to discard them). Thanks to Nico for pointing this
  out.
- Use macros to hide the #ifdef-ery in the SoC descriptor init,
  courtesy of Arnd.

>From v1:
- Move the SMP ops out of the descriptor, which makes the structure
  init a bit cleaner (thanks to Arnd).
- Mark all structures __initdata and keep a copy of the used ones.
- Keep a global pointer for the SMP ops.

Marc Zyngier (13):
  ARM: Add per-platform SMP/CPU-hotplug operations
  ARM: convert VExpress/RealView to smp_ops
  ARM: convert OMAP4 to smp_ops
  ARM: convert Tegra to smp_ops
  ARM: convert Exynos to smp_ops
  ARM: convert MSM SMP to smp_ops
  ARM: convert ux500 to smp_ops
  ARM: convert shmobile SMP to smp_ops
  ARM: convert highbank to smp_ops
  ARM: convert imx6q to smp_ops
  ARM: convert spear13xx to smp_ops
  ARM: smp: Make smp_ops mandatory for SMP platforms
  ARM: consolidate pen_release instead of having per platform
    definitions

 arch/arm/include/asm/mach/arch.h               |   10 +++
 arch/arm/include/asm/smp.h                     |   15 +---
 arch/arm/include/asm/smp_ops.h                 |   87 ++++++++++++++++++++++++
 arch/arm/kernel/setup.c                        |    2 +
 arch/arm/kernel/smp.c                          |   86 ++++++++++++++++++++++-
 arch/arm/mach-exynos/common.h                  |    8 +++
 arch/arm/mach-exynos/hotplug.c                 |    8 +--
 arch/arm/mach-exynos/mach-armlex4210.c         |    1 +
 arch/arm/mach-exynos/mach-exynos4-dt.c         |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c         |    1 +
 arch/arm/mach-exynos/mach-nuri.c               |    1 +
 arch/arm/mach-exynos/mach-origen.c             |    1 +
 arch/arm/mach-exynos/mach-smdk4x12.c           |    2 +
 arch/arm/mach-exynos/mach-smdkv310.c           |    2 +
 arch/arm/mach-exynos/mach-universal_c210.c     |    1 +
 arch/arm/mach-exynos/platsmp.c                 |   23 ++++---
 arch/arm/mach-highbank/core.h                  |    7 ++
 arch/arm/mach-highbank/highbank.c              |    1 +
 arch/arm/mach-highbank/hotplug.c               |    6 +-
 arch/arm/mach-highbank/platsmp.c               |   14 ++--
 arch/arm/mach-imx/hotplug.c                    |    6 +-
 arch/arm/mach-imx/mach-imx6q.c                 |    2 +
 arch/arm/mach-imx/platsmp.c                    |   15 ++--
 arch/arm/mach-msm/board-msm8960.c              |    3 +
 arch/arm/mach-msm/board-msm8x60.c              |    7 ++
 arch/arm/mach-msm/core.h                       |    7 ++
 arch/arm/mach-msm/hotplug.c                    |    8 +--
 arch/arm/mach-msm/platsmp.c                    |   20 +++---
 arch/arm/mach-omap2/board-4430sdp.c            |    1 +
 arch/arm/mach-omap2/board-generic.c            |    1 +
 arch/arm/mach-omap2/board-omap4panda.c         |    1 +
 arch/arm/mach-omap2/common.h                   |   10 +++
 arch/arm/mach-omap2/omap-hotplug.c             |    6 +-
 arch/arm/mach-omap2/omap-smp.c                 |   15 ++--
 arch/arm/mach-realview/core.c                  |    1 +
 arch/arm/mach-realview/core.h                  |    7 ++
 arch/arm/mach-realview/hotplug.c               |    8 +--
 arch/arm/mach-realview/platsmp.c               |   15 ++--
 arch/arm/mach-realview/realview_eb.c           |    1 +
 arch/arm/mach-realview/realview_pb11mp.c       |    1 +
 arch/arm/mach-realview/realview_pbx.c          |    1 +
 arch/arm/mach-shmobile/board-ag5evm.c          |    1 +
 arch/arm/mach-shmobile/board-kota2.c           |    1 +
 arch/arm/mach-shmobile/board-kzm9d.c           |    1 +
 arch/arm/mach-shmobile/board-kzm9g.c           |    1 +
 arch/arm/mach-shmobile/board-marzen.c          |    1 +
 arch/arm/mach-shmobile/hotplug.c               |   26 +++++--
 arch/arm/mach-shmobile/include/mach/common.h   |   19 ++----
 arch/arm/mach-shmobile/include/mach/emev2.h    |    8 +--
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |    6 ++
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |    4 ++
 arch/arm/mach-shmobile/platsmp.c               |   86 +----------------------
 arch/arm/mach-shmobile/setup-emev2.c           |    1 +
 arch/arm/mach-shmobile/smp-emev2.c             |   21 ++++--
 arch/arm/mach-shmobile/smp-r8a7779.c           |   21 ++++--
 arch/arm/mach-shmobile/smp-sh73a0.c            |   22 ++++--
 arch/arm/mach-spear13xx/hotplug.c              |    8 +--
 arch/arm/mach-spear13xx/include/mach/generic.h |    7 ++
 arch/arm/mach-spear13xx/platsmp.c              |   21 +++---
 arch/arm/mach-spear13xx/spear1310.c            |    1 +
 arch/arm/mach-spear13xx/spear1340.c            |    1 +
 arch/arm/mach-tegra/board-dt-tegra20.c         |    2 +
 arch/arm/mach-tegra/board-dt-tegra30.c         |    2 +
 arch/arm/mach-tegra/board-harmony.c            |    2 +
 arch/arm/mach-tegra/board-paz00.c              |    2 +
 arch/arm/mach-tegra/board-seaboard.c           |    4 ++
 arch/arm/mach-tegra/board-trimslice.c          |    2 +
 arch/arm/mach-tegra/common.c                   |    2 +
 arch/arm/mach-tegra/common.h                   |    6 ++
 arch/arm/mach-tegra/hotplug.c                  |    6 +-
 arch/arm/mach-tegra/platsmp.c                  |   17 +++--
 arch/arm/mach-ux500/board-mop500.c             |    4 ++
 arch/arm/mach-ux500/hotplug.c                  |    8 +--
 arch/arm/mach-ux500/include/mach/setup.h       |    7 ++
 arch/arm/mach-ux500/platsmp.c                  |   20 +++---
 arch/arm/mach-vexpress/core.h                  |    8 +++
 arch/arm/mach-vexpress/hotplug.c               |    8 +--
 arch/arm/mach-vexpress/platsmp.c               |   16 +++--
 arch/arm/mach-vexpress/v2m.c                   |    4 ++
 arch/arm/plat-mxc/include/mach/common.h        |    8 +++
 arch/arm/plat-versatile/include/plat/platsmp.h |   14 ++++
 arch/arm/plat-versatile/platsmp.c              |   10 +--
 82 files changed, 578 insertions(+), 244 deletions(-)
 create mode 100644 arch/arm/include/asm/smp_ops.h
 create mode 100644 arch/arm/mach-msm/core.h
 create mode 100644 arch/arm/mach-tegra/common.h
 create mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h

-- 
1.7.10.3
