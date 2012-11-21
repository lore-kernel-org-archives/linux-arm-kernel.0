From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Nov 2012 20:58:24 -0600
Subject: [PATCH v3 0/9] GIC and VIC clean-ups
Message-ID: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series is in preparation to move gic and vic to drivers/irqchip.
I dropped the actual move to drivers/irqchip as the infrastructure is
still being flushed out and I'd like to get the clean-ups at least into
3.8.

This series is available here:
git://sources.calxeda.com/kernel/linux.git irqchip-cleanup

Changes in v3:
- Add ux500 fix from Srinidhi
- Only including clean-ups for 3.8
- Keep gic register definitions in header. Will be needed for KVM
- use set_handle_irq from Thomas
- Remove all occurrences gic_handle_irq from platforms
- Add clean-up vic.h

Rob

Rob Herring (7):
  ARM: GIC: remove assembly ifdefs from gic.h
  ARM: GIC: remove direct use of gic_raise_softirq
  ARM: GIC: set handle_arch_irq in GIC initialization
  ARM: remove mach .handle_irq for GIC users
  ARM: VIC: shrink down vic.h
  ARM: VIC: set handle_arch_irq in VIC initialization
  ARM: remove mach .handle_irq for VIC users

Srinidhi Kasagar (1):
  ARM: mach-ux500: use SGI0 to wake up the other core

