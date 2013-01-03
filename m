From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:09 -0600
Subject: [PATCH v4 00/19] Move GIC and VIC to drivers/irqchip
Message-ID: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This is series adds irqchip initialization infrastructure from Thomas Petazzoni
and converts GIC and VIC over to use the new infrastructure moving both to
drivers/irqchip. All platforms doing GIC and VIC initialization via DT are
converted over to use the new infrastructure.

This series is available here:
git://sources.calxeda.com/kernel/linux.git irqchip-v4

Changes in v4:
- Rebase to v3.8-rc1
- Use arch_send_wakeup_ipi_mask added in 3.8
- Re-add move and conversion of GIC and VIC to drivers/irqchip
- More clean-ups of unneeded vic.h includes
- Move vic.h and gic.h to include/linux/irqchip/
- Convert spear shirq irqchip to new init infrastructure

Changes in v3:
- Add ux500 fix from Srinidhi
- Only including clean-ups for 3.8
- Keep gic register definitions in header. Will be needed for KVM
- use set_handle_irq from Thomas
- Remove all occurrences gic_handle_irq from platforms
- Add clean-up vic.h

Rob

Rob Herring (16):
  ARM: GIC: remove assembly ifdefs from gic.h
  ARM: GIC: remove direct use of gic_raise_softirq
  ARM: GIC: set handle_arch_irq in GIC initialization
  ARM: remove mach .handle_irq for GIC users
  irqchip: Move ARM GIC to drivers/irqchip
  ARM: use common irqchip_init for GIC init
  irqchip: Move ARM gic.h to include/linux/irqchip/arm-gic.h
  ARM: VIC: shrink down vic.h
  ARM: VIC: set handle_arch_irq in VIC initialization
  ARM: remove mach .handle_irq for VIC users
  ARM: remove unneeded vic.h includes
  ARM: samsung: remove unused tick.h
  irqchip: Move ARM VIC to drivers/irqchip
  ARM: spear: use common irqchip_init function
  ARM: picoxcell: use common irqchip_init function
  irqchip: Move ARM vic.h to include/linux/irqchip/arm-vic.h

Srinidhi Kasagar (1):
  ARM: mach-ux500: use SGI0 to wake up the other core

