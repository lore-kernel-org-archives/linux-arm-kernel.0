From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 20 Jan 2012 22:20:55 -0500 (EST)
Subject: [PATCH 00/20] arch_idle() cleanup and mach/system.h removal
In-Reply-To: <20120113140723.GW1068@n2100.arm.linux.org.uk>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <20120113104358.GR1068@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1201130853250.2722@xanadu.home>
 <20120113140723.GW1068@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1201202217510.19587@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jan 2012, Russell King - ARM Linux wrote:

> On Fri, Jan 13, 2012 at 08:54:58AM -0500, Nicolas Pitre wrote:
> > On Fri, 13 Jan 2012, Russell King - ARM Linux wrote:
> > 
> > > So, sending a pull request for the idle stuff in the last two days of
> > > the merge window, for a change which is quite big, which conflicts,
> > > which wasn't in -next before the merge window is just asking for trouble,
> > > and I'm not going to do it.
> > 
> > Too bad.  Let's try to stage this early in your devel-stable branch for 
> > next cycle then.
> 
> Arnd and myself just agreed this; once rc1 is out, could you please rebase
> on that, resend the pull request, and we'll merge it into both trees.
> 

Here it is.

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:

  git://git.linaro.org/people/nico/linux idle

for you to fetch changes up to a570067df9cc1b1821ca5255bbbe8adb67aca199:

  ARM: big removal of now unused arch_idle() (2012-01-20 19:25:58 -0500)