Thomas Petazzoni (1):
  arm: add set_handle_irq() to register the parent IRQ controller
    handler function

 arch/arm/common/gic.c                      |   50 ++++++++++++++++------------
 arch/arm/common/vic.c                      |   22 +++++++++++-
 arch/arm/include/asm/hardware/gic.h        |    8 -----
 arch/arm/include/asm/hardware/vic.h        |   24 ++-----------
 arch/arm/include/asm/mach/irq.h            |    1 +
 arch/arm/include/asm/smp.h                 |    1 +
 arch/arm/kernel/irq.c                      |   10 ++++++
 arch/arm/kernel/smp.c                      |    8 ++++-
 arch/arm/kernel/smp_twd.c                  |    1 -
 arch/arm/mach-cns3xxx/cns3420vb.c          |    2 --
 arch/arm/mach-ep93xx/adssphere.c           |    1 -
 arch/arm/mach-ep93xx/edb93xx.c             |    8 -----
 arch/arm/mach-ep93xx/gesbc9312.c           |    1 -
 arch/arm/mach-ep93xx/micro9.c              |    4 ---
 arch/arm/mach-ep93xx/simone.c              |    1 -
 arch/arm/mach-ep93xx/snappercl15.c         |    1 -
 arch/arm/mach-ep93xx/ts72xx.c              |    1 -
 arch/arm/mach-ep93xx/vision_ep9307.c       |    1 -
 arch/arm/mach-exynos/mach-armlex4210.c     |    2 --
 arch/arm/mach-exynos/mach-exynos4-dt.c     |    2 --
 arch/arm/mach-exynos/mach-exynos5-dt.c     |    2 --
 arch/arm/mach-exynos/mach-nuri.c           |    2 --
 arch/arm/mach-exynos/mach-origen.c         |    2 --
 arch/arm/mach-exynos/mach-smdk4x12.c       |    3 --
 arch/arm/mach-exynos/mach-smdkv310.c       |    3 --
 arch/arm/mach-exynos/mach-universal_c210.c |    2 --
 arch/arm/mach-exynos/mct.c                 |    1 -
 arch/arm/mach-exynos/platsmp.c             |    4 +--
 arch/arm/mach-highbank/highbank.c          |    1 -
 arch/arm/mach-highbank/platsmp.c           |    4 +--
 arch/arm/mach-imx/mach-imx6q.c             |    1 -
 arch/arm/mach-imx/platsmp.c                |    2 --
 arch/arm/mach-msm/board-dt-8660.c          |    1 -
 arch/arm/mach-msm/board-dt-8960.c          |    1 -
 arch/arm/mach-msm/platsmp.c                |    4 +--
 arch/arm/mach-msm/timer.c                  |    1 -
 arch/arm/mach-netx/nxdb500.c               |    1 -
 arch/arm/mach-netx/nxdkn.c                 |    1 -
 arch/arm/mach-netx/nxeb500hmi.c            |    1 -
 arch/arm/mach-nomadik/board-nhk8815.c      |    1 -
 arch/arm/mach-omap2/board-4430sdp.c        |    1 -
 arch/arm/mach-omap2/board-generic.c        |    3 --
 arch/arm/mach-omap2/board-omap4panda.c     |    1 -
 arch/arm/mach-omap2/omap-smp.c             |    4 +--
 arch/arm/mach-picoxcell/common.c           |    1 -
 arch/arm/mach-realview/core.c              |    1 -
 arch/arm/mach-realview/platsmp.c           |    3 --
 arch/arm/mach-realview/realview_eb.c       |    1 -
 arch/arm/mach-realview/realview_pb1176.c   |    1 -
 arch/arm/mach-realview/realview_pb11mp.c   |    1 -
 arch/arm/mach-realview/realview_pba8.c     |    1 -
 arch/arm/mach-realview/realview_pbx.c      |    1 -
 arch/arm/mach-s3c64xx/mach-anw6410.c       |    1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c      |    1 -
 arch/arm/mach-s3c64xx/mach-hmt.c           |    1 -
 arch/arm/mach-s3c64xx/mach-mini6410.c      |    1 -
 arch/arm/mach-s3c64xx/mach-ncp.c           |    1 -
 arch/arm/mach-s3c64xx/mach-real6410.c      |    1 -
 arch/arm/mach-s3c64xx/mach-smartq5.c       |    1 -
 arch/arm/mach-s3c64xx/mach-smartq7.c       |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6400.c      |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c      |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6440.c      |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6450.c      |    1 -
 arch/arm/mach-s5pc100/mach-smdkc100.c      |    1 -
 arch/arm/mach-s5pv210/mach-aquila.c        |    1 -
 arch/arm/mach-s5pv210/mach-goni.c          |    1 -
 arch/arm/mach-s5pv210/mach-smdkc110.c      |    1 -
 arch/arm/mach-s5pv210/mach-smdkv210.c      |    1 -
 arch/arm/mach-s5pv210/mach-torbreck.c      |    1 -
 arch/arm/mach-shmobile/board-ag5evm.c      |    1 -
 arch/arm/mach-shmobile/board-kota2.c       |    1 -
 arch/arm/mach-shmobile/board-kzm9d.c       |    2 --
 arch/arm/mach-shmobile/board-kzm9g.c       |    1 -
 arch/arm/mach-shmobile/board-marzen.c      |    2 --
 arch/arm/mach-shmobile/platsmp.c           |    3 --
 arch/arm/mach-shmobile/setup-emev2.c       |    1 -
 arch/arm/mach-shmobile/smp-emev2.c         |    2 +-
 arch/arm/mach-socfpga/socfpga.c            |    1 -
 arch/arm/mach-spear13xx/platsmp.c          |    2 --
 arch/arm/mach-spear13xx/spear1310.c        |    1 -
 arch/arm/mach-spear13xx/spear1340.c        |    1 -
 arch/arm/mach-spear3xx/spear300.c          |    2 --
 arch/arm/mach-spear3xx/spear310.c          |    2 --
 arch/arm/mach-spear3xx/spear320.c          |    2 --
 arch/arm/mach-spear6xx/spear6xx.c          |    1 -
 arch/arm/mach-tegra/board-dt-tegra20.c     |    3 --
 arch/arm/mach-tegra/board-dt-tegra30.c     |    2 --
 arch/arm/mach-tegra/platsmp.c              |    2 --
 arch/arm/mach-u300/core.c                  |    1 -
 arch/arm/mach-ux500/board-mop500.c         |    5 ---
 arch/arm/mach-ux500/platsmp.c              |    4 +--
 arch/arm/mach-versatile/versatile_ab.c     |    1 -
 arch/arm/mach-versatile/versatile_dt.c     |    1 -
 arch/arm/mach-versatile/versatile_pb.c     |    1 -
 arch/arm/mach-vexpress/ct-ca9x4.c          |    2 --
 arch/arm/mach-vexpress/platsmp.c           |    3 --
 arch/arm/mach-vexpress/v2m.c               |    2 --
 arch/arm/mach-zynq/common.c                |    1 -
 arch/arm/plat-mxc/include/mach/common.h    |    1 -
 arch/arm/plat-versatile/platsmp.c          |    2 +-
 101 files changed, 77 insertions(+), 203 deletions(-)

-- 
1.7.10.4
