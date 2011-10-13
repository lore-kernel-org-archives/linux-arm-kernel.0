From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 11:32:37 +0100
Subject: [PATCH v5 00/10] Per SoC descriptor
In-Reply-To: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
References: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20111013103237.GS21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 03:02:12PM +0100, Marc Zyngier wrote:
>  arch/arm/include/asm/mach/arch.h                |    2 +
>  arch/arm/include/asm/smp.h                      |   15 -----
>  arch/arm/include/asm/soc.h                      |   64 ++++++++++++++++++++
>  arch/arm/kernel/setup.c                         |    8 +++
>  arch/arm/kernel/smp.c                           |   73 ++++++++++++++++++++++-
>  arch/arm/mach-exynos4/core.h                    |   14 ++++
>  arch/arm/mach-exynos4/cpu.c                     |    8 +++
>  arch/arm/mach-exynos4/hotplug.c                 |    8 ++-
>  arch/arm/mach-exynos4/mach-armlex4210.c         |    3 +
>  arch/arm/mach-exynos4/mach-nuri.c               |    3 +
>  arch/arm/mach-exynos4/mach-origen.c             |    3 +
>  arch/arm/mach-exynos4/mach-smdk4x12.c           |    4 +
>  arch/arm/mach-exynos4/mach-smdkv310.c           |    4 +
>  arch/arm/mach-exynos4/mach-universal_c210.c     |    3 +
>  arch/arm/mach-exynos4/platsmp.c                 |   25 +++++++-
>  arch/arm/mach-msm/Makefile                      |    2 +-
>  arch/arm/mach-msm/board-msm8960.c               |    3 +
>  arch/arm/mach-msm/board-msm8x60.c               |    7 ++
>  arch/arm/mach-msm/core.c                        |   17 +++++
>  arch/arm/mach-msm/core.h                        |    9 +++
>  arch/arm/mach-msm/hotplug.c                     |    8 ++-
>  arch/arm/mach-msm/platsmp.c                     |   24 ++++++-
>  arch/arm/mach-omap2/board-4430sdp.c             |    1 +
>  arch/arm/mach-omap2/board-omap4panda.c          |    1 +
>  arch/arm/mach-omap2/include/mach/omap4-common.h |   14 ++++
>  arch/arm/mach-omap2/omap-hotplug.c              |    6 +-
>  arch/arm/mach-omap2/omap-smp.c                  |   24 ++++++-
>  arch/arm/mach-omap2/omap4-common.c              |    7 ++
>  arch/arm/mach-realview/core.c                   |    7 ++
>  arch/arm/mach-realview/core.h                   |    9 +++
>  arch/arm/mach-realview/hotplug.c                |    6 +-
>  arch/arm/mach-realview/platsmp.c                |   24 ++++++-
>  arch/arm/mach-realview/realview_eb.c            |    1 +
>  arch/arm/mach-realview/realview_pb1176.c        |    1 +
>  arch/arm/mach-realview/realview_pb11mp.c        |    1 +
>  arch/arm/mach-realview/realview_pba8.c          |    1 +
>  arch/arm/mach-realview/realview_pbx.c           |    1 +
>  arch/arm/mach-shmobile/Makefile                 |    2 +-
>  arch/arm/mach-shmobile/board-ag5evm.c           |    1 +
>  arch/arm/mach-shmobile/hotplug.c                |    8 ++-
>  arch/arm/mach-shmobile/include/mach/common.h    |    7 +-
>  arch/arm/mach-shmobile/include/mach/sh73a0.h    |    6 ++
>  arch/arm/mach-shmobile/platsmp.c                |   68 ---------------------
>  arch/arm/mach-shmobile/setup-sh73a0.c           |    6 ++
>  arch/arm/mach-shmobile/smp-sh73a0.c             |   35 ++++++++++-
>  arch/arm/mach-tegra/board-dt.c                  |    2 +
>  arch/arm/mach-tegra/board-harmony.c             |    2 +
>  arch/arm/mach-tegra/board-paz00.c               |    2 +
>  arch/arm/mach-tegra/board-seaboard.c            |    4 +
>  arch/arm/mach-tegra/board-trimslice.c           |    2 +
>  arch/arm/mach-tegra/common.c                    |    8 +++
>  arch/arm/mach-tegra/common.h                    |   11 ++++
>  arch/arm/mach-tegra/hotplug.c                   |    6 +-
>  arch/arm/mach-tegra/platsmp.c                   |   26 +++++++-
>  arch/arm/mach-ux500/board-mop500.c              |    3 +
>  arch/arm/mach-ux500/board-u5500.c               |    1 +
>  arch/arm/mach-ux500/hotplug.c                   |    8 ++-
>  arch/arm/mach-ux500/include/mach/setup.h        |    9 +++
>  arch/arm/mach-ux500/platsmp.c                   |   23 ++++++-
>  arch/arm/mach-vexpress/core.h                   |   10 +++
>  arch/arm/mach-vexpress/hotplug.c                |    6 +-
>  arch/arm/mach-vexpress/platsmp.c                |   24 ++++++-
>  arch/arm/mach-vexpress/v2m.c                    |    9 +++
>  arch/arm/plat-versatile/include/plat/platsmp.h  |   14 ++++
>  arch/arm/plat-versatile/platsmp.c               |    4 +-
>  65 files changed, 569 insertions(+), 149 deletions(-)

This isn't particularly appealing for something that's supposed to
be a clean up - it's introducing 400+ new lines of code.  It looks like
most of this comes from the platform stuff rather than core stuff.

Can't we do any better with this?  We really need things to be going
in the other direction.
