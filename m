From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Feb 2013 17:56:33 +0000
Subject: [GIT PULL] KVM/ARM virtual GIC and timer
Message-ID: <511930D1.8050208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is a pull request for the last few bits of KVM/ARM, namely the
virtual GIC and timer.

The dependencies are:
	- for-arm-soc/arch-timers (from Will)
	- for-rmk/virt/kvm/core (from Will, and already in RMK's tree)
	- irqchip/gic-vic-move (from Rob)

All these dependencies are already in your next/virt branch, and I
checked that the merge can be done absolutely painlessly (zero 
conflicts).

The diffstat is a bit weird, as I generated the pull request against 
your next/virt branch, and the merge of irqchip/gic-vic-move shows 
changes that you already have.

Cheers,

	M.


The following changes since commit 9e02e394c7d7fdc2570a73fb7fc6da3c79f6db2a:

  Merge branch 'for-will/arch-timer-unification' of git://linux-arm.org/linux-mr into for-arm-soc/arch-timers (2013-02-01 10:28:36 +0000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/timer

for you to fetch changes up to 1363a7031c3ca884e105b0c3b307313d524adab3:

  ARM: KVM: arch_timers: Wire the init code and config option (2013-02-01 11:09:01 +0000)

----------------------------------------------------------------
Christoffer Dall (3):
      ARM: gic: add missing distributor defintions
      KVM: ARM: Introduce KVM_ARM_SET_DEVICE_ADDR ioctl
      ARM: KVM: VGIC accept vcpu and dist base addresses from user space

Marc Zyngier (16):
      Merge remote-tracking branch 'arm-soc/irqchip/gic-vic-move' into kvm-arm/vgic
      ARM: gic: define GICH offsets for VGIC support
      ARM: gic: add __ASSEMBLY__ guard to C definitions
      ARM: KVM: Keep track of currently running vcpus
      ARM: KVM: Initial VGIC infrastructure code
      ARM: KVM: VGIC distributor handling
      ARM: KVM: VGIC virtual CPU interface management
      ARM: KVM: vgic: retire queued, disabled interrupts
      ARM: KVM: VGIC interrupt injection
      ARM: KVM: VGIC control interface world switch
      ARM: KVM: VGIC initialisation code
      ARM: KVM: Add VGIC configuration option
      Merge branch 'for-arm-soc/arch-timers' of git://git.kernel.org/.../will/linux into kvm-arm/timer
      ARM: KVM: arch_timers: Add guest timer core support
      ARM: KVM: arch_timers: Add timer world switch
      ARM: KVM: arch_timers: Wire the init code and config option

 Documentation/virtual/kvm/api.txt                                      |  137 ++++++-
 MAINTAINERS                                                            |   10 +
 arch/arm/Kconfig                                                       |    2 +
 arch/arm/Makefile                                                      |    1 +
 arch/arm/common/Kconfig                                                |   23 --
 arch/arm/common/Makefile                                               |    2 -
 arch/arm/include/asm/cputype.h                                         |   33 ++
 arch/arm/include/asm/idmap.h                                           |    1 +
 arch/arm/include/asm/kvm_arch_timer.h                                  |   85 ++++
 arch/arm/include/asm/kvm_arm.h                                         |  214 ++++++++++
 arch/arm/include/asm/kvm_asm.h                                         |   83 ++++
 arch/arm/include/asm/kvm_coproc.h                                      |   47 +++
 arch/arm/include/asm/kvm_emulate.h                                     |   72 ++++
 arch/arm/include/asm/kvm_host.h                                        |  184 +++++++++
 arch/arm/include/asm/kvm_mmio.h                                        |   56 +++
 arch/arm/include/asm/kvm_mmu.h                                         |   50 +++
 arch/arm/include/asm/kvm_psci.h                                        |   23 ++
 arch/arm/include/asm/kvm_vgic.h                                        |  221 +++++++++++
 arch/arm/include/asm/mach/irq.h                                        |    1 +
 arch/arm/include/asm/pgtable-3level-hwdef.h                            |    5 +
 arch/arm/include/asm/pgtable-3level.h                                  |   18 +
 arch/arm/include/asm/pgtable.h                                         |    7 +
 arch/arm/include/uapi/asm/kvm.h                                        |  180 +++++++++
 arch/arm/kernel/asm-offsets.c                                          |   43 ++
 arch/arm/kernel/irq.c                                                  |   10 +
 arch/arm/kernel/perf_event.c                                           |   16 +-
 arch/arm/kernel/perf_event_cpu.c                                       |   51 +--
 arch/arm/kernel/perf_event_v6.c                                        |    4 +-
 arch/arm/kernel/perf_event_v7.c                                        |   18 +-
 arch/arm/kernel/perf_event_xscale.c                                    |    2 +-
 arch/arm/kernel/smp.c                                                  |    3 +-
 arch/arm/kernel/smp_twd.c                                              |    1 -
 arch/arm/kernel/vmlinux.lds.S                                          |    6 +-
 arch/arm/kvm/Kconfig                                                   |   72 ++++
 arch/arm/kvm/Makefile                                                  |   23 ++
 arch/arm/kvm/arch_timer.c                                              |  271 +++++++++++++
 arch/arm/kvm/arm.c                                                     | 1169 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/coproc.c                                                  | 1050 +++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/coproc.h                                                  |  153 ++++++++
 arch/arm/kvm/coproc_a15.c                                              |  162 ++++++++
 arch/arm/kvm/emulate.c                                                 |  373 ++++++++++++++++++
 arch/arm/kvm/guest.c                                                   |  222 +++++++++++
 arch/arm/kvm/init.S                                                    |  114 ++++++
 arch/arm/kvm/interrupts.S                                              |  484 +++++++++++++++++++++++
 arch/arm/kvm/interrupts_head.S                                         |  605 +++++++++++++++++++++++++++++
 arch/arm/kvm/mmio.c                                                    |  156 ++++++++
 arch/arm/kvm/mmu.c                                                     |  787 +++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/psci.c                                                    |  108 ++++++
 arch/arm/kvm/reset.c                                                   |   74 ++++
 arch/arm/kvm/trace.h                                                   |  235 +++++++++++
 arch/arm/kvm/vgic.c                                                    | 1506 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-bcm/board_bcm.c                                          |   17 +-
 arch/arm/mach-cns3xxx/cns3420vb.c                                      |    2 -
 arch/arm/mach-cns3xxx/core.c                                           |    2 +-
 arch/arm/mach-ep93xx/adssphere.c                                       |    2 -
 arch/arm/mach-ep93xx/core.c                                            |    3 +-
 arch/arm/mach-ep93xx/edb93xx.c                                         |    9 -
 arch/arm/mach-ep93xx/gesbc9312.c                                       |    2 -
 arch/arm/mach-ep93xx/micro9.c                                          |    5 -
 arch/arm/mach-ep93xx/simone.c                                          |    2 -
 arch/arm/mach-ep93xx/snappercl15.c                                     |    2 -
 arch/arm/mach-ep93xx/ts72xx.c                                          |    2 -
 arch/arm/mach-ep93xx/vision_ep9307.c                                   |    2 -
 arch/arm/mach-exynos/common.c                                          |   10 +-
 arch/arm/mach-exynos/include/mach/regs-irq.h                           |    2 +-
 arch/arm/mach-exynos/mach-armlex4210.c                                 |    2 -
 arch/arm/mach-exynos/mach-exynos4-dt.c                                 |    2 -
 arch/arm/mach-exynos/mach-exynos5-dt.c                                 |    2 -
 arch/arm/mach-exynos/mach-nuri.c                                       |    2 -
 arch/arm/mach-exynos/mach-origen.c                                     |    2 -
 arch/arm/mach-exynos/mach-smdk4x12.c                                   |    3 -
 arch/arm/mach-exynos/mach-smdkv310.c                                   |    3 -
 arch/arm/mach-exynos/mach-universal_c210.c                             |    2 -
 arch/arm/mach-exynos/mct.c                                             |    1 -
 arch/arm/mach-exynos/platsmp.c                                         |    6 +-
 arch/arm/mach-highbank/highbank.c                                      |   11 +-
 arch/arm/mach-highbank/platsmp.c                                       |    6 +-
 arch/arm/mach-imx/common.h                                             |    1 -
 arch/arm/mach-imx/gpc.c                                                |    2 +-
 arch/arm/mach-imx/mach-imx6q.c                                         |   10 +-
 arch/arm/mach-imx/platsmp.c                                            |    4 +-
 arch/arm/mach-msm/board-dt-8660.c                                      |   16 +-
 arch/arm/mach-msm/board-dt-8960.c                                      |   16 +-
 arch/arm/mach-msm/platsmp.c                                            |    6 +-
 arch/arm/mach-msm/timer.c                                              |    1 -
 arch/arm/mach-netx/generic.c                                           |    2 +-
 arch/arm/mach-netx/nxdb500.c                                           |    2 -
 arch/arm/mach-netx/nxdkn.c                                             |    2 -
 arch/arm/mach-netx/nxeb500hmi.c                                        |    2 -
 arch/arm/mach-nomadik/board-nhk8815.c                                  |    2 -
 arch/arm/mach-nomadik/cpu-8815.c                                       |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c                                    |    3 +-
 arch/arm/mach-omap2/board-generic.c                                    |    3 -
 arch/arm/mach-omap2/board-omap4panda.c                                 |    3 +-
 arch/arm/mach-omap2/omap-smp.c                                         |    6 +-
 arch/arm/mach-omap2/omap-wakeupgen.c                                   |    3 +-
 arch/arm/mach-omap2/omap4-common.c                                     |   11 +-
 arch/arm/mach-picoxcell/common.c                                       |   15 +-
 arch/arm/mach-realview/core.c                                          |    1 -
 arch/arm/mach-realview/platsmp.c                                       |    3 -
 arch/arm/mach-realview/realview_eb.c                                   |    3 +-
 arch/arm/mach-realview/realview_pb1176.c                               |    3 +-
 arch/arm/mach-realview/realview_pb11mp.c                               |    3 +-
 arch/arm/mach-realview/realview_pba8.c                                 |    3 +-
 arch/arm/mach-realview/realview_pbx.c                                  |    3 +-
 arch/arm/mach-s3c64xx/common.c                                         |    2 +-
 arch/arm/mach-s3c64xx/include/mach/regs-irq.h                          |    1 -
 arch/arm/mach-s3c64xx/include/mach/tick.h                              |    2 +
 arch/arm/mach-s3c64xx/mach-anw6410.c                                   |    2 -
 arch/arm/mach-s3c64xx/mach-crag6410.c                                  |    2 -
 arch/arm/mach-s3c64xx/mach-hmt.c                                       |    2 -
 arch/arm/mach-s3c64xx/mach-mini6410.c                                  |    2 -
 arch/arm/mach-s3c64xx/mach-ncp.c                                       |    2 -
 arch/arm/mach-s3c64xx/mach-real6410.c                                  |    2 -
 arch/arm/mach-s3c64xx/mach-smartq5.c                                   |    2 -
 arch/arm/mach-s3c64xx/mach-smartq7.c                                   |    2 -
 arch/arm/mach-s3c64xx/mach-smdk6400.c                                  |    2 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c                                  |    2 -
 arch/arm/mach-s5p64x0/include/mach/regs-irq.h                          |    1 -
 arch/arm/mach-s5p64x0/include/mach/tick.h                              |   29 --
 arch/arm/mach-s5p64x0/mach-smdk6440.c                                  |    2 -
 arch/arm/mach-s5p64x0/mach-smdk6450.c                                  |    2 -
 arch/arm/mach-s5pc100/include/mach/regs-irq.h                          |    1 -
 arch/arm/mach-s5pc100/include/mach/tick.h                              |    2 +
 arch/arm/mach-s5pc100/mach-smdkc100.c                                  |    2 -
 arch/arm/mach-s5pv210/include/mach/regs-irq.h                          |    1 -
 arch/arm/mach-s5pv210/include/mach/tick.h                              |   26 --
 arch/arm/mach-s5pv210/mach-aquila.c                                    |    2 -
 arch/arm/mach-s5pv210/mach-goni.c                                      |    2 -
 arch/arm/mach-s5pv210/mach-smdkc110.c                                  |    2 -
 arch/arm/mach-s5pv210/mach-smdkv210.c                                  |    2 -
 arch/arm/mach-s5pv210/mach-torbreck.c                                  |    2 -
 arch/arm/mach-shmobile/board-ag5evm.c                                  |    3 +-
 arch/arm/mach-shmobile/board-kota2.c                                   |    3 +-
 arch/arm/mach-shmobile/board-kzm9d.c                                   |    2 -
 arch/arm/mach-shmobile/board-kzm9g.c                                   |    3 +-
 arch/arm/mach-shmobile/board-marzen.c                                  |    2 -
 arch/arm/mach-shmobile/intc-r8a7779.c                                  |    2 +-
 arch/arm/mach-shmobile/intc-sh73a0.c                                   |    2 +-
 arch/arm/mach-shmobile/platsmp.c                                       |    3 -
 arch/arm/mach-shmobile/setup-emev2.c                                   |   17 +-
 arch/arm/mach-shmobile/smp-emev2.c                                     |    4 +-
 arch/arm/mach-shmobile/smp-r8a7779.c                                   |    2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c                                    |    2 +-
 arch/arm/mach-socfpga/platsmp.c                                        |    4 +-
 arch/arm/mach-socfpga/socfpga.c                                        |   14 +-
 arch/arm/mach-spear13xx/include/mach/generic.h                         |    1 -
 arch/arm/mach-spear13xx/platsmp.c                                      |    4 +-
 arch/arm/mach-spear13xx/spear1310.c                                    |    5 +-
 arch/arm/mach-spear13xx/spear1340.c                                    |    5 +-
 arch/arm/mach-spear13xx/spear13xx.c                                    |   13 +-
 arch/arm/mach-spear3xx/include/mach/generic.h                          |    1 -
 arch/arm/mach-spear3xx/spear300.c                                      |    5 +-
 arch/arm/mach-spear3xx/spear310.c                                      |    5 +-
 arch/arm/mach-spear3xx/spear320.c                                      |    5 +-
 arch/arm/mach-spear3xx/spear3xx.c                                      |   16 -
 arch/arm/mach-spear6xx/spear6xx.c                                      |   16 +-
 arch/arm/mach-sunxi/sunxi.c                                            |    2 -
 arch/arm/mach-tegra/board-dt-tegra20.c                                 |    3 -
 arch/arm/mach-tegra/board-dt-tegra30.c                                 |    2 -
 arch/arm/mach-tegra/common.c                                           |   10 +-
 arch/arm/mach-tegra/irq.c                                              |    3 +-
 arch/arm/mach-tegra/platsmp.c                                          |    4 +-
 arch/arm/mach-u300/core.c                                              |    3 +-
 arch/arm/mach-ux500/board-mop500.c                                     |    5 -
 arch/arm/mach-ux500/cpu-db8500.c                                       |    2 -
 arch/arm/mach-ux500/cpu.c                                              |   10 +-
 arch/arm/mach-ux500/platsmp.c                                          |    6 +-
 arch/arm/mach-versatile/core.c                                         |    2 +-
 arch/arm/mach-versatile/versatile_ab.c                                 |    2 -
 arch/arm/mach-versatile/versatile_dt.c                                 |    2 -
 arch/arm/mach-versatile/versatile_pb.c                                 |    2 -
 arch/arm/mach-vexpress/ct-ca9x4.c                                      |    4 +-
 arch/arm/mach-vexpress/platsmp.c                                       |    3 -
 arch/arm/mach-vexpress/v2m.c                                           |   16 +-
 arch/arm/mach-zynq/common.c                                            |   17 +-
 arch/arm/mm/idmap.c                                                    |   55 ++-
 arch/arm/mm/mmu.c                                                      |   22 ++
 arch/arm/plat-samsung/s5p-irq-eint.c                                   |    3 +-
 arch/arm/plat-samsung/s5p-irq.c                                        |    3 +-
 arch/arm/plat-versatile/platsmp.c                                      |    4 +-
 drivers/irqchip/Kconfig                                                |   27 ++
 drivers/irqchip/Makefile                                               |    6 +-
 arch/arm/common/gic.c => drivers/irqchip/irq-gic.c                     |   59 +--
 arch/arm/common/vic.c => drivers/irqchip/irq-vic.c                     |   95 +++--
 drivers/irqchip/irqchip.c                                              |   30 ++
 drivers/irqchip/irqchip.h                                              |   29 ++
 drivers/irqchip/spear-shirq.c                                          |    5 +
 drivers/mfd/db8500-prcmu.c                                             |    2 +-
 include/asm-generic/vmlinux.lds.h                                      |   12 +-
 include/linux/irqchip.h                                                |   16 +
 arch/arm/include/asm/hardware/gic.h => include/linux/irqchip/arm-gic.h |   44 ++-
 arch/arm/include/asm/hardware/vic.h => include/linux/irqchip/arm-vic.h |   25 +-
 include/uapi/linux/kvm.h                                               |   17 +
 194 files changed, 9525 insertions(+), 675 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_arch_timer.h
 create mode 100644 arch/arm/include/asm/kvm_arm.h
 create mode 100644 arch/arm/include/asm/kvm_asm.h
 create mode 100644 arch/arm/include/asm/kvm_coproc.h
 create mode 100644 arch/arm/include/asm/kvm_emulate.h
 create mode 100644 arch/arm/include/asm/kvm_host.h
 create mode 100644 arch/arm/include/asm/kvm_mmio.h
 create mode 100644 arch/arm/include/asm/kvm_mmu.h
 create mode 100644 arch/arm/include/asm/kvm_psci.h
 create mode 100644 arch/arm/include/asm/kvm_vgic.h
 create mode 100644 arch/arm/include/uapi/asm/kvm.h
 create mode 100644 arch/arm/kvm/Kconfig
 create mode 100644 arch/arm/kvm/Makefile
 create mode 100644 arch/arm/kvm/arch_timer.c
 create mode 100644 arch/arm/kvm/arm.c
 create mode 100644 arch/arm/kvm/coproc.c
 create mode 100644 arch/arm/kvm/coproc.h
 create mode 100644 arch/arm/kvm/coproc_a15.c
 create mode 100644 arch/arm/kvm/emulate.c
 create mode 100644 arch/arm/kvm/guest.c
 create mode 100644 arch/arm/kvm/init.S
 create mode 100644 arch/arm/kvm/interrupts.S
 create mode 100644 arch/arm/kvm/interrupts_head.S
 create mode 100644 arch/arm/kvm/mmio.c
 create mode 100644 arch/arm/kvm/mmu.c
 create mode 100644 arch/arm/kvm/psci.c
 create mode 100644 arch/arm/kvm/reset.c
 create mode 100644 arch/arm/kvm/trace.h
 create mode 100644 arch/arm/kvm/vgic.c
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/tick.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/tick.h
 rename arch/arm/common/gic.c => drivers/irqchip/irq-gic.c (97%)
 rename arch/arm/common/vic.c => drivers/irqchip/irq-vic.c (92%)
 create mode 100644 drivers/irqchip/irqchip.c
 create mode 100644 drivers/irqchip/irqchip.h
 create mode 100644 include/linux/irqchip.h
 rename arch/arm/include/asm/hardware/gic.h => include/linux/irqchip/arm-gic.h (58%)
 rename arch/arm/include/asm/hardware/vic.h => include/linux/irqchip/arm-vic.h (63%)

-- 
Jazz is not dead. It just smells funny...
