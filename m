From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  7 Jun 2012 17:09:17 +0100
Subject: [PATCH v7 00/12] Per SoC descriptor
Message-ID: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[As per Arnd request, I've updated this patch series, in the hope that
it could be useful to the single zImage work]

This patch series introduces a per-soc descriptor which should, in the
end, contain most of the SoC specific operations.

This first patch series introduces the arm_soc_desc structure, adds
per-soc SMP and CPU hotplug operations, and converts all SMP platform
to this new scheme.

Patches against v3.5-rc1. Tested on VExpress (Cortex A15).

Also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git soc_desc-v3.5-rc1

Changelog:

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


Marc Zyngier (12):
  ARM: SoC: Introduce per SoC descriptor
  ARM: SoC: Add per SoC SMP and CPU hotplug operations
  ARM: SoC: convert VExpress/RealView to SoC descriptor
  ARM: SoC: convert OMAP4 to SoC descriptor
  ARM: SoC: convert Tegra to SoC descriptor
  ARM: SoC: convert Exynos4 to SoC descriptor
  ARM: SoC: convert MSM SMP to SoC descriptor
  ARM: SoC: convert ux500 to SoC descriptor
  ARM: SoC: convert shmobile SMP to SoC descriptor
  ARM: SoC: convert highbank to SoC descriptor
  ARM: SoC: convert imx6q to SoC descriptor
  ARM: smp: Make SoC descriptor mandatory for SMP platforms

 arch/arm/include/asm/mach/arch.h               |    2 +
 arch/arm/include/asm/smp.h                     |   14 ----
 arch/arm/include/asm/soc.h                     |   78 +++++++++++++++++++++
 arch/arm/kernel/setup.c                        |    8 +++
 arch/arm/kernel/smp.c                          |   79 +++++++++++++++++++++-
 arch/arm/mach-exynos/common.c                  |    6 ++
 arch/arm/mach-exynos/common.h                  |   10 +++
 arch/arm/mach-exynos/hotplug.c                 |    8 ++-
 arch/arm/mach-exynos/mach-armlex4210.c         |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c         |    1 +
 arch/arm/mach-exynos/mach-nuri.c               |    1 +
 arch/arm/mach-exynos/mach-origen.c             |    1 +
 arch/arm/mach-exynos/mach-smdk4x12.c           |    2 +
 arch/arm/mach-exynos/mach-smdkv310.c           |    2 +
 arch/arm/mach-exynos/mach-universal_c210.c     |    1 +
 arch/arm/mach-exynos/platsmp.c                 |   21 ++++--
 arch/arm/mach-highbank/core.h                  |    8 +++
 arch/arm/mach-highbank/highbank.c              |    7 ++
 arch/arm/mach-highbank/hotplug.c               |    6 +-
 arch/arm/mach-highbank/platsmp.c               |   19 ++++--
 arch/arm/mach-imx/hotplug.c                    |    6 +-
 arch/arm/mach-imx/mach-imx6q.c                 |    8 +++
 arch/arm/mach-imx/platsmp.c                    |   20 ++++--
 arch/arm/mach-msm/Makefile                     |    2 +-
 arch/arm/mach-msm/board-msm8960.c              |    3 +
 arch/arm/mach-msm/board-msm8x60.c              |    7 ++
 arch/arm/mach-msm/core.c                       |   17 +++++
 arch/arm/mach-msm/core.h                       |    9 +++
 arch/arm/mach-msm/hotplug.c                    |    8 ++-
 arch/arm/mach-msm/platsmp.c                    |   20 ++++--
 arch/arm/mach-omap2/board-4430sdp.c            |    1 +
 arch/arm/mach-omap2/board-generic.c            |    1 +
 arch/arm/mach-omap2/board-omap4panda.c         |    1 +
 arch/arm/mach-omap2/common.h                   |   13 ++++
 arch/arm/mach-omap2/omap-hotplug.c             |    6 +-
 arch/arm/mach-omap2/omap-smp.c                 |   20 ++++--
 arch/arm/mach-omap2/omap4-common.c             |    7 ++
 arch/arm/mach-realview/core.c                  |    7 ++
 arch/arm/mach-realview/core.h                  |    9 +++
 arch/arm/mach-realview/hotplug.c               |    6 +-
 arch/arm/mach-realview/platsmp.c               |   20 ++++--
 arch/arm/mach-realview/realview_eb.c           |    1 +
 arch/arm/mach-realview/realview_pb1176.c       |    1 +
 arch/arm/mach-realview/realview_pb11mp.c       |    1 +
 arch/arm/mach-realview/realview_pba8.c         |    1 +
 arch/arm/mach-realview/realview_pbx.c          |    1 +
 arch/arm/mach-shmobile/board-ag5evm.c          |    1 +
 arch/arm/mach-shmobile/board-kota2.c           |    1 +
 arch/arm/mach-shmobile/board-kzm9d.c           |    1 +
 arch/arm/mach-shmobile/board-kzm9g.c           |    1 +
 arch/arm/mach-shmobile/board-marzen.c          |    1 +
 arch/arm/mach-shmobile/hotplug.c               |   26 +++++--
 arch/arm/mach-shmobile/include/mach/common.h   |   19 ++----
 arch/arm/mach-shmobile/include/mach/emev2.h    |   10 +--
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |    8 +++
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |    6 ++
 arch/arm/mach-shmobile/platsmp.c               |   86 +-----------------------
 arch/arm/mach-shmobile/setup-emev2.c           |    7 ++
 arch/arm/mach-shmobile/setup-r8a7779.c         |    6 ++
 arch/arm/mach-shmobile/setup-sh73a0.c          |    6 ++
 arch/arm/mach-shmobile/smp-emev2.c             |   26 +++++--
 arch/arm/mach-shmobile/smp-r8a7779.c           |   26 +++++--
 arch/arm/mach-shmobile/smp-sh73a0.c            |   27 ++++++--
 arch/arm/mach-tegra/board-dt-tegra20.c         |    2 +
 arch/arm/mach-tegra/board-dt-tegra30.c         |    2 +
 arch/arm/mach-tegra/board-harmony.c            |    2 +
 arch/arm/mach-tegra/board-paz00.c              |    2 +
 arch/arm/mach-tegra/board-seaboard.c           |    4 ++
 arch/arm/mach-tegra/board-trimslice.c          |    2 +
 arch/arm/mach-tegra/common.c                   |    8 +++
 arch/arm/mach-tegra/common.h                   |   11 +++
 arch/arm/mach-tegra/hotplug.c                  |    6 +-
 arch/arm/mach-tegra/platsmp.c                  |   22 ++++--
 arch/arm/mach-ux500/board-mop500.c             |    4 ++
 arch/arm/mach-ux500/cpu.c                      |    7 ++
 arch/arm/mach-ux500/hotplug.c                  |    8 ++-
 arch/arm/mach-ux500/include/mach/setup.h       |    9 +++
 arch/arm/mach-ux500/platsmp.c                  |   19 ++++--
 arch/arm/mach-vexpress/core.h                  |   10 +++
 arch/arm/mach-vexpress/hotplug.c               |    6 +-
 arch/arm/mach-vexpress/platsmp.c               |   21 ++++--
 arch/arm/mach-vexpress/v2m.c                   |   10 +++
 arch/arm/plat-mxc/include/mach/common.h        |   10 +++
 arch/arm/plat-versatile/include/plat/platsmp.h |   14 ++++
 arch/arm/plat-versatile/platsmp.c              |    4 +-
 85 files changed, 712 insertions(+), 200 deletions(-)
 create mode 100644 arch/arm/include/asm/soc.h
 create mode 100644 arch/arm/mach-msm/core.c
 create mode 100644 arch/arm/mach-msm/core.h
 create mode 100644 arch/arm/mach-tegra/common.h
 create mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h

-- 
1.7.10.1
