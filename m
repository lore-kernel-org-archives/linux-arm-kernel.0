From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2011 17:51:18 +0100
Subject: [RFC PATCH 00/14] Switch GIC users (and omap2plus) to
	CONFIG_MULTI_IRQ_HANDLER
Message-ID: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support multiple primary interrupt controllers in the same
image, it is necessary to use the MULTI_IRQ_HANDLER config option.

This patch series makes a first step in that direction by:
- having the GIC code to provides a global handler,
- make GIC users to provide this handler from their machine descriptor.

A side effect of this is that it forces OMAP2/3 platforms to be
converted too in order to preserve the MULTI_OMAP feature. This leads
to a certain simplification of the interrupt handling for the
OMAP2/3/4 platforms.

The primary IRQ handlers have been written in C, and the performance
degradation is hardly noticeable. Should some tests reveal a major
increase in latency, it is always possible to restore the ASM version.

This series has been tested on VE (A9, A5, A15), PB11MP, Panda, IGEPv2
and Harmony. Patches against next-2011 plus my PPI series.

Marc Zyngier (14):
  ARM: GIC: Add global gic_handle_irq() function
  ARM: RealView: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: VExpress: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: msm: convert SMP platforms to CONFIG_MULTI_IRQ_HANDLER
  ARM: GIC: Add global gic_handle_irq_offset() function
  ARM: exynos4: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: tegra2: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: ux500: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: shmobile: convert smp platforms to gic_handle_irq()
  ARM: cns3xxx: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: zynq: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: omap2/3: Add global omap2/3_intc_handle_irq() functions
  ARM: omap2plus: convert to CONFIG_MULTI_IRQ_HANDLER
  ARM: GIC: Make MULTI_IRQ_HANDLER mandatory

 arch/arm/Kconfig                                  |    2 +
 arch/arm/common/Kconfig                           |    1 +
 arch/arm/common/gic.c                             |   49 +++++++-
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   60 ---------
 arch/arm/include/asm/hardware/gic.h               |    3 +-
 arch/arm/mach-cns3xxx/cns3420vb.c                 |    2 +
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S  |    2 -
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |   62 ---------
 arch/arm/mach-exynos4/mach-armlex4210.c           |    2 +
 arch/arm/mach-exynos4/mach-nuri.c                 |    2 +
 arch/arm/mach-exynos4/mach-origen.c               |    2 +
 arch/arm/mach-exynos4/mach-smdk4212.c             |    2 +
 arch/arm/mach-exynos4/mach-smdkv310.c             |    2 +
 arch/arm/mach-exynos4/mach-universal_c210.c       |    2 +
 arch/arm/mach-msm/board-msm8960.c                 |    2 +
 arch/arm/mach-msm/board-msm8x60.c                 |    4 +
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   17 ---
 arch/arm/mach-msm/include/mach/entry-macro-vic.S  |   37 ------
 arch/arm/mach-msm/include/mach/entry-macro.S      |   27 ++++-
 arch/arm/mach-omap2/Kconfig                       |    2 +
 arch/arm/mach-omap2/board-2430sdp.c               |    1 +
 arch/arm/mach-omap2/board-3430sdp.c               |    1 +
 arch/arm/mach-omap2/board-3630sdp.c               |    1 +
 arch/arm/mach-omap2/board-4430sdp.c               |    2 +
 arch/arm/mach-omap2/board-am3517crane.c           |    1 +
 arch/arm/mach-omap2/board-am3517evm.c             |    1 +
 arch/arm/mach-omap2/board-apollon.c               |    1 +
 arch/arm/mach-omap2/board-cm-t35.c                |    2 +
 arch/arm/mach-omap2/board-cm-t3517.c              |    1 +
 arch/arm/mach-omap2/board-devkit8000.c            |    1 +
 arch/arm/mach-omap2/board-generic.c               |    1 +
 arch/arm/mach-omap2/board-h4.c                    |    1 +
 arch/arm/mach-omap2/board-igep0020.c              |    2 +
 arch/arm/mach-omap2/board-ldp.c                   |    1 +
 arch/arm/mach-omap2/board-n8x0.c                  |    3 +
 arch/arm/mach-omap2/board-omap3beagle.c           |    1 +
 arch/arm/mach-omap2/board-omap3evm.c              |    1 +
 arch/arm/mach-omap2/board-omap3logic.c            |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c          |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c          |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c        |    1 +
 arch/arm/mach-omap2/board-omap4panda.c            |    2 +
 arch/arm/mach-omap2/board-overo.c                 |    1 +
 arch/arm/mach-omap2/board-rm680.c                 |    1 +
 arch/arm/mach-omap2/board-rx51.c                  |    1 +
 arch/arm/mach-omap2/board-zoom.c                  |    2 +
 arch/arm/mach-omap2/include/mach/entry-macro.S    |  137 ---------------------
 arch/arm/mach-omap2/irq.c                         |   49 ++++++++
 arch/arm/mach-realview/include/mach/entry-macro.S |    2 -
 arch/arm/mach-realview/realview_eb.c              |    1 +
 arch/arm/mach-realview/realview_pb1176.c          |    1 +
 arch/arm/mach-realview/realview_pb11mp.c          |    1 +
 arch/arm/mach-realview/realview_pba8.c            |    1 +
 arch/arm/mach-realview/realview_pbx.c             |    1 +
 arch/arm/mach-shmobile/Makefile                   |    1 -
 arch/arm/mach-shmobile/board-ag5evm.c             |    2 +-
 arch/arm/mach-shmobile/entry-gic.S                |   18 ---
 arch/arm/mach-shmobile/include/mach/common.h      |    1 -
 arch/arm/mach-tegra/board-dt.c                    |    2 +
 arch/arm/mach-tegra/board-harmony.c               |    2 +
 arch/arm/mach-tegra/board-paz00.c                 |    2 +
 arch/arm/mach-tegra/board-seaboard.c              |    4 +
 arch/arm/mach-tegra/board-trimslice.c             |    2 +
 arch/arm/mach-tegra/include/mach/entry-macro.S    |   22 +---
 arch/arm/mach-ux500/board-mop500.c                |    4 +
 arch/arm/mach-ux500/board-u5500.c                 |    2 +
 arch/arm/mach-ux500/include/mach/entry-macro.S    |    2 -
 arch/arm/mach-vexpress/include/mach/entry-macro.S |    2 -
 arch/arm/mach-vexpress/v2m.c                      |    2 +
 arch/arm/mach-zynq/common.c                       |    1 +
 arch/arm/mach-zynq/include/mach/entry-macro.S     |    3 -
 arch/arm/plat-omap/include/plat/irqs.h            |    2 +
 72 files changed, 212 insertions(+), 371 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/entry-macro-gic.S
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro-qgic.S
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro-vic.S
 delete mode 100644 arch/arm/mach-shmobile/entry-gic.S
