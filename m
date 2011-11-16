From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 16 Nov 2011 11:23:48 +0000
Subject: [GIT PULL] ARM irqchip consolidation
Message-ID: <4EC39D44.8000706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

I've collected patches converting GIC and VIC based platforms to use the
MULTI_IRQ_HANDLER configuration option in a single branch (as they depend
on a common patch).

It also include the patch adding non-banked support to the GIC, which is
required to convert EXYNOS to MULTI_IRQ_HANDLER in a sane way (not to
mention fixing obvious bugs).

If you're happy with this, feel free to pull this branch.

Thanks,

	M.

The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:
  Linus Torvalds (1):
        Linux 3.2-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irqchip-consolidation

Jamie Iles (12):
      ARM: vic: device tree binding
      ARM: vic: MULTI_IRQ_HANDLER handler
      ARM: ep93xx: convert to MULTI_IRQ_HANDLER
      ARM: netx: convert to MULTI_IRQ_HANDLER
      ARM: nomadik: convert to MULTI_IRQ_HANDLER
      ARM: s3c64xx: convert to MULTI_IRQ_HANDLER
      ARM: spear: convert to MULTI_IRQ_HANDLER
      ARM: u300: convert to MULTI_IRQ_HANDLER
      ARM: versatile: convert to MULTI_IRQ_HANDLER
      ARM: samsung: convert to MULTI_IRQ_HANDLER
      ARM: picoxcell: convert to MULTI_IRQ_HANDLER
      ARM: VIC: remove non MULTI_IRQ_HANDLER support