Thomas Petazzoni (2):
  irqchip: add basic infrastructure
  arm: add set_handle_irq() to register the parent IRQ controller
    handler function

 arch/arm/common/Kconfig                            |   23 --------
 arch/arm/common/Makefile                           |    2 -
 arch/arm/include/asm/mach/irq.h                    |    1 +
 arch/arm/kernel/irq.c                              |   10 ++++
 arch/arm/kernel/smp.c                              |    3 +-
 arch/arm/kernel/smp_twd.c                          |    1 -
 arch/arm/mach-bcm/board_bcm.c                      |   17 +-----
 arch/arm/mach-cns3xxx/cns3420vb.c                  |    2 -
 arch/arm/mach-cns3xxx/core.c                       |    2 +-
 arch/arm/mach-ep93xx/adssphere.c                   |    2 -
 arch/arm/mach-ep93xx/core.c                        |    3 +-
 arch/arm/mach-ep93xx/edb93xx.c                     |    9 ---
 arch/arm/mach-ep93xx/gesbc9312.c                   |    2 -
 arch/arm/mach-ep93xx/micro9.c                      |    5 --
 arch/arm/mach-ep93xx/simone.c                      |    2 -
 arch/arm/mach-ep93xx/snappercl15.c                 |    2 -
 arch/arm/mach-ep93xx/ts72xx.c                      |    2 -
 arch/arm/mach-ep93xx/vision_ep9307.c               |    2 -
 arch/arm/mach-exynos/common.c                      |   10 ++--
 arch/arm/mach-exynos/include/mach/regs-irq.h       |    2 +-
 arch/arm/mach-exynos/mach-armlex4210.c             |    2 -
 arch/arm/mach-exynos/mach-exynos4-dt.c             |    2 -
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 -
 arch/arm/mach-exynos/mach-nuri.c                   |    2 -
 arch/arm/mach-exynos/mach-origen.c                 |    2 -
 arch/arm/mach-exynos/mach-smdk4x12.c               |    3 -
 arch/arm/mach-exynos/mach-smdkv310.c               |    3 -
 arch/arm/mach-exynos/mach-universal_c210.c         |    2 -
 arch/arm/mach-exynos/mct.c                         |    1 -
 arch/arm/mach-exynos/platsmp.c                     |    6 +-
 arch/arm/mach-highbank/highbank.c                  |   11 +---
 arch/arm/mach-highbank/platsmp.c                   |    6 +-
 arch/arm/mach-imx/common.h                         |    1 -
 arch/arm/mach-imx/gpc.c                            |    2 +-
 arch/arm/mach-imx/mach-imx6q.c                     |   10 +---
 arch/arm/mach-imx/platsmp.c                        |    4 +-
 arch/arm/mach-msm/board-dt-8660.c                  |   16 +-----
 arch/arm/mach-msm/board-dt-8960.c                  |   16 +-----
 arch/arm/mach-msm/platsmp.c                        |    6 +-
 arch/arm/mach-msm/timer.c                          |    1 -
 arch/arm/mach-netx/generic.c                       |    2 +-
 arch/arm/mach-netx/nxdb500.c                       |    2 -
 arch/arm/mach-netx/nxdkn.c                         |    2 -
 arch/arm/mach-netx/nxeb500hmi.c                    |    2 -
 arch/arm/mach-nomadik/board-nhk8815.c              |    2 -
 arch/arm/mach-nomadik/cpu-8815.c                   |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c                |    3 +-
 arch/arm/mach-omap2/board-generic.c                |    3 -
 arch/arm/mach-omap2/board-omap4panda.c             |    3 +-
 arch/arm/mach-omap2/omap-smp.c                     |    6 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |    3 +-
 arch/arm/mach-omap2/omap4-common.c                 |   11 +---
 arch/arm/mach-picoxcell/common.c                   |   15 +----
 arch/arm/mach-realview/core.c                      |    1 -
 arch/arm/mach-realview/platsmp.c                   |    3 -
 arch/arm/mach-realview/realview_eb.c               |    3 +-
 arch/arm/mach-realview/realview_pb1176.c           |    3 +-
 arch/arm/mach-realview/realview_pb11mp.c           |    3 +-
 arch/arm/mach-realview/realview_pba8.c             |    3 +-
 arch/arm/mach-realview/realview_pbx.c              |    3 +-
 arch/arm/mach-s3c64xx/common.c                     |    2 +-
 arch/arm/mach-s3c64xx/include/mach/regs-irq.h      |    1 -
 arch/arm/mach-s3c64xx/include/mach/tick.h          |    2 +
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 -
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 -
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 -
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 -
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 -
 arch/arm/mach-s3c64xx/mach-real6410.c              |    2 -
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    2 -
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    2 -
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 -
 arch/arm/mach-s5p64x0/include/mach/regs-irq.h      |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    2 -
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    2 -
 arch/arm/mach-s5pc100/include/mach/regs-irq.h      |    1 -
 arch/arm/mach-s5pc100/include/mach/tick.h          |    2 +
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    2 -
 arch/arm/mach-s5pv210/include/mach/regs-irq.h      |    1 -
 arch/arm/mach-s5pv210/include/mach/tick.h          |   26 ---------
 arch/arm/mach-s5pv210/mach-aquila.c                |    2 -
 arch/arm/mach-s5pv210/mach-goni.c                  |    2 -
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    2 -
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 -
 arch/arm/mach-s5pv210/mach-torbreck.c              |    2 -
 arch/arm/mach-shmobile/board-ag5evm.c              |    3 +-
 arch/arm/mach-shmobile/board-kota2.c               |    3 +-
 arch/arm/mach-shmobile/board-kzm9d.c               |    2 -
 arch/arm/mach-shmobile/board-kzm9g.c               |    3 +-
 arch/arm/mach-shmobile/board-marzen.c              |    2 -
 arch/arm/mach-shmobile/intc-r8a7779.c              |    2 +-
 arch/arm/mach-shmobile/intc-sh73a0.c               |    2 +-
 arch/arm/mach-shmobile/platsmp.c                   |    3 -
 arch/arm/mach-shmobile/setup-emev2.c               |   17 +-----
 arch/arm/mach-shmobile/smp-emev2.c                 |    4 +-
 arch/arm/mach-shmobile/smp-r8a7779.c               |    2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c                |    2 +-
 arch/arm/mach-socfpga/platsmp.c                    |    4 +-
 arch/arm/mach-socfpga/socfpga.c                    |   14 ++---
 arch/arm/mach-spear13xx/include/mach/generic.h     |    1 -
 arch/arm/mach-spear13xx/platsmp.c                  |    4 +-
 arch/arm/mach-spear13xx/spear1310.c                |    5 +-
 arch/arm/mach-spear13xx/spear1340.c                |    5 +-
 arch/arm/mach-spear13xx/spear13xx.c                |   13 +----
 arch/arm/mach-spear3xx/include/mach/generic.h      |    1 -
 arch/arm/mach-spear3xx/spear300.c                  |    5 +-
 arch/arm/mach-spear3xx/spear310.c                  |    5 +-
 arch/arm/mach-spear3xx/spear320.c                  |    5 +-
 arch/arm/mach-spear3xx/spear3xx.c                  |   16 ------
 arch/arm/mach-spear6xx/spear6xx.c                  |   16 +-----
 arch/arm/mach-sunxi/sunxi.c                        |    1 -
 arch/arm/mach-tegra/board-dt-tegra20.c             |    3 -
 arch/arm/mach-tegra/board-dt-tegra30.c             |    2 -
 arch/arm/mach-tegra/common.c                       |   10 +---
 arch/arm/mach-tegra/irq.c                          |    3 +-
 arch/arm/mach-tegra/platsmp.c                      |    4 +-
 arch/arm/mach-u300/core.c                          |    3 +-
 arch/arm/mach-ux500/board-mop500.c                 |    5 --
 arch/arm/mach-ux500/cpu-db8500.c                   |    2 -
 arch/arm/mach-ux500/cpu.c                          |   10 +---
 arch/arm/mach-ux500/platsmp.c                      |    6 +-
 arch/arm/mach-versatile/core.c                     |    2 +-
 arch/arm/mach-versatile/versatile_ab.c             |    2 -
 arch/arm/mach-versatile/versatile_dt.c             |    2 -
 arch/arm/mach-versatile/versatile_pb.c             |    2 -
 arch/arm/mach-vexpress/ct-ca9x4.c                  |    4 +-
 arch/arm/mach-vexpress/platsmp.c                   |    3 -
 arch/arm/mach-vexpress/v2m.c                       |   16 +-----
 arch/arm/mach-zynq/common.c                        |   17 +-----
 arch/arm/plat-samsung/s5p-irq-eint.c               |    3 +-
 arch/arm/plat-samsung/s5p-irq.c                    |    3 +-
 arch/arm/plat-versatile/platsmp.c                  |    4 +-
 drivers/irqchip/Kconfig                            |   27 +++++++++
 drivers/irqchip/Makefile                           |    6 +-
 arch/arm/common/gic.c => drivers/irqchip/irq-gic.c |   59 ++++++++++++--------
 arch/arm/common/vic.c => drivers/irqchip/irq-vic.c |   29 +++++++++-
 drivers/irqchip/irqchip.c                          |   30 ++++++++++
 drivers/irqchip/irqchip.h                          |   29 ++++++++++
 drivers/irqchip/spear-shirq.c                      |    3 +
 drivers/mfd/db8500-prcmu.c                         |    2 +-
 include/asm-generic/vmlinux.lds.h                  |   12 +++-
 include/linux/irqchip.h                            |   16 ++++++
 .../gic.h => include/linux/irqchip/arm-gic.h       |   15 +----
 .../vic.h => include/linux/irqchip/arm-vic.h       |   25 +--------
 145 files changed, 302 insertions(+), 544 deletions(-)
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/tick.h
 rename arch/arm/common/gic.c => drivers/irqchip/irq-gic.c (97%)
 rename arch/arm/common/vic.c => drivers/irqchip/irq-vic.c (92%)
 create mode 100644 drivers/irqchip/irqchip.c
 create mode 100644 drivers/irqchip/irqchip.h
 create mode 100644 include/linux/irqchip.h
 rename arch/arm/include/asm/hardware/gic.h => include/linux/irqchip/arm-gic.h (77%)
 rename arch/arm/include/asm/hardware/vic.h => include/linux/irqchip/arm-vic.h (63%)

-- 
1.7.10.4
