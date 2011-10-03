From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  3 Oct 2011 10:56:58 +0800
Subject: [PATCH v5 0/8] add initial imx6q support
Message-ID: <1317610626-24357-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the initial support for imx6q, which is a
Cortex-A9 Quad Core based SoC.

It's based on v3.1-rc8 with the following branches merged.

* rmk's for-next branch with the following additional patches wait for
  rmk to apply:
  - ARM: l2x0: add empty l2x0_of_init (Rob Herring)
  - ARM: cache-l2x0: add resume entry for l2 in secure mode (Barry Song)
  - ARM: localtimer: add header linux/errno.h explicitly (Shawn Guo)
  - ARM: smp: Add an IPI handler callable from C code (Marc Zyngier)
  - ARM: smp: Add a localtimer handler callable from C code (Shawn Guo)

* Rob Herring's "GIC OF bindings" series, currently on

    git://git.jdl.com/software/linux-3.0.git gic-v2

  tglx has picked up the two that are irq core related.  And I'm not
  sure about the branch that Rob will push others to.

* Branches that will be merged into arm-soc
  - Sascha's imx-cleanup
  - Sascha's imx-features
  - [GIT PULL] DEBUG_LL platform updates for 3.2 (Will Deacon)

Regards,
Shawn

Changes since v4:
 * Address Russell's comments, do not call do_IPI() and do_local_timer()
   from C code.
 * Change to 'select AUTO_ZRELADDR if !ZBOOT_ROM'
 * Rebase to Barry's L2 suspend infrastructure
 * Fold Sascha's merge-imx3-imx6 patch to get single zImage support for
   imx3 and imx6 family

Changes since v3:
 * Fold the gic_handle_irq (local to imx) support patch in the series.
   It can be replaced by Marc Zyngier's global gic_handle_irq support
   with a little rework if his PPI and MULTI_IRQ_HANDLER series gets
   merged.

Changes since v2:
 * Refine the L2 register save/restore implementation per Lorenzo's
   suggestion
 * Rebase to Rob's latest GIC OF bindings series
 * Rebase to Sascha's MULTI_IRQ_HANDLER support series

Changes since v1:
 * Use the existing IMX_IO_P2V for static mapping
 * Fix the MXC_INTERNAL_IRQS breakage introduced by GIC definition
 * Retrieve clock frequency for fixed clocks from device tree
 * Drop early_initcall from imx_src_init() and call it from imx6q
   platform initialization
 * Use readl_relaxed/writel_relaxed rather than __raw_readl/__raw_writel
   as suggested by Arnd
 * Kill unnecessary imx_local_timer_pre_suspend/resume functions
 * Kill Kconfig symbol MACH_IMX6Q
 * Rebase to rmk's "Add L2 cache cleaning to generic CPU suspend" series
   so that we can retain L2 cache with necessary L2 register
   save/restore across suspend/resume cycle
 * Rebase to Rob's new "GIC OF bindings" series

Sascha Hauer (1):
      arm/imx: merge i.MX3 and i.MX6

Shawn Guo (7):
      arm/imx6q: add device tree source
      arm/imx6q: add core definitions and low-level debug uart
      arm/imx: add gic_handle_irq function
      arm/imx6q: add core drivers clock, gpc, mmdc and src
      arm/imx6q: add smp and cpu hotplug support
      arm/imx6q: add device tree machine support
      arm/imx6q: add suspend/resume support

 Documentation/devicetree/bindings/arm/fsl.txt |    6 +
 arch/arm/Kconfig                              |    2 +-
 arch/arm/Kconfig.debug                        |    7 +
 arch/arm/Makefile                             |    2 +-
 arch/arm/boot/dts/imx6q-sabreauto.dts         |   82 +
 arch/arm/boot/dts/imx6q.dtsi                  |  555 +++++++
 arch/arm/mach-imx/Kconfig                     |   29 +-
 arch/arm/mach-imx/Makefile                    |   11 +
 arch/arm/mach-imx/Makefile.boot               |   14 +-
 arch/arm/mach-imx/clock-imx6q.c               | 2012 +++++++++++++++++++++++++
 arch/arm/mach-imx/gpc.c                       |  113 ++
 arch/arm/mach-imx/head-v7.S                   |   99 ++
 arch/arm/mach-imx/hotplug.c                   |   44 +
 arch/arm/mach-imx/lluart.c                    |   32 +
 arch/arm/mach-imx/localtimer.c                |   35 +
 arch/arm/mach-imx/mach-imx6q.c                |   84 +
 arch/arm/mach-imx/mmdc.c                      |   72 +
 arch/arm/mach-imx/platsmp.c                   |   85 ++
 arch/arm/mach-imx/pm-imx6q.c                  |   70 +
 arch/arm/mach-imx/src.c                       |   49 +
 arch/arm/mm/Kconfig                           |    2 +-
 arch/arm/plat-mxc/Kconfig                     |   11 +-
 arch/arm/plat-mxc/Makefile                    |    2 +-
 arch/arm/plat-mxc/gic.c                       |   47 +
 arch/arm/plat-mxc/include/mach/common.h       |   29 +
 arch/arm/plat-mxc/include/mach/debug-macro.S  |    2 +
 arch/arm/plat-mxc/include/mach/entry-macro.S  |    6 +
 arch/arm/plat-mxc/include/mach/hardware.h     |    6 +
 arch/arm/plat-mxc/include/mach/irqs.h         |   10 +-
 arch/arm/plat-mxc/include/mach/mx6q.h         |   33 +
 30 files changed, 3537 insertions(+), 14 deletions(-)