Marc Zyngier (19):
      ARM: gic: allow GIC to support non-banked setups
      ARM: Make global handler and CONFIG_MULTI_IRQ_HANDLER mutually exclusive
      ARM: mxc: rename gic_handle_irq to avoid name clash
      ARM: GIC: Add global gic_handle_irq() function
      ARM: imx: convert smp platforms to global gic_handle_irq()
      ARM: highbank: convert to CONFIG_MULTI_IRQ_HANDLER
      ARM: RealView: convert to CONFIG_MULTI_IRQ_HANDLER
      ARM: VExpress: convert to CONFIG_MULTI_IRQ_HANDLER
      ARM: msm: convert SMP platforms to CONFIG_MULTI_IRQ_HANDLER
      ARM: exynos4: convert to CONFIG_MULTI_IRQ_HANDLER
      ARM: tegra2: convert to CONFIG_MULTI_IRQ_HANDLER
      ARM: ux500: convert to CONFIG_MULTI_IRQ_HANDLER
      ARM: shmobile: convert smp platforms to gic_handle_irq()
      ARM: cns3xxx: convert to CONFIG_MULTI_IRQ_HANDLER
      ARM: zynq: convert to CONFIG_MULTI_IRQ_HANDLER
      ARM: omap2/3: Add global omap2/3_intc_handle_irq() functions
      ARM: omap2plus: convert to CONFIG_MULTI_IRQ_HANDLER
      ARM: omap2plus: remove irq-related global base addresses
      ARM: GIC: Make MULTI_IRQ_HANDLER mandatory

 Documentation/devicetree/bindings/arm/gic.txt      |    4 +
 Documentation/devicetree/bindings/arm/vic.txt      |   29 ++++
 arch/arm/common/Kconfig                            |    6 +
 arch/arm/common/gic.c                              |  164 +++++++++++++++++---
 arch/arm/common/vic.c                              |  143 ++++++++++++++----
 arch/arm/include/asm/entry-macro-vic2.S            |   57 -------
 arch/arm/include/asm/hardware/entry-macro-gic.S    |   60 -------
 arch/arm/include/asm/hardware/gic.h                |   26 +--
 arch/arm/include/asm/hardware/vic.h                |   10 +-
 arch/arm/kernel/entry-armv.S                       |    7 +-
 arch/arm/mach-cns3xxx/cns3420vb.c                  |    2 +
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S   |    2 -
 arch/arm/mach-ep93xx/adssphere.c                   |    2 +
 arch/arm/mach-ep93xx/edb93xx.c                     |    9 +
 arch/arm/mach-ep93xx/gesbc9312.c                   |    2 +
 arch/arm/mach-ep93xx/include/mach/entry-macro.S    |   42 -----
 arch/arm/mach-ep93xx/micro9.c                      |    5 +
 arch/arm/mach-ep93xx/simone.c                      |    2 +
 arch/arm/mach-ep93xx/snappercl15.c                 |    2 +
 arch/arm/mach-ep93xx/ts72xx.c                      |    2 +
 arch/arm/mach-exynos/cpu.c                         |   20 +--
 arch/arm/mach-exynos/include/mach/entry-macro.S    |   75 ---------
 arch/arm/mach-exynos/mach-armlex4210.c             |    2 +
 arch/arm/mach-exynos/mach-nuri.c                   |    2 +
 arch/arm/mach-exynos/mach-origen.c                 |    2 +
 arch/arm/mach-exynos/mach-smdk4x12.c               |    3 +
 arch/arm/mach-exynos/mach-smdkv310.c               |    3 +
 arch/arm/mach-exynos/mach-universal_c210.c         |    4 +-
 arch/arm/mach-exynos/platsmp.c                     |   28 +----
 arch/arm/mach-highbank/highbank.c                  |    1 +
 arch/arm/mach-highbank/include/mach/entry-macro.S  |    2 -
 arch/arm/mach-msm/board-msm8960.c                  |    2 +
 arch/arm/mach-msm/board-msm8x60.c                  |    4 +
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S  |   17 --
 arch/arm/mach-msm/include/mach/entry-macro-vic.S   |   37 -----
 arch/arm/mach-msm/include/mach/entry-macro.S       |   27 +++-
 arch/arm/mach-netx/include/mach/entry-macro.S      |   13 --
 arch/arm/mach-netx/nxdb500.c                       |    2 +
 arch/arm/mach-netx/nxdkn.c                         |    2 +
 arch/arm/mach-netx/nxeb500hmi.c                    |    2 +
 arch/arm/mach-nomadik/board-nhk8815.c              |    2 +
 arch/arm/mach-nomadik/include/mach/entry-macro.S   |   30 ----
 arch/arm/mach-omap2/Kconfig                        |    2 +
 arch/arm/mach-omap2/board-2430sdp.c                |    1 +
 arch/arm/mach-omap2/board-3430sdp.c                |    1 +
 arch/arm/mach-omap2/board-3630sdp.c                |    1 +
 arch/arm/mach-omap2/board-4430sdp.c                |    2 +
 arch/arm/mach-omap2/board-am3517crane.c            |    1 +
 arch/arm/mach-omap2/board-am3517evm.c              |    1 +
 arch/arm/mach-omap2/board-apollon.c                |    1 +
 arch/arm/mach-omap2/board-cm-t35.c                 |    2 +
 arch/arm/mach-omap2/board-cm-t3517.c               |    1 +
 arch/arm/mach-omap2/board-devkit8000.c             |    1 +
 arch/arm/mach-omap2/board-generic.c                |    1 +
 arch/arm/mach-omap2/board-h4.c                     |    1 +
 arch/arm/mach-omap2/board-igep0020.c               |    2 +
 arch/arm/mach-omap2/board-ldp.c                    |    1 +
 arch/arm/mach-omap2/board-n8x0.c                   |    3 +
 arch/arm/mach-omap2/board-omap3beagle.c            |    1 +
 arch/arm/mach-omap2/board-omap3evm.c               |    1 +
 arch/arm/mach-omap2/board-omap3logic.c             |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c           |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c           |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c         |    1 +
 arch/arm/mach-omap2/board-omap4panda.c             |    2 +
 arch/arm/mach-omap2/board-overo.c                  |    1 +
 arch/arm/mach-omap2/board-rm680.c                  |    1 +
 arch/arm/mach-omap2/board-rx51.c                   |    1 +
 arch/arm/mach-omap2/board-zoom.c                   |    2 +
 arch/arm/mach-omap2/include/mach/entry-macro.S     |  137 ----------------
 arch/arm/mach-omap2/include/mach/omap4-common.h    |    2 -
 arch/arm/mach-omap2/io.c                           |    3 -
 arch/arm/mach-omap2/irq.c                          |   51 ++++++
 arch/arm/mach-omap2/omap4-common.c                 |    6 +-
 arch/arm/mach-picoxcell/common.c                   |    9 +-
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   11 +-
 arch/arm/mach-pxa/include/mach/entry-macro.S       |   36 -----
 arch/arm/mach-realview/include/mach/entry-macro.S  |    2 -
 arch/arm/mach-realview/realview_eb.c               |    1 +
 arch/arm/mach-realview/realview_pb1176.c           |    1 +
 arch/arm/mach-realview/realview_pb11mp.c           |    1 +
 arch/arm/mach-realview/realview_pba8.c             |    1 +
 arch/arm/mach-realview/realview_pbx.c              |    1 +
 arch/arm/mach-s3c64xx/include/mach/entry-macro.S   |    7 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +
 arch/arm/mach-s3c64xx/mach-real6410.c              |    2 +
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    2 +
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    2 +
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +
 arch/arm/mach-s5p64x0/include/mach/entry-macro.S   |    7 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    2 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    2 +
 arch/arm/mach-s5pc100/include/mach/entry-macro.S   |   25 ---
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    2 +
 arch/arm/mach-s5pv210/include/mach/entry-macro.S   |   37 -----
 arch/arm/mach-s5pv210/mach-aquila.c                |    2 +
 arch/arm/mach-s5pv210/mach-goni.c                  |    2 +
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    2 +
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 +
 arch/arm/mach-s5pv210/mach-torbreck.c              |    2 +
 arch/arm/mach-shmobile/Makefile                    |    1 -
 arch/arm/mach-shmobile/board-ag5evm.c              |    2 +-
 arch/arm/mach-shmobile/board-kota2.c               |    2 +-
 arch/arm/mach-shmobile/entry-gic.S                 |   18 --
 arch/arm/mach-shmobile/include/mach/common.h       |    1 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S  |    9 -
 arch/arm/mach-spear3xx/include/mach/entry-macro.S  |   27 ----
 arch/arm/mach-spear3xx/spear300_evb.c              |    2 +
 arch/arm/mach-spear3xx/spear310_evb.c              |    2 +
 arch/arm/mach-spear3xx/spear320_evb.c              |    2 +
 arch/arm/mach-spear6xx/include/mach/entry-macro.S  |   36 -----
 arch/arm/mach-spear6xx/spear600_evb.c              |    2 +
 arch/arm/mach-tegra/board-dt.c                     |    2 +
 arch/arm/mach-tegra/board-harmony.c                |    2 +
 arch/arm/mach-tegra/board-paz00.c                  |    2 +
 arch/arm/mach-tegra/board-seaboard.c               |    4 +
 arch/arm/mach-tegra/board-trimslice.c              |    2 +
 arch/arm/mach-tegra/include/mach/entry-macro.S     |   22 +---
 arch/arm/mach-u300/include/mach/entry-macro.S      |   24 ---
 arch/arm/mach-u300/u300.c                          |    2 +
 arch/arm/mach-ux500/board-mop500.c                 |    4 +
 arch/arm/mach-ux500/board-u5500.c                  |    2 +
 arch/arm/mach-ux500/include/mach/entry-macro.S     |    2 -
 arch/arm/mach-versatile/include/mach/entry-macro.S |   30 ----
 arch/arm/mach-versatile/versatile_ab.c             |    2 +
 arch/arm/mach-versatile/versatile_dt.c             |    2 +
 arch/arm/mach-versatile/versatile_pb.c             |    2 +
 arch/arm/mach-vexpress/include/mach/entry-macro.S  |    2 -
 arch/arm/mach-vexpress/v2m.c                       |    2 +
 arch/arm/mach-zynq/common.c                        |    1 +
 arch/arm/mach-zynq/include/mach/entry-macro.S      |    3 -
 arch/arm/plat-mxc/Makefile                         |    1 -
 arch/arm/plat-mxc/gic.c                            |   41 -----
 arch/arm/plat-mxc/include/mach/common.h            |    1 -
 arch/arm/plat-mxc/include/mach/entry-macro.S       |   11 --
 arch/arm/plat-omap/include/plat/irqs.h             |    3 +-
 arch/arm/plat-s5p/Kconfig                          |    1 +
 142 files changed, 590 insertions(+), 950 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vic.txt
 delete mode 100644 arch/arm/include/asm/entry-macro-vic2.S
 delete mode 100644 arch/arm/include/asm/hardware/entry-macro-gic.S
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro-qgic.S
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro-vic.S
 delete mode 100644 arch/arm/mach-shmobile/entry-gic.S
 delete mode 100644 arch/arm/plat-mxc/gic.c
-- 
Jazz is not dead. It just smells funny...