----------------------------------------------------------------
Nicolas Pitre (23):
      ARM: OMAP1: Fix pm_idle during suspend
      ARM: clean up idle handlers
      ARM: OMAP: convert idle handlers from pm_idle to arm_pm_idle
      ARM: mach-s5pv210: use standard arch_idle()
      ARM: mach-s5pc100: use standard arch_idle()
      ARM: mach-s5p64x0: move idle handler from pm_idle to arm_pm_idle
      ARM: mach-exynos: use standard arch_idle()
      ARM: mach-at91: move special idle code out of line
      ARM: mach-clps711x: move special idle code out of line
      ARM: mach-ebsa110: move special idle code out of line
      ARM: mach-gemini: move special idle code out of line
      ARM: mach-h720x: move special idle code out of line
      ARM: s3c24xx: move special idle code to out of line
      ARM: plat-mxc: hook special idle handlers to arm_pm_idle
      ARM: mach-msm: hook special idle handlers to arm_pm_idle
      ARM: mach-ixp23xx: properly disable CPU idle call
      ARM: mach-ixp4xx: properly disable CPU idle call
      ARM: mach-shark: properly disable CPU idle call
      ARM: mach-w90x900: properly disable CPU idle call
      ARM: mach-s3c64xx: use standard arch_idle() implementation
      ARM: mach-tegra: properly disable CPU idle call
      ARM: substitute arch_idle()
      ARM: big removal of now unused arch_idle()

 arch/arm/include/asm/system.h                  |    1 +
 arch/arm/kernel/process.c                      |   27 +++++++-----
 arch/arm/mach-at91/at91cap9.c                  |    8 ++++
 arch/arm/mach-at91/at91rm9200.c                |   10 ++++
 arch/arm/mach-at91/at91sam9260.c               |    8 ++++
 arch/arm/mach-at91/at91sam9261.c               |    8 ++++
 arch/arm/mach-at91/at91sam9263.c               |    8 ++++
 arch/arm/mach-at91/at91sam9g45.c               |    7 +++
 arch/arm/mach-at91/at91sam9rl.c                |    8 ++++
 arch/arm/mach-at91/at91x40.c                   |   12 +++++
 arch/arm/mach-at91/include/mach/system.h       |   50 ----------------------
 arch/arm/mach-bcmring/include/mach/system.h    |   28 ------------
 arch/arm/mach-clps711x/common.c                |   16 +++++++
 arch/arm/mach-clps711x/include/mach/system.h   |   35 ---------------
 arch/arm/mach-cns3xxx/include/mach/system.h    |   25 -----------
 arch/arm/mach-davinci/include/mach/system.h    |   21 ---------
 arch/arm/mach-dove/include/mach/system.h       |   17 -------
 arch/arm/mach-ebsa110/core.c                   |   25 +++++++++++
 arch/arm/mach-ebsa110/include/mach/system.h    |   37 ----------------
 arch/arm/mach-ep93xx/include/mach/system.h     |    7 ---
 arch/arm/mach-exynos/common.c                  |   12 -----
 arch/arm/mach-exynos/include/mach/system.h     |   20 ---------
 arch/arm/mach-footbridge/include/mach/system.h |   13 ------
 arch/arm/mach-gemini/Makefile                  |    2 +-
 arch/arm/mach-gemini/idle.c                    |   29 +++++++++++++
 arch/arm/mach-gemini/include/mach/system.h     |   14 ------
 arch/arm/mach-gemini/irq.c                     |    4 +-
 arch/arm/mach-h720x/common.c                   |   18 ++++++++
 arch/arm/mach-h720x/include/mach/system.h      |   27 ------------
 arch/arm/mach-highbank/include/mach/system.h   |   24 ----------
 arch/arm/mach-imx/mm-imx3.c                    |   52 +++++++++++------------
 arch/arm/mach-imx/pm-imx27.c                   |    3 +-
 arch/arm/mach-integrator/include/mach/system.h |   33 --------------
 arch/arm/mach-iop13xx/include/mach/system.h    |   13 ------
 arch/arm/mach-iop32x/include/mach/system.h     |   13 ------
 arch/arm/mach-iop33x/include/mach/system.h     |   13 ------
 arch/arm/mach-ixp2000/include/mach/system.h    |   14 ------
 arch/arm/mach-ixp23xx/core.c                   |    3 +
 arch/arm/mach-ixp23xx/include/mach/system.h    |   16 -------
 arch/arm/mach-ixp4xx/common.c                  |    6 +++
 arch/arm/mach-ixp4xx/include/mach/system.h     |   19 --------
 arch/arm/mach-kirkwood/include/mach/system.h   |   17 -------
 arch/arm/mach-ks8695/include/mach/system.h     |   27 ------------
 arch/arm/mach-lpc32xx/include/mach/system.h    |   27 ------------
 arch/arm/mach-mmp/include/mach/system.h        |   16 -------
 arch/arm/mach-msm/idle.S                       |   36 ----------------
 arch/arm/mach-msm/idle.c                       |   49 +++++++++++++++++++++
 arch/arm/mach-msm/include/mach/system.h        |    1 -
 arch/arm/mach-mv78xx0/include/mach/system.h    |   17 -------
 arch/arm/mach-mx5/mm.c                         |   28 +++++-------
 arch/arm/mach-mxs/include/mach/system.h        |   25 -----------
 arch/arm/mach-mxs/pm.c                         |    3 +-
 arch/arm/mach-netx/include/mach/system.h       |   28 ------------
 arch/arm/mach-nomadik/include/mach/system.h    |   32 --------------
 arch/arm/mach-omap1/include/mach/system.h      |    5 --
 arch/arm/mach-omap1/pm.c                       |   19 ++-------
 arch/arm/mach-omap2/include/mach/system.h      |    5 --
 arch/arm/mach-omap2/pm24xx.c                   |    4 +-
 arch/arm/mach-omap2/pm34xx.c                   |    6 +--
 arch/arm/mach-omap2/pm44xx.c                   |    8 +--
 arch/arm/mach-omap2/prm_common.c               |    1 -
 arch/arm/mach-orion5x/include/mach/system.h    |   19 --------
 arch/arm/mach-picoxcell/include/mach/system.h  |   26 -----------
 arch/arm/mach-pnx4008/include/mach/system.h    |   29 -------------
 arch/arm/mach-prima2/include/mach/system.h     |   17 -------
 arch/arm/mach-pxa/include/mach/system.h        |   15 -------
 arch/arm/mach-realview/include/mach/system.h   |   33 --------------
 arch/arm/mach-rpc/include/mach/system.h        |   13 ------
 arch/arm/mach-s3c2410/include/mach/system.h    |   54 ------------------------
 arch/arm/mach-s3c2412/s3c2412.c                |    4 +-
 arch/arm/mach-s3c2416/s3c2416.c                |    3 -
 arch/arm/mach-s3c64xx/include/mach/system.h    |   19 --------
 arch/arm/mach-s5p64x0/common.c                 |   15 +++----
 arch/arm/mach-s5p64x0/include/mach/system.h    |   21 ---------
 arch/arm/mach-s5pc100/common.c                 |   12 -----
 arch/arm/mach-s5pc100/include/mach/system.h    |   19 --------
 arch/arm/mach-s5pv210/common.c                 |   12 -----
 arch/arm/mach-s5pv210/include/mach/system.h    |   21 ---------
 arch/arm/mach-sa1100/include/mach/system.h     |    9 ----
 arch/arm/mach-shark/core.c                     |    6 +++
 arch/arm/mach-shark/include/mach/system.h      |   13 ------
 arch/arm/mach-shmobile/include/mach/system.h   |    5 --
 arch/arm/mach-spear3xx/include/mach/system.h   |   19 --------
 arch/arm/mach-spear6xx/include/mach/system.h   |   19 --------
 arch/arm/mach-tegra/common.c                   |    3 +-
 arch/arm/mach-tegra/include/mach/system.h      |   28 ------------
 arch/arm/mach-u300/include/mach/system.h       |   14 ------
 arch/arm/mach-ux500/include/mach/system.h      |   20 ---------
 arch/arm/mach-versatile/include/mach/system.h  |   33 --------------
 arch/arm/mach-vexpress/include/mach/system.h   |   33 --------------
 arch/arm/mach-vt8500/include/mach/system.h     |    5 --
 arch/arm/mach-w90x900/dev.c                    |    1 +
 arch/arm/mach-w90x900/include/mach/system.h    |   19 --------
 arch/arm/mach-zynq/include/mach/system.h       |   23 ----------
 arch/arm/plat-mxc/include/mach/system.h        |   25 -----------
 arch/arm/plat-omap/include/plat/system.h       |   15 -------
 arch/arm/plat-s3c24xx/cpu.c                    |   27 ++++++++++++
 arch/arm/plat-spear/include/plat/system.h      |   26 -----------
 98 files changed, 326 insertions(+), 1409 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/system.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/system.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/system.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/system.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/system.h
 delete mode 100644 arch/arm/mach-dove/include/mach/system.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/system.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/system.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/system.h
 create mode 100644 arch/arm/mach-gemini/idle.c
 delete mode 100644 arch/arm/mach-h720x/include/mach/system.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/system.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/system.h
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/system.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/system.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/system.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/system.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/system.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/system.h
 delete mode 100644 arch/arm/mach-msm/idle.S
 create mode 100644 arch/arm/mach-msm/idle.c
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/system.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/system.h
 delete mode 100644 arch/arm/mach-netx/include/mach/system.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/system.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/system.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/system.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/system.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/system.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/system.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/system.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/system.h
 delete mode 100644 arch/arm/mach-realview/include/mach/system.h
 delete mode 100644 arch/arm/mach-rpc/include/mach/system.h
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/system.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/system.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/system.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/system.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/system.h
 delete mode 100644 arch/arm/mach-shark/include/mach/system.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/system.h
 delete mode 100644 arch/arm/mach-u300/include/mach/system.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/system.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/system.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/system.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/system.h
 delete mode 100644 arch/arm/mach-zynq/include/mach/system.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/system.h
 delete mode 100644 arch/arm/plat-omap/include/plat/system.h
 delete mode 100644 arch/arm/plat-spear/include/plat/system.h
