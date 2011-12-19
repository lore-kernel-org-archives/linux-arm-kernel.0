From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:29 -0500
Subject: [PATCH 00/20] arch_idle() cleanup and mach/system.h removal
Message-ID: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the logical continuation of the arch_reset() work that Russell did
and therefore this must be applied on top of Russell's "reset" branch.

Most arch_idle() implementations are simply a call to cpu_do_idle() and
can be eliminated in favor of a common call.  However, some platforms
require special idle handling and the arm_pm_idle hook is made available
for those cases.

Why "arm_pm_idle"?  Because there is already a generic "pm_idle", but its
calling convention is rather awkward with regard to interrupts, so the
default "pm_idle" handler will call arm_pm_idle if it is non null, or
cpu_do_idle otherwise.  The generic pm_idle hook still can be overriden
as before.

This series is therefore meant to be functionally a big no-op i.e.
everything should just behave as before, despite having more than 1000
lines of code and 55 files removed in the end.

[PATCH 01/20] ARM: clean up idle handlers
[PATCH 02/20] ARM: mach-s5pv210: use standard arch_idle()
[PATCH 03/20] ARM: mach-s5pc100: use standard arch_idle()
[PATCH 04/20] ARM: mach-exynos: use standard arch_idle()
[PATCH 05/20] ARM: mach-at91: move special idle code out of line
[PATCH 06/20] ARM: mach-clps711x: move special idle code out of line
[PATCH 07/20] ARM: mach-ebsa110: move special idle code out of line
[PATCH 08/20] ARM: mach-gemini: move special idle code out of line
[PATCH 09/20] ARM: mach-h720x: move special idle code out of line
[PATCH 10/20] ARM: s3c24xx: move special idle code to out of line
[PATCH 11/20] ARM: plat-mxc: hook special idle handlers to
[PATCH 12/20] ARM: mach-msm: hook special idle handlers to
[PATCH 13/20] ARM: mach-ixp23xx: properly disable CPU idle call
[PATCH 14/20] ARM: mach-ixp4xx: properly disable CPU idle call
[PATCH 15/20] ARM: mach-shark: properly disable CPU idle call
[PATCH 16/20] ARM: mach-w90x900: properly disable CPU idle call
[PATCH 17/20] ARM: mach-s3c64xx: properly disable CPU idle call
[PATCH 18/20] ARM: mach-tegra: properly disable CPU idle call
[PATCH 19/20] ARM: substitute arch_idle()
[PATCH 20/20] ARM: big removal of now unused arch_reset()

 arch/arm/include/asm/system.h                  |    1 +
 arch/arm/kernel/process.c                      |   27 ++++++----
 arch/arm/mach-at91/at91cap9.c                  |    8 +++
 arch/arm/mach-at91/at91rm9200.c                |   10 ++++
 arch/arm/mach-at91/at91sam9260.c               |    8 +++
 arch/arm/mach-at91/at91sam9261.c               |    8 +++
 arch/arm/mach-at91/at91sam9263.c               |    8 +++
 arch/arm/mach-at91/at91sam9g45.c               |    7 +++
 arch/arm/mach-at91/at91sam9rl.c                |    8 +++
 arch/arm/mach-at91/at91x40.c                   |   12 ++++
 arch/arm/mach-at91/include/mach/system.h       |   50 ------------------
 arch/arm/mach-bcmring/include/mach/system.h    |   28 ----------
 arch/arm/mach-clps711x/common.c                |   16 ++++++
 arch/arm/mach-clps711x/include/mach/system.h   |   35 ------------
 arch/arm/mach-cns3xxx/include/mach/system.h    |   25 ---------
 arch/arm/mach-davinci/include/mach/system.h    |   21 -------
 arch/arm/mach-dove/include/mach/system.h       |   17 ------
 arch/arm/mach-ebsa110/core.c                   |   25 +++++++++
 arch/arm/mach-ebsa110/include/mach/system.h    |   37 -------------
 arch/arm/mach-ep93xx/include/mach/system.h     |    7 ---
 arch/arm/mach-exynos/cpu.c                     |   12 ----
 arch/arm/mach-exynos/include/mach/system.h     |   22 --------
 arch/arm/mach-footbridge/include/mach/system.h |   13 -----
 arch/arm/mach-gemini/Makefile                  |    2 +-
 arch/arm/mach-gemini/idle.c                    |   29 ++++++++++
 arch/arm/mach-gemini/include/mach/system.h     |   31 -----------
 arch/arm/mach-gemini/irq.c                     |    4 +-
 arch/arm/mach-h720x/common.c                   |   18 ++++++
 arch/arm/mach-h720x/include/mach/system.h      |   27 ----------
 arch/arm/mach-highbank/include/mach/system.h   |   24 --------
 arch/arm/mach-imx/mm-imx3.c                    |    4 +-
 arch/arm/mach-imx/pm-imx27.c                   |    3 +-
 arch/arm/mach-integrator/include/mach/system.h |   33 ------------
 arch/arm/mach-iop13xx/include/mach/system.h    |   13 -----
 arch/arm/mach-iop32x/include/mach/system.h     |   13 -----
 arch/arm/mach-iop33x/include/mach/system.h     |   13 -----
 arch/arm/mach-ixp2000/include/mach/system.h    |   14 -----
 arch/arm/mach-ixp23xx/core.c                   |    3 +
 arch/arm/mach-ixp23xx/include/mach/system.h    |   16 ------
 arch/arm/mach-ixp4xx/common.c                  |    6 ++
 arch/arm/mach-ixp4xx/include/mach/system.h     |   19 -------
 arch/arm/mach-kirkwood/include/mach/system.h   |   17 ------
 arch/arm/mach-ks8695/include/mach/system.h     |   27 ----------
 arch/arm/mach-lpc32xx/include/mach/system.h    |   27 ----------
 arch/arm/mach-mmp/include/mach/system.h        |   16 ------
 arch/arm/mach-msm/idle.S                       |   36 -------------
 arch/arm/mach-msm/idle.c                       |   49 +++++++++++++++++
 arch/arm/mach-msm/include/mach/system.h        |    1 -
 arch/arm/mach-mv78xx0/include/mach/system.h    |   17 ------
 arch/arm/mach-mx5/mm.c                         |    2 +-
 arch/arm/mach-mxs/include/mach/system.h        |   25 ---------
 arch/arm/mach-mxs/pm.c                         |    3 +-
 arch/arm/mach-netx/include/mach/system.h       |   28 ----------
 arch/arm/mach-nomadik/include/mach/system.h    |   32 -----------
 arch/arm/mach-omap1/include/mach/system.h      |    5 --
 arch/arm/mach-omap1/pm.c                       |   19 ++-----
 arch/arm/mach-omap2/include/mach/system.h      |    5 --
 arch/arm/mach-omap2/pm24xx.c                   |    5 +-
 arch/arm/mach-omap2/pm34xx.c                   |    7 +--
 arch/arm/mach-omap2/pm44xx.c                   |    2 +
 arch/arm/mach-orion5x/include/mach/system.h    |   19 -------
 arch/arm/mach-picoxcell/include/mach/system.h  |   26 ---------
 arch/arm/mach-pnx4008/include/mach/system.h    |   29 ----------
 arch/arm/mach-prima2/include/mach/system.h     |   17 ------
 arch/arm/mach-pxa/include/mach/system.h        |   15 -----
 arch/arm/mach-realview/include/mach/system.h   |   33 ------------
 arch/arm/mach-rpc/include/mach/system.h        |   13 -----
 arch/arm/mach-s3c2410/include/mach/system.h    |   37 -------------
 arch/arm/mach-s3c2412/s3c2412.c                |    3 +-
 arch/arm/mach-s3c2416/s3c2416.c                |    2 -
 arch/arm/mach-s3c64xx/cpu.c                    |    2 +
 arch/arm/mach-s3c64xx/include/mach/system.h    |    5 --
 arch/arm/mach-s5p64x0/cpu.c                    |   16 +++---
 arch/arm/mach-s5p64x0/include/mach/system.h    |   23 --------
 arch/arm/mach-s5pc100/cpu.c                    |   12 ----
 arch/arm/mach-s5pc100/include/mach/system.h    |   21 -------
 arch/arm/mach-s5pv210/cpu.c                    |   12 ----
 arch/arm/mach-s5pv210/include/mach/system.h    |   23 --------
 arch/arm/mach-sa1100/include/mach/system.h     |    9 ---
 arch/arm/mach-shark/core.c                     |    6 ++
 arch/arm/mach-shark/include/mach/system.h      |   13 -----
 arch/arm/mach-shmobile/include/mach/system.h   |    5 --
 arch/arm/mach-spear3xx/include/mach/system.h   |   19 -------
 arch/arm/mach-spear6xx/include/mach/system.h   |   19 -------
 arch/arm/mach-tegra/common.c                   |    3 +-
 arch/arm/mach-tegra/include/mach/system.h      |   28 ----------
 arch/arm/mach-u300/include/mach/system.h       |   14 -----
 arch/arm/mach-ux500/include/mach/system.h      |   20 -------
 arch/arm/mach-versatile/include/mach/system.h  |   33 ------------
 arch/arm/mach-vexpress/include/mach/system.h   |   33 ------------
 arch/arm/mach-vt8500/include/mach/system.h     |    5 --
 arch/arm/mach-w90x900/dev.c                    |    1 +
 arch/arm/mach-w90x900/include/mach/system.h    |   19 -------
 arch/arm/mach-zynq/include/mach/system.h       |   23 --------
 arch/arm/plat-mxc/include/mach/common.h        |    1 -
 arch/arm/plat-mxc/include/mach/system.h        |   30 -----------
 arch/arm/plat-mxc/system.c                     |    1 -
 arch/arm/plat-omap/include/plat/system.h       |   15 -----
 arch/arm/plat-s3c24xx/cpu.c                    |   27 ++++++++++
 arch/arm/plat-spear/include/plat/system.h      |   26 ---------
 arch/arm/plat-tcc/include/mach/system.h        |   31 -----------
 101 files changed, 299 insertions(+), 1390 deletions(-)
